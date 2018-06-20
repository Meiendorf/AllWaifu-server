<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="Waifu.aspx.cs" Inherits="AllWaifu.Waifu_New" %>

<%@ MasterType VirtualPath="~/AllWaifu.master" %>
<%@ Register Src="~/Comments.ascx" TagPrefix="uc1" TagName="Comments" %>
<%@ Register Src="~/TopList.ascx" TagPrefix="uc1" TagName="TopList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
    <link rel="stylesheet" href="/css/anime.css" />
    <link rel="stylesheet" href="/css/search.css" />
    <link rel="stylesheet" href="/css/waifu.css??3" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/balloon-css/0.5.0/balloon.min.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InSlideoutListPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="SlideoutPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <section class="main_context waif_context">
        <div class="main_grid_anime">
            <div class="anime_el">
                <div class="type_title">
                    ПЕРСОНАЖ
                </div>
                <div class="anime_img">
                    <img src="<%=PageWaif.Image%>" alt="Img" />
                    <div class="anime_img_info">
                        <div class="anime_title">
                            <%=PageWaif.Name%>
                        </div>
                        <div class="add_info">
                            <div class="waif_fav_cont">
                                <div class="waif_fav_hint" data-balloon="Добавить в избранное" data-balloon-pos="down" data-balloon-length="medium">
                                    <i class="fa waif_fav fa-heart-o" aria-hidden="true"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="anime_info">
                    <div class="anime_desc_title">
                        Информация
                    </div>
                    <div class="nwaif_info cl-effect-5">
                        <div class="nwaif_info_row">
                            <b>Аниме : </b>
                            <a href="/anime/<%=PageWaif.AnimeId%>" style="font-family: RubikRegular;">
                                <span data-hover="<%=PageWaif.Anime %>"><%=PageWaif.Anime %></span>
                            </a>
                        </div>
                        <div class="nwaif_info_row">
                            <b>Просмотры : </b>
                            <span><%=PageWaif.Popularity %></span>
                            <i class="fa fa-eye" aria-hidden="true"></i>
                        </div>
                        <div class="nwaif_info_row">
                            <b>В закладках  : </b>
                            <span><%=PageWaif.Favority %></span>
                            <i class="fa fa-heart" aria-hidden="true"></i>
                        </div>
                        <div class="nwaif_info_row">
                            <b>Теги : </b>
                            <asp:Repeater ID="TagRepeater" runat="server">
                                <ItemTemplate>
                                    <div class="nwaif_tags">
                                        <a href="/search/waifu?tags=<%#Eval("Name")%>" class="nwaif_tag">
                                            <div class="nwaif_tag_title">
                                                <%#Eval("Name")%>
                                            </div>
                                            <div class="nwaif_tag_popular">
                                                (<%#Eval("Popularity")%>)
                                            </div>
                                        </a>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
                <div class="waif_content nwaif_content">
                    <div class="anime_desc_title col-md-12">
                        <br />
                        Описание
                    </div>
                    <asp:Repeater ID="ChapterRepeater" OnItemDataBound="ChapterRepeater_ItemDataBound" runat="server">
                        <ItemTemplate>
                            <div class="waif_cont_column <%# Eval("SizeCssClass")%>">
                                <div class="waif_cont_block col-md-12">
                                    <div class="waif_cont_title">
                                        <%# Eval("Title")%>
                                    </div>
                                    <div class="waif_cont_text">
                                        <asp:Repeater ID="ElementRepeater" runat="server">
                                            <ItemTemplate>
                                                <b>
                                                    <%#Eval("Title")%>
                                                </b>
                                                <%#Eval("Content") %><br />
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div id="CommentsBlock">

                </div>
            </div>

            <div class="anime_top">
                <div class="anime_top_title">
                    <div class="anime_top_type">
                        ТОП ПЕРСОНАЖЕЙ
                    </div>
                    <input type="radio" checked name="anime_tabs" id="ViewsRadio" />
                    <label class="anime_tabs" for="ViewsRadio">Просмотры</label>
                    <input type="radio" name="anime_tabs" id="PersRadio" />
                    <label class="anime_tabs" for="PersRadio">Закладки</label>
                    <div class="anime_top_list" id="ViewsList">
                        <uc1:TopList runat="server" ID="PopListControl" PageUrl="/waifu" />
                    </div>
                    <div class="anime_top_list" id="PersList">
                        <uc1:TopList runat="server" ID="FavListControl" PopIconClass="fa-heart" PageUrl="/waifu" />
                    </div>
                </div>

                <div class="vk_news_anime" style="box-shadow: none; color: #fff;">
                    <div class="type_title">
                        МЫ В VK
                    </div>
                    <div id="vk_groups"></div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
    <script src="/js/profile_comments.js?<%=DateTime.Now.Ticks.ToString() %>"></script>
    <script>
        userId = "<%=UserId%>";
        isAuth = "<%=IsAuthenticated%>";
        heart = "<%if (UserRole != "User") { Response.Write("underblade"); } %>";
        pageReplyId = "<%=ReplyId%>";
        pageReplyFrom = "<%=ReplyFrom%>";

        $("#CommentsBlock").comments("init", {
            "type": "waifu",
            "id": <%=PageWaif.Id%>,
            "username": userId,
            "heart": heart
        });

        if (pageReplyId != "") {
            var data = $("#CommentsBlock").data("commentsData");
            data.replyId = pageReplyId;
            data.replyTo = pageReplyFrom;
            $("#CommentsBlock").data("commentsData", data);
            $("#CommentsBlock").find(".comment_inp")[0].focus();
            $("#CommentsBlock").find(".reply_box").show().find(".reply_box_to")[0].innerText = "Ответ @" + data.replyTo;
        }

        $(".anime_comments")[0].classList.add("col-md-12");
        if (isAuth == "True") {
            var userName = "<%=UserName%>";
            var waifuId = "<%=PageWaif.Id%>";
            var isFav = "<%=IsFavForCurrentUser%>";
            var faO = "fa-heart-o";
            var fa = "fa-heart";
            var fav_class_add = faO;
            var fav_class_del = fa;
            if (isFav == "True") {
                fav_class_add = fa;
                fav_class_del = faO;
                $(".waif_fav").removeClass(fav_class_del);
                $(".waif_fav").addClass(fav_class_add);
            }
            $(".waif_fav").click(function () {
                if (userName == "") {
                    $(location).attr('href', 'Login.aspx');
                }
                if (fav_class_add == faO) {
                    fav_class_add = fa;
                    fav_class_del = faO;
                    AllWaifu.AjaxHelper.AddToFavorites(waifuId, userName,
                        function (result) { }, function (err) { console.log(err) });
                }
                else {
                    fav_class_add = faO;
                    fav_class_del = fa;
                    AllWaifu.AjaxHelper.DeleteFromFavorites(waifuId, userName,
                        function (result) { }, function (err) { console.log(err) });
                }
                $(this).removeClass(fav_class_del);
                $(this).addClass(fav_class_add);
            });
        }
        else {
            $(".waif_fav").click(function () {
                $(location).attr('href', '/login');
            });
        }
    </script>
    <script src="/js/vk_openapi.js"></script>
    <script type="text/javascript">
        VK.Widgets.Group("vk_groups", { mode: 4, width: "auto", wide: 1, height: "400" }, 155417759);
    </script>
</asp:Content>
