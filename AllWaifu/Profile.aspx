<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="AllWaifu.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
    <link rel="stylesheet" href="/css/anime.css" />
    <link rel="stylesheet" href="/css/profile.css?<%=DateTime.Now.Ticks.ToString() %>" />
    <link rel="stylesheet" href="/css/search.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SlideoutPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="InSlideoutListPlaceHolder" runat="server">
    <%if (Request.IsAuthenticated){ %>
    <%if (IsUserPage)
        { %>
    <%if(Role != "User"){ %>
    <li style="border-top: 2px solid #29A4D0" onclick="$('.profile_anime_cont').fadeIn();">
        <a href="#">Добавить аниме
        </a>
    </li>
    <%} %>
    <li>
        <a href="#">Уведомления
        </a>
    </li>
    <li>
        <a href="/edit">Настройки
        </a>
    </li>
    <%}
        else
        {%>
    <li style="border-top: 2px solid #29A4D0">
        <a href="#">Повысить репутацию
        </a>
    </li>
    <li>
        <a href="#">Понизить репутацию
        </a>
    </li>
    <li>
        <a href="#">Пожаловаться
        </a>
    </li>
    <li>
        <a href="#">Прокомментировать
        </a>
    </li>
    <%} %>
    <%} %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <div class="profile_grid">
        <div class="profile_info">
            <div class="profile_info_title type_title">
                <%if (IsUserPage)
                    { %>ВАШ ПРОФИЛЬ,<%} %> <%=this.user.Login%>
            </div>
            <div class="profile_info_content">
                <div class="profile_image">
                    <img src="<%=this.user.Image %>" />
                </div>
                <div class="profile_info_list">
                    <% if (!String.IsNullOrEmpty(user.FullName))
                        {%>
                    <div class="profile_info_el">
                        <b>Имя : </b><%=user.FullName %>
                    </div>
                    <%}%>
                    <% if (!String.IsNullOrEmpty(user.Url))
                        {%>
                    <div class="profile_info_el cl-effect-5">
                        <b>Веб-сайт : </b>
                        <a href="<%=user.Url %>">
                            <b><span data-hover="Перейти">Перейти </span></b>
                        </a>
                    </div>
                    <%}%>
                    <div class="profile_info_el">
                        <b>Группа : </b>
                        <span color="<%=user.Color%>"><%=user.Role %></span>
                    </div>
                    <div class="profile_info_el">
                        <b>Дата регистрации : </b><%=user.RegDate %>
                    </div>
                </div>
            </div>
            <div class="profile_additional">
                <div class="profile_description">
                    <div class="type_title">
                        О СЕБЕ
                    </div>
                    <div class="transparent_5p">
                    </div>
                    <div class="profile_description_text">
                        <%=user.Description %>
                    </div>
                </div>
                <div class="profile_added_waifu">
                    <div class="cl-effect-5">
                        <a class="type_title link_type_title" href="#">
                            <span data-hover="ДОБАВЛЕННЫЕ">ДОБАВЛЕННЫЕ</span>
                        </a>
                    </div>
                    <div class="profile_top_list">
                        <asp:Repeater ID="Added_Repeater" runat="server">
                            <ItemTemplate>
                                <div class="anime_top_els">
                                    <div class="anime_el_img">
                                        <a href="/waifu/<%#Eval("Id") %>">
                                            <img src="<%#Eval("Image") %>" />
                                        </a>
                                        <div class="add_anime_waif_inf">
                                            <i class="fa fa-eye" aria-hidden="true"></i>
                                            <span><%#Eval("Popularity") %></span>
                                        </div>
                                    </div>
                                    <div class="anime_el_name cl-effect-5">
                                        <p>
                                            <a href="/waifu/<%#Eval("Id") %>">
                                                <span data-hover="<%#Eval("Name") %>"><%#Eval("Name") %>
                                                </span>
                                            </a>
                                        </p>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="profile_added_waifu">
                    <div class="cl-effect-5">
                        <a class="type_title link_type_title" href="#">
                            <span data-hover="ЗАКЛАДКИ">ЗАКЛАДКИ</span>
                        </a>
                    </div>
                    <div class="profile_top_list">
                        <asp:Repeater ID="Favorites_Repeater" runat="server">
                            <ItemTemplate>
                                <div class="anime_top_els">
                                    <div class="anime_el_img">
                                        <a href="/waifu/<%#Eval("Id") %>">
                                            <img src="<%#Eval("Image") %>" />
                                        </a>
                                        <div class="add_anime_waif_inf">
                                            <i class="fa fa-eye" aria-hidden="true"></i>
                                            <span><%#Eval("Popularity") %></span>
                                        </div>
                                    </div>
                                    <div class="anime_el_name cl-effect-5">
                                        <p>
                                            <a href="/waifu/<%#Eval("Id") %>">
                                                <span data-hover="<%#Eval("Name") %>"><%#Eval("Name") %>
                                                </span>
                                            </a>
                                        </p>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
            <div id="CommentsBlock">

            </div>
        </div>
        <div class="profile_settings">
            <div class="type_title">
                МЕНЮ
            </div>
            <div class="profile_settings_els cl-effect-5">
                <%if (Request.IsAuthenticated){ %>
                    <%if (IsUserPage)
                        { %>
                    <div class="profile_settings_el">
                        <i class="fa fa-cog" aria-hidden="true"></i>
                        Настройки
                    </div>
                    <div class="profile_settings_el">
                        <i class="fa fa-bell-o" aria-hidden="true"></i>
                        Уведомления
                    </div>
                    <% if(Role != "User"){ %>
                    <div class="profile_settings_el" onclick="$('.profile_anime_cont').fadeIn();">
                        <i class="fa fa-plus" style="padding-left: 2px" aria-hidden="true"></i>
                        Добавить аниме
                    </div>
                    <%} %>
                    <div class="profile_settings_el">
                        <i class="fa fa-sign-out" aria-hidden="true" style="padding-left: 2px"></i>
                        Выход
                    </div>
                    <%}
                        else
                        { %>
                    <div class="profile_settings_el">
                        <i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
                        Повысить репутацию
                    </div>
                    <div class="profile_settings_el">
                        <i class="fa fa-thumbs-o-down" aria-hidden="true"></i>
                        Понизить репутацию
                    </div>
                    <div class="profile_settings_el">
                        <i class="fa fa-times" aria-hidden="true"></i>
                        Пожаловаться
                    </div>
                    <div class="profile_settings_el">
                        <i class="fa fa-comment-o" aria-hidden="true"></i>
                        Прокомментировать
                    </div>
                    <%} %>
                <%} else {%>
                    <div class="profile_settings_el" onclick="$(location).attr('href', '/login');">
                        <i class="fa fa-sign-in" aria-hidden="true"></i>
                        Войти
                    </div>
                <%} %>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
    <div class="profile_anime_cont">
        <div class="profile_anime_popup">
            <div class="profile_popup_box">
                <div class="profile_popup_title type_title">
                    Добавить аниме
                </div>
                <div class="profile_popup_content">
                    <div class="profile_popup_thumb">
                        <img src="/images/none2.png" />
                    </div>
                    <div class="profile_load_but anime_watch">
                        <button type="button" id="LoadImage">
                            Загрузить
                        </button>
                    </div>
                    <div class="anime_desc_title">
                        Название
                    </div>
                    <div class="profile_popup_desc">
                        <textarea required placeholder="Название" name="" id="AnimeTitle" rows="1"></textarea>
                    </div>
                    <div class="anime_desc_title">
                        Ссылка
                    </div>
                    <div class="profile_popup_desc">
                        <textarea required placeholder="Ссылка" name="" id="AnimeUrl" rows="1"></textarea>
                    </div>
                    <div class="anime_desc_title">
                        Описание
                    </div>
                    <div class="profile_popup_desc">
                        <textarea required placeholder="Описание" name="" id="AnimeDesc" rows="4"></textarea>
                    </div>
                    <div class="profile_popup_save anime_watch">
                        <button id="SaveButton" onclick="SendAnime();">
                            Сохранить
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="/bower_components/blueimp-file-upload/js/vendor/jquery.ui.widget.js" type="text/javascript"></script>
    <script src="/bower_components/blueimp-file-upload/js/jquery.iframe-transport.js" type="text/javascript"></script>
    <script src="/bower_components/blueimp-file-upload/js/jquery.fileupload.js" type="text/javascript"></script>
    <script src="/bower_components/cloudinary-jquery/cloudinary-jquery.js" type="text/javascript"></script>
    <script src="https://widget.cloudinary.com/global/all.js" type="text/javascript"></script>
    <script>
        heart = "<%if (Role != "User") { Response.Write("underblade"); }%>";
        pageId = "<%=user.Login%>";
        userId = "<%=ClientId%>";
    </script>
    <script src="/js/profile.js?<%=DateTime.Now.Ticks.ToString() %>"></script>
    <script src="/js/profile_comments.js?<%=DateTime.Now.Ticks.ToString() %>"></script>
</asp:Content>
