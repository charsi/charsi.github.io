
var bigfoot = $.bigfoot(
    {
    activateOnHover: true
    }
);
$.bigfoot();

// Creates Captions from Alt tags
$("div.post-body").children("p").children('img').each(
    function() {
    // Let's put a caption if there is one
    if ($(this).attr("alt")) {
        $(this).wrap(
            '<figure class="image"></figure>'
        ).after(
            '<figcaption>' +
            $(this).attr(
                "alt") +
            '</figcaption>'
        );
    }
});
