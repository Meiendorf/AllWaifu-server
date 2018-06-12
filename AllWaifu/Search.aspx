<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="AllWaifu.Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
    <link rel="stylesheet" href="/bower_components/chosen/chosen.css" />
    <link rel="stylesheet" href="/css/search.css?<%=DateTime.Now.Ticks.ToString()%>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InSlideoutListPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="SlideoutPlaceHolder" runat="server">
    <div class="search_sort search_mobile">
        <div class="search_sort_head">
            Сортировка
        </div>
        <ul class="search_radio">
            <li>
                <input type="radio" id="PopularRadioM" name="sort_type">
                <label for="PopularRadioM">По просмотрам</label>
                <div class="check"></div>
            </li>
            <li>
                <input type="radio" id="NewRadioM" name="sort_type">
                <label for="NewRadioM">По дате</label>
                <div class="check"></div>
            </li>
            <li>
                <input type="radio" id="AlphRadioM" name="sort_type">
                <label for="AlphRadioM">По имени</label>
                <div class="check"></div>
            </li>
            <span class="search_radio_span"></span>
            <li>
                <input type="radio" id="AscRadioM" name="sort_der">
                <label for="AscRadioM">Возрастание</label>
                <div class="check"></div>
            </li>
            <li>
                <input type="radio" id="DescRadioM" name="sort_der">
                <label for="DescRadioM">Убывание</label>
                <div class="check"></div>
            </li>
            <li class="search_tags">
                <div class="search_tags_title search_sort_head">
                    Тип
                </div>
                <select name="type_select" id="TypeSelectM" class="search_type_select">
                    <option>Всё</option>
                    <option>Персонажи</option>
                    <option>Аниме</option>
                </select>
            </li>
            <li class="search_tags">
                <div class="search_tags_title search_sort_head">
                    Теги
                </div>
                <select id="TagsSelectM" data-placeholder="По каким тегам искать" class="chosen-select" multiple tabindex="4">
                    <option value=""></option>
                    <asp:Repeater ID="TagsRepeaterM" runat="server">
                        <ItemTemplate>
                            <option value="<%#Container.DataItem.ToString()%>"><%#Container.DataItem.ToString()%></option>
                        </ItemTemplate>
                    </asp:Repeater>
                </select>
            </li>
            <li class="search_but_cont">
                <input class="search_sort_but" type="button" id="SaveSortM" onclick="Sort('M');" value="Применить" style="width: 100%" />
            </li>
        </ul>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <div class="nsearch_grid">
        <div class="nsearch_els cl-effect-5">
            <div class="type_title" id="MainTitle">
                Результаты поиска
            </div>
            <div class="nothing_found">
                <div class="desktop_nothing_title">
                    По вашему запросу ничего не найдено.
                </div>
                <img class="nothing_found_image" src="/images/rikko.png" alt="" />
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

        <div class="nsearch_more">
            <button class="infinite_scroll_but search_sort_but" type="button" onclick="AddContent();" id="AddMore">
                <i class="fa fa-plus"></i>
                <div>
                    Загрузить еще
                </div>
            </button>
        </div>
        <div class="nsearch_side">
            <div class="search_sort" id="DesktopSort">
                <div class="type_title">
                    Сортировка
                </div>
                <ul class="search_radio">
                    <li>
                        <input type="radio" id="PopularRadio" name="sort_type">
                        <label for="PopularRadio">По просмотрам</label>
                        <div class="check"></div>
                    </li>
                    <li>
                        <input type="radio" id="NewRadio" name="sort_type">
                        <label for="NewRadio">По дате</label>
                        <div class="check"></div>
                    </li>
                    <li>
                        <input type="radio" id="AlphRadio" name="sort_type">
                        <label for="AlphRadio">По имени</label>
                        <div class="check"></div>
                    </li>
                    <span class="search_radio_span"></span>
                    <li>
                        <input type="radio" id="AscRadio" name="sort_der">
                        <label for="AscRadio">Возрастание</label>
                        <div class="check"></div>
                    </li>
                    <li>
                        <input type="radio" id="DescRadio" name="sort_der">
                        <label for="DescRadio">Убывание</label>
                        <div class="check"></div>
                    </li>
                    <li class="search_tags">
                        <div class="search_tags_title">
                            Тип
                        </div>
                        <select name="type_select" id="TypeSelect" class="search_type_select">
                            <option>Всё</option>
                            <option>Персонажи</option>
                            <option>Аниме</option>
                        </select>
                    </li>
                </ul>
                <div class="search_tags tags_select">
                    <div class="search_tags_title">
                        Теги
                    </div>
                    <select id="TagsSelect" data-placeholder="По каким тегам искать" class="chosen-select" multiple tabindex="4">
                        <option value=""></option>
                        <asp:Repeater ID="TagRepeater" runat="server">
                            <ItemTemplate>
                                <option value="<%#Container.DataItem.ToString()%>"><%#Container.DataItem.ToString()%></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                </div>
                <div class="search_but_cont">
                    <input class="search_sort_but" type="button" id="SaveSort" onclick="Sort();" value="Применить" style="width: 100%" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
    <script src="/bower_components/chosen/chosen.jquery.min.js" type="text/javascript"></script>
    <script>
        type = '<%=Type%>';
        text = '<%=Text%>';
        tags = '<%=Tags%>';
        user = '<%=User%>';
        userType = '<%=UserType%>';
        $('.chosen-select').chosen();
    </script>
    <script src="/js/search.js??<%=DateTime.Now.Ticks.ToString()%>"></script>
    <input id="QueryType" type="hidden" runat="server" />
</asp:Content>
