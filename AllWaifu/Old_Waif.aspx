<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="Old_Waif.aspx.cs" Inherits="AllWaifu.Waif" %>
<%@ MasterType  virtualPath="~/AllWaifu.master"%>
<%@ Register Src="~/Comments.ascx" TagPrefix="uc1" TagName="Comments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">

</asp:Content>
<asp:Content ID="OwlContent" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
    <h1 class="sub_logo hidden-xs">Replenished Collection of Anime Characters</h1>
    <h1 class="sub_logo_min"> Collection of Characters </h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <section class="main_context">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="waif">
                        <div class="waif_img">
                            <img src="<%=PageWaif.Image %>" alt="Ошибка"/>
                            <div class="waif_img_cont gradient_generator">
                                <div class="waif_title">
                                    <%=PageWaif.Name%>
                                </div>
                                <div class="anime_title">
                                    <a href="#" style="font-size:25px !important;">
                                        <%=PageWaif.Anime %>
                                    </a>
                                </div>
                                <div class="waif_author anime_title">
                                    Добавлено : 
                                    <a href="#" style="font-size:25px !important;">
                                        <%=PageWaif.Author %>
                                    </a>
                                </div>
                                <div class="waif_follow">
                                    <div class="waif_follow_but">
                                        <i class="fa fa-heart-o f_var" aria-hidden="true"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding: 10px;padding-top : 0">
                            <div class="waif_content">
                                <div class="mobile_waif_title">
                                    <div class="gradient_generator">
                                        <div class="waif_title" style="font-size : 35px; font-weight: bold;">
                                            <%=PageWaif.Name %>
                                        </div>
                                        <div class="anime_title">
                                            <a href="#" style="font-size:25px !important;"">
                                                <%=PageWaif.Anime %>
                                            </a>
                                        </div>
                                        <div class="waif_follow">
                                            <div class="waif_follow_but">
                                                <span><b>В избранное </b> </span>
                                                <i class="fa fa-heart-o f_var" aria-hidden="true"></i>
                                            </div>
                                        </div>
                                    </div>
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
                                                               <%#Eval("Title")+" "%>
                                                           </b> 
                                                           <%#Eval("Content") %><br/>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <div class="waif_cont_column col-md-12">
                                    <div class="waif_cont_block col-md-12">
                                        <% if (PageWaif.FormatTags.Count != 0)
                                            {%>
                                        <div class="waif_cont_title">
                                            Теги
                                        </div>
                                        <%}%>
                                        <div class="waif_cont_text waif_tags">
                                            <asp:Repeater ID="TagRepeater" runat="server">
                                                <ItemTemplate>
                                                    <div class="tag">
                                                        <a href="#">
                                                            <%# Container.DataItem %>
                                                        </a>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div> 
                                    </div> 
                                </div>
                                <div class="col-md-12 xs-author">
                                    <div class="anime_title" style="float: right;">
                                        <span><b>Добавил :</b> </span>
                                        <a href="#">
                                            <%=PageWaif.Author%>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <h1 class="sub_logo" align="center">Комментарии</h1>
                    <div class="waif">
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
                                <uc1:Comments runat="server" id="Comments" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
    <div class="pop_div">
        Добавлено в избранное
    </div>
</asp:Content>
