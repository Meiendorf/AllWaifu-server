<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="AllWaifu.IndexPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
    <link rel="stylesheet" href="/css/anime.css" />
    <link rel="stylesheet" href="/css/search.css" />
    <link rel="stylesheet" href="/css/mainpage.css" />
    <link rel="stylesheet" type="text/css" href="/libs/owl-carousel/owl.carousel.min.css"/>
    <link rel="stylesheet" type="text/css" href="/libs/owl-carousel/owl.theme.default.min.css"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InSlideoutListPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="SlideoutPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <section class="main_context">
        <div class="mainpp_row row">
            <div class="mainpage_personages col-sm-10 col-xs-12 col-md-12">
                <div class="mainp_title type_title">
                    Топ персонажей
                </div>
                <div class="mainp_els owl-carousel owl-theme">
                    <asp:Repeater ID="TopWaifuRepeater" runat="server">
                        <ItemTemplate>
                            <div class="search_el">
                                <div class="search_el_img">
                                    <a href="/waifu/<%#Eval("Id")%>">
                                        <img src="<%#Eval("Image")%>"/>
                                    </a>
                                        <div class="add_anime_waif_inf">
                                            <div class="waif_inf_el">
                                                <i class="fa fa-eye" aria-hidden="true"></i>
                                                <span><%#Eval("Popularity")%></span>
                                            </div>
                                        </div>
                                </div>
                                <div class="search_el_text">
                                    <a class="search_el_name" href="/waifu/<%#Eval("Id")%>">
                                        <span data-hover="<%#Eval("Name")%>"><%#Eval("Name")%></span>
                                    </a>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
        <div class="mainpp_row row">
            <div class="mainpage_grid centered-block col-sm-10 col-xs-12 col-md-12">
                <div class="mainp_new">
                    <div class="type_title">
                        НОВОСТИ
                    </div>
                    <div class="mainp_news_els">
                        <asp:Repeater ID="TopNewsRepeater" runat="server">
                            <ItemTemplate>
                                <div class="mainp_news_el">
                                    <div class="mainp_line"></div>
                                    <a href="/news">
                                        <div class="mainp_news_cont">
                                            <div class="mainp_date">
                                                <span><%#Eval("Date")%></span>
                                            </div>
                                            <div class="mainp_cont">
                                                <%#Eval("Title")%>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <div>
                    </div>
                </div>
                <div class="mainp_random">
                    <div class="type_title">
                        Cлучайные персонажи
                    </div>
                    <div class="mainp_random_els anime_top_list">
                        <asp:Repeater ID="RandomWaifRepeater" runat="server">
                            <ItemTemplate>
                                <div class="anime_top_els">
                                    <div class="anime_el_img">
                                        <a href="/waifu/<%#Eval("Id")%>">
                                            <img src="<%#Eval("Image")%>" />
                                        </a>
                                        <div class="add_anime_waif_inf">
                                            <i class="fa fa-eye" aria-hidden="true"></i>
                                            <span><%#Eval("Popularity")%></span>
                                        </div>
                                    </div>
                                    <div class="anime_el_name cl-effect-5">
                                        <p>
                                            <a href="/waifu/<%#Eval("Id")%>">
                                                <span data-hover="<%#Eval("Name")%>"><%#Eval("Name")%>
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
        </div>

        <div class="mainpp_row row">
            <div class="mainpage_personages col-sm-10 col-xs-12 col-md-12">
                <div class="mainp_title type_title">
                    Топ аниме
                </div>
                <div class="mainp_els owl-carousel owl-theme">
                    <asp:Repeater ID="TopAnimeRepeater" runat="server">
                        <ItemTemplate>
                            <div class="search_el">
                                <div class="search_el_img">
                                    <a href="/anime/<%#Eval("Id")%>">
                                        <img src="<%#Eval("Image")%>"/>
                                    </a>
                                        <div class="add_anime_waif_inf">
                                            <div class="waif_inf_el">
                                                <i class="fa fa-eye" aria-hidden="true"></i>
                                                <span><%#Eval("Popularity")%></span>
                                            </div>
                                        </div>
                                </div>
                                <div class="search_el_text">
                                    <a class="search_el_name" href="/anime/<%#Eval("Id")%>">
                                        <span data-hover="<%#Eval("Name")%>"><%#Eval("Name")%></span>
                                    </a>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
        <div class="mainpp_row row">
            <div class="mainp_waif_cont col-sm-10 col-xs-12 col-md-12">
                <div class="mainp_waif">
                    <div class="mainp_waif_els_cont" style="margin-right: 10px">
                        <div class="nsearch_els cl-effect-5 mainp_waif_els">
                            <div class="type_title">
                                Обновления
                            </div>
                            <div class="search_el nsearch_el">
                                <div class="search_el_img">
                                    <a href="#">
                                        <img src="/images/kuroneko.jpg">
                                    </a>
                                    <div class="add_anime_waif_inf">
                                        <div class="waif_inf_el">
                                            <i class="fa fa-eye" aria-hidden="true"></i>
                                            <span>20454</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="search_el_text">
                                    <a class="search_el_name" href="#">
                                        <span data-hover="Рури Гоку">Рури Гоку</span>
                                    </a>
                                    <br />
                                    <span class='search_el_type'>Персонаж </span>
                                </div>
                            </div>
                        </div>
                        <div class="mainp_waif_pag">
                            <div class="nsearch_more">
                                <button type="button" onclick="AddContent()" class="infinite_scroll_but search_sort_but" id="AddMore">
                                    <i class="fa fa-plus"></i>
                                    <div>
                                        Загрузить еще
                                    </div>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="mainp_waif_side">
                        <div class="vk_news_anime" style="box-shadow: none; color: #fff;">
                            <div class="type_title">
                                МЫ В VK
                            </div>
                            <div id="vk_groups"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
    <script type="text/javascript" src="/libs/owl-carousel/owl.carousel.min.js"></script>
    <script src="/js/vk_openapi.js"></script>
    <script type="text/javascript">
		VK.Widgets.Group("vk_groups", {mode: 4, width: "auto", wide: 1, height: "400"}, 155417759);
	</script>
    <script charset="windows-1251" src="/js/mainpage.js?<%=DateTime.Now.Ticks.ToString() %>"></script>
</asp:Content>
