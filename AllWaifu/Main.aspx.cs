using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class IndexPage : System.Web.UI.Page
    {
        public List<WaifuLight> TopWaifu { get; set; } = new List<WaifuLight>();
        public List<WaifuLight> RandomWaifu { get; set; } = new List<WaifuLight>();
        public List<AnimeLight> TopAnime { get; set; } = new List<AnimeLight>();
        public List<NewsFull> TopNews { get; set; } = new List<NewsFull>();

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadLists();
            BindAll();
        }

        public void LoadLists()
        {
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                var sCmd = "SELECT TOP 10 Id, Name, Image, Popularity FROM {0} {1} ORDER BY Popularity DESC ";
                using(var cmd = new SqlCommand(String.Format(sCmd, "Waifu", " WHERE Confirmed = N'1'"), _connection))
                {
                    using (var rd = cmd.ExecuteReader())
                    {
                        while (rd.Read())
                        {
                            TopWaifu.Add(new WaifuLight(rd));
                        }
                    }
                }
                using (var cmd = new SqlCommand(String.Format(sCmd, "Anime", ""), _connection))
                {
                    using (var rd = cmd.ExecuteReader())
                    {
                        while (rd.Read())
                        {
                            TopAnime.Add(new AnimeLight(rd));
                        }
                    }
                }
                using (var cmd = new SqlCommand("SELECT TOP 6 Id, Name, Image, Popularity FROM Waifu WHERE Confirmed=N'1' ORDER BY Newid()", _connection))
                {
                    using (var rd = cmd.ExecuteReader())
                    {
                        while (rd.Read())
                        {
                            RandomWaifu.Add(new WaifuLight(rd));
                        }
                    }
                }
                using (var cmd = new SqlCommand("SELECT TOP 10 Id, Title, Date FROM News ORDER BY Id DESC", _connection))
                {
                    using (var rd = cmd.ExecuteReader())
                    {
                        while (rd.Read())
                        {
                            var temp = new NewsFull(rd);
                            temp.Date = temp.Date.Remove(temp.Date.LastIndexOf('.'));
                            TopNews.Add(temp);
                        }
                    }
                }
            }
        }
        public void BindAll()
        {
            TopWaifuRepeater.DataSource = TopWaifu;
            TopWaifuRepeater.DataBind();
            RandomWaifRepeater.DataSource = RandomWaifu;
            RandomWaifRepeater.DataBind();
            TopAnimeRepeater.DataSource = TopAnime;
            TopAnimeRepeater.DataBind();
            TopNewsRepeater.DataSource = TopNews;
            TopNewsRepeater.DataBind();
        }
    }

}