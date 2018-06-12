<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TopList.ascx.cs" Inherits="AllWaifu.TopList" %>
<asp:Repeater ID="TopRepeater" runat="server">
    <ItemTemplate>
        <div class="anime_top_els">
            <div class="anime_el_img">
                <a href="<%=PageUrl%>/<%#Eval("Id")%>">
                    <img src="<%#Eval("Image")%>" />
                </a>
                <div class="add_anime_waif_inf">
                    <i class="fa <%=PopIconClass%>" aria-hidden="true"></i>
                    <span><%#Eval("Popularity") %></span>
                </div>
            </div>
            <div class="anime_el_name cl-effect-5">
                <p>
                    <a href="<%=PageUrl%>/<%#Eval("Id") %>">
                        <span data-hover="<%#Eval("Name") %>">
                            <%#Eval("Name") %>
                        </span>
                    </a>
                </p>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
