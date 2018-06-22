using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Xml;

namespace AllWaifu
{
    public class ChapterElement
    {
        public string Title { get; set; } = "";
        public string Content { get; set; } = "";

        public ChapterElement() { }

        public ChapterElement(XmlNode xElement)
        {
            if (xElement.Attributes.Count > 0)
            {
                Title = xElement.Attributes.GetNamedItem("title").Value;
            }
            Content = xElement.InnerText;
        }
        public XmlElement ToXmlElement(XmlDocument xDoc)
        {
            var xmlEl = xDoc.CreateElement("element");
            xmlEl.SetAttribute("title", Title);
            xmlEl.InnerText = Content;
            return xmlEl;
        }
    }

    public class DescriptionChapter
    {
        public string Title { get; set; } = "None";
        private string cssClass = "";
        public string SizeCssClass
        {
            get
            {
                return cssClass;
            }
            set
            {
                switch(value)
                {
                    case "0.3":
                        cssClass = "col-md-4";
                        break;
                    case "0.5":
                        cssClass = "col-md-6";
                        break;
                    case "1":
                        cssClass = "col-md-12";
                        break;
                    default:
                        cssClass = value;
                        break;
                }
            }
        }
        public List<ChapterElement> Elements { get; set; } = new List<ChapterElement>();

        public DescriptionChapter()
        {
        }

        public DescriptionChapter(XmlNode xChapter)
        {
            if (xChapter.Attributes.Count > 0)
            {
                Title = xChapter.Attributes.GetNamedItem("title").Value;
                SizeCssClass = xChapter.Attributes.GetNamedItem("size").Value;
            }

            foreach (XmlNode element in xChapter.ChildNodes)
            {
                Elements.Add(new ChapterElement(element));
            }
        }
        public XmlElement ToXmlElement(XmlDocument xDoc)
        {
            var xmlEl = xDoc.CreateElement("chapter");
            xmlEl.SetAttribute("title", Title);
            xmlEl.SetAttribute("size", SizeCssClass);
            foreach (var el in Elements)
            {
                xmlEl.AppendChild(el.ToXmlElement(xDoc));
            }
            return xmlEl;
        }
    }

    public class Waifu
    {
        public string Name { get; set; }
        public string Author { get; set; }
        public string Anime { get; set; }
        public string AlterNames { get; set; }
        public string AnimeId { get; set; } = "-1";
        public int Id { get; set; } = -1;
        public string Image { get; set; }
        public string tags;
        public List<string> FormatTags { get; private set; } = new List<string>();
        public List<LightElement> OurTags { get; set;  } = new List<LightElement>();
        public string Confirmed { get; set; }
        public string Tags
        {
            set
            {
                tags = value;
                string[] rowTags = value.Split(',');
                foreach (var tag in rowTags)
                {
                    FormatTags.Add(tag.Trim());
                }
            }
            get
            {
                return tags;
            }
        }
        public string Popularity { get; set; }
        public string Favority { get; set; }
        public List<Comment> Comments { get; set; } = new List<Comment>();
        public List<DescriptionChapter> Chapters { get; set; } = new List<DescriptionChapter>();

        public Waifu()
        {

        }
        public Waifu(string name, string author, string anime, int id, string image, string tags)
        {
            Name = name;
            Author = author;
            Anime = anime;
            Id = id;
            Image = image;
            Tags = tags;
        }
        
