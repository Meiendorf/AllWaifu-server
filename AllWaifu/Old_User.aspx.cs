using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class User : System.Web.UI.Page
    {
        public UserFull user { get; set; } = null;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] == null)
            {
                if (Request.IsAuthenticated)
                {
                    ((AllWaifu)Master).user = new UserFull(Membership.GetUser());
                    user = ((AllWaifu)Master).user;
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
            else
            {
                string Login = Request.QueryString["id"];
 
                var us = Membership.GetUser(Login);
                if (us == null)
                {
                    Response.Redirect("Error.aspx");
                }
                else
                {
                    user = new UserFull(us);
                }
            }
          
            Initializate_Repeaters();
        }
        public void Initializate_Repeaters()
        {
            Added_Repeater.DataSource = user.Added;
            Added_Repeater.DataBind();
            Favorites_Repeater.DataSource = user.Favorites;
            Favorites_Repeater.DataBind();
            Comments.Data = user.Comments;
        }
    }
}