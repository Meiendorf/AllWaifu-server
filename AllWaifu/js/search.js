$(document).ready(function () {
    /*Global*/
    dir = "DESC";
    by = "Id";
    count = 6;
    offset = 0;
    if (tags != "") {
        tags.split(',').forEach(function (tag) {
            var options = $("#TagsSelect")[0].options;
            for (var i = 0; i < options.length; i++) {
                if (options[i].value == tag) {
                    options[i].selected = true;
                }
            }
            });

        $('.chosen-select').trigger("chosen:updated");
    }
    if (user != "") {
        if (userType == "fav") {
            $("#MainTitle")[0].innerText = "Закладки";
        }
        else {
            $("#MainTitle")[0].innerText = "Добавленное";
        }
    }
    template = $(".search_el").eq(0).clone();
    noResults = $(".nothing_found").eq(0).clone();
    $(".nothing_found")[0].remove();
    $(".search_el")[0].remove();
    AddContent();
    $(".infinite_scroll_but")[0].formAction = "";
    /*Global*/
});

function AddContent()
{
    AllWaifu.AjaxHelper.SearchFull(count, offset, by, dir, type, text, tags, user, userType,
        function (result) {
            var elements = JSON.parse(result);
            if ($(".nothing_found").length > 0) {
                $(".nothing_found")[0].remove();
            }
            if ((elements.length == 0) && (offset == 0))
            {
                $(".nsearch_els").find(".type_title")[0].after(noResults[0]);
                $(".infinite_scroll_but").hide();
                //$(location).attr('href', 'Error.aspx?error=NotFound');
            }
            elements.forEach(function (el, i, elements) {
                formated = FillTemplate(el);
                $(".nsearch_els")[0].append(formated[0]);
            });
            offset += elements.length;
            if (elements.length == 0)
            {
                $(".infinite_scroll_but").hide();
            }
        },
        function (error) {
             console.log(error);
        });
}
function Sort(t = "")
{
    if ($("#PopularRadio" + t)[0].checked)
    {
        by = "Popularity";
    }
    if ($("#NewRadio" + t)[0].checked) {
        by = "New";
    }
    if ($("#AlphRadio" + t)[0].checked) {
        by = "Name";
    }
    if ($("#AscRadio" + t)[0].checked) {
        dir = "ASC";
    }
    if ($("#DescRadio" + t)[0].checked) {
        dir = "DESC";
    }
    switch ($("#TypeSelect" + t)[0].selectedOptions[0].value){
        case "Аниме":
            type = "anime";
            break;
        case "Персонажи":
            type = "waifu";
            break;
        case "Не принятые":
            if (heart) {
                type = "unconfirmed";
            }
            break;
        default:
            type = "all";
    }
    $(".search_el").toArray().forEach(function (el, i) { el.remove(); });
    tags = "";
    options = $("#TagsSelect" + t)[0].selectedOptions;
    for (var i = 0; i < options.length; i++) {
        tags += options[i].value;
        if (i < options.length - 1) {
            tags += ",";
        }
    }
    offset = 0;
    AddContent();
    $(".infinite_scroll_but").show();
}
function FillTemplate(el) {
    temp = template.clone();
    temp.find(".search_el_img img")[0].src = el["Image"];
    temp.find(".search_el_type")[0].innerText = el["Type"];
    temp.find(".search_el_name span")[0].dataset.hover = el["Name"];
    temp.find(".search_el_name span")[0].innerText = el["Name"];
    temp.find(".waif_inf_el span")[0].innerText = el["Popularity"];
    hrefBase = "/waifu/";
    if (el["Type"] == "Аниме") {
        hrefBase = "/anime/";
    }
    temp.find(".search_el_name")[0].href = hrefBase + el["Id"];
    temp.find(".search_el_img a")[0].href = hrefBase + el["Id"];
    return temp;
}