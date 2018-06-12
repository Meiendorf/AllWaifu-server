using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class Profile : System.Web.UI.Page
    {
        public UserFull user { get; set; } = null;
        public bool IsUserPage { get; set; } = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (RouteData.Values["id"] == null)
            {
                if (Request.IsAuthenticated)
                {
                    ((AllWaifu)Master).user = new UserFull(Membership.GetUser());
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
                    Response.Redirect("/error/NotFound");
                }
                else
                {
                    user = new UserFull(us);
                }
                IsUserPage = false;
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