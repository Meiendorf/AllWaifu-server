$(document).ready(function() {

    var slideout = new Slideout({
        'panel': document.getElementById('main_el'),
        'menu': document.getElementById('slideout_menu'),
        'padding': 256,
        'tolerance': 70
      });
    $(".slideout_button").click(function(){
        slideout.toggle();
    })
	try{
		document.getElementById("wcomments").onkeydown = function(){
			var el = this;
			setTimeout(function(){
				el.style.cssText = 'height:auto; padding:3px;';
				el.style.cssText = 'height:' + el.scrollHeight+ 'px';
			 },0);
		}
	}
	catch(e)
	{}

	$(".men_but").click(function(){
		$(".desk_menu").slideToggle();
	});

	var i = 0;
	var isPop = true;

	$(".f_var").click(function(){
		var remClass = "fa-heart-o"
		var addClass = "fa-heart"
		if (i == 1) {
			remClass = [addClass, addClass=remClass][0]
		}
		$(this).removeClass(remClass);
		$(this).addClass(addClass);
		if (i == 1){
			i = 0;
		} else {
			if (isPop){
				popRemove("pop_show", "pop_hide");
				isPop = false;
				setTimeout(popRemove, 2000, "pop_hide", "pop_show");
			}
			i = 1;
		}
	});

	function popRemove(add, remove){
		$(".pop_div").removeClass(remove);
		$(".pop_div").addClass(add);
		isPop = true;
    }
    try {
        $(".dd_menu")[0].style.display = "none";
    } catch(e){
    
    }
    $(document).click(function(event) { 
        if(!$(event.target).closest('.user_dropdown').length) {
            if($('.main-dd-menu').is(":visible")) {
                $('.main-dd-menu').fadeOut(200);
            }
        }     
        if(!$(event.target).closest('.help-trigger').length) {
            if($('.help-menu').is(":visible")) {
                $('.help-menu').fadeOut(200);
            }
        }        
    });

    $(".user_dropdown").click(function(){
        var el = $(".main-dd-menu");
        if (el[0] != null) {
            if (el.is(":visible")) {
                el.fadeOut(200);
            }
            else {
                el.fadeIn(200);
            }
        }
    }); 
    $(".help-trigger").click(function(){
        var el = $(".help-menu");
        if (el[0] != null) {
            if (el.is(":visible")) {
                el.fadeOut(200);
            }
            else {
                el.fadeIn(200);
            }
        }
    }); 

    $(".help-mobile-trigger").click(function(){
        $(this).toggleClass("help-mobile-bgc");
        $(".help-mobile-arrow").toggleClass('rotated');
    });

    /* Search functionality */
    try{
    function EqualWidth(id) {
        $("#ui-id-1").width($(".heaven_search").eq(id).width());
    }
    function OnSearchEnterPress(t="") {
        var href = "/search/all/" + $("#SearchBox" + t)[0].value;
        $(location).attr('href', href);
    }
    function SearchBothFunc(ul, item) {
        var link = $("<a>");
        link[0].href = item.href;
        link[0].innerText = item.label;
        link = link[0];
        return $("<li>")
            .attr("data-value", item.label)
            .append(link)
            .appendTo(ul);
    }
    var renderItems = function (ul, item) {
        setTimeout(EqualWidth.bind(null, 1), 50);
        return SearchBothFunc(ul, item);
    }
    var renderItemsM = function (ul, item) {
        setTimeout(EqualWidth.bind(null, 0), 50);
        return SearchBothFunc(ul, item);
    }
    var searchEl = function () {
        this.label = "";
        this.href = "";
    }
    sourceFunc = function (req, resp) {
        AllWaifu.AjaxHelper.LiveSearch(req.term,
            function (result) {
                resp(JSON.parse(result));
            },
            function (err) {
                console.log(err);
            })
    }
    $("#SearchBox").autocomplete({
        autofocus : true,
        source: sourceFunc,
    }).data("uiAutocomplete")._renderItem = renderItems;
    $("#SearchBoxM").autocomplete({
        autofocus: true,
        source: sourceFunc,
    }).data("uiAutocomplete")._renderItem = renderItemsM;
    $("#SearchBox").keypress(function (e) {
        if (e.keyCode == 13) {
            OnSearchEnterPress();
        }
    });
    $("#SearchBoxM").keypress(function (e) {
        if (e.keyCode == 13) {
            OnSearchEnterPress("M");
        }
    });
}catch(e){}
   /* $("#SearchBox").autocomplete( "option", "source", [ "c++", "java", "php", "coldfusion", "javascript", "asp", "ruby" ] );
    */
});

