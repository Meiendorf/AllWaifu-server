<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Recovery.aspx.cs" Inherits="AllWaifu.RecoveryPage" %>

<!DOCTYPE html>
<html lang="ru" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>AllWaifu</title>
    <meta name="description" content="" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="/favicon.png" />
    <link rel="stylesheet" href="/libs/bootstrap/bootstrap-grid-3.3.1.min.css" />
    <link rel="stylesheet" href="/libs/font-awesome-4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="/css/fonts.css" />
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="/css/anime.css" />
    <link rel="stylesheet" href='/css/login.css' />
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
                    Восстановление пароля
                </div>
                <hr />
                <div class="err_message">
                    <asp:Label Text="" ID="LoginError" runat="server" />
                </div>
                <div class="login_field">
                    <div class="login_label">
                        Новый пароль
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
                    <input runat="server" value="Подвердить" type="submit" onserverclick="ConfirmRecovery_ServerClick" />
                </div>
            </div>
        </div>
    </form>
</body>

<script src="/libs/jquery/jquery-1.11.1.min.js"></script>
<script>
    $("#RegRepeatPass").change(PassRepeatClick);

    function PassRepeatClick() {
        if ($("#RegPass")[0].value != $("#RegRepeatPass")[0].value) {
            $get("RegRepeatPass").setCustomValidity('Пароли не совпадают');
        }
        else {
            $get("RegRepeatPass").setCustomValidity('');
        }
    }
</script>
</html>
