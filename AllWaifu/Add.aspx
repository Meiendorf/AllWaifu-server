<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="Add.aspx.cs" Inherits="AllWaifu.Add_Waif" %>
<%@ MasterType  virtualPath="~/AllWaifu.master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
    <link rel="stylesheet" href="/css/search.css?2" />
    <link rel="stylesheet" href="/css/anime.css?9" />
    <link rel="stylesheet" href="/css/add_waif.css?2" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InSlideoutListPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="SlideoutPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <div class="addwaif_grid">
        <div class="add_waif">
            <div class="type_title">
                Добавить персонажа
            </div>
            <div class="content_chapter">
                <div class="row">
                    <div class="col-md-4">
                        <div class="load_box">
                            <div class="" style="padding: 0px 5px 0px 5px; grid-area: limage;">
                                <img class="load_image" src="/images/none.png" runat="server" id="ThumbImage" alt="Image">
                            </div>
                            <div class="load_image_cont" style="grid-area: lcont;">
                                <div class="anime_desc_title">
                                    Загрузите изображение
                                </div>
                                Размеры не должны быть меньше 1024x576. Соотношение 16:9.
                            </div>
                            <div class="anime_watch" style="grid-area: lbut;">
                                <button type="button" name="LoadImage" id="LoadImage">
                                    Выбрать файл
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="anime_desc_title" style="padding: 10px">
                            Основная информация.
                        </div>
                        <div class="row chapter_row">
                            <div class="col-md-3">
                                <div class="anime_desc_title" style="font-weight: normal">
                                    Имя персонажа
                                </div>
                            </div>
                            <div class="col-md-9">
                                <input required class="chapter_input" type="text" name="WaifName" id="WaifName">
                            </div>
                        </div>
                        <div class="row chapter_row">
                            <div class="col-md-3">
                                <div class="anime_desc_title" style="font-weight: normal">
                                    Название аниме
                                </div>
                            </div>
                            <div class="col-md-9">
                                <input required class="chapter_input" type="text" name="WaifName" id="AnimeName">
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="anime_desc_title">
                                Описание
                            </div>
                            <div class="content_chapter">
                                <div class="waif_cont_text">
                                    Описание персонажа включает в себя структурированные части, в которые входят поля и их значения. Часть может не содержать в себе полей, а состоять только из текста. Для лучшего понимания компановки рекомендуется ознакомиться с уже существующими на сайте описаниями. Вы можете использовать шаблонные элементы, удалять их, добавлять свои и задавать им размер и название.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="description_chapter">
                        <div class="desc_title type_title">
                            <div class="sub_desc_title">
                                <div class="desc_select_title">
                                    Размер 
                                </div>
                                <select class="desc_select">
                                    <option>0.5</option>
                                    <option>1</option>
                                    <option>0.3</option>
                                </select>
                                <input class="field_input" required placeholder="Название части (нажмите для редактирования)" type="text">
                            </div>
                            <div class="delete_el_but">
                                <i class="fa fa-times" aria-hidden="true"></i>
                            </div>
                        </div>
                        <div class="row desc_field_row">
                            <div class="col-md-3">
                                <div class="desc_field_title">
                                    <textarea rows="2" required placeholder="Название поля" class="field_input"></textarea>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="desc_field_content">
                                    <textarea rows="2" required placeholder="Содержимое поля (для расширения потяните за правый нижний край)" class="desc_field_text"></textarea>
                                    <div class="delete_el_but">
                                        <i class="fa fa-times" aria-hidden="true"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12" style="padding: 0">
                            </div>
                        </div>
                        <div class="row desc_field_row">
                            <div class="col-md-3">
                                <div class="desc_field_title">
                                    <textarea rows="2" required placeholder="Название поля" class="field_input"></textarea>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="desc_field_content">
                                    <textarea rows="2" required placeholder="Содержимое поля (для расширения потяните за правый нижний край)" class="desc_field_text"></textarea>
                                    <div class="delete_el_but">
                                        <i class="fa fa-times" aria-hidden="true"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12" style="padding: 0">
                            </div>
                        </div>
                        <div class="row desc_field_row">
                            <div class="col-md-3">
                                <div class="desc_field_title">
                                    <textarea rows="2" required placeholder="Название поля" class="field_input"></textarea>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="desc_field_content">
                                    <textarea rows="2" required placeholder="Содержимое поля (для расширения потяните за правый нижний край)" class="desc_field_text"></textarea>
                                    <div class="delete_el_but">
                                        <i class="fa fa-times" aria-hidden="true"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12" style="padding: 0">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 add_but_cont">
                                <div class="anime_watch">
                                    <button type="button" class="field_add_but field_but">
                                        Добавить
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="description_chapter">
                        <div class="desc_title type_title">
                            <div class="sub_desc_title">
                                <div class="desc_select_title">
                                    Размер 
                                </div>
                                <select class="desc_select">
                                    <option>0.5</option>
                                    <option>1</option>
                                    <option>0.3</option>
                                </select>
                                <input class="field_input" required placeholder="Название части (нажмите для редактирования)" type="text">
                            </div>
                            <div class="delete_el_but">
                                <i class="fa fa-times" aria-hidden="true"></i>
                            </div>
                        </div>
                        <div class="row desc_field_row">
                            <div class="col-md-12">
                                <div class="desc_field_content">
                                    <textarea rows="3" required placeholder="Содержимое части" class="desc_field_text"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="description_chapter">
                        <div class="desc_title type_title">
                            Теги
                        </div>
                        <div class="content_chapter" style="text-align: center;">
                            <div class="waif_cont_text">
                                Перечислите ключевые слова, которые кратко охарактеризуют вашего персонажа и по которым его можно будет легко найти.
                            </div>
                        </div>
                        <div class="tag_inp_container" style="padding: 5px 20px">
                            <textarea rows="1" id="TagsInp" placeholder="Перечислите теги через запятую" class="desc_field_text"></textarea>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="_description_chapter">
                        <div class="desc_title type_title">
                            Альтернативные имена
                        </div>
                        <div class="content_chapter" style="text-align: center;">
                            <div class="waif_cont_text">
                                Перечислите другие имена вашего персонажа.
                            </div>
                        </div>
                        <div class="tag_inp_container" style="padding: 5px 20px">
                            <textarea rows="1" id="AlterNames" placeholder="Перечислите имена через запятую" class="desc_field_text"></textarea>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 add_but_cont send_but_cont">
                    <% if ((((AllWaifu.AllWaifu)Master).user.Role == "Admin" || ((AllWaifu.AllWaifu)Master).user.Role == "Creator") && (Confirmed != "1"))
                    { %>
                       <div class="anime_watch">
                           <input type="submit" class="field_add_but" style="background-color: #63D795"  onclick="if (checkFormValidation()) { acceptWaifu(); }" runat="server" value="Подтвердить" id="_Admin_Button" onserverclick="ConfirmAdmin_ServerClick" />
                        </div>
                    <%}%>
                    <% else if ((((AllWaifu.AllWaifu)Master).user.Role == "Admin" || ((AllWaifu.AllWaifu)Master).user.Role == "Creator") && (Confirmed == "1"))
                    { %>
                       <div class="anime_watch">
                           <input type="submit" class="field_add_but" style="background-color: #FF6666"  onclick="deleteWaifuClick(<%=RenWaif.Id%>);" runat="server" value="Удалить" id="DeleteWaifuBut"/>
                        </div>
                    <%}
                    else
                    { %>
                        <div class="send_cont_text">
                            Прежде чем появиться на сайте, ваше описание должно быть проверено администрацией. После окончания проверки мы сразу же вас уведомим.
                        </div>
                    <%} %>
                    
                    <div class="anime_watch">
                        <input type="submit" class="field_add_but" value="Отправить" onclick="if (checkFormValidation()) { parsePageToWaifuXml(); sendWaifToServer(); }" runat="server" id="_Confirm_Button" onserverclick="Confirm_ServerClick" />
                    </div>
                    <div class="anime_watch">
                        <button type="button" onclick="addNewChapter('field')" class="field_add_but" id="addFieldBut">
                            Добавить c полями
                        </button>
                    </div>
                    <div class="anime_watch">
                        <button type="button" onclick="addNewChapter('text')" class="field_add_but" id="addTextBut">
                            Добавить без полей
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
    <script type="text/javascript" src="/js/add_waif.js?<%=DateTime.Now.Ticks.ToString()%>"></script>
    <script src="/bower_components/blueimp-file-upload/js/vendor/jquery.ui.widget.js" type="text/javascript"></script>
    <script src="/bower_components/blueimp-file-upload/js/jquery.iframe-transport.js" type="text/javascript"></script>
    <script src="/bower_components/blueimp-file-upload/js/jquery.fileupload.js" type="text/javascript"></script>
    <script src="/bower_components/cloudinary-jquery/cloudinary-jquery.js" type="text/javascript"></script>
    <script src="https://widget.cloudinary.com/global/all.js" type="text/javascript"></script>
    <script type="text/javascript">
        var userName = "<%=((AllWaifu.AllWaifu)Master).user.Login%>";
        var userToken = "<%=((AllWaifu.AllWaifu)Master).user.Id%>";
       
        var rofl = <% if (SerializedWaif == "")
        { Response.Write(String.Format("\"{0}\"", SerializedWaif)); }
        else { Response.Write(SerializedWaif); }%>
    </script>
</asp:Content>
