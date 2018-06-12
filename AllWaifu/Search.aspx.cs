using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class Search : System.Web.UI.Page
    {
        public string Type { get; set; } = "all";
        public string Text { get; set; } = "";
        public string Tags { get; set; } = "";
        public string User { get; set; } = "";
        public string UserType { get; set; } = "";
        public List<string> FormatedTags { get; set; } = new List<string>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (RouteData.Values["type"] != null)
            {
                Type = RouteData.Values["type"].ToString();
            }
            if (RouteData.Values["text"] != null)
            {
                Text = RouteData.Values["text"].ToString();
            }
            if (Request.QueryString["tags"] != null)
            {
                Tags = Request.QueryString["tags"].ToString();
            }
            if (Request.QueryString["user"] != null)
            {
                User = Request.QueryString["user"];
            }
            if (Request.QueryString["userby"] != null)
            {
                UserType = Request.QueryString["userby"];
            }
            LoadTags();

        }
        public void LoadTags()
        {
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("SELECT TagName FROM WaifuTags ORDER BY Popularity DESC", _connection))
                {
                    var rd = cmd.ExecuteReader();
                    while(rd.Read())
                    {
                        FormatedTags.Add(rd["TagName"].ToString());
                    }
                    rd.Close();
                }
            }
            TagRepeater.DataSource = FormatedTags;
            TagRepeater.DataBind();
            TagsRepeaterM.DataSource = FormatedTags;
            TagsRepeaterM.DataBind();
        }

    }
}