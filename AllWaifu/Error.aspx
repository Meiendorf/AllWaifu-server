<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="AllWaifu.ErrorPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
    <link rel="stylesheet" href="/css/anim.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
    <h1 class="sub_logo hidden-xs"> Error </h1>
    <h1 class="sub_logo_min"> Error </h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <section class="main_context" style="color : #000">
        <div class="container">
            <div class="error_block">
                <div class="glitch" data-text="404">404</div>
                <br/>
                <img src="/images/kudere2.png" alt="" class="error_img">
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
</asp:Content>
