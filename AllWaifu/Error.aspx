<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="AllWaifu.ErrorPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <section class="main_context vertical-center">
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 col-lg-12">
                    <div class="error_main">
                        <div class="error_code">
                            <%=ErrorCode%>
                        </div>
                        <div class="error_content">
                            <%=ErrorMessage%>
                        </div>
                        <div class="error_image col-md-7 col-lg-7">
                            <img src="/images/error.png"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
</asp:Content>
