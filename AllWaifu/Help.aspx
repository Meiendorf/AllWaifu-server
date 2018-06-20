<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="Help.aspx.cs" Inherits="AllWaifu.HelpPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
    <link rel="stylesheet" href="css/anime.css" />
    <link rel="stylesheet" href="css/help.css" />
    <link rel="stylesheet" href="css/search.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InSlideoutListPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="SlideoutPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <section class="main_context">
        <div class="main_grid_anime">
            <div class="anime_el">
                <div class="type_title">
                    Помощь
                </div>
                <div class="help_content">
                    <div class="help_title">
                        Часто задаваемые вопросы
                    </div>
                    <div class="help_additional">
                        Если вы только зарегистрировались, рекомендуем ознакомиться с правилами сайта.
                    </div>
                    <div class="help_list">
                        <div class="help_list_name">
                            Описания
                        </div>
                        <div data-accordion class="help_list_el">
                            <div data-control class="help_el_title">
                                Как добавить своё описание персонажа?
                            </div>
                            <div data-content class="help_el_content">
                                <div>В главном меню перейдите на страницу "Добавление".</div>
                            </div>
                        </div>
                        <div data-accordion class="help_list_el">
                            <div data-control class="help_el_title">
                                Как быстро мое описание проверят?
                            </div>
                            <div data-content class="help_el_content">
                                <div>По мере занятости администрации. В среднем этот процесс не должен длиться больше дня. Если ваше описание долго не появляется на сайте, свяжитесь с администрацией.</div>
                            </div>
                        </div>
                        <div data-accordion class="help_list_el">
                            <div data-control class="help_el_title">
                                Могу ли я изменить или удалить свое описание после отправки?
                            </div>
                            <div data-content class="help_el_content">
                                <div>Нет, только через администрацию.</div>
                            </div>
                        </div>
                        <div data-accordion class="help_list_el">
                            <div data-control class="help_el_title">
                                Есть ли ограничения на количество описаний?
                            </div>
                            <div data-content class="help_el_content">
                                <div>Нет, вы можете добавлять сколько угодно описаний.</div>
                            </div>
                        </div>
                        <div data-accordion class="help_list_el">
                            <div data-control class="help_el_title">
                                Что учитывается при проверке описания?
                            </div>
                            <div data-content class="help_el_content">
                                <div>Во-первых, уникальность. Если описание данного персонажа уже существует, то мы сравним его с вашим и выберем лучшее. Во-вторых, качество характеристики. Она должна быть развернутой, полной, выражающей суть персонажа во всех возможных подробностях. Администрация имеет право редактирования полученных описаний для исправления ошибок, так что не удивляейтесь, если что-то будет не совпадать с вашим вариантом.</div>
                            </div>
                        </div>
                    </div>
                    <div class="help_list">
                        <div class="help_list_name">
                            Профиль
                        </div>
                        <div data-accordion class="help_list_el">
                            <div data-control class="help_el_title">
                                Можно ли удалить свой аккаунт?
                            </div>
                            <div data-content class="help_el_content">
                                <div>Пока нет, но в скором времени такая функция будет добавлена</div>
                            </div>
                        </div>
                        <div data-accordion class="help_list_el">
                            <div data-control class="help_el_title">
                                Как быстро мое описание проверят?
                            </div>
                            <div data-content class="help_el_content">
                                <div>По мере занятости администрации. В среднем этот процесс не должен длиться больше дня. Если ваше описание долго не появляется на сайте, свяжитесь с администрацией.</div>
                            </div>
                        </div>
                        <div data-accordion class="help_list_el">
                            <div data-control class="help_el_title">
                                Могу ли я изменить или удалить свое описание после отправки?
                            </div>
                            <div data-content class="help_el_content">
                                <div>Нет, только через администрацию.</div>
                            </div>
                        </div>
                        <div data-accordion class="help_list_el">
                            <div data-control class="help_el_title">
                                Есть ли ограничения на количество описаний?
                            </div>
                            <div data-content class="help_el_content">
                                <div>Нет, вы можете добавлять сколько угодно описаний.</div>
                            </div>
                        </div>
                        <div data-accordion class="help_list_el">
                            <div data-control class="help_el_title">
                                Что учитывается при проверке описания?
                            </div>
                            <div data-content class="help_el_content">
                                <div>Во-первых, уникальность. Если описание данного персонажа уже существует, то мы сравним его с вашим и выберем лучшее. Во-вторых, качество характеристики. Она должна быть развернутой, полной, выражающей суть персонажа во всех возможных подробностях. Администрация имеет право редактирования полученных описаний для исправления ошибок, так что не удивляейтесь, если что-то будет не совпадать с вашим вариантом.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="anime_top">
                <div class="vk_news_anime" style="box-shadow: none; color: #fff;">
                    <div class="type_title">
                        МЫ В VK
                    </div>
                    <div id="vk_groups"></div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
    <script src="js/vk_openapi.js"></script>
    <script type="text/javascript">
        $("[data-accordion]").accordion({
            "transitionSpeed": 400
        });
		VK.Widgets.Group("vk_groups", {mode: 4, width: "auto", wide: 1, height: "400"}, 155417759);
	</script>
</asp:Content>
