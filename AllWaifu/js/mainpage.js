$(document).ready(function(){
    count = 6;
    offset = 0;
    template = $(".nsearch_el").eq(0).clone();
    $(".nsearch_el")[0].remove();
    AddContent();
    $(".infinite_scroll_but")[0].formAction = "";

    $('.mainp_els').owlCarousel({
        loop : true,
        nav : false,
        items : 5,
        responsive:{
            0:{
                items: 1
            },
            768 :{
                items : 4
            },
            1300 : {
                items : 5
            },
        }
    });
});
function AddContent() {
    AllWaifu.AjaxHelper.SearchFull(count, offset, "Id", "DESC", "all", "", "", "", "",
        function (result) {
            var elements = JSON.parse(result);
            elements.forEach(function (el, i, elements) {
                formated = FillTemplate(el);
                $(".nsearch_els")[0].append(formated[0]);
            });
            offset += elements.length;
            if (elements.length == 0) {
                $(".infinite_scroll_but").hide();
            }
        },
        function (error) {
           // console.log(error);
        });
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