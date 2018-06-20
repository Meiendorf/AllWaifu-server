using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace AllWaifu
{
    public partial class AllWaifu : System.Web.UI.MasterPage
    {
        public UserFull user;
        public string UserName { get; set; } = "";
        public string Email { get; set; } = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.IsAuthenticated)
            {
                if (user == null)
                {
                    user = new UserFull(Membership.GetUser());
                }
                UserName = user.Login;
                Email = user.Email;
                user.LoadNotifications();
                NotifyRepeater.DataSource = user.Notifications;
                NotifyRepeater.DataBind();
            }
        }

    }
}