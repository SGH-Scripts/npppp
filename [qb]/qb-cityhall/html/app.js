let mouseOver = false;
let selectedIdentity = null;
let selectedIdentityType = null;
let selectedIdentityCost = null;
let selectedJob = null;
let selectedJobId = null;

Open = function(data) {
    FillCharInfo(data);
    $(".container").fadeIn(150);
}

Close = function() {
    $(".container").fadeOut(150, function(){
        ResetPages();
    });
    $.post('https://qb-cityhall/close');
    ResetJobInfo()
}

ResetPages = function() {
    $(".cityhall-main-options").show();
    $(".cityhall-identity-page").hide();
    $(".cityhall-job-page").hide();

    $(selectedJob).removeClass("job-selected");
    $(selectedIdentity).removeClass("job-selected");
}

FillCharInfo = function (data) {
    var gender = "Male"
    if (data.char.gender == 0) 
        gender = "Male"
    else
        gender = "Female"

    var elem = '<div class="char-info-title"><span>Character Information</span></div>' +
        '<div class="char-info-box"><span id="info-label">Name: </span><span class="char-info-js">'+ data.char.name + '</span></div>' + 
        '<div class="char-info-box"><span id="info-label">Birth date: </span><span class="char-info-js">'+ data.char.birth +'</span></div>' +
        '<div class="char-info-box"><span id="info-label">Gender: </span><span class="char-info-js">'+ gender +'</span></div>' +
        '<div class="char-info-box"><span id="info-label">Nationality: </span><span class="char-info-js">'+ data.char.nationality +'</span></div>' +
        '<div class="char-info-box"><span id="info-label">Current Job: </span><span class="char-info-js">'+ data.char.currentJob +'</span></div>' +
        '<div class="char-info-box"><span id="info-label">Phone number: </span><span class="char-info-js">'+ data.char.phoneNumber +'</span></div>' +
        '<div class="char-info-box"><span id="info-label">Account number: </span><span class="char-info-js">'+ data.char.accountNumber +'</span></div>';
    
    $( ".cityhall-personal-info" ).html(elem);
}

SetJobs = function(jobs) {
    $.each(jobs, (job, name) => {
        let html = `<div class="job-page-block" data-job="${job}"><p>${name}</p></div>`;
        $('.job-page-blocks-overflow').append(html);
    })
}

ResetJobInfo = function() {
    $(selectedJob).removeClass("job-selected");
    $(selectedIdentity).removeClass("job-selected");
    $(".request-identity-button").fadeOut(100);
    $(".job-details-info").fadeOut(100);
    $(".job-actions-buttons").fadeOut(100);

    selectedJob = null;
    selectedIdentity = null;
}

SetupJobInfo = function (data) {
    var elem = '<div class="job-info-title"><span>'+ data.job.title +'</span></div>' +
        '<div class="job-info-box"><span id="info-label">Salary: </span><span class="job-info-js">$'+ data.job.salary +'</span></div>' + 
        '<div class="job-info-box"><span id="info-label">Description: </span><span class="job-info-js">'+ data.job.description +'</span></div>    ';

    $( ".job-details-info" ).html(elem);
}

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case "open":
                Open(event.data);
                break;
            case "close":
                Close();
                break;
            case "setJobs":
                SetJobs(event.data.jobs);
                break;
            case "setupJobInfo":
                SetupJobInfo(event.data);
                break;
        }
    })
});

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            Close();
            break;
    }
});

$('.cityhall-option-block').click(function(e){
    e.preventDefault();

    let blockPage = $(this).data('page');
    $(".cityhall-main-options").fadeOut(100, () => {
        $(`.cityhall-${blockPage}-page`).fadeIn(100);
    });

    if (blockPage == "identity") {
        $(".identity-page-blocks").html("");

        $.post('https://qb-cityhall/requestLicenses', JSON.stringify({}), function(licenses){
            $.each(licenses, (i, license) => {
                let elem = `<div class="identity-page-block" data-type="${i}" data-cost="${license.cost}">`+
                            `<div class="identity-license-image">`+
                            `<img src="images/${i}.png" alt="license_${i}">`+
                            `</div>`+
                            `<div class="identity-license-info">`+
                            `<div class="license-title-box"><span id="info-label">${license.label}</span></div>`+
                            `<div class="license-info-box"><span id="info-label">Request new ${license.label}</span></div>`+
                            `</div>`+
                            `</div>`;
                $(".identity-page-blocks").append(elem);
            });
        });
    }
});

$(document).on("click", ".identity-page-block", function(e){
    e.preventDefault();
    selectedIdentityType = $(this).data('type');
    selectedIdentityCost = $(this).data('cost');
    if (selectedIdentity == null) {
        $(this).addClass("identity-selected");
        // $(".hover-description").fadeIn(10);
        selectedIdentity = this;
        $(".request-identity-button").fadeIn(100);
        $(".request-identity-button").html(`<p>Buy $${selectedIdentityCost}</p>`);
    } else if (selectedIdentity == this) {
        $(this).removeClass("identity-selected");
        selectedIdentity = null;
        $(".request-identity-button").fadeOut(100);
    } else {
        $(selectedIdentity).removeClass("identity-selected");
        $(this).addClass("identity-selected");
        selectedIdentity = this;
        $(".request-identity-button").html("<p>Buy</p>");
    }
});

$(".request-identity-button").click(function(e){
    e.preventDefault();
    $.post('https://qb-cityhall/requestId', JSON.stringify({
        type: selectedIdentityType,
        cost: selectedIdentityCost
    }))
    ResetPages();
});

$(document).on("click", ".job-page-block", function(e){
    e.preventDefault();
    selectedJobId = $(this).data('job');
    if (selectedJob == null) {
        $(this).addClass("job-selected");
        selectedJob = this;
        $.post('https://qb-cityhall/setJobInfo', JSON.stringify({ job: selectedJobId }))
        $(".job-details-info").fadeIn(100);
        $(".job-actions-buttons").fadeIn(100);
    } else if (selectedJob == this) {
        $(this).removeClass("job-selected");
        selectedJob = null;
        $(".job-details-info").fadeOut(100);
        $(".job-actions-buttons").fadeOut(100);
    } else {
        $(selectedJob).removeClass("job-selected");
        $(this).addClass("job-selected");
        selectedJob = this;
        $.post('https://qb-cityhall/setJobInfo', JSON.stringify({ job: selectedJobId }))
    }
});

$(document).on('click', '.gps-job-button', function(e){
    e.preventDefault();

    $.post('https://qb-cityhall/setGps', JSON.stringify({
        job: selectedJobId
    }))

    ResetJobInfo();
    ResetPages();
});

$(document).on('click', '.apply-job-button', function(e){
    e.preventDefault();
    $.post('https://qb-cityhall/applyJob', JSON.stringify(selectedJobId))

    ResetJobInfo();
    ResetPages();
});

$(document).on('click', '.back-to-main', function(e){
    e.preventDefault();
    ResetJobInfo();  
    ResetPages();
});
