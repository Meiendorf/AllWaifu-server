using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class Comments : System.Web.UI.UserControl
    {
        public List<Comment> Data = null;
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Data == null)
            {
                Data = new List<Comment>();
            }
            CommentsRepeater.DataSource = Data;
            if (Data.Count == 0)
            {
                CommentsList.Visible = false;
            }
            CommentsRepeater.DataBind();
        }
    }
}