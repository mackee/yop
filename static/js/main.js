if (typeof(window.console) == "undefined") { console = {}; console.log = console.warn = console.error = function(a) {}; }

$(function () {
	function streamer(xhr) {
	}

	$("#yop-button").click(function() {
		var iyopon = document.getElementById("iyopon");
		iyopon.load();
		iyopon.play();
	});

	$(".name-input").bind("keydown keyup keypress change", function() {
		var input = $(this).val();
		input = input.toUpperCase();
		input = input.replace(/[^A-Z]/, "");
		$(this).val(input);
	});

	$("#join-button").click(function(){
		var name = $(".name-input").val();
        var ajax = new XMLHttpRequest();
        ajax.open("GET", "http://localhost:5000/stream/connect");
        ajax.onload = function (oEvent) {
            var arrayBuffer = ajax.response; // Note: not oReq.responseText
            console.log("hoge");
            if (arrayBuffer) {
                var byteArray = new Uint8Array(arrayBuffer);
                for (var i = 0; i < byteArray.byteLength; i++) {
                  // do something with each byte in the array
                }
            }
        };
        ajax.send(null);
    });
});
