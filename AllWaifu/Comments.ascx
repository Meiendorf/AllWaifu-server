<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Comments.ascx.cs" Inherits="AllWaifu.Comments" %>
<%if ((CommentsRepeater.DataSource as ICollection).Count == 0)
    {
        Response.Write(@"<div class=""empty_block"">
                                <div class=""anime_desc_title"">
                                    Здесь пусто!
                                </div>
                                <img src=""/images/yo.png"" class=""empty_block_image"" alt="""">
                             </div>");
    }%>
<div class="comment_list" id="CommentsList" runat="server">
    <asp:Repeater ID="CommentsRepeater" runat="server">
        <ItemTemplate>
            <div class="comment_el" id="comment-<%#Eval("Id")%>">
                <div class="comment_img">
                    <a href="/profile/<%#Eval("From.Id")%>">
                        <img src="<%#Eval("From.Image")%>" />
                    </a>
                </div>
                <div class="comment_name">
                    <a href="/profile/<%#Eval("From.Id")%>">
                        <%#Eval("From.Login")%>
                    </a>
                </div>
                <div class="comment_additional">
                    <div class="comment_date">
                        <%#Eval("Date")%>
                    </div>
                    <div title="@<%#Eval("From.Login")%>" class="comment_reply">
                        <a>Ответить</a>
                    </div>
                    <div class="comment_complain">
                        <a>Пожаловаться</a>
                    </div>
                </div>
                <div class="comment_text">
                    <%#Eval("Text")%>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