/* Notifications functionality */
function notifyCommentHover(type, id, elId, th) {
    var cloneble = $('<div class="comment_el"> <div class="comment_img"> <a href="#"> <img/> </a> </div> <div class="comment_name"> <a href="#"> Рома Мельник </a> </div> <div class="comment_additional"> <div class="comment_date"> 28 Май 2018 23:48:42 </div> <div class="comment_reply"> <a>Ответить</a> </div> </div> <div class="comment_text"> </div></div>');
    if ($(th).data("replyActivated") != null) {
        return;
    }
    th.title = "Загрузка...";
    tippy(th,
        {
            interactive: 'true',
            theme: 'light'
        });
    th._tippy.show();
    AllWaifu.AjaxHelper.GetCommentById(type, id,
        function (result) {
            $(th).data("replyActivated", true);
            th._tippy.destroy();
            if (result == "") {
                th.title = "Комментарий удален";
                tippy(th,
                    {
                        interactive: 'true',
                        theme: 'light'
                    });
                th._tippy.show();
                return;
            }
            var el = JSON.parse(result);
            var comment = notifyCommentFillTemplate(el, cloneble);
            comment.find(".delete_el_but").remove();
            var viewLink = comment.find(".comment_text a");
            if (viewLink.length > 0) {
                viewLink.eq(0).attr("onmouseover", viewLink.eq(0).attr("onmouseover").
                    replace("methods.replyHover", "notifyCommentHover"));
            }
            var cmReply = comment.find(".comment_reply");
            cmReply.data("replyId", el["Id"]);
            cmReply.data("replyType", type);
            cmReply.data("replyFrom", userName);
            cmReply.data("pageId", elId);
            tippy(th,
                {
                    html: comment[0],
                    interactive: 'true',
                    maxWidth : '420px',
                    theme: 'noticomment'
                });
            th._tippy.show();
        },
        function (err) {
            console.log(err);
        });
}
function notifyCommentFillTemplate(el, cloneble) {
    var result = cloneble.clone();
    result.find(".comment_name").find("a")[0].innerText = el["From"]["Login"];
    result.find(".comment_name").find("a")[0].href = "/profile/" + el["From"]["Login"];
    result.find(".comment_img").find("img")[0].src = el["From"]["Image"];
    result.find(".comment_img").find("img")[0].alt = "/images/none.png"
    result.find(".comment_img").find("a")[0].href = "/profile/" + el["From"]["Login"];
    result.find(".comment_date")[0].innerText = el["Date"];
    result.find(".comment_text")[0].innerHTML = el["Text"];
    if (result.find(".comment_reply").length > 0) {
        result.find(".comment_reply").click(notifyReplyButtonClick);
    }
    return result;
}
function notifyReplyButtonClick() {
    if ($(this).data("replyId") == null) {
        return;
    }
    var link = "#";
    var linkTemplate = '/{0}/{1}?replyId=' + $(this).data("replyId") + '&replyFrom=' + $(this).data("replyFrom");
    var type = $(this).data("replyType");
    switch (type) {
        case "user":
            link = String.format(linkTemplate, "profile", $(this).data("pageId"));
            break;
        case "anime":
            link = String.format(linkTemplate, "anime", $(this).data("pageId"));
            break;
        case "waifu":
            link = String.format(linkTemplate, "waifu", $(this).data("pageId"));
            break;
    }
    
    $(location).attr('href', link);
}

    /* Notifications functionality */

