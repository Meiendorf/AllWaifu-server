(function ($) {

    class CommentsData {
        constructor() {
            this.comments = $(CommentsData.commentsHtml);
            this.commentsEl = this.comments.find(".comment_el").eq(0).clone();
            this.comments.find(".comment_el")[0].remove();

            this.count = 10;
            this.offset = 0;
            this.id = '';
            this.type = '';
            this.username = '';
            this.replyTo = '';
            this.replyId = '';
        }

        static get commentsHtml() {
            return ' <div class="anime_comments comments_container"> <div class="anime_desc_title"> Комментарии </div> <div class="profile_inp"> </div> <div class="waif_inp"> <div class="reply_box" style="display: none"> <div class="reply_box_to"> Ответ @shinigami_shin </div> <div class="reply_delete_el_but" id="HideReply"> <i class="fa fa-times" aria-hidden="true"></i> </div> </div> <div class="comment_textbox"> <textarea rows="3" placeholder="Текст комментария" class="comment_inp" id="wcomments"></textarea> </div> <div class="comment_submit"> <button type="button" class="send_min_but comment_send_but"> Отправить </button> </div> </div> <div class="comment_list cl-effect-5"> <div class="comment_el"> <div class="comment_img"> <a href="#"> <img src="images/haruna.png"> </a> </div> <div class="comment_name"> <a href="#"> Рома Мельник </a> </div> <div class="comment_additional"> <div class="comment_date"> 28 Май 2018 23:48:42 </div> <div class="comment_reply"> <a>Ответить</a> </div> <div class="comment_complain"> <a>Пожаловаться</a> </div> </div> <div class="comment_text"> </div> </div> </div> <div class="comment_more"> <button type="button" class="infinite_scroll_but search_sort_but" id="AddMore"> <i class="fa fa-plus"></i> <div> Загрузить еще </div> </button> </div> </div>';
        }
        static get notFoundHtml() {
            return '<div class="empty_block"> <div class="anime_desc_title"> Здесь пусто! </div> <img src="/images/yo.png" class="empty_block_image" alt=""> </div>';
        }
    }
    commentsData = new function () {
        this.commentsHtml = ' <div class="anime_comments comments_container"> <div class="anime_desc_title"> Комментарии </div> <div class="profile_inp"> </div> <div class="waif_inp"> <div class="comment_textbox"> <textarea rows="3" placeholder="Текст комментария" class="comment_inp" id="wcomments"></textarea> </div> <div class="comment_submit"> <button class="send_min_but comment_send_but"> Отправить </button> </div> </div> <div class="comment_list cl-effect-5"> <div class="comment_el"> <div class="comment_img"> <a href="#"> <img src="images/haruna.png"> </a> </div> <div class="comment_name"> <a href="#"> Рома Мельник </a> </div> <div class="comment_additional"> <div class="comment_date"> 28 Май 2018 23:48:42 </div> <div class="comment_reply"> <a>Ответить</a> </div> <div class="comment_complain"> <a>Пожаловаться</a> </div> </div> <div class="comment_text"> </div> </div> </div> <div class="comment_more"> <button type="button" class="infinite_scroll_but search_sort_but" id="AddMore"> <i class="fa fa-plus"></i> <div> Загрузить еще </div> </button> </div> </div>';
        this.comments = $(this.commentsHtml);
        this.commentEl = this.comments.find(".comment_el").eq(0).clone();
        this.comments.find(".comment_el")[0].remove();

    }

    methods = {
        init: function (options) {
            if (this.data("commentsData") != null) {
                return;
            }
            var settings = $.extend({
                'type': '',
                'id': '',
                'username': ''
            }, options);
            var newComments = new CommentsData();
            newComments.id = settings['id'];
            newComments.type = settings['type'];
            newComments.username = settings['username'];

            newComments.comments.find(".search_sort_but").click(methods.addContent);
            newComments.comments.find(".reply_delete_el_but").click(methods.replyCloseButtonClick);
            newComments.comments.find(".comment_send_but").click(methods.sendButtonClick);
            if (settings['username'] == '') {
                if (newComments.comments.find(".waif_inp").length > 0) {
                    newComments.comments.find(".waif_inp")[0].remove();
                }
                newComments.commentsEl.find(".comment_reply").remove();
                newComments.commentsEl.find(".comment_complain").remove();
            }
            if (this.find(".comments_container").length == 0) {
                this.append(newComments.comments[0]);
            }
            this.data("commentsData", newComments);
            this.find(".search_sort_but").click();
        },
        addContent: function () {
            var mainEl = $(this).parent().parent().parent();
            var data = mainEl.data("commentsData");
            if (data == null) {
                console.log("contentError");
                return;
            }
            AllWaifu.AjaxHelper.GetComments(data.count, data.offset, data.type, data.id,
                function (result) {
                    var elements = JSON.parse(result);
                    if (elements.length == 0 && data.offset == 0) {
                        data.comments.find(".comment_more").hide();
                        data.comments.find(".comment_list").after($(commentsData.notFoundHtml));
                    }
                    elements.forEach(function (el, i, elements) {
                        var formated = methods.fillTemplate(el, data.commentsEl);
                        formated.find(".comment_reply").data("dataId", mainEl[0].id);
                        data.comments.find(".comment_list").append(formated);
                    });
                    data.offset += elements.length;
                    if (elements.length == 0) {
                        data.comments.find(".comment_more").hide();
                    }
                    $(this).parent().parent().parent().data("commentsData", data);
                },
                function (err) {
                    console.log(err);
                }
            )
        },
        replyHover : function (type, id, th) {

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
                    var el = JSON.parse(result);
                    var comment = methods.fillTemplate(el, $(th).parent().parent());
                    var mainId = $(th).parent().parent().find(".comment_reply").data("dataId");
                    comment.find(".comment_reply").data("dataId", mainId);
                    th._tippy.destroy();
                    tippy(th,
                        {
                            html: comment[0],
                            interactive: 'true',
                            theme: 'light'
                        });
                    $(th).data("replyActivated", true);
                    th._tippy.show();
                },
                function (err) {
                    console.log(err);
                }
            );
        },
        sendButtonClick: function () {
            var mainEl = $(this).parentsUntil(".comments_container").parent().parent();
            var data = mainEl.data("commentsData");
            var text = mainEl.find(".comment_inp")[0].value;
            if(data.replyId != '' && data.replyTo != ''){
                text = '<a onmouseover="methods.replyHover(\''+data.type+'\','+data.replyId+', this)">@'+data.replyTo+', </a>'+text;
            }
            mainEl.find(".comment_inp")[0].value = "";
            mainEl.find(".reply_delete_el_but").click();
            AllWaifu.AjaxHelper.PostComment(text, data.type, data.username, data.id,
                function(result){console.log("Post comment "+result);},
                function(err){console.log(err);}
            );
        },
        replyButtonClick: function(){
            var mainEl = $("#"+$(this).data("dataId"));
            var data = mainEl.data("commentsData");
            data.replyTo = $(this).data("commLog");
            data.replyId = $(this).data("commId");
            mainEl.data("commentsData", data);
            mainEl.find(".comment_inp")[0].focus();
            mainEl.find(".reply_box").show().find(".reply_box_to")[0].innerText = "Ответ @"+data.replyTo;
        },
        replyCloseButtonClick : function(){
            var mainEl = $(this).parentsUntil(".comments_container").parent().parent();
            var data = mainEl.data("commentsData");
            data.replyTo = '';
            data.replyId = '';
            mainEl.data("commentsData", data);
            $(this).parent().hide();
        },
        fillTemplate: function (el, cloneble) {
            var result = cloneble.clone();
            result.find(".comment_name").find("a")[0].innerText = el["From"]["Login"];
            result.find(".comment_name").find("a")[0].href = "/profile/" + el["From"]["Login"];
            result.find(".comment_img").find("img")[0].src = el["From"]["Image"];
            result.find(".comment_img").find("a")[0].href = "/profile/" + el["From"]["Login"];
            result.find(".comment_date")[0].innerText = el["Date"];
            result.find(".comment_text")[0].innerHTML = el["Text"];
            if(result.find(".comment_reply").length>0){
                result.find(".comment_reply").data("commId", el["Id"]).data("commLog", el["From"]["Login"]);
                result.find(".comment_reply").click(methods.replyButtonClick);
            }
            return result;
        }

    }
    $.fn.comments = function (methodOrOptions) {

        if (methods[methodOrOptions]) {
            return methods[methodOrOptions].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof methodOrOptions === 'object' || !methodOrOptions) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + methodOrOptions + ' does not exist on jQuery.comments');
        }    

    };


})(jQuery);