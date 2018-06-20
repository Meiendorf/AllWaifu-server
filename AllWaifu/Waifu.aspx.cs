using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class Waifu_New : System.Web.UI.Page
    {
        public SqlConnection _connection { get; set; }
        public Waifu PageWaif { get; set; }

        public bool IsFavForCurrentUser { get; set; } = false;
        public string UserRole { get; set; }
        public bool IsAuthenticated { get; set; } = false;
        public string UserName { get; set; } = "";
        public string UserId { get; set; } = "";

        public string ReplyId { get; set; } = "";
        public string ReplyFrom { get; set; } = "";

        public int CurrentElement { get; set; } = 0;
        public List<LightElement> TopPopWaif = new List<LightElement>();
        public List<LightElement> TopFavWaif = new List<LightElement>();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (RouteData.Values["id"] != null)
            {
                DataBaseWork(Convert.ToInt32(RouteData.Values["id"]));
                
                if (Master.user == null)
                {
                    var _user = Membership.GetUser();
                    Master.user = new UserFull(_user);
                    if (_user == null)
                    {
                        UserRole = "User";
                    }
                    else
                    {
                        UserName = Master.user.Login;
                        UserId = Master.user.Id;
                        UserRole = Master.user.Role;
                    }
                }
                else
                {
                    UserRole = Master.user.Role;
                }

                if (PageWaif.Confirmed != "1")
                {
                    if ((UserRole == "User") || (UserRole == "Moder"))
                    {
                        Response.Redirect("/error/401");
                    }
                }
                if (!String.IsNullOrEmpty(Request.QueryString["replyId"]) &&
                    !String.IsNullOrEmpty(Request.QueryString["replyFrom"]))
                {
                    ReplyId = Request.QueryString["replyId"];
                    ReplyFrom = Request.QueryString["replyFrom"];
                }

                if (Request.IsAuthenticated)
                {
                    IsAuthenticated = true;
                    using (var _connection = new SqlConnection(Global.WaifString))
                    {
                        _connection.Open();
                        using (var cmd = new SqlCommand("SELECT Id FROM Favorites WHERE UserId=(SELECT Id " +
                                                       "FROM Users WHERE Name=@UserName) AND WaifuId=@Id", _connection))
                        {
                            cmd.Parameters.AddWithValue("UserName", Master.user.Login);
                            cmd.Parameters.AddWithValue("Id", PageWaif.Id);

                            if (cmd.ExecuteScalar() != null)
                            {
                                IsFavForCurrentUser = true;
                            }
                        }

                    }
                }
                return;
            }
            Response.Redirect("~/main");
        }
        public void DataBaseWork(int id)
        {
            PageWaif = new Waifu();
            bool res = PageWaif.ReadFromBase(id);
            if (res)
            {
                using (_connection = new SqlConnection(Global.WaifString))
                {
                    _connection.Open();
                    using (var cmd = new SqlCommand("SELECT TOP 3 Id, Name, Image, Popularity FROM Waifu ORDER BY Popularity DESC",
                                                    _connection))
                    {
                        using (var rd = cmd.ExecuteReader())
                        {
                            while(rd.Read())
                            {
                                TopPopWaif.Add(new WaifuLight(rd) as LightElement);
                            }
                        }
                    }
                    using (var cmd = new SqlCommand("SELECT TOP 3 w.Id, w.Name, w.Image, " +
                                                   "(SELECT COUNT(f.Id) FROM Favorites as f WHERE f.WaifuId = w.Id) " +
                                                   "as Favority FROM Waifu as w ORDER BY Favority DESC", _connection))
                    {
                        using (var rd = cmd.ExecuteReader())
                        {
                            while(rd.Read())
                            {
                                var temp = new WaifuLight(rd);
                                temp.Popularity = temp.Favority;
                                TopFavWaif.Add(temp as LightElement);
                            }
                        }
                    }
                }
                var redacted = PageWaif.Chapters.Select(x =>
                {
                    x.Elements = x.Elements.Select(y => 
                    {
                        if(!String.IsNullOrWhiteSpace(y.Title))
                        {
                            y.Title += " : ";
                        }
                        return y;
                    }).ToList();
                    return x;
                }).ToList();

                ChapterRepeater.DataSource = redacted;
                TagRepeater.DataSource = PageWaif.OurTags;
                TagRepeater.DataBind();
                ChapterRepeater.DataBind();
                FavListControl.Data = TopFavWaif;
                PopListControl.Data = TopPopWaif;
            }
            else
            {
                Response.Redirect("/error/404");
            }
        }
        protected void Page_Unload(object sender, EventArgs e)
        {

            if (_connection != null && _connection.State != ConnectionState.Closed)
            {
                _connection.Close();
            }
        }

        protected void ChapterRepeater_ItemDataBound(object sender, RepeaterItemEventArgs args)
        {
            if (args.Item.ItemType == ListItemType.Item || args.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater childRepeater = (Repeater)args.Item.FindControl("ElementRepeater");
                childRepeater.DataSource = PageWaif.Chapters[CurrentElement].Elements;
                //childRepeater.ItemDataBound;
                childRepeater.DataBind();
                CurrentElement++;
            }
        }
    }
}