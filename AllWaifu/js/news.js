var template = $(".news_element").clone();
$(".news_element")[0].remove();
var count = 6;
var offset = 0;

function sendPostButton() {
    if (!confirm("Вы уверены, что хотите отправить пост?")) {
        return;
    }
    var result = new Object();
    var editHtml = '<div>' + $(".richtext").trumbowyg('html') + '</div>';
    result.title = $(".richtext .news_title")[0].innerText;
    var htmlEl = $(editHtml);
    $(".richtext").trumbowyg('empty');
    htmlEl.find('.news_title')[0].remove();
    result.content = htmlEl[0].innerHTML;
    result.date = new Date().toLocaleDateString();
    result.author = userName;
    //console.log(result);
    AllWaifu.AjaxHelper.AddNewsToBase(result,
        function (result) { }, function (err) { console.log(err) });

}
function deletePostButton() {
    var post = $(this).parent().parent();
    var id = post.find(".news_id")[0].value;
    post[0].remove();
    AllWaifu.AjaxHelper.DeleteNews(id, function (result) { }, function (err) { });
}

$(document).ready(function () {  
    $('.richtext').trumbowyg({
        autogrow: true,
        urlProtocol: true,
        imageWidthModalEdit: true,
        btnsDef: {
            image: {
                dropdown: ['insertImage', 'upload'],
                ico: 'insertImage'
            },
            send: {
                fn: sendPostButton,
                tag: '',
                title: 'Send post to database',
                text: 'Send',
                class: '',
                hasIcon : false
            }
        },
        btns: [
            ['template'],
            ['viewHTML'],
            ['formatting'],
            ['strong', 'em', 'del'],
            ['superscript', 'subscript'],
            ['link'],
            ['image'], // Our fresh created dropdown
            ['justifyLeft', 'justifyCenter', 'justifyRight', 'justifyFull'],
            ['unorderedList', 'orderedList'],
            ['horizontalRule'],
            ['removeformat'],
            ['fullscreen'],
            ['send']
        ],
        plugins: {
            upload: {
                serverPath: 'https://api.imgur.com/3/image',
                fileFieldName: 'image',
                headers: {
                    'Authorization': 'Client-ID 048e2a9023476b3'
                },
                urlPropertyName: 'data.link'
            },
            templates: [
                {
                    name: 'News post',
                    html: '<div class="news_title">Заголовок</div><br/><p>Содержимое</p>'
                }
            ]
        }

    });
    AddContent();
});


function AddContent() {
    AllWaifu.AjaxHelper.GetNews(count, offset,
        function (result) {
            var elements = JSON.parse(result);
            elements.forEach(function (el, i, elements) {
                formated = FillTemplate(el);
                $(".news_elements")[0].append(formated[0]);
            });
            offset += elements.length;
            if (elements.length == 0) {
                $(".infinite_scroll_but").hide();
            }
        },
        function (err) {
            console.log(err);
        });
}
function FillTemplate(el) {
    var res = template.clone();
    res.find(".news_title_text")[0].innerHTML = el["Title"];
    res.find(".news_content")[0].innerHTML = el["Content"];
    res.find(".news_added_by")[0].innerHTML = el["Author"];
    res.find(".news_date")[0].innerHTML = el["Date"];
    res.find(".news_id")[0].value = el["Id"];
    if (res.find(".news_delete").length > 0) {
        res.find(".news_delete").click(deletePostButton);
    }
    return res;
}