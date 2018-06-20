using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using CloudinaryDotNet.Actions;
using CloudinaryDotNet;

namespace AllWaifu
{
    public partial class Edit_Page : System.Web.UI.Page
    {
        public UserFull user = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Header.DataBind();
            if (!Request.IsAuthenticated)
            {
                Response.Redirect("/login");
            }
            
            Master.user = new UserFull(Membership.GetUser());
            user = Master.user;
        }
   
        protected void SaveAll_Click(object sender, EventArgs e)
        {
            if(Membership.GetUserNameByEmail(UserEmail.Value) == null)
            {
                user.Change_Email(UserEmail.Value);
            }
            if(Membership.GetUser(UserName.Value) == null)
            {
                user.Change_Login(UserName.Value);
            }
            if (OldPass.Value != "")
            {
                user.Change_Password(OldPass.Value, RegPass.Value);
            }
            user.Change_Description(wcomments.Value);
            user.Change_Name(UserRName.Value);
            user.Change_Url(UserUrl.Value);
            user.Change_Image(ImageSrc.Value);

            FormsAuthentication.SignOut();
            FormsAuthentication.SetAuthCookie(user.Login, true);
            Response.Redirect("/profile");
        }
    }
}