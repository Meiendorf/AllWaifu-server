using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class News : System.Web.UI.Page
    {
        public bool IsAdmin { get; set; } = false;
        public string UserName { get; set; } = "";
        public string UserToken { get; set; } = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            ((AllWaifu)Master).user = new UserFull(Membership.GetUser());

            if (Request.IsAuthenticated && !(((AllWaifu)Master).user.Role == "User") 
                && !(((AllWaifu)Master).user.Role == "Moder"))
            {
                IsAdmin = true;
                UserName = ((AllWaifu)Master).user.Login;
                UserToken = ((AllWaifu)Master).user.Id;
            }
        }
    }
}