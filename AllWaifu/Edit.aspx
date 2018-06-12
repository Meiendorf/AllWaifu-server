<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="AllWaifu.Edit_Page" %>
<%@ MasterType  virtualPath="~/AllWaifu.master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
    <link rel="stylesheet" href="/css/anime.css" 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <section class="main_context" style="color : #000">
        <div class="container">
            <div class="row">
                <div class="type_title edit_main_title">
                    Настройки
                </div>
                <div class="edit_grid">
                    <div class="anime_desc_title edit_title">
                        Основные данные
                    </div>
                    <div class="edit_photo_grid">
                        <img class="edit_img" id="ThumbImage" runat="server" src="/images/none.png"/>
                        <div class="edit_img_func">
                            <div class="anime_desc_title edit_img_title" style="font-size : 20px">
                                Обновить фото
                            </div>
                            <div style="margin: 2px 0px">
                                Фото будет приведено к размерам 200x200
                            </div>
                            <div class="anime_watch">
                                <button type="button" id="LoadImage">
                                    Выбрать файл
                                    <i class="fa fa-upload"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="edit_login_grid">
                        <div class="edit_el">
                        </div>
                        <div class="edit_el">
                            <div class="chapter_label">
                                Логин 
                            </div>
                            <input runat="server" pattern="^[а-яА-ЯёЁa-zA-Z0-9_]{3,30}$" class="chpater_input" type="text" id="UserName" required
                               title="Логин должен занимать от 3 до 30 символов, и состоять только из букв, цифр и подчеркивания!"
                               placeholder="3-30 символов" />
                        </div>
                        <div class="edit_el">
                            <div class="chapter_label">
                                Почта 
                            </div>
                            <input type="email" runat="server" required id="UserEmail" 
                                class="chapter_input"
                                placeholder="Вводите существующий адрес" />
                        </div>
                    </div>
                    <div class="anime_desc_title edit_title">
                        Безопасность
                    </div>
                    <div class="edit_pass_grid">
                        <div class="edit_pass_el">
                            <br/>
                            <div class="chapter_label">
                                Старый пароль
                            </div>
                            <input runat="server" class="chapter_input" pattern="^[а-яА-ЯёЁa-zA-Z0-9_#@~*+=\'\-\;\:\/$%^&()\\\[\]|!?_-`\{\}]{6,30}$" type="password" id="OldPass"
                           title="Пароль должен занимать от 6 до 30 символов и не содержать пробелов и кавычек!" placeholder="6-30 символов" />
                        </div>
                        <div class="edit_pass_el">
                            <div class="chapter_label">
                                Новый пароль
                            </div>
                            <input runat="server" class="chapter_input" pattern="^[а-яА-ЯёЁa-zA-Z0-9_#@~*+=\'\-\;\:\/$%^&()\\\[\]|!?_-`\{\}]{6,30}$" type="password" id="RegPass"
                           title="Пароль должен занимать от 6 до 30 символов и не содержать пробелов и кавычек!" placeholder="6-30 символов" />
                        </div>
                        <div class="edit_pass_el">
                            <div class="chapter_label">
                                Повторите ввод
                            </div>
                            <input class="chapter_input" runat="server" type="password" id="RegRepeatPass"
                            placeholder="6-30 символов" />
                        </div>
                    </div>
                    <div class="anime_desc_title edit_title">
                        <br/>
                        Дополнительная информация
                    </div>
                    <div class="edit_custom_grid">
                        <div class="edit_custom_el edit_custom_desc">
                            <div class="chapter_label">
                                О себе
                            </div>
                            <textarea rows="4" runat="server" style="padding-bottom : 10px;" placeholder="Описание" 
                                 name="wcomments" id="wcomments"></textarea>
                        </div>
                        <div class="edit_custom_el edit_custom_name">
                            <div class="chapter_label">
                                Имя
                            </div>
                            <input class="chapter_input"  placeholder="Введите свое имя" type="text" runat="server" name="UserRName" id="UserRName"/>
                        </div>
                        <div class="edit_custom_el edit_custom_url">
                            <div class="chapter_label">
                                Ссылка
                            </div>
                            <input class="chapter_input" placeholder="Введите cсылку" runat="server" type="text" name="UserRName" id="UserUrl"/>
                        </div>
                        <div class="anime_watch save_button">
                            <button type="submit" runat="server" onserverclick="SaveAll_Click" id="SaveAll">
                                Сохранить
                                <i class="fa fa-floppy-o" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:hiddenfield id="ImageSrc" runat="server"></asp:hiddenfield>

    </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
    <script type="text/javascript">
        var userName = '<%= Master.user.Login%>';
        var email = '<%= Master.user.Email%>';
        var description = '<%=  Master.user.Description%>';
        var url = '<%= Master.user.Url%>';
        var name = '<%=Master.user.FullName%>';
        var id = '<%= Master.user.Id%>';
        $get("ImageSrc").value = '<%=Master.user.Image%>';
    </script>
    <script src="js/edit.js" type="text/javascript"></script>
    
    <script src="/bower_components/blueimp-file-upload/js/vendor/jquery.ui.widget.js" type="text/javascript"></script>
    <script src="/bower_components/blueimp-file-upload/js/jquery.iframe-transport.js" type="text/javascript"></script>
    <script src="/bower_components/blueimp-file-upload/js/jquery.fileupload.js" type="text/javascript"></script>
    <script src="/bower_components/cloudinary-jquery/cloudinary-jquery.js" type="text/javascript"></script>
    <script src="https://widget.cloudinary.com/global/all.js" type="text/javascript">  
    </script>

</asp:Content>
