<%@ Page Title="" Language="C#" MasterPageFile="~/AllWaifu.Master" AutoEventWireup="true" CodeBehind="Old_MainPage.aspx.cs" Inherits="AllWaifu.MainPage" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadContentPlaceholder" runat="server">
    <script src="js/vk_openapi.js"></script>
    <link rel="stylesheet" href="libs/owl-carousel/owl.carousel.min.css" />
    <link rel="stylesheet" href="libs/owl-carousel/owl.theme.css" />
    <link rel="stylesheet" href="libs/countdown/jquery.countdown.css" />
    <script src="libs/owl-carousel/owl.carousel.min.js"></script>
</asp:Content>

<asp:Content ID="OwlContent" ContentPlaceHolderID="OwlPlaceHolder" runat="server">
    <h1 class="sub_logo hidden-xs">Replenished Collection of Anime Characters</h1>
    <h1 class="sub_logo_min"> Collection of Characters </h1>
    <div class="slider owl-nav">
	    <div class="next_button owl-next">
		    <i class="fa fa-chevron-right" aria-hidden="true"></i>
	    </div>
	    <div class="prev_button owl-prev">
		    <i class="fa fa-chevron-left" aria-hidden="true"></i>
	    </div>
	    <div class="owl-carousel owl-theme">
		    <div>
			    <div class="over_text">
				    <div class="over_title">
					    <a href="#" class=""> Rem </a>
				    </div>
				    <div class="over_inf">
					    <a href="#" class="">Re:Zero kara hajimeru isekai seikatsu</a>
				    </div>
			    </div>
			    <img src="images/rem.png" alt="Ошибка"/>
		    </div>
		    <div>
			    <div class="over_text">
				    <div class="over_title">
					    <a href="#" class=""> Kirino x Ayase </a>
				    </div>
				    <div class="over_inf">
					    <a href="#" class="">Ore no Imouto ga Konna ni Kawaii Wake ga Nai</a>
				    </div>
			    </div>
			    <img src="images/aiane.jpg" alt="Ошибка"/>
		    </div>
	    </div>
    </div>
</asp:Content>

<asp:Content ID="MainContext" ContentPlaceHolderID="MainContentPlaceholder" runat="server">
    <section id="main" class="main_context">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<h1 style="margin-left : 15px; text-align: center;">Последние обновления</h1>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-9">
					<div class="news">
                        <asp:Repeater ID="ContentRepeater" runat="server">
                            <ItemTemplate>
                                <div class="col-md-6">
							        <div class="news_item">
								        <div class="row">
									        <div class="col-md-12 content_image">
                                                <a class="" href="Waif.aspx?id=<%# Eval("Id") %>">
										            <img src="<%# Eval("Image") %>" alt="Ошибка"/>
                                                </a>
									        </div>
									        <div class="col-md-12">
										        <div class="context_title">
											        <a href="Waif.aspx?id=<%# Eval("Id") %>"><%# Eval("Name") %></a>
										        </div>
										        <div class="anime_title">
											        <a href="#"><%# Eval("Anime") %></a>
										        </div>
									        </div>
								        </div>
							        </div>
						        </div>	
                            </ItemTemplate>
                        </asp:Repeater>
					</div>

					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class = "pag_container">
							<ul class="pagination">
                                <asp:Repeater ID="PaginationRepeater" runat="server">
                                    <ItemTemplate>
                                        <%#Container.DataItem%>
                                    </ItemTemplate>
                                </asp:Repeater>
							</ul>
						</div>
					</div>	
				</div>

				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-3">
					<div class="comments">
						<div class="com_title" style="text-align : center; font-size : 25px">
							Последние комментарии
						</div>
						<hr style="margin: 0"/>
						<ul>
							<li>
								<div class="row">
									<div class="col-xs-2 col-sm-2 col-md-1 col-lg-4 col-xl-4 com_img">
										<a href="#">
											<img src="https://pinguem.ru/static/img/avatar.c2a08a3fc438.png"/>
										</a>
									</div>
									<div class="col-xs-10 col-sm-10 col-md-11 col-lg-8 col-xl-8">
										<div class="com_title">
											<a href="#">
												Рома Мельник
											</a>
										</div>
										<div class="com_text">
											Ну, неплохое такое
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="row">
									<div class="col-xs-2 col-sm-2 col-md-1 col-lg-4 col-xl-4 com_img">
										<a href="#">
											<img src="https://pinguem.ru/static/img/avatar.c2a08a3fc438.png"/>
										</a>
									</div>
									<div class="col-xs-10 col-sm-10 col-md-11 col-lg-8 col-xl-8">
										<div class="com_title">
											<a href="#">
												Нацуки Минамия
											</a>
										</div>
										<div class="com_text">
											Ну, в принципе, неплохо, да, мне понравилось, очень даже ничего
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="row">
									<div class="col-xs-2 col-sm-2 col-md-1 col-lg-4 col-xl-4 com_img">
										<a href="#">
											<img src="https://pinguem.ru/static/img/avatar.c2a08a3fc438.png"/>
										</a>
									</div>
									<div class="col-xs-10 col-sm-10 col-md-11 col-lg-8 col-xl-8">
										<div class="com_title">
											<a href="#">
												Крулл Цепеш
											</a>
										</div>
										<div class="com_text">
											Так себе, среднячок
										</div>
									</div>
								</div>
							</li>
						</ul>
					</div>
					<div class="vk_news">
						<div class="com_title" style="text-align : center; font-size : 25px">
							Мы в VK
						</div>
							<hr style="margin: 0"/>
						<div id="vk_groups"></div>
					</div>
				</div>
			</div>
		</div>
	</section>
</asp:Content>

<asp:Content ID="Footer" ContentPlaceHolderID="FooterContentPlaceholder" runat="server">
    <script type="text/javascript">
        VK.Widgets.Group("vk_groups", { mode: 4, width: "auto", wide: 1, height: "400" }, 155417759);
     </script>
</asp:Content>