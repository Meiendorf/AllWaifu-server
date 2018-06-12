using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Nemiro.OAuth; 
using Nemiro.OAuth.Clients;
using System.Web.Security;
using System.Text.RegularExpressions;
using System.Data.SqlClient;
using System.Configuration;

namespace AllWaifu
{
    public partial class Login : System.Web.UI.Page
    {
        public string PassRegEx = @"^[а-яА-ЯёЁa-zA-Z0-9_#@~*+=\-\/$%^&()\\\[\]|!?_-`\{\}]{6,30}$";
        public string LoginRegEx = @"^[а-яА-ЯёЁa-zA-Z0-9_]{3,30}$";
        public string MailRegEx = @"^[^@]+@[^@.]+\.[^@]+$";
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Request.IsAuthenticated)
            {
                Response.Redirect("/profile");
            }
           // Membership.GetUser();
            if (IsPostBack)
            {
                LoginError.Text = "";
            }
            OAuthChecking();
        }

        protected void Login_Click(object sender, EventArgs e)
        {
            string login = "";
            if (Membership.ValidateUser(LogLogin.Value, LogPass.Value))
            {
                login = LogLogin.Value;
            }
            else
            {
                var userName = Membership.GetUserNameByEmail(LogLogin.Value);
                if (!String.IsNullOrEmpty(userName))
                {
                    login = userName;
                }
            }
            if (login == "")
            {
                LoginError.Text = "Неправильный логин или пароль!";
            }
            else
            {
                FormsAuthentication.RedirectFromLoginPage(login, true);
            }
        }

        public void OAuthChecking()
        {
            var result = OAuthWeb.VerifyAuthorization();
            var user = result.UserInfo;
            if (result.IsSuccessfully)
            {
                LoginError.Text = "Succes";
                var member = Membership.GetUserNameByEmail(user.Email);
                if (member == null)
                {
                    string newPass = Membership.GeneratePassword(10, 0);
                    string valResult = ServerRegistrationValidation(user.Email, result.UserName, newPass);
                    if (valResult == "Ok" || valResult[0] == 'Н')
                    {
                        Membership.CreateUser(result.UserName, newPass, user.Email);
                       // Roles.AddUserToRole(result.UserName, "User");
                        string url = user.Url;
                        if (result.ClientName == "vk")
                        {
                            url = "https://vk.com/id" + result.UserId;
                        }
                        if (result.ClientName == "gg")
                        {
                            url = "https://plus.google.com/" + result.UserId;
                        }
                        CreateWaifuUser(result.UserName, user.Userpic, url, user.FullName);
                        SmtpHelper.SendPassword(user.Email, newPass, result.UserName);
                    }
                }
                if (member == null)
                {
                    member = Membership.GetUserNameByEmail(user.Email);
                }
                FormsAuthentication.RedirectFromLoginPage(member, true);
                Response.End();
            }
        }

        protected void Registration_Click(object sender, EventArgs e)
        {
            string result = ServerRegistrationValidation(RegEmail.Value, RegLogin.Value, RegPass.Value);
            if (result!="Ok")
            {
                LoginError.Text = result;
                return;
            }
            LoginError.Text = "Успех";
            Membership.CreateUser(RegLogin.Value, RegPass.Value, RegEmail.Value);
            //Roles.AddUserToRole(RegLogin.Value, "User");
            CreateWaifuUser(RegLogin.Value);
            FormsAuthentication.RedirectFromLoginPage(RegLogin.Value, true);
        }
        
        public void CreateWaifuUser(string login, object image=null, object url=null, object name=null)
        {
            SqlConnection _connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AllWaifu"].ConnectionString);
            _connection.Open();
            try
            {
                SqlCommand command = new SqlCommand("INSERT INTO Users (Id, Name, Image, Url, RealName)" +
                                                    " VALUES (@Id, @Name, @Image, @Url, @RealName)", _connection);
                command.Parameters.AddWithValue("Id", Membership.GetUser(login).ProviderUserKey.ToString());
                command.Parameters.AddWithValue("Name", login);
                command.Parameters.AddWithValue("Image", image ?? DBNull.Value);
                command.Parameters.AddWithValue("Url", url ?? DBNull.Value);
                command.Parameters.AddWithValue("RealName", name ?? DBNull.Value);
        
                command.ExecuteNonQuery();
            }
            finally
            {
                _connection.Close();
            }
        }
        public static void DeleteUserFromBase(string Login)
        {
            SqlConnection _connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AllWaifu"].ConnectionString);
            _connection.Open();
            try
            {
                SqlCommand command = new SqlCommand("DELETE FROM Users WHERE Name=@Name", _connection);

                command.Parameters.AddWithValue("Name", Login);

                command.ExecuteNonQuery();
            }
            finally
            {
                _connection.Close();
            }
            Membership.DeleteUser(Login);
        }

        public string ServerRegistrationValidation(string email, string login, string pass)
        {

            Regex loginEx = new Regex(LoginRegEx);
            Regex passEx = new Regex(PassRegEx);
            Regex mailEx = new Regex(MailRegEx);

            if (!loginEx.IsMatch(login))
            {
                return "Неверный формат логина, повторите попытку.";
            }
            if (!passEx.IsMatch(pass))
            {
                return "Неверный формат пароля, повторите попытку.";
            }
            if (!mailEx.IsMatch(email))
            {
                return "Неверный формат почты, повторите попытку.";
            }
            if (Membership.GetUserNameByEmail(email)!=null)
            {
                return "Пользователь с данной почтой уже существует.";
            }
            if (Membership.GetUser(login)!=null)
            {
                return "Пользователь с данным логином уже существует.";
            }
            return "Ok";
        }

        protected void OAuthButton_Click(object sender, ImageClickEventArgs e)
        {
            string provider = "";
            string id = (sender as ImageButton).ID;
            switch (id)
            {
                case "VkOAuthButton":
                    provider = "vk";
                    break;
                case "GgOAuthButton":
                    provider = "google";
                    break;
                case "FbOAuthButton":
                    provider = "facebook";
                    break;
            }

            OAuthWeb.RedirectToAuthorization(provider, Request.Url.AbsoluteUri);
        }
    }
}