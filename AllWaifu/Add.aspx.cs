using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace AllWaifu
{
    public partial class Add_Waif : System.Web.UI.Page
    {
        public Waifu RenWaif = new Waifu();
        public string Confirmed = "-1";
        public string SerializedWaif = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Request.IsAuthenticated)
            {
                Response.Redirect("/login");
                return;
            }
            if (RouteData.Values["id"] != null)
            {
                ((AllWaifu)Master).user = new UserFull(Membership.GetUser());

                if(!(Master.user.Role == "Admin" || Master.user.Role == "Creator"))
                {
                    Response.Redirect("/error/401");
                    return;
                }
                bool res = RenWaif.ReadFromBase(Convert.ToInt32(RouteData.Values["id"]));
                if (!res)
                {
                    Response.Redirect("/error/404");
                    return;
                }
                var serializer = new JavaScriptSerializer();
                SerializedWaif = serializer.Serialize(RenWaif);
                Confirmed = RenWaif.Confirmed;
            }
        }

        protected void Confirm_ServerClick(object sender, EventArgs e)
        {
            string url = ThumbImage.Src;
            url = url.Substring(url.LastIndexOf('/') + 1);
            url = url.Substring(0, url.Length - 4);
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                var cmd = new SqlCommand("DELETE FROM CloudinaryCache WHERE Url=@Url", _connection);
                cmd.Parameters.AddWithValue("Url", url);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            Response.Redirect("/main");
            return;
        }
        protected void ConfirmAdmin_ServerClick(object sender, EventArgs e)
        {
            Confirm_ServerClick(sender, e);
        }


    }
}