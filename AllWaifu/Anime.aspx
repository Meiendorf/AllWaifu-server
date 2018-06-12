<%@Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/AllWaifu.Master" CodeBehind="Anime.aspx.cs" Inherits="AllWaifu.Anime" %>

<%@ Register Src="~/Comments.ascx" TagPrefix="uc1" TagName="Comments" %>
<%@ Register Src="~/TopList.ascx" TagPrefix="uc1" TagName="TopList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
    <link rel="stylesheet" href="/css/profile.css?<%=DateTime.Now.Ticks.ToString()%>" />
    <link rel="stylesheet" href="/css/anime.css?<%=DateTime.Now.Ticks.ToString()%>" />
    <link rel="stylesheet" href="/css/search.css?<%=DateTime.Now.Ticks.ToString()%>"/>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="SlideoutPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="InSlideoutListPlaceHolder" runat="server">
    <%if (IsAdmin){ %>
    <li style="border-top: 2px solid #29A4D0"  onclick="$('.profile_anime_cont').fadeIn();">
        <a href="#">
            Добавить аниме
        </a>
    </li>
    <%} %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <div class="main_grid_anime">
        <div class="anime_el">
            <div class="type_title">
                АНИМЕ
            </div>
            <div class="anime_img">
                <img src="<%=PageAnim.Image%>" alt="Img" />
                <div class="anime_img_info">
                    <div class="anime_title">
                        <%=PageAnim.Name %>
                    </div>
                    <div class="add_info">
                        <i class="fa fa-eye" aria-hidden="true"></i>
                        <span><%=PageAnim.Popularity %></span>
                    </div>
                </div>
            </div>
            <div class="anime_info">
                <div class="anime_desc_title">
                    Описание
                </div>
                <div class="anime_desc">
                    <%=PageAnim.Description %>
                </div>
                <div class="anime_watch">
                    <button type="button">
                        <a id="WatchLink" href="<%=PageAnim.WatchLink %>">Смотреть 
                        </a>
                        <i class="fa fa-caret-right" aria-hidden="true" style="font-size: 15px; color: #fff"></i>
                    </button>
                </div>
            </div>
            <div class="anime_waifu">
                <div class="anime_desc_title">
                    Персонажи
                </div>
                <div class="search_els_anime cl-effect-5">
                    <asp:Repeater ID="WaifsRepeater" runat="server">
                        <ItemTemplate>
                            <div class="search_el">
                                <div class="search_el_img">
                                    <img src="<%#Eval("Image") %>">
                                    <div class="add_anime_waif_inf">
                                        <div class="waif_inf_el">
                                            <i class="fa fa-eye" aria-hidden="true"></i>
                                            <span><%#Eval("Popularity") %></span>
                                        </div>
                                        <div class="waif_inf_el">
                                            <i class="fa fa-heart" aria-hidden="true"></i>
                                            <span><%#Eval("Favority") %></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="search_el_text">
                                    <a class="search_el_name" href="/waifu/<%#Eval("Id")%>">
                                        <span data-hover="<%#Eval("Name") %>"><%#Eval("Name") %></span>
                                    </a>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="anime_watch" style="padding: 0px 10px; margin-bottom: 10px;">
                    <button type="button">
                        <a href="/add">
                            Добавить 
                        </a>
                        <i class="fa fa-caret-right" aria-hidden="true" style="font-size: 15px; color: #fff"></i>
                    </button>
                </div>
            </div>
            <div class="anime_comments">
                <div class="anime_desc_title">
                    Комментарии
                </div>
                <div class="waif_inp">
                    <div class="row">
                        <div class="col-md-10">
                            <textarea rows="1" placeholder="Текст комментария"
                                name="wcomments" id="wcomments"></textarea>
                        </div>
                        <div class="col-md-2" style="margin-top : 5px">
                            <button class="send_min_but" style="height: 31px;">
                                Отправить
                            </button>
                        </div>
                        <uc1:Comments ID="CommentsBlock" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        <div class="anime_top">
            <div class="anime_top_title">
                <div class="anime_top_type">
                    ТОП АНИМЕ
                </div>
                <input type="radio" checked name="anime_tabs" id="ViewsRadio" />
                <label class="anime_tabs" for="ViewsRadio">Просмотры</label>
                <input type="radio" name="anime_tabs" id="PersRadio" />
                <label class="anime_tabs" for="PersRadio">Персонажи</label>
                <div class="anime_top_list" id="ViewsList">
                    <uc1:TopList runat="server" ID="TopViewsControl" PageUrl="/anime"/>
                </div>
                <div class="anime_top_list" id="PersList">
                    <uc1:TopList runat="server" ID="TopPersControl" PopIconClass="fa-user-circle-o" PageUrl="/anime"/>
                </div>
            </div>
            <% if(IsAdmin){%>
            <button class="anime_edit_but" onclick="$('.profile_anime_cont').fadeIn();"  type="button">
                <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                <span>Редактировать</span>
            </button>
            <%} %>
            <div class="vk_news_anime" style="box-shadow: none; color: #fff; margin-top : 5px;">
                <div class="type_title">
                    МЫ В VK
                </div>
                <div id="vk_groups"></div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
    <div class="profile_anime_cont">
        <div class="profile_anime_popup">
            <div class="profile_popup_box">
                <div class="profile_popup_title type_title">
                    Добавить аниме
                </div>
                <div class="profile_popup_content">
                    <div class="profile_popup_thumb">
                        <img src="/images/none2.png"/>
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
    <% if(IsAdmin){%>
    <script src="/js/anime.js"></script>
    <%} %>
    <script src="/js/vk_openapi.js"></script>
    <script type="text/javascript">
        anime_id = <%=PageAnim.Id%>;
        VK.Widgets.Group("vk_groups", { mode: 4, width: "auto", wide: 1, height: "400" }, 155417759);
	</script>
</asp:Content>
