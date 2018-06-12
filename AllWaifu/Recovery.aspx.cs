using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class RecoveryPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool isOkay = false;
            if(RouteData.Values["token"] != null)
            {
                string token = RouteData.Values["Token"].ToString();
                DeleteOldTokens();
                string userName = GetUserByToken(token);
                if(!String.IsNullOrEmpty(userName))
                {
                    ViewState["userName"] = userName;
                    isOkay = true;
                }
            }
            if(!isOkay)
            {
                Response.Redirect("/error/RecoveryTokenExpired");
            }
        }

        public void DeleteOldTokens()
        {
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("DELETE FROM RecoveryTokens WHERE Timestamp < " +
                                               "DATEADD(mi, -60, GETDATE())", _connection))
                {
                    cmd.ExecuteNonQuery();
                }
            }
        }
        public string GetUserByToken(string token)
        {
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("SELECT Name FROM Users WHERE Id=(SELECT" +
                                               " UserId FROM RecoveryTokens WHERE Token=@Token)", _connection))
                {
                    cmd.Parameters.AddWithValue("Token", token);
                    return cmd.ExecuteScalar().ToString();
                }
            }
        }

        protected void ConfirmRecovery_ServerClick(object sender, EventArgs e)
        {
            string pass = RegPass.Value;
            var userName = ViewState["userName"].ToString();
            if(String.IsNullOrEmpty(userName))
            {
                LoginError.Text = "Ошибка при обработке запроса. Попробуйте еще раз";
                return;
            }
            var user = new UserFull(userName);
            var genPas = Membership.GetUser(userName).ResetPassword();
            user.Change_Password(genPas, pass);
            Response.Redirect("/login");
            /*Deleting token from db, actually dont think that it is useful feature */
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("DELETE From RecoveryToken WHERE UserId=(SELECT Id " +
                                               "WHERE Name=@UserName)", _connection))
                {
                    cmd.Parameters.AddWithValue("UserName", userName);
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}