using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class Profile : System.Web.UI.Page
    {
        public UserFull user { get; set; } = null;
        public string ClientId { get; set; } = "";
        public bool IsUserPage { get; set; } = true;
        public int RepuationType { get; set; } = -1;
        public string Role { get; set; } = "";
        public string ReplyId { get; set; } = "";
        public string ReplyFrom { get; set; } = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsAuthenticated)
            {
                ((AllWaifu)Master).user = new UserFull(Membership.GetUser());
                ClientId = ((AllWaifu)Master).user.Id;
                Role = ((AllWaifu)Master).user.Role;
            }
            if (RouteData.Values["id"] == null)
            {
                if (Request.IsAuthenticated)
                {
                    user = ((AllWaifu)Master).user;
                }
                else
                {
                    Response.Redirect("/login");
                }
            }
            else
            {
                string Login = RouteData.Values["id"].ToString();

                var us = Membership.GetUser(Login);
                if (us == null)
                {
                    Response.Redirect("/error/404");
                }
                else
                {
                    if (((AllWaifu)Master).user != null)
                    {
                        if(!(((AllWaifu)Master).user.Login == us.UserName))
                        {
                            IsUserPage = false;
                            using (var _connection = new SqlConnection(Global.WaifString))
                            {
                                _connection.Open();
                                using (var cmd = new SqlCommand("SELECT Type FROM ReputationLog WHERE " +
                                                               "UserFrom=@Uf AND UserTo=@Ut", _connection))
                                {
                                    cmd.Parameters.AddWithValue("Uf", ((AllWaifu)Master).user.Id);
                                    cmd.Parameters.AddWithValue("Ut", us.UserName);
                                    var type = cmd.ExecuteScalar();
                                    if(type != null)
                                    {
                                        RepuationType = Convert.ToInt32(type);
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        IsUserPage = false;
                    }
                    user = new UserFull(us);
                }
            }
            
            if(!String.IsNullOrEmpty(Request.QueryString["replyId"]) && 
               !String.IsNullOrEmpty(Request.QueryString["replyFrom"]))
            {
                ReplyId = Request.QueryString["replyId"];
                ReplyFrom = Request.QueryString["replyFrom"];
            }

            Initializate_Repeaters();
        }
        public void Initializate_Repeaters()
        {
            Added_Repeater.DataSource = user.Added;
            Added_Repeater.DataBind();
            Favorites_Repeater.DataSource = user.Favorites;
            Favorites_Repeater.DataBind();
        }
    }
}