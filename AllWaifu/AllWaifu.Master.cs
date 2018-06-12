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
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.IsAuthenticated)
            {
                if (user == null)
                {
                    user = new UserFull(Membership.GetUser());
                }
            }
        }
    }
}