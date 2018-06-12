using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class Old_Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString["type"]!=null)
            {
                string type = Request.QueryString["type"];
                if(type == "unconfirmed")
                {
                    // LoadUnconfirmed();
                    QueryType.Value = type;
                }
            }
        }
        public void LoadUnconfirmed()
        {

        }
    }
}