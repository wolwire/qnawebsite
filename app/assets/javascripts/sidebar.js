function navToggle() {
    var $webBody = $("#web-body");

    if ($webBody.hasClass('nav-md')){
        $webBody.removeClass('nav-md');
        $webBody.addClass('nav-sm');
        $("#openbtn").html('<i class="fa fa-bars"></i>');
    } else {
        $webBody.removeClass('nav-sm');
        $webBody.addClass('nav-md');
        $("#openbtn").html('<i class="fa fa-times"></i>');
    }
}

