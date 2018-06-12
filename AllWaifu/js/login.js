var toogleLostPass = function(){
    $(".lost_pass_cont").fadeToggle();
    $(".lost_pass_box").fadeToggle();
}

function iterateTextInputs(func) {
    $('input').not(':input[type=button], :input[type=submit], :input[type=hidden], :input[type=image]').
        each(func);
}
function lostPassClick() {
    iterateTextInputs(function (i, e) {
        e.required = false;
    });
    $("#LostPassEmail")[0].required = true;
}
function closeLostPassClick() {
    iterateTextInputs(function (i, e) {
        e.required = true;
    });
    $("#LostPassEmail")[0].value = "";
    $("#LostPassEmail")[0].required = false;
}

$(".lost_pass_cont").hide();
$(".lost_pass_box").hide();

$(document).ready(function () {
    /* SETCUSTOMVALIDITY БПАН */ 
    
    $("#LostPassBut").click(function () {
        $(".lost_pass_cont").fadeIn();
        $(".lost_pass_box").fadeIn();
    });
    $("#HideLostBut").click(function () {
        $(".lost_pass_cont").fadeOut();
        $(".lost_pass_box").fadeOut();
    });

   $("#SendRecoveryBut")[0].formAction = "";
   $("#SendRecoveryBut").click(lostPassConfirm);

   $('.lost_pass_cont').on('keyup keypress', function (e) {
       var keyCode = e.keyCode || e.which;
       if (keyCode === 13) {
           e.preventDefault();
           return false;
       }
   });

});
loginForm = $(".login_form").clone();
registForm = $(".regist_form").clone();
loginForm.hide();
registForm.hide();
$(".regist_form").remove();

$("#logToRegBut").click(LogToRegClick);
$("#regToLogBut").click(RegToLogClick);
$("#LostPassEmail").blur(IsEmailInBaseLostBlur);

function RegToLogClick() {
    $(".regist_form").remove();
    newForm = loginForm.clone();
    newForm.find("#logToRegBut").click(LogToRegClick);
    $(".cool_content").after(newForm);
    $(".login_form").fadeIn();
    $("#LostPassBut").click(toogleLostPass);
    $("#LostPassEmail").blur(IsEmailInBaseLostBlur);
}

function LogToRegClick() {
    $(".login_form").remove();
    newForm = registForm.clone();
    newForm.find("#regToLogBut").click(RegToLogClick);
    newForm.find("#RegRepeatPass").change(PassRepeatClick);
    newForm.find("#RegLogin").blur(IsLoginInBaseBlur);
    newForm.find("#RegEmail").blur(IsEmailInBaseBlur);
    $(".cool_content").after(newForm);
    $(".regist_form").fadeIn();
}
function IsLoginInBaseBlur() {
    AllWaifu.AjaxHelper.IsLoginInBase($("#RegLogin")[0].value,
        OnLoginValidationComplete, OnLoginValidationError);
}
function OnLoginValidationComplete(result) {
    if (result) {
        $get("RegLogin").setCustomValidity("Этот логин уже занят!");
    }
    else {
        $get("RegLogin").setCustomValidity('');
    }
}
function OnLoginValidationError(error) {
    $get("RegLogin").setCustomValidity("Этот логин уже занят!");
}

function IsEmailInBaseLostBlur() {
    AllWaifu.AjaxHelper.IsEmailInBase($("#LostPassEmail")[0].value,
        OnEmailValidationCompleteLost, function (err) { });
}

function OnEmailValidationCompleteLost(result) {
    if (!result) {
        $get("LostPassEmail").setCustomValidity("Такого пользователя не существует!");
    }
    else {
        $get("LostPassEmail").setCustomValidity('');
    }
}

function IsEmailInBaseBlur() {
    AllWaifu.AjaxHelper.IsEmailInBase($("#RegEmail")[0].value,
        OnEmailValidationComplete, OnEmailValidationError);
}
function OnEmailValidationComplete(result) {
    if (result) {
        $get("RegEmail").setCustomValidity("Эта почта уже занята!");
    }
    else {
        $get("RegEmail").setCustomValidity('');
    }
}
function OnEmailValidationError(error) {
    $get("RegEmail").setCustomValidity("Эта почта уже занята!");
}

function PassRepeatClick(){
    if ($("#RegPass")[0].value != $("#RegRepeatPass")[0].value) {
        $get("RegRepeatPass").setCustomValidity('Пароли не совпадают');
    }
    else {
        $get("RegRepeatPass").setCustomValidity('');
    }
}

function lostPassConfirm() {
    if (!$("#LostPassEmail")[0].checkValidity()) {
        return;
    }
    $("#LoginError")[0].innerText = "";
    lostEmail = $("#LostPassEmail")[0].value;
    /* writing token to db and sending as url to email */
    AllWaifu.AjaxHelper.SendRecoveryUrl(lostEmail,
        function (result) {
            if (!result) {
                $("#LoginError")[0].innerText = "Произошла ошибка при отправке ссылки. Повторите попытку.";
            }
        }, function (err) { console.log(err); });
    closeLostPassClick();
    toogleLostPass();
}