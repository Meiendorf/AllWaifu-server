<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="Old_User.aspx.cs" Inherits="AllWaifu.User" %>
<%@ Register Src="~/Comments.ascx" TagPrefix="uc1" TagName="Comments" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
</asp:Content>
<asp:Content ID="OwlContent" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
    <h1 class="sub_logo hidden-xs">User Profile</h1>
    <h1 class="sub_logo_min">User </h1>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <section class="main_context">
        <div class="container">
            <div class="row">
                <div class="col-md-12 user_content" style="padding: 0">
                    <div class="user_main">
                        <div class="row">
                            <div class="user_status col-xs-12 us_mobile" style="text-align: right">
                                <%=user.Role%>
                            </div>
                            <div class="col-md-2 col-sm-3 col-xs-12" style="text-align : center">
                                <div class="user_img">
                                    <img src="<%=user.Image%>" alt="User photo" />
                                </div>
                            </div>
                            <div class="col-md-10 col-sm-9 col-xs-12">
                                <div class="user_info">
                                    <div class="user_status us_desktop" style="<%=user.Color%>">
                                        <%=user.Role %>
                                    </div>
                                    <div class="user_name" id="UserNome" runat="server">
                                        <%=user.Login %>
                                        <div class="user_settings">
                                            <a href="Edit.aspx">
                                                <i class="fa fa-cog"></i>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="add_info us_desktop">
                                        <ul>
                                            <% if (!String.IsNullOrEmpty(user.FullName)) %>
                                            <%{ Response.Write(String.Format("<li>{0}</li>", user.FullName)); }%>
                                            <% if (!String.IsNullOrEmpty(user.Url)) %>
                                            <%{ Response.Write(String.Format("<li><a href=\"{0}\">профиль</a></li>", user.Url)); }%>
                                            <% if (!String.IsNullOrEmpty(user.RegDate)) %>
                                            <%{ Response.Write(String.Format("<li>на сайте с {0}</li>", user.RegDate)); }%>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="add_info us_mobile col-xs-12" style="margin-top: 10px; text-align: center">
                                <ul>
                                    <% if (!String.IsNullOrEmpty(user.FullName)) %>
                                    <%{ Response.Write(String.Format("<li>{0}</li>", user.FullName)); }%>
                                    <% if (!String.IsNullOrEmpty(user.Url)) %>
                                    <%{ Response.Write(String.Format("<li><a href=\"{0}\">профиль</a></li>", user.Url)); }%>
                                    <% if (!String.IsNullOrEmpty(user.RegDate)) %>
                                    <%{ Response.Write(String.Format("<li>на сайте с {0}</li>", user.RegDate)); }%>
                                </ul>
                            </div>
                            <div class="col-md-12">
                                <br />
                            </div>
                            <div class="col-xs-12 col-sm-12 col-md-4">
                                <div class="waif_cont_title">
                                    О себе.
                                </div>
                                <div class="user_biog">
                                    <%=user.Description %>
                                </div>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-4 waif_rec">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="user_inf_titles">
                                            <i class="fa fa-plus user_titles_arrow" aria-hidden="true" style="float: left;"></i>
                                            <a href="#">Добавленное
                                            <i class="fa fa-caret-right user_titles_arrow" aria-hidden="true"></i>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="user_recomend">
                                        <ul class="user_waif_list">
                                            <asp:Repeater ID="Added_Repeater" runat="server">
                                                <ItemTemplate>
                                                    <li class="col-md-12">
                                                        <div class="col-md-6 user_waif_img">
                                                            <a href='<%# Eval("Id", "Waif.aspx?id={0}") %>'>
                                                                <img src='<%# Eval("Image")%>' alt="Ошибка" />
                                                            </a>
                                                        </div>
                                                        <div class="col-md-6 usl_title">
                                                            <a href='<%# Eval("Id", "Waif.aspx?id={0}") %>'>
                                                                <%# Eval("Name") %>
                                                            </a>
                                                        </div>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-4 waif_rec">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="user_inf_titles">
                                            <i class="fa fa-heart user_titles_arrow" aria-hidden="true" style="float: left;"></i>
                                            <a href="#">Избранное
                                            <i class="fa fa-caret-right user_titles_arrow" aria-hidden="true"></i>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="user_recomend">
                                        <ul class="user_waif_list">
                                            <asp:Repeater ID="Favorites_Repeater" runat="server">
                                                <ItemTemplate>
                                                    <li class="col-md-12">
                                                        <div class="col-md-6 user_waif_img">
                                                            <a href='<%# Eval("Id", "Waif.aspx?id={0}") %>'>
                                                                <img src='<%# Eval("Image")%>' alt="Ошибка" />
                                                            </a>
                                                        </div>
                                                        <div class="col-md-6 usl_title">
                                                            <a href='<%# Eval("Id", "Waif.aspx?id={0}") %>'>
                                                                <%# Eval("Name") %>
                                                            </a>
                                                        </div>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <h1 class="sub_logo" align="center">Комментарии</h1>
                </div>
                <div class="waif col-md-12">
                    <div class="waif_inp">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="waif_cont_title">
                                    Оставить свой
                                </div>
                            </div>
                            <div class="col-md-10">
                                <textarea rows="1" placeholder="Текст комментария"
                                    name="wcomments" id="wcomments"></textarea>
                            </div>
                            <div class="col-md-2">
                                <button class="comm_but">
                                    Отправить
                                </button>
                            </div>
                            <uc1:Comments runat="server" id="Comments"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="FootetContent" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
</asp:Content>
