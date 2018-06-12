using CloudinaryDotNet;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Helpers;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.Services;

namespace AllWaifu
{
    /// <summary>
    /// Сводное описание для AjaxHelper
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Чтобы разрешить вызывать веб-службу из скрипта с помощью ASP.NET AJAX, раскомментируйте следующую строку. 
    [System.Web.Script.Services.ScriptService]
    public class AjaxHelper : System.Web.Services.WebService
    {
        SqlConnection _connection;
        [WebMethod]
        public bool IsEmailInBase(string email)
        {
            if (Membership.GetUserNameByEmail(email) != null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        [WebMethod]
        public bool IsLoginInBase(string Login)
        {
            bool result = false;
            _connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AllWaifu"].ConnectionString);
            _connection.Open();
            try
            {
                SqlCommand command = new SqlCommand("SELECT UserName FROM aspnet_Users WHERE LoweredUserName=@Login", _connection);
                command.Parameters.AddWithValue("Login", Login.ToLower());
                object answer = command.ExecuteScalar();
                if (answer != null)
                {
                    result = true;
                }
            }
            finally
            {
                _connection.Close();
                _connection = null;
            }
            return result;
        }
        [WebMethod]
        public bool IsPassCorrect(string Login, string pass)
        {
            return !Membership.ValidateUser(Login, pass);
        }
        [WebMethod]
        public string CreateCloudinarySignature(object settings)
        {
            var parameters = (settings as IDictionary<string, object>);

            Dictionary<string, object> dictionary = new Dictionary<string, object>();
            var newKeys = new List<string>(parameters.Keys);
            newKeys.Sort();
            foreach (var key in newKeys)
            {
                dictionary.Add(key, parameters[key]);
            }
            parameters = dictionary as IDictionary<string, object>;

            Account shin = new Account(
                "shingami322",
                "245454634769229",
                "rhdYXDZ5jXghrGWi3U2YZQPVPBg"
                );

            Cloudinary cloudinary = new Cloudinary(shin);
            return cloudinary.Api.SignParameters(parameters);
        }
        [WebMethod]
        public void ChangeImage(string login, string src)
        {
            var cmd = new SqlCommand("UPDATE Users SET Image=@Img WHERE Name=@Login");
            cmd.Parameters.AddWithValue("Img", (object)src ?? DBNull.Value);
            cmd.Parameters.AddWithValue("Login", login);
            UserFull.Simple_Change(cmd);
        }
        [WebMethod]
        public void AddWaifToBase(Dictionary<string, object> waif)
        {
            //Анти дудос, в продакшене раскоменть
            /*var cookie = Context.Request.Cookies["WL"];
            if(cookie != null)
            {
                return;
            }*/
            Waifu newWaif = new Waifu();
            newWaif.WaifuFromJs(waif);
            int id = Convert.ToInt32(waif["id"]);
            string confirmed = Convert.ToString(waif["confirmed"]);
            if (id != -1)
            {
                newWaif.Id = id;
                newWaif.UpdateBase(confirmed == "1");
            }
            else
            {
                if (confirmed == "1")
                {
                    newWaif.Confirmed = "1";
                }
                newWaif.SendToBase();
            }
            /*var nCookie = new HttpCookie("WL", "VioletEvergraden");
            nCookie.Expires = DateTime.Now.AddMinutes(1);
            Context.Response.Cookies.Add(nCookie);*/
        }
        [WebMethod]
        public void AddAnimeToBase(Dictionary<string, object> anime)
        {
            //Анти дудос, в продакшене раскоменть
            /*var cookie = Context.Request.Cookies["WL"];
            if(cookie != null)
            {
                return;
            }*/
            AnimeLight anim = new AnimeLight();
            anim.AnimeFromJs(anime);
            if (anim.Id == -1)
            {
                anim.SendToBase();
            }
            else
            {
                anim.UpdateBase();
            }
            anim.ClearCache();
            /*var nCookie = new HttpCookie("WL", "VioletEvergraden");
            nCookie.Expires = DateTime.Now.AddMinutes(1);
            Context.Response.Cookies.Add(nCookie);*/
        }
        [WebMethod]
        public void AddNewsToBase(Dictionary<string, object> news)
        {
            var post = new NewsFull();
            post.NewsFromJs(news);
            post.SendToBase();
        }
        [WebMethod]
        public void DeleteNews(int id)
        {
            try
            {
                NewsFull.DeleteFromBase(id);
            }
            catch (Exception)
            {

            }
        }
        [WebMethod]
        public string GetNews(int count, int offset)
        {
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                var Result = new List<NewsFull>();
                using (var cmd = new SqlCommand("SELECT * FROM News ORDER BY Id DESC " +
                                                "OFFSET @Of ROWS FETCH NEXT @Co ROWS ONLY", _connection))
                {
                    cmd.Parameters.AddWithValue("Of", offset);
                    cmd.Parameters.AddWithValue("Co", count);
                    var rd = cmd.ExecuteReader();
                    while(rd.Read())
                    {
                        var temp = new NewsFull();
                        temp.NewsFromReader(rd);
                        Result.Add(temp);
                    }
                    return new JavaScriptSerializer().Serialize(Result);
                }
            }
        }
        [WebMethod]
        public void AddUrlToCache(string url)
        {
            _connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AllWaifu"].ConnectionString);
            using (_connection)
            {
                _connection.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO CloudinaryCache VALUES (@Url)", _connection);
                cmd.Parameters.AddWithValue("Url", url);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
        }
        [WebMethod]
        public string SearchFull(int count, int offset, string by, string dir, string query = "all", string text = "", string tags = "", string user = "", string userType = "")
        {
            List<LightElement> Result = new List<LightElement>();
            using (_connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();

                if (dir != "ASC")
                {
                    dir = "DESC";
                }
                switch (by)
                {
                    case "Name":
                        break;
                    case "Popularity":
                        break;
                    default:
                        by = "Id";
                        break;
                }

                var serializer = new JavaScriptSerializer();
                string sortCommand = "ORDER BY " + by + " " + dir + " OFFSET " + offset.ToString() + " ROWS " +
                                  "FETCH NEXT " + count.ToString() + " ROWS ONLY";
                string aCommand = "(SELECT Id, Name, Image, Popularity, N'Аниме' as Type FROM Anime WHERE (Popularity > -1) {0}) ";
                string wCommand = "(SELECT Id, Name, Image, Popularity, N'Персонаж' as Type FROM Waifu WHERE (Popularity > -1) {0}) ";

                string wStatement = "";
                string aStatement = "";

                if(user != "")
                {
                    if (userType == "fav")
                    {
                        wStatement += "AND (Id IN (SELECT WaifuId FROM Favorites " +
                                      "WHERE UserId=(SELECT Id FROM Users WHERE " +
                                      "Name=N'" + user + "'))) ";
                    }
                    else
                    {
                        wStatement += "AND (Author=N'" + user + "') ";
                    }
                    query = "waifu";

                }
                if (query == "unconfirmed")
                {
                    wStatement += "AND (Confirmed != N'1') ";
                }
                if (query == "waifu" || query == "all")
                {
                    wStatement += "AND (Confirmed = N'1') ";
                }
                text = text.Trim().Replace(",", "").Replace(" ", "");
                tags = tags.Trim(',', ' ');
                if (!String.IsNullOrEmpty(text))
                {
                    wStatement += String.Format("AND ((Name LIKE N'%{0}%') OR (AlterNames LIKE N'%{0}%')) ", text); ;
                    aStatement += String.Format("AND (Name LIKE N'%{0}%') ", text);
                }
                if (!String.IsNullOrEmpty(tags))
                {
                    var fTags = tags.Split(',');
                    var tagLine = "";
                    for (int i = 0; i < fTags.Length; i++)
                    {
                        tagLine = "AND (dbo.GetWaifuTagsString(Id) LIKE N'%{0}%') ";
                        tagLine = String.Format(tagLine, fTags[i]);
                        wStatement += tagLine;
                    }
                    query = "waifu";
                }
                aCommand = String.Format(aCommand, aStatement);
                wCommand = String.Format(wCommand, wStatement);
                var execCommand = "";
                if (query == "all" || query=="text")
                {
                    execCommand = String.Format("{0} UNION {1} {2}", wCommand, aCommand, sortCommand);
                }
                if (query == "unconfirmed" || query == "waifu")
                {
                    execCommand = wCommand + sortCommand;
                }
                if (query == "anime")
                {
                    execCommand = aCommand + sortCommand;
                }
                using (var cmd = new SqlCommand(execCommand, _connection))
                {

                    using (var rd = cmd.ExecuteReader())
                    {
                        while (rd.Read())
                        {
                            LightElement wl = new LightElement(rd);
                            wl.Type = rd["Type"].ToString();
                            Result.Add(wl);
                        }
                    }
                    var sb = new StringBuilder();
                    serializer.Serialize(Result, sb);
                    return sb.ToString();
                }
            }
        }
        [WebMethod]
        public string GetComments(int count, int offset, string type, string id="")
        {
            var Result = new List<Comment>();
            var table = "";
            var idTable = "";
            switch (type)
            {
                case "anime":
                    table = "AnimeComments";
                    idTable = "AnimeId";
                    break;
                case "waifu":
                    table = "WaifuComments";
                    idTable = "WaifuId";
                    break;
                case "user":
                    table = "UserComments";
                    idTable = "UserTo";
                    break;
            }
            if(table == "")
            {
                return "";
            }
            using (_connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                var commandString = "SELECT * FROM " + table + " ";
                if(id != "")
                {
                    commandString += "WHERE "+idTable+"=N'" + id + "' ";
                }
                commandString += "ORDER BY Id DESC OFFSET " + offset.ToString() + " ROWS " +
                                 "FETCH NEXT " + count.ToString() +" ROWS ONLY";
                using (var cmd = new SqlCommand(commandString, _connection))
                {
                    using (var rd = cmd.ExecuteReader())
                    {
                        while(rd.Read())
                        {
                            Result.Add(new Comment(rd));
                        }
                    }
                }
            }
            return new JavaScriptSerializer().Serialize(Result);
        }
        [WebMethod]
        public string GetCommentById(string type, int id)
        {
            Comment result;
            var table = ReaderHelper.GetCommentsTable(type);
            if (table == "")
            {
                return "";
            }

            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("SELECT * FROM " + table + " WHERE Id=@Id", _connection))
                {
                    cmd.Parameters.AddWithValue("Id", id);
                    using( var rd = cmd.ExecuteReader())
                    {
                        rd.Read();
                        result = new Comment(rd);
                    }

                }
            }
            return new JavaScriptSerializer().Serialize(result);
        }
        [WebMethod]
        public bool PostComment(string text, string type, string userId, string id)
        {
            var table = ReaderHelper.GetCommentsTable(type);
            if(table == "")
            {
                return false;
            }
            using (_connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("SELECT Name FROM Users WHERE Id=@Id", _connection))
                {
                    cmd.Parameters.AddWithValue("Id", userId);
                    if(String.IsNullOrEmpty(cmd.ExecuteScalar().ToString()))
                    {
                        return false;
                    }
                }
                using (var cmd = new SqlCommand("INSERT INTO " + table + " VALUES(@UserId, @Id, @Text, " +
                                                "GETDATE())", _connection))
                {
                    cmd.Parameters.AddWithValue("UserId", userId);
                    cmd.Parameters.AddWithValue("Id", id);
                    cmd.Parameters.AddWithValue("Text", text);
                    cmd.ExecuteNonQuery();
                }
            }
            return true;
        }
        [WebMethod]
        public void AddToFavorites(int waifuId, string userName)
        {
            using(var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("INSERT INTO Favorites VALUES((SELECT Id FROM Users WHERE Name=@Name), @WId)", _connection))
                {
                    cmd.Parameters.AddWithValue("Name", userName);
                    cmd.Parameters.AddWithValue("WId", waifuId);
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch { }
                }
            }
        }
        [WebMethod]
        public void DeleteFromFavorites(int waifuId, string userName)
        {
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("DELETE FROM Favorites WHERE UserId=(SELECT Id FROM Users WHERE Name=@Name) AND WaifuId=@WId", _connection))
                {
                    cmd.Parameters.AddWithValue("Name", userName);
                    cmd.Parameters.AddWithValue("WId", waifuId);
                    cmd.ExecuteNonQuery();
                }
            }
        }
        [WebMethod]
        public string LiveSearch(string text)
        {
            var Result = new List<LiveSearchResult>();
            using (_connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                var tCmd = "(SELECT Id, Name, N'Waif' as Type, Popularity FROM Waifu WHERE (Confirmed = N'1') AND " +
                           "((Name LIKE N'%{0}%') OR (AlterNames LIKE N'%{0}%'))) UNION " +
                           "(SELECT Id, Name, N'Anime' as Type, Popularity FROM Anime WHERE " +
                           "Name LIKE N'%{0}%') ORDER BY Popularity DESC OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY";
                tCmd = String.Format(tCmd, text);
                using (var cmd = new SqlCommand(tCmd, _connection))
                {
                    var rd = cmd.ExecuteReader();
                    while(rd.Read())
                    {
                        Result.Add(new LiveSearchResult(rd));
                    }
                }
                if(Result.Count == 0)
                {
                    var temp = new LiveSearchResult();
                    temp.label = "Ничего не найдено.";
                    Result.Add(temp);
                }
                var serializer = new JavaScriptSerializer();
                return serializer.Serialize(Result);
            }
        }
        [WebMethod]
        public bool AnimeExist(string name)
        {
            using (_connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("SELECT Id FROM Anime WHERE Name=@Name", _connection))
                {
                    cmd.Parameters.AddWithValue("Name", name);

                    return null != cmd.ExecuteScalar();
                }
            }
        }
        [WebMethod]
        public bool SendRecoveryUrl(string email)
        {
            string userName = Membership.GetUserNameByEmail(email);
            if (String.IsNullOrEmpty(userName))
            {
                return false;
            }

            string token = Guid.NewGuid().ToString();
            string tokenUrl = HttpContext.Current.Request.Url.ToString();
            for (int i = 0; i < 2; i++)
            {
                tokenUrl = tokenUrl.Remove(tokenUrl.LastIndexOf("/"));
            }
            tokenUrl += "/recovery.aspx?token=" + token;
            SmtpHelper.SendRecoveryToken(email, tokenUrl);

            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("DELETE FROM RecoveryToken WHERE UserId=(SELECT Id FROM " +
                                               "Users WHERE Name=@UserName)", _connection))
                {
                    cmd.Parameters.AddWithValue("UserName", userName);
                    cmd.ExecuteNonQuery();
                }
                using (var cmd = new SqlCommand("INSERT INTO RecoveryTokens VALUES((SELECT Id FROM Users " +
                                               "WHERE Name=@UserName), @Token, GETDATE())", _connection))
                {
                    cmd.Parameters.AddWithValue("UserName", userName);
                    cmd.Parameters.AddWithValue("Token", token);
                    cmd.ExecuteNonQuery();
                }
            }
            return true;
        }

    }
}