        public bool ReadFromBase(int id)
        {
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("SELECT COUNT(WaifuId) FROM Favorites WHERE WaifuId=@Id", _connection))
                {
                    cmd.Parameters.AddWithValue("Id", id);
                    Favority = cmd.ExecuteScalar().ToString();
                }
                using (SqlCommand command = new SqlCommand("SELECT w.*, a.Name as Anime FROM Waifu w LEFT JOIN Anime a ON " +
                                                    "(w.AnimeId = CAST(a.Id as NVARCHAR(MAX))) WHERE w.Id=@ID", _connection))
                {

                    command.Parameters.AddWithValue("ID", id);

                    SqlDataReader rd = command.ExecuteReader();
                    if (rd.Read())
                    {
                        Id = Convert.ToInt32(rd["Id"]);
                        Name = Convert.ToString(rd["Name"]);
                        AlterNames = Convert.ToString(rd["AlterNames"]);
                        Anime = Convert.ToString(rd["Anime"]);
                        int res = -1;
                        if (int.TryParse(rd["AnimeId"].ToString(), out res))
                        {
                            AnimeId = res.ToString();
                        }
                        if (AnimeId == "-1")
                        {
                            Anime = rd["AnimeId"].ToString();
                        }
                        Author = Convert.ToString(rd["Author"]);
                        Popularity = Convert.ToString(rd["Popularity"]);
                        Image = Convert.ToString(rd["Image"]);
                        Confirmed = Convert.ToString(rd["Confirmed"]);
                        LoadChaptersFromXml(Convert.ToString(rd["Description"]));
                        LoadComments();
                        LoadTags();
                        return true;
                    }
                }
            }
                return false;
        }
        public void LoadTags()
        {
            if (Id == -1)
            {
                return;
            }
            SqlConnection _connection = new SqlConnection(Global.WaifString);
            try
            {
                _connection.Open();
                SqlCommand cmd = new SqlCommand("SELECT w.TagName, w.Popularity FROM WaifuTagsList as l INNER JOIN WaifuTags as w "+
                                                "ON w.TagName=l.TagId WHERE l.WaifuId=@Id", _connection);
                cmd.Parameters.AddWithValue("Id", Id);
                var rd = cmd.ExecuteReader();
                FormatTags.Clear();
                while(rd.Read())
                {
                    var temp = new LightElement();
                    temp.Name = rd["TagName"].ToString();
                    temp.Popularity = Convert.ToInt32(rd["Popularity"]);
                    OurTags.Add(temp);
                    FormatTags.Add(rd["TagName"].ToString());
                }
                rd.Close();
                cmd.Dispose();
            }
            finally
            {
                _connection.Close();
            }
        }
        public void LoadComments()
        {
            if (Id == -1)
            {
                return;
            }
            SqlConnection _connection = new SqlConnection(Global.WaifString);
            _connection.Open();
            try
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM WaifuComments WHERE WaifuId=@Id", _connection);
                cmd.Parameters.AddWithValue("Id", Id);

                Comments = LoadCommentList(cmd);
            }
            finally
            {
                _connection.Close();
            }
        }
        public void WaifuFromJs(Dictionary<string, object> waif)
        {
            Name = waif["name"].ToString();
            AlterNames = waif["alterNames"].ToString();
            Anime = waif["anime"].ToString();
            Author = waif["author"].ToString();
            Image = waif["imageName"].ToString();
            Tags = waif["tags"].ToString();
            object[] chapters = waif["chapters"] as object[];
            foreach(var chapt in chapters)
            {
                var rChapt = chapt as Dictionary<string, object>;
                var wChapt = new DescriptionChapter();
                wChapt.SizeCssClass = rChapt["type"].ToString();
                wChapt.Title = rChapt["name"].ToString();
                var rFields = rChapt["fields"] as object[];
                foreach(var field in rFields)
                {
                    var rField = field as Dictionary<string, object>;
                    var wElement = new ChapterElement();
                    wElement.Title = rField["name"].ToString();
                    wElement.Content = rField["value"].ToString();
                    wChapt.Elements.Add(wElement);
                }
                Chapters.Add(wChapt);
            }
        }
        public void RefreshTags()
        {
            if(Id == -1)
            {
                return;
            }
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                var cmd = new SqlCommand("DELETE FROM WaifuTagsList WHERE WaifuId=@Id", _connection);
                cmd.Parameters.AddWithValue("Id", Id);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                foreach (var el in FormatTags)
                {
                    cmd = new SqlCommand("INSERT INTO WaifuTagsList VALUES(@Id, @TagName);", _connection);
                    cmd.Parameters.AddWithValue("TagName", el);
                    cmd.Parameters.AddWithValue("Id", Id);
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                }
            }
        }
        public void UpdateBase(bool approve = false)
        {
            if (Id == -1)
            {
                return;
            }
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                if (approve)
                {
                    Notification.AddNew(Author, "<a href=\"/waifu/"+Id.ToString()+"\">Ваше описание было принято!</a>",
                                        true, Image, "/waifu/"+Id.ToString());
                    Confirmed = "1";
                }
                SqlCommand cmd;
                if (Confirmed == "1")
                {
                    RefreshTags();
                }
                cmd = new SqlCommand("UPDATE Waifu SET Name=@Name, AnimeId=@AnimeId, " +
                                     "Author=@Author, Image=@Image, Description=@Description, " +
                                     "Confirmed=@Confirmed, AlterNames=@AlterNames WHERE Id=@Id", _connection);
                cmd.Parameters.AddWithValue("Id", Id);
                cmd.Parameters.AddWithValue("Name", Name);
                using (var _cmd = new SqlCommand("SELECT Id FROM Anime WHERE Name=@Name", _connection))
                {
                    _cmd.Parameters.AddWithValue("Name", Anime);
                    var res = (_cmd.ExecuteScalar());
                    if (res != null)
                    {
                        cmd.Parameters.AddWithValue("AnimeId", res.ToString());
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("AnimeId", Anime);
                    }
                };
                cmd.Parameters.AddWithValue("Author", Author);
                cmd.Parameters.AddWithValue("Image", Image);
                cmd.Parameters.AddWithValue("Description", DescToXmlDocument());
                cmd.Parameters.AddWithValue("Confirmed", Confirmed);
                cmd.Parameters.AddWithValue("AlterNames", AlterNames);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
        }
        public void SendToBase()
        {
            if (Id != -1)
            {
                return;
            }
            SqlConnection _connection = new SqlConnection(Global.WaifString);
            using (_connection)
            {
                _connection.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO Waifu (Name, AnimeId, Author, Image, Description, Confirmed, AlterNames) " +
                                                "VALUES(@Name, @AnimeId, @Author, @Image, @Description, @Confirmed, @AlterNames)", _connection);

                cmd.Parameters.AddWithValue("Name", Name);
                cmd.Parameters.AddWithValue("AlterNames", AlterNames);
                using (var _cmd = new SqlCommand("SELECT Id FROM Anime WHERE Name=@Name", _connection))
                {
                    _cmd.Parameters.AddWithValue("Name", Anime);
                    var res = (_cmd.ExecuteScalar());
                    if(res != null)
                    {
                        cmd.Parameters.AddWithValue("AnimeId", res.ToString());
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("AnimeId", Anime);
                    }
                }
                cmd.Parameters.AddWithValue("Author", Author);
                cmd.Parameters.AddWithValue("Image", Image);
                cmd.Parameters.AddWithValue("Description", DescToXmlDocument());
                if (Confirmed != "1")
                {
                    cmd.Parameters.AddWithValue("Confirmed", tags);
                }
                else
                {
                    RefreshTags();
                    cmd.Parameters.AddWithValue("Confirmed", Confirmed);
                }

                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
        }
        public string DescToXmlDocument()
        {
            XmlDocument xDoc = new XmlDocument();
            XmlDeclaration xDec = xDoc.CreateXmlDeclaration("1.0", "utf-8", null);
            xDoc.AppendChild(xDec);
            var xRoot = xDoc.CreateElement("chapters");
            foreach(var chapter in Chapters)
            {
                xRoot.AppendChild(chapter.ToXmlElement(xDoc));
            }
            xDoc.AppendChild(xRoot);

            return xDoc.OuterXml;
        }
        public static List<Comment> LoadCommentList(SqlCommand cmd)
        {
            var Comments = new List<Comment>();
            var rd = cmd.ExecuteReader();

            while (rd.Read())
            {
                Comment Temp = new Comment();
                Temp.From = new UserLight(rd["UserFrom"].ToString());
                Temp.Text = rd["Text"].ToString();
                Comments.Add(Temp);
            }
            
            rd.Close();
            cmd.Dispose();
            return Comments;

        }
        public void LoadChaptersFromXml(string xChapters)
        {
            XmlDocument xDoc = new XmlDocument();
            xDoc.LoadXml(xChapters);

            foreach (XmlNode xChapter in xDoc.DocumentElement)
            {
                Chapters.Add(new DescriptionChapter(xChapter));
            }
        }
    }

    public class LightElement
    {
        public int Id { get; set; } = -1;
        public string Type { get; set; } = "";
        public int Popularity { get; set; } = 1;
        public string Name { get; set; }
        public string Image { get; set; }

        public LightElement()
        {

        }
        public LightElement(SqlDataReader rd)
        {
            if (rd.ColumnExists("Id"))
            {
                Id = Convert.ToInt32(rd["Id"]);
            }
            if (rd.ColumnExists("Name"))
            {
                Name = Convert.ToString(rd["Name"]);
            }
            if (rd.ColumnExists("Image"))
            {
                Image = Convert.ToString(rd["Image"]);
            }
            if(rd.ColumnExists("Popularity"))
            try
            {
                Popularity = Convert.ToInt32(rd["Popularity"]);
            }
            catch { }
        }
    }

    public class WaifuLight : LightElement
    {
        public string Anime { get; set; } = "";
        public string AnimeId { get; set; } = "-1";
        public int Favority { get; set; } = 0;
        public WaifuLight(SqlDataReader rd )  
            : base(rd)
        {
            Type = "Персонаж";
            if (rd.ColumnExists("AnimeId"))
            {
                AnimeId = Convert.ToString(rd["AnimeId"]);
            }
            if (rd.ColumnExists("Anime"))
            {
                Anime = Convert.ToString(rd["Anime"]);
            }
            if(rd.ColumnExists("Favority"))
            {
                Favority = Convert.ToInt32(rd["Favority"]);
            }

        }
        public WaifuLight()
        {
            Type = "Персонаж";
        }
    }

    public class AnimeLight : LightElement
    {
        public string Description { get; set; } = "";
        public string WatchLink { get; set; } = "#";
        public List<Comment> Comments { get; set; } = new List<Comment>();
        public AnimeLight()
        {
            Type = "Аниме";
        }
        public AnimeLight(SqlDataReader rd)
            : base(rd)
        {
            if (rd.ColumnExists("Description"))
            {
                Description = Convert.ToString(rd["Description"]);
            }
            if (rd.ColumnExists("WatchLink"))
            {
                WatchLink = Convert.ToString(rd["WatchLink"]);
            }
        }
        public void AnimeFromJs(Dictionary<string, object> anime)
        {
            Name = anime["name"].ToString();
            Image = anime["image"].ToString();
            WatchLink = anime["url"].ToString();
            Description = anime["description"].ToString();
            if(anime.ContainsKey("id"))
            {
                Id = Convert.ToInt32(anime["id"]);
            }
        }
        public void SendToBase()
        {
            if(Id != -1)
            {
                return;
            }
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("INSERT INTO Anime VALUES(@Name, @Image, 1, @Desc, @Url)", _connection))
                {
                    cmd.Parameters.AddWithValue("Name", Name);
                    cmd.Parameters.AddWithValue("Image", Image);
                    cmd.Parameters.AddWithValue("Desc", Description);
                    cmd.Parameters.AddWithValue("Url", WatchLink);
                    cmd.ExecuteNonQuery();
                }
                using (var cmd = new SqlCommand("UPDATE Waifu SET AnimeId=@Id WHERE AnimeId=@Name", _connection))
                {
                    cmd.Parameters.AddWithValue("Id", Id);
                    cmd.Parameters.AddWithValue("Name", Name);
                    cmd.ExecuteNonQuery();
                }
            }
        }
        public void UpdateBase()
        {
            if(Id == -1)
            {
                return;
            }
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("UPDATE Anime SET Name=@Name, Image=@Image, Description=@Description," +
                                              " WatchLink=@WatchLink WHERE Id=@Id", _connection))
                {
                    cmd.Parameters.AddWithValue("Name", Name);
                    cmd.Parameters.AddWithValue("Image", Image);
                    cmd.Parameters.AddWithValue("Description", Description);
                    cmd.Parameters.AddWithValue("WatchLink", WatchLink);
                    cmd.Parameters.AddWithValue("Id", Id);
                    cmd.ExecuteNonQuery();
                }
            }
        }
        public void ClearCache()
        {
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("DELETE FROM CloudinaryCache WHERE Url=@PublicId", _connection))
                {
                    var public_id = Image.Substring(Image.LastIndexOf('/') + 1);
                    public_id = public_id.Substring(0, public_id.Length - 4);
                    cmd.Parameters.AddWithValue("PublicId", public_id);
                    cmd.ExecuteNonQuery();
                }
            }
        }
        public void LoadComments()
        {
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("SELECT * From AnimeComments WHERE AnimeId=@Id"))
                {
                    cmd.Parameters.AddWithValue("Id", Id);
                    using (var rd = cmd.ExecuteReader())
                    {
                        while(rd.Read())
                        {
                            Comments.Add(new Comment(rd));
                        }
                    }
                }
            }
        }
    }

    public class Pagination
    {
        const string FaPrev = @"<li><a href=""{0}""><i class=""fa fa-angle-double-left"" aria-hidden=""true""></i></a></li>";
        const string FaNext = @"<li><a href=""{0}""><i class=""fa fa-angle-double-right"" aria-hidden=""true""></i></a></li>";
        const string ActivePage = @"<li class=""active""><a href = ""{0}"" > {1} </a></li>";
        const string Page = @"<li><a href =""{0}""> {1} </a></li>";
        const string Separator = @"<li><span>...</span></li>";
        const string LinkFormat = "/MainPage.aspx?page={0}#main";

        public List<String> PaginationElements = new List<string>();

        public Pagination(int pageCount, int currPage)
        {
            if (currPage > 1)
            {
                AddInPagination(currPage - 1, PagElVar.FaPrev);
            }

            if (pageCount > 7)
            {
                if (currPage != 1)
                {
                    AddInPagination(1, PagElVar.Page);
                }
                else
                {
                    AddInPagination(currPage, PagElVar.ActivePage);
                }
                for (int i = currPage - 2; i < currPage + 3; i++)
                {
                    if (i > 0 || i < pageCount)
                    {
                        if (i != currPage)
                        {
                            AddInPagination(currPage, PagElVar.Page);
                        }
                        else
                        {
                            AddInPagination(currPage, PagElVar.ActivePage);
                        }
                    }
                }
                if (currPage != pageCount)
                {
                    AddInPagination(pageCount, PagElVar.Page);
                }
                else
                {
                    AddInPagination(currPage, PagElVar.ActivePage);
                }
            }
            else
            {
                for (int i = 1; i < pageCount + 1; i++)
                {

                    if (i != currPage)
                    {
                        AddInPagination(i, PagElVar.Page);
                    }
                    else
                    {
                        AddInPagination(i, PagElVar.ActivePage);
                    }

                }
            }

            if (currPage < pageCount)
            {
                AddInPagination(currPage + 1, PagElVar.FaNext);
            }
        }

        public void AddInPagination(int num, PagElVar what)
        {
            switch (what)
            {
                case PagElVar.FaNext:
                    PaginationElements.Add(String.Format(FaNext, String.Format(LinkFormat, num)));
                    break;
                case PagElVar.FaPrev:
                    PaginationElements.Add(String.Format(FaPrev, String.Format(LinkFormat, num)));
                    break;
                case PagElVar.ActivePage:
                    PaginationElements.Add(String.Format(ActivePage, String.Format(LinkFormat, num), num));
                    break;
                case PagElVar.Page:
                    PaginationElements.Add(String.Format(Page, String.Format(LinkFormat, num), num));
                    break;
            }
        }
    }

    public class UserLight
    {
        public string Id { get; protected set; } = "-1";
        public string Login { get; protected set; } = "";
        public string Image { get; protected set; } = "";

        public UserLight()
        {
        }

        public UserLight(string login)
        {
            SqlConnection _connection = new SqlConnection(Global.WaifString);
            _connection.Open();
            try
            {
                SqlCommand cmd = new SqlCommand("SELECT Id, Image FROM Users WHERE Name=@Login", _connection);
                cmd.Parameters.AddWithValue("Login", login);
                var rb = cmd.ExecuteReader();
                if (rb.Read())
                {
                    Id = rb["Id"].ToString();
                    Image = rb["Image"].ToString();
                    Login = login;
                }
                rb.Close();
            }
            finally
            {
                _connection.Close();
            }
        }
        public void LoadById(string id)
        {
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("SELECT Image, Name FROM Users WHERE Id=@Id", _connection))
                {
                    cmd.Parameters.AddWithValue("Id", id);
                    using (var rd = cmd.ExecuteReader())
                    {
                        rd.Read();
                        Login = rd["Name"].ToString();
                        Image = rd["Image"].ToString();
                        Id = id;
                    }
                }
            }
        }
    }

    public class UserFull : UserLight
    {
        public string Url { get; private set; }
        public string Email { get; private set; }
        public string FullName { get; private set; }
        public string Role { get; private set; } = "User";
        public string Description { get; private set; }
        public string RegDate { get; private set; }
        public string Color { get; private set; }
        public int Reputation { get; private set; } = 1;
        public bool CanComment { get; private set; } = true;
        public bool NotifyComment { get; private set; } = true;
        public bool Exist { get; private set; } = false;
        public List<WaifuLight> Favorites { get; private set; } = new List<WaifuLight>();
        public List<WaifuLight> Added { get; private set; } = new List<WaifuLight>();
        public List<Comment> Comments { get; private set; } = new List<Comment>();
        public List<Notification> Notifications { get; private set; } = new List<Notification>();
        private MembershipUser User { get; set; }
        public UserFull() { }

        public UserFull(MembershipUser user)
        {
            if(user == null)
            {
                return;
            }
            User = user;
            Email = user.Email;
            Login = user.UserName;
            Id = user.ProviderUserKey.ToString();
            RegDate = user.CreationDate.ToShortDateString();
            GetUserFromUsers(Id);
            Roles_Init();
            if (String.IsNullOrEmpty(Description))
            {
                Description = "Новый пользователь.";
            }
        }
        
        public UserFull(string login) :
            this(Membership.GetUser(login))
        {
        }

        public bool Change_Login(string login)
        {
            Regex loginEx = new Regex("^[а-яА-ЯёЁa-zA-Z0-9_]{3,30}$");
            if (!loginEx.IsMatch(login) || (login == Login))
            {
                return false;
            }
            if (Membership.GetUser(login)==null)
            {
                var _connection = new SqlConnection(Global.WaifString);
                _connection.Open();
                try
                {
                    using (var cmd = new SqlCommand("UPDATE Users SET Name=@Login WHERE Name=@Current", _connection))
                    {
                        cmd.Parameters.AddWithValue("Login", login);
                        cmd.Parameters.AddWithValue("Current", Login);
                        cmd.ExecuteNonQuery();
                    }
                    using (var cmd = new SqlCommand("UPDATE aspnet_Users SET UserName=@Login, LoweredUserName=@LLogin WHERE UserName=@Current", _connection))
                    {
                        cmd.Parameters.AddWithValue("Login", login);
                        cmd.Parameters.AddWithValue("LLogin", login.ToLower());
                        cmd.Parameters.AddWithValue("Current", Login);
                        cmd.ExecuteNonQuery();
                    }
                    using (var cmd = new SqlCommand("UPDATE Waifu SET Author=@Login WHERE Author=@Current", _connection))
                    {
                        cmd.Parameters.AddWithValue("Login", login);
                        cmd.Parameters.AddWithValue("Current", Login);
                        cmd.ExecuteNonQuery();
                    }
                    var CommentsTables = new string[] { "WaifuComments", "UserComments", "AnimeComments" };
                    foreach(var el in CommentsTables)
                    {
                        using (var cmd = new SqlCommand(String.Format("UPDATE {0} SET UserFrom=@Login WHERE UserFrom=@current", el), _connection))
                        {
                            cmd.Parameters.AddWithValue("Login", login);
                            cmd.Parameters.AddWithValue("Current", Login);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
                finally
                {
                    _connection.Close();
                }
                Login = login;
                FormsAuthentication.SignOut();
                FormsAuthentication.SetAuthCookie(Login, true);
                return true;
            }
            else
            {
                return false;
            }
        }
        public bool Change_Email(string email)
        {
            if (email != Email)
            {
                Regex emailEx = new Regex(@"^[^@]+@[^@.]+\.[^@]+$");
                if (!emailEx.IsMatch(email))
                {
                    return false;
                }
                if (Membership.GetUserNameByEmail(email) == null)
                {
                    var cmd = new SqlCommand("UPDATE aspnet_Membership SET Email=@Mail, LoweredEmail=@LMail WHERE Email=@Mil");
                    cmd.Parameters.AddWithValue("Mail", email);
                    cmd.Parameters.AddWithValue("LMail", email.ToLower());
                    cmd.Parameters.AddWithValue("Mil", Email);
                    Simple_Change(cmd);
                    Email = email;
                    return true;
                }
                else
                {
                    return false;
                }
            }
            return false;
        }
        public void Change_Description(string desc)
        {
            if (desc != Description)
            {
                var cmd = new SqlCommand("UPDATE Users SET Description=@Desc WHERE Name=@Login");
                cmd.Parameters.AddWithValue("Desc", (object)desc ?? DBNull.Value);
                cmd.Parameters.AddWithValue("Login", Login);
                Simple_Change(cmd);
            }
        }
        public void Change_Url(string url)
        {
            if (url != Url)
            {
                var cmd = new SqlCommand("UPDATE Users SET Url=@Url WHERE Name=@Login");
                cmd.Parameters.AddWithValue("Url", (object)url ?? DBNull.Value);
                cmd.Parameters.AddWithValue("Login", Login);
                Simple_Change(cmd);
            }
        }
        public void Change_Image(string image)
        {
            if ((image != Image) && (image != "images/none.png"))
            {
                var cmd = new SqlCommand("UPDATE Users SET Image=@Img WHERE Name=@Login");
                cmd.Parameters.AddWithValue("Img", (object)image ?? DBNull.Value);
                cmd.Parameters.AddWithValue("Login", Login);
                Simple_Change(cmd);
            }
        }
        public void Change_Name(string name)
        {
            if (name != FullName)
            {
                var cmd = new SqlCommand("UPDATE Users SET RealName=@Nome WHERE Name=@Login");
                cmd.Parameters.AddWithValue("Nome", (object)name ?? DBNull.Value);
                cmd.Parameters.AddWithValue("Login", Login);
                Simple_Change(cmd);
            }
        }
        public static void Simple_Change(SqlCommand cmd)
        {
            var connection = new SqlConnection(Global.WaifString);
            connection.Open();
            cmd.Connection = connection;
            try
            {
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            finally
            {
                connection.Close();
            }
        }
        public void Change_Password(string oldPass, string newPass)
        {
            Regex passEx = new Regex(@"^[а-яА-ЯёЁa-zA-Z0-9_#@~*+=\-\/$%^&()\\\[\]|!?_-`\{\}]{6,30}$");
            if (passEx.IsMatch(newPass))
            {
                User.ChangePassword(oldPass, newPass);
            }
        }

        public void Roles_Init()
        {
            var roles = Roles.GetRolesForUser(Login);
            if (roles.Length > 0)
            {
                Role = roles[0];
            }

            switch (Role)
            {
                case "User":
                    Color = "#6500A9";
                    break;
                case "Admin":
                    Color = "#A90000";
                    break;
                case "Moder":
                    Color = "#2011EC";
                    break;
                default:
                    Color = "#A91197";
                    break;
            }
        }
        public void GetUserFromUsers(string id)
        {
            SqlConnection _connection = new SqlConnection(Global.WaifString);
            _connection.Open();
            try
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Users WHERE Id=@Id", _connection);
                cmd.Parameters.AddWithValue("Id", id);
                var rd = cmd.ExecuteReader();
                rd.Read();
                FullName = rd["RealName"].ToString();
                Url = rd["Url"].ToString();
                Description = rd["Description"].ToString();
                Image = rd["Image"].ToString();
                CanComment = Convert.ToBoolean(rd["CanComment"]);
                NotifyComment = Convert.ToBoolean(rd["NotifyComment"]);
                Reputation = Convert.ToInt16(rd["Reputation"]);
                rd.Close();
                cmd.Dispose();

                cmd = new SqlCommand("SELECT TOP 3 Id, Name, Image FROM Waifu WHERE Author=@Author AND Confirmed LIKE '1' ORDER BY Id DESC", _connection);
                cmd.Parameters.AddWithValue("Author", Login);

                rd = cmd.ExecuteReader();
                while(rd.Read())
                {
                    Added.Add(CreateFromReader(rd));
                }
 
                rd.Close();
                cmd.Dispose();

                cmd = new SqlCommand("SELECT TOP 3 Id, Name, Image FROM Waifu WHERE Id IN " +
                                    "(SELECT WaifuId FROM Favorites WHERE UserId = @Id) AND CONFIRMED LIKE '1' ORDER BY Id DESC", _connection);

                cmd.Parameters.AddWithValue("Id", id);
                rd = cmd.ExecuteReader();
                while(rd.Read())
                {
                    Favorites.Add(CreateFromReader(rd));
                }

                rd.Close();
                cmd.Dispose();

                WaifuLight empty = new WaifuLight();
                empty.Id = -1;
                empty.Image = "/images/none2.png";
                empty.Name = "Пусто.";
                if (Added.Count == 0)
                {
                    Added.Add(empty);
                }
                if (Favorites.Count == 0)
                {
                    Favorites.Add(empty);
                }
                 
            }
            finally
            {
                _connection.Close();
            }
        } 
        public void LoadComments()
        {
            /*var cmd = new SqlCommand("SELECT * FROM UserComments WHERE UserTo=@Login", _connection);
            cmd.Parameters.AddWithValue("Login", Login);

            Comments = Waifu.LoadCommentList(cmd);*/
            throw new NotImplementedException();
        }
        public void LoadNotifications()
        {
            if(Id == "-1")
            {
                return;
            }
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("SELECT * FROM Notifications WHERE UserId=@Id ORDER BY Id DESC", _connection))
                {
                    cmd.Parameters.AddWithValue("Id", Id);
                    using (var rd = cmd.ExecuteReader())
                    {
                        while (rd.Read())
                        {
                            Notifications.Add(new Notification(rd));
                        }
                    }
                }
            }
        }

        public WaifuLight CreateFromReader(SqlDataReader rd)
        {
            WaifuLight wl = new WaifuLight();
            wl.Image = rd["Image"].ToString();
            wl.Name = rd["Name"].ToString();
            wl.Id = Convert.ToInt32(rd["Id"]);
            return wl;
        }
    }

    public class Comment
    {
        public int Id { get; set; }
        public UserLight From { get; set; }
        public string Text { get; set; }
        public string Date { get; set; }
        public Comment()
        {

        }
        public Comment(SqlDataReader rd)
        {
            Id = Convert.ToInt32(rd["Id"]);
            Text = rd["Text"].ToString();
            Date = rd["Timestamp"].ToString();
            From = new UserLight();
            From.LoadById(rd["UserFrom"].ToString());
        }
    }

    public class NewsFull
    {
        public int Id { get; set; } = -1;
        public string Title { get; set; } = "";
        public string Content { get; set; } = "";
        public string Date { get; set; } = "";
        public string Author { get; set; } = "";

        public NewsFull() { }
        public NewsFull(SqlDataReader rd)
        {
            NewsFromReader(rd);
        }
        public void NewsFromJs(Dictionary<string, object> news)
        {
            Title = news["title"].ToString();
            Content = news["content"].ToString();
            Date = news["date"].ToString();
            Author = news["author"].ToString();
        }
        public void SendToBase()
        {
            if(Id == -1)
            {
                using (var _connection = new SqlConnection(Global.WaifString))
                {
                    _connection.Open();
                    using (var cmd = new SqlCommand("INSERT INTO News VALUES(@Title, @Content, @Date, @Author)", _connection))
                    {
                        cmd.Parameters.AddWithValue("Title", Title);
                        cmd.Parameters.AddWithValue("Content", Content);
                        cmd.Parameters.AddWithValue("Date", Date);
                        cmd.Parameters.AddWithValue("Author", Author);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }
        public static void DeleteFromBase(int Id)
        {
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                using (var cmd = new SqlCommand("DELETE FROM News WHERE Id=@Id", _connection))
                {
                    cmd.Parameters.AddWithValue("Id", Id);
                    cmd.ExecuteNonQuery();
                }
            }
        }
        public void DeleteFromBase()
        {
            if (Id != -1)
            {
                DeleteFromBase(Id);
            }
        }
        public void NewsFromReader(SqlDataReader rd)
        {
            var properties = GetType().GetProperties();
            foreach(var property in properties)
            {
                if (rd.ColumnExists(property.Name))
                {
                    if (property.Name == "Id")
                    {
                        property.SetValue(this, Convert.ToInt32(rd[property.Name]));
                    }
                    else
                    {
                        property.SetValue(this, rd[property.Name].ToString());
                    }
                }
            }
        }
    }

    public class Notification
    {
        public int Id { get; set; } = -1;
        public string UserId { get; set; } = "";
        public string Content { get; set; } = "";
        public string Image { get; set; } = "";
        public string ImageUrl { get; set; } = "";
        public bool IsRead { get; set; } = false;
        public string Date { get; set; } = "";
        public string IsReadMarkup { get; set; } = "<div class=\"notify-new\"></div>";

        public Notification()
        {

        }
        public Notification(SqlDataReader rd)
        {
            if (rd.ColumnExists("Id"))
            {
                Id = Convert.ToInt32(rd["Id"].ToString());
            }
            if (rd.ColumnExists("UserId"))
            {
                UserId = rd["UserId"].ToString();
            }
            if (rd.ColumnExists("Content"))
            {
                Content = rd["Content"].ToString();
            }
            if (rd.ColumnExists("Image"))
            {
                Image = rd["Image"].ToString();
            }
            if (rd.ColumnExists("IsRead"))
            {
                IsRead = Convert.ToBoolean(rd["IsRead"]);
                if (IsRead)
                {
                    IsReadMarkup = "";
                }
            }
            if (rd.ColumnExists("Timestamp"))
            {
                Date = rd["Timestamp"].ToString();
            }
            if (rd.ColumnExists("ImageUrl"))
            {
                if (rd["ImageUrl"].ToString() != "")
                {
                    ImageUrl = "href=\"" + rd["ImageUrl"].ToString() + "\"";
                }
            }
        }
        
        public static void AddNew(string userId, string content, bool isUserName = false, string image = "/images/none.png", string imageUrl="")
        {
            using (var _connection = new SqlConnection(Global.WaifString))
            {
                _connection.Open();
                if (isUserName)
                {
                    using (var cmd = new SqlCommand("SELECT Id FROM Users WHERE Name=@Name", _connection))
                    {
                        cmd.Parameters.AddWithValue("Name", userId);
                        userId = cmd.ExecuteScalar().ToString();
                    }
                }
                using (var cmd = new SqlCommand("INSERT INTO Notifications (UserId, Content, Image, ImageUrl) " +
                                               " VALUES (@UId, @Content, @Image, @ImageUrl)", _connection))
                {
                    cmd.Parameters.AddWithValue("UId", userId);
                    cmd.Parameters.AddWithValue("Content", content);
                    cmd.Parameters.AddWithValue("Image", image);
                    cmd.Parameters.AddWithValue("ImageUrl", imageUrl);
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }

    public class LiveSearchResult
    {
        public string label { get; set; }
        public string href { get; set; } = "#";

        public LiveSearchResult()
        {

        }
        
        public LiveSearchResult(SqlDataReader rd)
        {
            label = rd["Name"].ToString();
            href = String.Format("/{0}/{1}", rd["Type"].ToString().ToLower(), rd["Id"].ToString());
        }
    }

    public static class SmtpHelper
    {
        public static SmtpClient client { get; set; }
        public static bool IsCreated { get; set; } = false;
        public static string Email { get; set; }
        public static void ClientCreate(string login, string pass)
        {
            if (!IsCreated)
            {
                try
                {
                    client = new SmtpClient("smtp.rambler.ru", 587);
                    client.EnableSsl = true;
                    client.Timeout = 100000;
                    client.DeliveryMethod = SmtpDeliveryMethod.Network;
                    client.UseDefaultCredentials = false;
                    client.Credentials = new NetworkCredential(login, pass);
                    IsCreated = true;
                    Email = login;
                }
                catch (Exception e)
                {
                    IsCreated = false;
                }
            }

        }
        public static void SendPassword(string email, string password, string login)
        {
            MailMessage msg = new MailMessage();
            msg.To.Add(email);
            msg.From = new MailAddress(Email);
            msg.Subject = "AllWaifu registration.";
            msg.Body = String.Format("Спасибо Вам за регистрацию на нашем проекте. Вам были присвоены следующие данные :"+
                                     "\n\t Логин : {0}\n\t Пароль : {1}\n"+
                                     "С уважением, администрация сайта AllWaifu.", login, password);
            client.Send(msg);
        }
        public static void SendRecoveryToken(string email, string tokenUrl)
        {
            MailMessage msg = new MailMessage();
            msg.To.Add(email);
            msg.From = new MailAddress(Email);
            msg.Subject = "AllWaifu password recovery.";
            msg.Body = String.Format("Для вашего аккаунта была запрошена смена пароля. Если Вы не причастны к этому, проигнорируйте данное письмо.\n\n" +
                                     "\tДля восстановления пароля перейдите по ссылке, она действительна в течении часа : {0} \n" +
                                     "С уважением, администрация сайта AllWaifu.", tokenUrl);
            client.Send(msg);
        }
    }
    public enum PagElVar
    {
        FaPrev,
        FaNext,
        ActivePage,
        Page
    }
    static class ReaderHelper
    {

        /// <summary>
        /// Checks if a column exists in the DataReader
        /// </summary>
        /// <param name="dr">DataReader</param>
        /// <param name="ColumnName">Name of the column to find</param>
        /// <returns>Returns true if the column exists in the DataReader, else returns false</returns>
        public static Boolean ColumnExists(this IDataReader dr, String ColumnName)
        {
            for (Int32 i = 0; i < dr.FieldCount; i++)
                if (dr.GetName(i).Equals(ColumnName, StringComparison.OrdinalIgnoreCase))
                    return true;

            return false;
        }
        public static string GetCommentsTable(string type)
        {
            var table = "";
            switch (type)
            {
                case "anime":
                    table = "AnimeComments";
                    break;
                case "waifu":
                    table = "WaifuComments";
                    break;
                case "user":
                    table = "UserComments";
                    break;
            }
            return table;
        }
    }
}