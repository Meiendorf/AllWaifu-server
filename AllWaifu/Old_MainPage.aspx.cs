using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class MainPage : System.Web.UI.Page
    {
        public SqlConnection _connection { get; set; }

        public int PageNumber = 1;
        public int ItemsOnPage = 6;
        public int PageCount;
        public Pagination MainPagination;
        public List<WaifuLight> PageContent = new List<WaifuLight>();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                PageNumber = Convert.ToInt32(Request.QueryString["page"]);
                if (PageNumber == 0)
                {
                    PageNumber++;
                }
            }
            catch { }
            GetPageFromDB(PageNumber);
        }

        public void GetPageFromDB(int pageNum)
        {
            string connectionString = Global.WaifString;
            _connection = new SqlConnection(connectionString);
            _connection.Open();

            object Count = new SqlCommand("SELECT COUNT(*) FROM Waifu", _connection).ExecuteScalar();
            PageCount = Convert.ToInt32(Math.Ceiling(Convert.ToDouble(Count) / Convert.ToDouble(ItemsOnPage)));
            MainPagination = new Pagination(PageCount, pageNum);

            SqlCommand GetPageCommand = new SqlCommand("EXEC GetWaifuPage @offset, @page_size", _connection);
            GetPageCommand.Parameters.AddWithValue("offset", ItemsOnPage * (PageNumber - 1));
            GetPageCommand.Parameters.AddWithValue("page_size", ItemsOnPage);

            SqlDataReader rd = GetPageCommand.ExecuteReader();
            while (rd.Read())
            {
                WaifuLight item = new WaifuLight(rd);
                PageContent.Add(item);
            }
            rd.Close();

            ContentRepeater.DataSource = PageContent;
            ContentRepeater.DataBind();
            PaginationRepeater.DataSource = MainPagination.PaginationElements;
            PaginationRepeater.DataBind();
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            if (_connection != null && _connection.State != ConnectionState.Closed)
            {
                _connection.Close();
            }
        }
    }
}