<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="Old_Search.aspx.cs" Inherits="AllWaifu.Old_Search" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
    <link rel="stylesheet" href="css/search.css?<%=DateTime.Now.Ticks.ToString()%>" />
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="SlideoutPlaceHolder" runat="server">
    <div class ="search_sort search_mobile">
        <div class="search_sort_head">
            Сортировка
        </div>
        <ul class = "search_radio">
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
            <span> </span>
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
            <li class="search_but_cont">
                <input class="search_sort_but" type="button" id="SaveSortMobile" onclick="Sort('M')" value="Отсортировать" style="width:100%"/>
            </li>
        </ul>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
    <h1 class="sub_logo hidden-xs">Search Results</h1>
    <h1 class="sub_logo_min"> Search Results </h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/AjaxHelper.asmx" />
        </Services>
    </asp:ScriptManager>
    <div class="search_grid">
        <div class="search_els cl-effect-5">
            <div class="search_el shadow">
                <div class="search_el_img">
                    <a style="padding : 0;">
                        <img src="images/kuroneko.jpg">
                    </a>
                </div>
                <div class ="search_el_text">
                    <a class="search_el_name" href="#">
                        <span data-hover="Рури Гоку">Рури Гоку</span>
                    </a><br/>
                    <span class="search_el_type"> Персонаж </span>
                </div>
            </div>
        </div>
        <div class="infinite_scroll">
            <button type="button" class="infinite_scroll_but search_sort_but" id="AddMore" onclick="AddContent();">
                <i class="fa fa-plus"></i>
                <div style="display : inline-block">
                    Загрузить еще
                </div>
            </button>
        </div>
        <div class ="search_sort shadow" id="DesktopSort">
            <div class="search_sort_head">
                Сортировка
            </div>
            <ul class = "search_radio">
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
                <span> </span>
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
                <li class="search_but_cont">
                    <input class="search_sort_but" type="button" id="SaveSort" onclick="Sort()" value="Отсортировать" style="width:100%"/>
                </li>
            </ul>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
    <script src="js/search.js??<%=DateTime.Now.Ticks.ToString()%>"></script>
    <input id="QueryType" type="hidden" runat="server"/>
</asp:Content>
