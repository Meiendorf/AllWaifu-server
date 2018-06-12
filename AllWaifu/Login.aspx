<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AllWaifu.Login" %>

<!DOCTYPE html>
<html lang="ru" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>AllWaifu</title>
    <meta name="description" content="" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="favicon.png" />
    <link rel="stylesheet" href="/libs/bootstrap/bootstrap-grid-3.3.1.min.css" />
    <link rel="stylesheet" href="/libs/font-awesome-4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="/css/fonts.css" />
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="/css/anime.css" />
    <link rel="stylesheet" href='/css/login.css??3>' />
    <link rel="stylesheet" href="/css/media.css" />
</head>
<body>
    <form id="form1" style="height: 100%;" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
            <Services>
                <asp:ServiceReference Path="~/AjaxHelper.asmx" />
            </Services>
        </asp:ScriptManager>
        <div class="main_grid">
            <div class="cool_mobile_content">
                ALLWAIFU
            </div>
            <div class="cool_content">
            </div>
            <div id="login_form" class="auth_form login_form">
                <div class="type_title">
                    Вход
                </div>
                <hr />
                <div class="err_message">
                    <asp:Label Text="" ID="LoginError" runat="server" />
                </div>
                <div class="login_field">
                    <div class="login_label">
                        Логин или почта
                    </div>
                    <div class="login_input">
                        <input runat="server" type="text" id="LogLogin" required
                            title="Введите логин или почту от вашего аккаунта"
                            placeholder="Введите логин или почту" />
                    </div>
                </div>
                <div class="login_field">
                    <div class="login_label">
                        Пароль
                    </div>
                    <div class="login_input">
                        <input runat="server" pattern="^[а-яА-ЯёЁa-zA-Z0-9_#@~*+=\-\/$%^&()\\\[\]|!?_-`\{\}]{6,30}$" type="password" id="LogPass" required
                            title="Пароль должен занимать от 6 до 30 символов и не содержать кавычек!" placeholder="6-30 символов" />
                    </div>
                </div>
                <div class="lost_pass">
                    <a href="#" onclick="lostPassClick();" id="LostPassBut" style="color: #333">Забыли пароль?</a>
                </div>
                <div class="login_but anime_watch">
                    <input runat="server" value="Войти" type="submit" onserverclick="Login_Click" />
                </div>
                <div class="anime_desc_title" style="margin-top: 10px">
                    Войти через
                </div>
                <ul class="social_login_list">
                    <li>
                        <asp:ImageButton ImageUrl="/images/vk_ico.png" ID="VkOAuthButton" formnovalidate
                            OnClick="OAuthButton_Click" CssClass="social_login_list_input" runat="server" />
                    </li>
                    <li>
                        <asp:ImageButton ImageUrl="/images/fb_ico.png" ID="FbOAuthButton" formnovalidate
                            OnClick="OAuthButton_Click" CssClass="social_login_list_input" runat="server" />
                    </li>
                    <li>
                        <asp:ImageButton ImageUrl="/images/gg_ico.png" ID="GgOAuthButton" formnovalidate
                            OnClick="OAuthButton_Click" CssClass="social_login_list_input" runat="server" />
                    </li>
                </ul>
                <hr />
                <div class="login_to_regist">
                    <div class="anime_desc_title">
                        Вы не зарегистрированы?
                    </div>
                    <div class="anime_watch">
                        <button id="logToRegBut" type="button">
                            Регистрация
                        </button>
                    </div>
                </div>
            </div>
            <div id="regist_form" class="auth_form regist_form">
                <div class="type_title">
                    Регистрация
                </div>
                <div class="err_message">
                    <asp:Label Text="" ID="RegError" runat="server" />
                </div>
                <div class="login_field">
                    <div class="login_label">
                        Email
                    </div>
                    <div class="login_input">
                        <input type="email" runat="server" required id="RegEmail" placeholder="Вводите существующий адрес" />
                    </div>
                </div>
                <div class="login_field">
                    <div class="login_label">
                        Логин
                    </div>
                    <div class="login_input">
                        <input runat="server" pattern="^[а-яА-ЯёЁa-zA-Z0-9_]{3,30}$" type="text" id="RegLogin" required
                            title="Логин должен занимать от 3 до 30 символов, и состоять только из букв, цифр и подчеркивания!"
                            placeholder="3-30 символов" />
                    </div>
                </div>
                <div class="login_field">
                    <div class="login_label">
                        Пароль
                    </div>
                    <div class="login_input">
                        <input runat="server" pattern="^[а-яА-ЯёЁa-zA-Z0-9_#@~*+=\-\/$%^&()\\\[\]|!?_-`\{\}]{6,30}$" type="password" id="RegPass" required
                            title="Пароль должен занимать от 6 до 30 символов и не содержать кавычек и пробелов!" placeholder="6-30 символов" />
                    </div>
                </div>
                <div class="login_field">
                    <div class="login_label">
                        Подтверждение пароля
                    </div>
                    <div class="login_input">
                        <input runat="server" type="password" id="RegRepeatPass" required
                            placeholder="6-30 символов" />
                    </div>
                </div>
                <div class="login_but anime_watch">
                    <input value="Зарегистрироваться" type="submit" runat="server" name="aspnetwebformssucks" onserverclick="Registration_Click"/>
                </div>
                <div class="login_to_regist">
                    <div class="anime_desc_title">
                        Уже есть аккаунт?
                    </div>
                    <div class="anime_watch">
                        <button type="button" id="regToLogBut">
                            Войти
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="lost_pass_cont" style="display : none">
            <div class="lost_pass_box">
                <div class="type_title">
                    Восстановить пароль
                    <div class="delete_el_but" onclick="closeLostPassClick();" id="HideLostBut">
                        <i class="fa fa-times" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="login_field">
                    <div class="login_label">
                        Почта
                    </div>
                    <div class="login_input">
                        <input id="LostPassEmail" type="email" placeholder="Введите сюда почту" />
                    </div>
                </div>
                <div class="lost_pass_info">
                    На вашу почту будет выслана ссылка для восстановления пароля. Она валидна в течении часа.
                </div>
                <div class="anime_watch">
                    <input value="Подтвердить" type="submit" id="SendRecoveryBut" />
                </div>
            </div>
        </div>
    </form>
</body>

<script src="/libs/jquery/jquery-1.11.1.min.js"></script>
<script charset="utf-8" type="text/javascript" src="/js/login.js?<%=DateTime.Now.Ticks.ToString() %>"></script>

</html>
