// Join Discord for support: https://discord.gg/f2Nbv9Ebf5
// Join Discord for support: https://discord.gg/f2Nbv9Ebf5
// Join Discord for support: https://discord.gg/f2Nbv9Ebf5
// Join Discord for support: https://discord.gg/f2Nbv9Ebf5
// Join Discord for support: https://discord.gg/f2Nbv9Ebf5

document.onkeyup = function (data) {
    if (data.which == 27) {
        cancel()
    }
};

function putCBS() {
    let x = document.getElementById("cbs-content").value;
    if (x !== "") {
        $.post('https://an_chalkBoard/putCBS', JSON.stringify({ text: x}));
        $("#main").fadeOut();
        document.getElementById("cbs-content").value = "";
        $("#main").css('display', 'none');
    } else {
        $.post('https://an_chalkBoard/emptySign', JSON.stringify({ text: x}));
    }
}

function cancel() {
    $.post('https://an_chalkBoard/escape', JSON.stringify({}));
    $("#main").fadeOut();
    $("#main").css('display', 'none');
}

window.addEventListener('message', function(e) {
    switch(event.data.action) {
        case 'openPutCBS':
            $("textarea").removeAttr('disabled','disabled');
            $("button").fadeIn();
            $("#main").fadeIn();
            break;
        case 'showCBS':
            $("textarea").attr('disabled','disabled');
            $("button").hide();
            $("#main").fadeIn();
            document.getElementById("cbs-content").value = event.data.TextRead;
            break;
        case 'closeCBS':
            $("#main").fadeOut();
            $("#main").css('display', 'none');
            break;
        case 'cleanCBS':
            document.getElementById("cbs-content").value = "";
            break;
    }
});

// Join Discord for support: https://discord.gg/f2Nbv9Ebf5
// Join Discord for support: https://discord.gg/f2Nbv9Ebf5
// Join Discord for support: https://discord.gg/f2Nbv9Ebf5
// Join Discord for support: https://discord.gg/f2Nbv9Ebf5
// Join Discord for support: https://discord.gg/f2Nbv9Ebf5