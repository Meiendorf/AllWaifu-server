using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class Waif : System.Web.UI.Page
    {
        public SqlConnection _connection { get; set; }
        public Waifu PageWaif { get; set; }
        public int CurrentElement { get; set; } = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Request.QueryString["id"] != null)
            {
                if(true)
                {
                    DataBaseWork(Convert.ToInt32(Request.QueryString["id"]));
                }
                /*catch (Exception err)
                {
                    Response.Redirect("Error.aspx?error="+err.Message);
                }*/
                if (PageWaif.Confirmed != "1")
                {
                    string role;
                    if (Master.user == null)
                    {
                        var _user = Membership.GetUser();
                        if(_user == null)
                        {
                            role = "User";
                        }
                        else
                        {
                            Master.user = new UserFull(_user);
                            role = Master.user.Role;
                        }
                    }
                    else
                    {
                        role = Master.user.Role;
                    }

                    if ((role == "User") || (role == "Moder"))
                    {
                        Response.Redirect("Error.aspx?error=NoAccess");
                    }
                }
                return;
            }
            Response.Redirect("MainPage.aspx");
        }
        public void DataBaseWork(int id)
        {
            PageWaif = new Waifu();
            bool res = PageWaif.ReadFromBase(id);
            if (res)
            {
                Comments.Data = PageWaif.Comments;
                ChapterRepeater.DataSource = PageWaif.Chapters;
                TagRepeater.DataSource = PageWaif.FormatTags;
                TagRepeater.DataBind();
                ChapterRepeater.DataBind();
            }
            else
            {
                Server.Transfer("MainPage.aspx", true);
                Response.Write("Base error");
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
                childRepeater.DataBind();
                CurrentElement++;
            }
        }
    }
}