using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class ErrorPage : System.Web.UI.Page
    {
        public string ErrorCode = "404";
        public string ErrorMessage = "Запрашиваемая вами информация не была найдена.";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (RouteData.Values["error"] != null)
            {
                string err = RouteData.Values["error"].ToString();
                switch (err)
                {
                    case "401":
                        ErrorCode = err;
                        ErrorMessage = "У вас недостаточно прав для просмотра этой страницы.";
                        break;
                    case "503":
                        ErrorCode = "503";
                        ErrorMessage = "Время действия ссылки истекло.";
                        break;
                    case "500":
                        ErrorCode = "500";
                        ErrorMessage = "Серверная ошибка";
                        break;
                }
            }
        }
    }
}