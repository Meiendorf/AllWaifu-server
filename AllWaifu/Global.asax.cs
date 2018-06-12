using Nemiro.OAuth;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;

namespace AllWaifu
{
   
    public class Global : System.Web.HttpApplication
    {
        public static string WaifString = ConfigurationManager.ConnectionStrings["AllWaifu"].ConnectionString;

        protected void Application_Start(object sender, EventArgs e)
        {
            OAuthManager.RegisterClient
            (
                "vk",
                "6321519",
                "QSQ1hDbauZXRCOwBqdKw"
            );
            OAuthManager.RegisterClient
            (
                "google",
                "7217423339-i95d3cl3s9nip1f790s891qlc0au6cnc.apps.googleusercontent.com",
                "dz0hCWelnOpfbvcr7g9NI2Zj"
            );
            OAuthManager.RegisterClient
            (
                "facebook",
                "156221961821221",
                "c7f50e02445b972da8f7db2f89f2c738"
            );

            SmtpHelper.ClientCreate("natsuki-bot@rambler.ru", "kiritorito1110111");

            RegisterRoutes(RouteTable.Routes);
        }

        void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("SearchRoute", "search/{type}/{text}/{*tags}", "~/Search.aspx", false, 
                new RouteValueDictionary { { "type", "all" }, { "text", "" }},
                new RouteValueDictionary { { "type", "(^all$|^waifu$|^unconfirmed$|^anime$|^text$)" } });
            var idNullRoute = new RouteValueDictionary { { "id", null } };
            routes.MapPageRoute("MainRoute", "main", "~/Main.aspx");
            routes.MapPageRoute("AnimeRoute", "anime/{id}", "~/Anime.aspx", false, idNullRoute);
            routes.MapPageRoute("EditRoute", "edit", "~/Edit.aspx");
            routes.MapPageRoute("ErrorRoute", "error/{error}", "~/Error.aspx", false,
                new RouteValueDictionary { { "error", null } });
            routes.MapPageRoute("LoginRoute", "login", "~/Login.aspx");
            routes.MapPageRoute("AddRoute", "add/{id}", "~/Add.aspx", false, idNullRoute);
            routes.MapPageRoute("NewsRoute", "news", "~/News.aspx");
            routes.MapPageRoute("ProfileRoute", "profile/{id}", "~/Profile.aspx", false, idNullRoute);
            routes.MapPageRoute("RecoveryRoute", "recovery/{token}", "~/Recovery.aspx", false,
                new RouteValueDictionary { { "token", null } });
            routes.MapPageRoute("WaifuRoute", "waifu/{id}", "~/Waifu.aspx", false, idNullRoute);
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}