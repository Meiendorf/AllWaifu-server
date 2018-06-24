<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="News.aspx.cs" Inherits="AllWaifu.News" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
    <link rel="stylesheet" href="/css/news.css??1" />
    <link rel="stylesheet" href="/node_modules/trumbowyg/dist/ui/trumbowyg.css">
    <link rel="stylesheet" href="/css/anime.css" />
    <link rel="stylesheet" href="/css/search.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InSlideoutListPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="SlideoutPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <section class="main_context">
        <div class="news_grid_container">
            <div class="news_grid">
                <div class="news_add">
                    <%if(IsAdmin){ %>
                    <div class="type_title">
                        Добавить пост
                    </div>
                    <div class="richtext">
                    </div>
                    <%}%>
                </div>
                <div class="news_elements">
                    <div class="type_title news_els_title">
                        Последние новости
                    </div>
                    <div class="news_element">
                        <div class="news_title">
                            <div class="news_title_text">

                            </div>
                            <%if(IsAdmin){ %>
                            <div class="news_delete">
                                <i class="fa fa-times" aria-hidden="true"></i>
                            </div>
                             <%}%>
                        </div>
                        <div class="news_content">

                        </div>
                        <div class="news_additional">
                            <div class="news_added_by">
                               
                            </div>
                            <div class="news_date">
                                
                            </div>
                        </div>
                        <input type="hidden" class="news_id" />
                    </div>
                </div>
                <div class="news_sidebar">
                    <div class="vk_news_anime" style="box-shadow: none; color: #fff;">
                        <div class="type_title">
                            МЫ В VK
                        </div>
                        <div id="vk_groups"></div>
                    </div>
                </div>
                <div class="news_more">
                    <button type="button" class="infinite_scroll_but search_sort_but" id="AddMore" onclick="AddContent()">
                        <i class="fa fa-plus"></i>
                        <div>
                            Загрузить еще
                        </div>
                    </button>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
    <script src="/js/vk_openapi.js"></script>
    <script src="https://rawgit.com/RickStrahl/jquery-resizable/master/dist/jquery-resizable.min.js"></script>
    <script src="/node_modules/trumbowyg/dist/trumbowyg.min.js"></script>
    <script src="/node_modules/trumbowyg/plugins/resizimg/trumbowyg.resizimg.js"></script>
    <script src="/node_modules/trumbowyg/dist/plugins/upload/trumbowyg.upload.min.js"></script>
    <script src="/node_modules/trumbowyg/dist/plugins/pasteembed/trumbowyg.pasteembed.js"></script>
    <script src="/node_modules/trumbowyg/dist/plugins/history/trumbowyg.history.js"></script>
    <script src="/node_modules/trumbowyg/dist/plugins/template/trumbowyg.template.js"></script>
    <script src="/node_modules/trumbowyg/dist/plugins/emoji/trumbowyg.emoji.js"></script>
    <script src="/js/news.js??<%=DateTime.Now.Ticks.ToString()%>"></script>
    <script type="text/javascript">
        userName = "<%=UserName%>";
        userToken = "<%=UserToken%>";
        VK.Widgets.Group("vk_groups", { mode: 4, width: "auto", wide: 1, height: "400" }, 155417759);
	</script>
</asp:Content>
