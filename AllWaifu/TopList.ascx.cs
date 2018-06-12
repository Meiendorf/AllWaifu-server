using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class TopList : System.Web.UI.UserControl
    {
        public string PageUrl { get; set; } = "Error.aspx";
        public List<LightElement> Data { get; set; } = new List<LightElement>();
        public string PopIconClass { get; set; } = "fa-eye";

        protected void Page_Load(object sender, EventArgs e)
        {
            
            TopRepeater.DataSource = Data;
            TopRepeater.DataBind();
        }
    }
}