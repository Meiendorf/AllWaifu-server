using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AllWaifu
{
    public partial class Anime : System.Web.UI.Page
    {
        public AnimeLight PageAnim { get; set; } = null;
        public List<LightElement> TopViewed { get; set; } = new List<LightElement>();
        public List<LightElement> TopPers { get; set; } = new List<LightElement>();
        public List<Comment> Comments { get; set; } = new List<Comment>();
        public List<WaifuLight> Waifs { get; set; } = new List<WaifuLight>();
        public bool IsAdmin { get; set; } = false;
        public SqlConnection _connection { get; set; } = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            bool okey = false;
            string qId = RouteData.Values["id"].ToString();
            if (!String.IsNullOrEmpty(qId))
            {
                using (_connection = new SqlConnection(Global.WaifString))
                {
                    _connection.Open();
                    if (LoadAnime(Convert.ToInt32(qId)))
                    {
                        LoadTops(3);
                        LoadComments();
                        LoadWaifs();
                        BindAll();
                        okey = true;
                    }
                }
            }
            if(!okey)
            {
                Response.Redirect("/error/NotFound");
            }
            if (Request.IsAuthenticated)
            {
                if ((Master as AllWaifu).user == null)
                {
                    (Master as AllWaifu).user = new UserFull(Membership.GetUser());
                }
                string role = (Master as AllWaifu).user.Role;
                if (role.ToLower() == "admin" || role.ToLower() == "ghost writer")
                {
                    IsAdmin = true;
                }
            }
        }
        public bool LoadAnime(int id)
        {
            if(_connection == null)
            {
                return false;
            }
            var res = false;
            using (var cmd = new SqlCommand("SELECT * FROM Anime WHERE Id=@Id", _connection))
            {
                cmd.Parameters.AddWithValue("Id", id);
                var rd = cmd.ExecuteReader();
                if (rd.Read())
                {
                    PageAnim = new AnimeLight(rd);
                    res = true;
                }
                rd.Close();
            }
            return res;
        }
        public void LoadTops(int count)
        {
            string command = "SELECT TOP {0} a.Id, a.Name, a.Image, a.Popularity, COUNT(w.Id) as waifCount " +
                             "FROM Anime a LEFT JOIN Waifu w ON (w.AnimeId LIKE a.Id) GROUP BY " +
                             "a.Id, a.Name, a.Image, a.Popularity, a.Description ORDER BY {1} DESC";
            using (var cmd = new SqlCommand(String.Format(command, count, "a.Popularity"), _connection))
            {
                var rd = cmd.ExecuteReader();
                while(rd.Read())
                {
                    AnimeLight temp = new AnimeLight(rd);
                    TopViewed.Add(temp);
                }
                rd.Close();
            }
           
            using (var cmd = new SqlCommand(String.Format(command, count, "waifCount"), _connection))
            {
                var rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    AnimeLight temp = new AnimeLight(rd);
                    temp.Popularity = Convert.ToInt32(rd["waifCount"]);
                    TopPers.Add(temp);
                }
                rd.Close();
            }
        }
        public void LoadComments()
        {
            using (var cmd = new SqlCommand("SELECT * FROM AnimeComments WHERE AnimeId = @Id", _connection))
            {
                cmd.Parameters.AddWithValue("Id", PageAnim.Id);
                var rd = cmd.ExecuteReader();
                while(rd.Read())
                {
                    Comments.Add(new Comment(rd));
                }
                rd.Close();
            }
        }
        public void LoadWaifs()
        {
            
            using (var cmd = new SqlCommand("SELECT w.Id, w.Name, w.Image, w.Popularity, Count(f.Id) as Favority " +
                                            "FROM Waifu w LEFT JOIN Favorites f ON(f.WaifuId = w.Id) WHERE AnimeId LIKE @Id " +
                                            "GROUP BY w.Id, w.Name, w.Image, w.Popularity ORDER BY w.Popularity DESC", _connection))
            {
                cmd.Parameters.AddWithValue("Id", PageAnim.Id);
                var rd = cmd.ExecuteReader();
                while(rd.Read())
                {
                    Waifs.Add(new WaifuLight(rd));
                }
                rd.Close();
            }
        }
        public void BindAll()
        {
            CommentsBlock.Data = Comments;
            WaifsRepeater.DataSource = Waifs;
            TopViewsControl.Data = TopViewed;
            TopPersControl.Data = TopPers;
            WaifsRepeater.DataBind();   
        }
    }
}