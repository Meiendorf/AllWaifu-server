<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="Old_Add.aspx.cs" Inherits="AllWaifu.Old_Add" %>
<%@ MasterType  virtualPath="~/AllWaifu.master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
    <link rel="stylesheet" href="css/search.css" />
    <link rel="stylesheet" href="css/anime.css" />
    <link rel="stylesheet" href="css/add_waif.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <section class="main_context">
        <div class="container">
            <div class="row">
                <div class="col-md-12 waif add_waif">
                    <div class="row">

                        <div class="col-md-12"">
                            <div class="waif_cont_title">
                                Основная информация.
                            </div>
                            <div class="content_chapter">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="load_box">
                                            <div class="" style="padding: 0px 5px 0px 5px; grid-area : limage;">
                                                <img class="load_image" src="images/none.png" id="ThumbImage" runat="server" alt="Image"/>
                                            </div>
                                            <div class="load_image_cont" style="grid-area: lcont;">
                                                <div class="waif_cont_title" style="font-size: 21px">
                                                    Загрузите изображение
                                                </div>
                                                Размеры не должны быть меньше 1024x576. Соотношение 16:9.
                                            </div>
                                            <div class="load_but" style="grid-area : lbut;">
                                                <input type="button" class="comm_but" value="Выбрать файл" name="LoadImage" id="LoadImage"/>
                                            </div>
                                         </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="row chapter_row">
                                            <div class="col-md-3">
                                                <div class="chapter_label">
                                                    Имя персонажа
                                                </div>
                                            </div>
                                            <div class="col-md-9">
                                                <input class="chapter_input" required type="text" name="WaifName" id="WaifName"/>
                                            </div>
                                        </div>
                                        <div class="row chapter_row">
                                            <div class="col-md-3">
                                                <div class="chapter_label">
                                                    Название аниме
                                                </div>
                                            </div>
                                            <div class="col-md-9">
                                                <input required class="chapter_input" type="text" name="WaifName" id="AnimeName"/>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="waif_cont_title">
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
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="description_chapter">
                                <div class="desc_title">
                                    <div class="waif_cont_title">
                                        <div class="desc_select_title">
                                            Размер 
                                        </div>
                                        <select class="desc_select">
                                            <option>0.5</option>
                                            <option>1</option>
                                            <option>0.3</option>
                                        </select>
                                        <input required class="field_input" placeholder="Название части (нажмите для редактирования)"  type="text"/>
                                    </div>
                                    <div class="delete_el_but">
                                        <i class="fa fa-times-circle" aria-hidden="true"></i>
                                    </div>
                                </div>
                                <div class="row desc_field_row">
                                    <div class="col-md-3">
                                        <div class="desc_field_title">
                                            <textarea required rows="1" placeholder="Название поля" class="field_input"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-md-9">
                                        <div class="desc_field_content">
                                            <textarea required rows="1" placeholder="Содержимое поля (для расширения потяните за правый нижний край)" 
                                            class="desc_field_text"></textarea>
                                            <div class="delete_el_but">
                                                <i class="fa fa-times-circle" aria-hidden="true"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12" style="padding: 0">
                                        <hr style="margin: 0"/>
                                    </div>
                                </div>
                                <div class="row desc_field_row">
                                    <div class="col-md-3">
                                        <div class="desc_field_title">
                                            <textarea required rows="1" placeholder="Название поля" class="field_input"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-md-9">
                                        <div class="desc_field_content">
                                            <textarea required rows="1" placeholder="Содержимое поля (для расширения потяните за правый нижний край)" 
                                            class="desc_field_text"></textarea>
                                            <div class="delete_el_but">
                                                <i class="fa fa-times-circle" aria-hidden="true"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12" style="padding: 0">
                                        <hr style="margin: 0"/>
                                    </div>
                                </div>
                                <div class="row desc_field_row">
                                    <div class="col-md-3">
                                        <div class="desc_field_title">
                                            <textarea required rows="1" placeholder="Название поля" class="field_input"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-md-9">
                                        <div class="desc_field_content">
                                            <textarea required rows="1" placeholder="Содержимое поля (для расширения потяните за правый нижний край)" 
                                            class="desc_field_text"></textarea>
                                            <div class="delete_el_but">
                                                <i class="fa fa-times-circle" aria-hidden="true"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12" style="padding: 0">
                                        <hr style="margin: 0"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 add_but_cont">
                                        <input type="button" class="comm_but field_add_but field_but" value="Добавить"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="description_chapter">
                                <div class="desc_title">
                                    <div class="waif_cont_title">
                                        <div class="desc_select_title">
                                            Размер 
                                        </div>
                                        <select class="desc_select">
                                            <option>0.5</option>
                                            <option>1</option>
                                            <option>0.3</option>
                                        </select>
                                        <input required class="field_input" placeholder="Название части (нажмите для редактирования)" type="text"/>
                                    </div>
                                    <div class="delete_el_but">
                                        <i class="fa fa-times-circle" aria-hidden="true"></i>
                                    </div>
                                </div>
                                <div class="row desc_field_row">
                                    <div class="col-md-12">
                                        <div class="desc_field_content">
                                            <textarea required rows="3" placeholder="Содержимое части" 
                                            class="desc_field_text"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="description_chapter" style="padding: 5px">
                                <div class="waif_cont_title">
                                    Теги
                                </div>
                                <hr style="margin: 0"/>
                                <div class="content_chapter" style="text-align: center;">
                                    <div class="waif_cont_text">
                                        Перечислите ключевые слова, которые кратко охарактеризуют вашего персонажа и по которым его можно будет легко найти.
                                    </div>
                                </div>
                                <textarea id="TagsInp" rows="1" placeholder="Перечислите теги через запятую" 
                                class="desc_field_text"></textarea>
                            </div>
                        </div>
                        <div class="col-md-12 add_but_cont send_but_cont">
                            <% if ((Master.user.Role == "Admin" || Master.user.Role == "Ghost Writer") && (Confirmed != "1"))
                                { %>
                                <input type="submit" class="comm_but field_add_but" onclick="if (checkFormValidation()) { acceptWaifu(); }" runat="server" value="Подтвердить" id="Admin_Button" onserverclick="ConfirmAdmin_ServerClick"/>
                            <%} else { %>
                              <div class="send_cont_text">
                                Прежде чем появиться на сайте, ваше описание должно быть проверено администрацией. После окончания проверки мы сразу же вас уведомим.
                            </div>
                            <%} %>
                            <input type="submit" class="comm_but field_add_but" onclick="if (checkFormValidation()) { parsePageToWaifuXml(); sendWaifToServer(); }" runat="server" value="Отправить" id="Confirm_Button" onserverclick="Confirm_ServerClick"/>
                            <input type="button" onclick="addNewChapter('field')" class="comm_but field_add_but" value="Добавить с полями" id="addFieldBut"/>
                            <input type="button" onclick="addNewChapter('text')" class="comm_but field_add_but" value="Добавить без полей" id="addTextBut"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
    <script type="text/javascript" src="js/add_waif.js?<%=DateTime.Now.Ticks.ToString()%>"></script>
    <script src="bower_components/blueimp-file-upload/js/vendor/jquery.ui.widget.js" type="text/javascript"></script>
    <script src="bower_components/blueimp-file-upload/js/jquery.iframe-transport.js" type="text/javascript"></script>
    <script src="bower_components/blueimp-file-upload/js/jquery.fileupload.js" type="text/javascript"></script>
    <script src="bower_components/cloudinary-jquery/cloudinary-jquery.js" type="text/javascript"></script>
    <script src="https://widget.cloudinary.com/global/all.js" type="text/javascript"></script>
    <script type="text/javascript">
        var userName = "<%=Master.user.Login%>";
       
        var rofl = <% if (SerializedWaif == "")
                           { Response.Write(String.Format("\"{0}\"", SerializedWaif)); }
                      else { Response.Write(SerializedWaif); }%>
    </script>
</asp:Content>
