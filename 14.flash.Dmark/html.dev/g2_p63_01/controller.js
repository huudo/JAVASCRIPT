function _$(id) {
	return $(document.getElementById(id));
}

function createTag(tag) {
		return document.createElementNS("http://www.w3.org/2000/svg", tag)
	}

function draw_ax(a, b, panel_id){

	

	if(show_status == 1 && typeof(panel_id) == 'undefined'){
		$(document.getElementById("point_container")).empty();
		
	}

		
		//giao voi y = 5
		var x_y5 = (5-b)/a;
		var y_y5 = 5;
		
		//giao voi y = -5
		var x_y5_minus = (-5-b)/a;
		var y_y5_minus = -5;

		//giao voi x = 5
		var x_x5 = 5;
		var y_x5 = 5*a + b;

		//giao voi x = -5
		var x_x5_minus = -5;
		var y_x5_minus = (-5*a) + b;
		

		var check_I1 = 0;

		if(x_y5 >= -5 && x_y5 <= 5){
			if(check_I1 == 0){
				x1 = x_y5;
				y1 = y_y5;
				
			}else if(check_I1==1){
				x2 = x_y5;
				y2 = y_y5;
			}
			check_i = "I1";
			check_I1++;
			console.log("I1");

		}

		if(y_x5 >= -5 && y_x5 <= 5){
			if(check_I1 == 0){
				x1 = x_x5;
				y1 = y_x5;
				
			}else if(check_I1==1){
				x2 = x_x5;
				y2 = y_x5;
			}
			check_i = "I2";
			check_I1++;
			console.log("I2");	
		}

		if(x_y5_minus >= -5 && x_y5_minus <= 5){
			if(check_I1 == 0){
				x1 = x_y5_minus;
				y1 = y_y5_minus;
				
			}else if(check_I1==1){
				x2 = x_y5_minus;
				y2 = y_y5_minus;
			}
			check_i = "I3";
			check_I1++;
			console.log("I3");

		}

		if(y_x5_minus >= -5 && y_x5_minus <= 5){
			if(check_I1 == 0){
				x1 = x_x5_minus;
				y1 = y_x5_minus;
				
			}else if(check_I1==1){
				x2 = x_x5_minus;
				y2 = y_x5_minus;
			}
			check_i = "I4";
			check_I1++;
			console.log("I4");
		}
		console.log(check_i);
		if (typeof(panel_id) == 'undefined') {
			panel_id ="";
		}else{
			$(document.getElementById("point_container"+panel_id)).append($(createTag("image")).attr({href: "g2_p63_01/image/image_117_0.png", width: 75, height: 75}));
		}

		if(a == 1 && b == 0){
			$(document.getElementById("point_container"+panel_id)).append($(createTag("line")).css({stroke:"#000","stroke-width":solid}).attr({
				x1:-x1*distant,
				y1:y1*distant,
				x2:x2*distant,
				y2:-y2*distant
			}));
		}if(a == 2 && b == -5){
			$(document.getElementById("point_container"+panel_id)).append($(createTag("line")).css({stroke:"#000","stroke-width":solid}).attr({
				x1:0,
				y1:200,
				x2:200,
				y2:-200
			}));

		}else{
			$(document.getElementById("point_container"+panel_id)).append($(createTag("line")).css({stroke:"#000","stroke-width":solid}).attr({
				x1:x1*distant,
				y1:-y1*distant,
				x2:x2*distant,
				y2:-y2*distant
			}));
		}

		

		var point = $(createTag("circle"))
				.css({
					stroke: "black",
					fill: "black"
				})
				.attr({
					id: "circle" ,
					cx: 0,
					cy: -b*distant,
					r: circle_r
				});
		$(document.getElementById("point_container")).append(point);

		save_status = 0;

		// giá trị đồ thị đang vẽ
		//alert(a.toFixed(2));
		//$(document.getElementById(g_txt_a)).text(a.toFixed(2));

	}



function action_increase_a(){

	for(var i=0; i<g_aRulers.length-1; i++) {
			if(g_move_a_x == g_aRulers[i]) {
				g_move_a_x = g_aRulers[i+1];
				
				break;
			}

		}
//	console.log(g_move_a_x);

	draw_ax(g_move_a_x, g_move_b);
	global_AdjustTextDragEndA();

	$(document.getElementById(BTN_move_a)).attr({
		"transform": ["matrix(1,0,0,1,", g_move_a_x*dist , ",0)"].join("")
	});

}

function action_decrease_a(){

	for(var i=0; i<g_aRulers.length-1; i++) {
			if(g_move_a_x == g_aRulers[i]) {
				g_move_a_x = g_aRulers[i-1];
				//alert("aaa");
				break;
			}

		}
	
	console.log(g_move_a_x);
	draw_ax(g_move_a_x, g_move_b);
	global_AdjustTextDragEndA();

	$(document.getElementById(BTN_move_a)).attr({
		"transform": ["matrix(1,0,0,1,", g_move_a_x*dist , ",0)"].join("")
	});

}

function action_increase_b(){

	for(var i=0; i<g_aRulers_b.length-1; i++) {
			if(g_move_b == g_aRulers_b[i]) {
				g_move_b = g_aRulers_b[i+1];
				break;
			}
		}

	draw_ax(g_move_a_x, g_move_b);
	global_AdjustTextDragEndB();

	$(document.getElementById(BTN_move_b)).attr({
		"transform": ["matrix(1,0,0,1,", g_move_b*dist , ",0)"].join("")
	});

}

function action_decrease_b(){

	for(var i=0; i<g_aRulers_b.length-1; i++) {
			if(g_move_b == g_aRulers_b[i]) {
				g_move_b = g_aRulers_b[i-1];

				break;
			}

		}

	draw_ax(g_move_a_x, g_move_b);
	global_AdjustTextDragEndB();

	$(document.getElementById(BTN_move_b)).attr({
		"transform": ["matrix(1,0,0,1,", g_move_b*dist , ",0)"].join("")
	});

}

function move_pointer_a(){

	
}

function off_phanso(){
	$(document.getElementById(g_txt_a_flash)).find("text").hide();
    $(document.getElementById(g_txt_a_tuso)).find("text").empty().text();
	$(document.getElementById(g_txt_a_mauso)).find("text").empty().text();
	$(document.getElementById(g_txt_a_plus)).css({"display": "none"});
}


function getClosestFraction(value, tol, plus) {
    var original_value = value;
 
    var iteration = 0;
    var denominator=1, last_d = 0, numerator;
    while (iteration < 20) {
        value = 1 / (value - Math.floor(value))
        var _d = denominator;
        denominator = Math.floor(denominator * value + last_d);
        last_d = _d;
        numerator = Math.ceil(original_value * denominator)

        if (Math.abs(numerator/denominator - original_value) < tol)
            break;
        iteration++;
    }
    if(g_move_a_x.toFixed(1) == -0.7 || g_move_a_x.toFixed(1) == 0.7){
    	numerator = 2;
    	denominator = 3;
    }
    if(g_move_a_x.toFixed(1) == -0.3 || g_move_a_x.toFixed(1) == 0.3){
    	numerator = 1;
    	denominator = 3;
    }

    //return return [dCodes, dCodes2];  

    $(document.getElementById(g_txt_a)).find("text").empty().text();
    $(document.getElementById(g_txt_a_flash)).find("text").show();
    $(document.getElementById(g_txt_a_tuso)).find("text").empty().text(Math.abs(numerator));
	$(document.getElementById(g_txt_a_mauso)).find("text").empty().text(denominator);

	if(plus == 1){
		$(document.getElementById(g_txt_a_plus)).find("text").show().empty().text("-");
		$(document.getElementById(g_txt_a_plus)).css({"display": "block"});
	}


    return {numerator: numerator, denominator: denominator, plus: plus};
    
};

function getClosestFractionAll(value, tol, plus) {
    var original_value = value;
 
    var iteration = 0;
    var denominator=1, last_d = 0, numerator;
    while (iteration < 20) {
        value = 1 / (value - Math.floor(value))
        var _d = denominator;
        denominator = Math.floor(denominator * value + last_d);
        last_d = _d;
        numerator = Math.ceil(original_value * denominator)

        if (Math.abs(numerator/denominator - original_value) < tol)
            break;
        iteration++;
    }
    if(g_move_a_x.toFixed(1) == -0.7 || g_move_a_x.toFixed(1) == 0.7){
    	numerator = 2;
    	denominator = 3;
    }
    if(g_move_a_x.toFixed(1) == -0.3 || g_move_a_x.toFixed(1) == 0.3){
    	numerator = 1;
    	denominator = 3;
    }

    return {numerator: numerator, denominator: denominator, plus: plus};
    
};

function global_AdjustTextDragA() {
		//di chuyen thanh cuộn a
		$(document.getElementById(BTN_move_a)).attr({
			"transform": ["matrix(1,0,0,1,", p*dist, ",0)"].join("")
		})

		// in ra giá trị của a
		$(document.getElementById(g_txt_a)).find("text").text(g_move_a_x.toFixed(1));

		// di chuyen x
		$(document.getElementById(g_x1)).attr({
			"transform": ["matrix(1,0,0,1,", g_x1_dist, ",0)"].join("")
		});


		if(g_move_b > 0){
			$(document.getElementById(g_txt_b)).find("text").text("+ "+g_move_b.toFixed(0));
		}else if(g_move_b < 0){
			$(document.getElementById(g_txt_b)).find("text").text("- "+Math.abs(g_move_b.toFixed(0)));
		}else{
			$(document.getElementById(g_txt_b)).find("text").text("+ "+Math.abs(g_move_b.toFixed(0)));
		}

		if(g_move_a_x > 0){
			$(document.getElementById(g_txt_a_plus)).hide();
			$(document.getElementById(g_txt_a)).find("text").attr({x: 28});
		}else{
			$(document.getElementById(g_txt_a)).find("text").attr({x: 8});
		}

		off_phanso();
		
		$(document.getElementById(g_txt_a)).show();
		$(document.getElementById(g_txt_a)).find("text").attr({x: 8});
		$(document.getElementById(g_txt_b)).find("text").attr({x: 16});


		$(document.getElementById(g_txt_b)).show();
		$(document.getElementById(g_x1)).show();
}

function global_AdjustTextDragEndA() {
		console.log("===");
		$(document.getElementById(BTN_move_a)).attr({
			"transform": ["matrix(1,0,0,1,", p*dist, ",0)"].join("")
		});

		if(g_move_a_x == g_move_a_x.toFixed(1)){
			$(document.getElementById(g_txt_a)).find("text").text(g_move_a_x);
		}else{
			$(document.getElementById(g_txt_a)).find("text").text(g_move_a_x.toFixed(1));
		}
		$(document.getElementById(g_x1)).attr({
			"transform": ["matrix(1,0,0,1,-25,0)"].join("")
		});

		if($(document.getElementById(g_txt_b)).find("text").text() == "+ 0" || $(document.getElementById(g_txt_b)).find("text").text() == "- 0") $(document.getElementById(g_txt_b)).find("text").empty();

		check_phanso = 0;
		for(var i=0; i<g_arr_check_phanso.length-1; i++) {
			if(g_move_a_x == g_arr_check_phanso[i]) {
				
				if(g_move_a_x < 0){
					plus = 1;
					getClosestFraction(g_move_a_x, 50, plus);
				}else{
					plus = 0;
					getClosestFraction(g_move_a_x, 50, plus);
				}
				check_phanso = 1;
				break;
			}

		}

		if(check_phanso == 0){
			off_phanso();
			$(document.getElementById(g_txt_a)).show();
		}

		if(g_move_a_x == 1) $(document.getElementById(g_txt_a)).find("text").empty();
		if(g_move_a_x == -1){
			$(document.getElementById(g_txt_a)).find("text").attr({x: 36}).empty().text("-");
		}else{
			$(document.getElementById(g_txt_a)).find("text").attr({x: 8});
		}

		if(g_move_a_x > 0){
			$(document.getElementById(g_txt_a)).find("text").attr({x: 28});
		}else{
			$(document.getElementById(g_txt_a)).find("text").attr({x: 8});
		}

		if(g_move_a_x == 0){
			$(document.getElementById(g_txt_a)).find("text").empty().text(g_move_b);
			//$(document.getElementById(g_txt_a)).empty().text(g_move_b);
			$(document.getElementById(g_x1)).hide();
			$(document.getElementById(g_txt_b)).hide();
		}else{
			$(document.getElementById(g_x1)).show();
			$(document.getElementById(g_txt_b)).show();
		}

		$(document.getElementById(g_txt_b)).find("text").attr({x: -12});
		
}

function global_AdjustTextDragB() {
		// di chuyen con tro a
			$(document.getElementById(BTN_move_b)).attr({
				"transform": ["matrix(1,0,0,1,", p*dist, ",0)"].join("")
			})

			// in ra giá trị của a
			$(document.getElementById(g_txt_a)).find("text").text(g_move_a_x.toFixed(0));

			// di chuyen x
			$(document.getElementById(g_x1)).attr({
				"transform": ["matrix(1,0,0,1,", g_x1_dist, ",0)"].join("")
			});

			// in ra giá trị của b
			$(document.getElementById(g_txt_b)).find("text").text(g_move_b.toFixed(1));

			if(g_move_b > 0){
				$(document.getElementById(g_txt_b)).find("text").text("+"+g_move_b.toFixed(1));
			}else if(g_move_b < 0){
				$(document.getElementById(g_txt_b)).find("text").text("-"+Math.abs(g_move_b.toFixed(1)));
			}else{
				$(document.getElementById(g_txt_b)).find("text").text("+"+Math.abs(g_move_b.toFixed(1)));
			}

			if(g_move_a_x == 0){
				$(document.getElementById(g_x1)).show();
			}

			if(g_move_a_x > 0){
				$(document.getElementById(g_txt_a)).find("text").attr({x: 28});
			}else{
				$(document.getElementById(g_txt_a)).find("text").attr({x: 8});
			}

			$(document.getElementById(g_txt_a)).show();
			$(document.getElementById(g_txt_b)).show();

			$(document.getElementById(g_txt_b)).find("text").attr({x: 18});


			// if(check_phanso == 0){
			// 	off_phanso();
			// 	$(document.getElementById(g_txt_a)).show();
			// }

			off_phanso();
}

function global_AdjustTextDragEndB() {
		// di chuyen con tro a
		$(document.getElementById(BTN_move_b)).attr({
			"transform": ["matrix(1,0,0,1,", p*dist, ",0)"].join("")
		})
		$(document.getElementById(g_txt_a)).find("text").text(g_move_a_x.toFixed(0));
		// in ra giá trị của b
		if(g_move_b > 0){
			$(document.getElementById(g_txt_b)).find("text").text("+ "+g_move_b);
		}else{
			$(document.getElementById(g_txt_b)).find("text").text("- "+Math.abs(g_move_b));
		}

		

		if($(document.getElementById(g_txt_b)).find("text").text() == "+ 0" || $(document.getElementById(g_txt_b)).find("text").text() == "- 0") $(document.getElementById(g_txt_b)).find("text").empty();

		if(g_move_a_x == 0){
			$(document.getElementById(g_txt_a)).find("text").empty().text(g_move_b);
			//$(document.getElementById(g_txt_a)).empty().text(g_move_b);
			$(document.getElementById(g_x1)).hide();
			$(document.getElementById(g_txt_b)).hide();
		}else{
			$(document.getElementById(g_x1)).show();
		}

		for(var i=0; i<g_arr_check_phanso.length-1; i++) {
			if(g_move_a_x == g_arr_check_phanso[i]) {
				
				if(g_move_a_x < 0){
					getClosestFraction(g_move_a_x, 50, 1);
				}else{
					getClosestFraction(g_move_a_x, 50, 0);
				}
				check_phanso = 1;
				break;
			}

		}

		if(check_phanso == 0){
			off_phanso();
			$(document.getElementById(g_txt_a)).show();
		}

		
		if(g_move_a_x == 1) $(document.getElementById(g_txt_a)).find("text").empty();
		if(g_move_a_x == -1){
			$(document.getElementById(g_txt_a)).find("text").attr({x: 8}).empty().text("-");
		}else{
			$(document.getElementById(g_txt_a)).find("text").attr({x: 8});
		}

		if(g_move_a_x > 0) $(document.getElementById(g_txt_a)).find("text").attr({x: 28});
		
		$(document.getElementById(g_txt_b)).find("text").attr({x: -12});
		$(document.getElementById(g_x1)).attr({
			"transform": ["matrix(1,0,0,1,-25,0)"].join("")
		});
}

function show_all(){

	$(document.getElementById("point_container")).empty();

	if(show_status == 1){
		$(document.getElementById(g_txt_show)).find("text").empty().text("残像表示");
		$(document.getElementById("0:34:141:1:52")).hide();
		$(document.getElementById("0:34:141:3:59:54_0")).find("image").attr({href: "g2_p63_01/image/image_47_0.png"});
		$(document.getElementById("0:34:141:3:59:56_1")).find("image").attr({href: "g2_p63_01/image/image_49_0.png"});
		circle_r = 0;
		solid = 1;
		draw_ax(g_move_a_x, g_move_b);
		$(document.getElementById("0:34:141:87:140")).hide();
		$(document.getElementById("point_container0")).hide();
		$(document.getElementById("point_container1")).hide();
		$(document.getElementById("point_container2")).hide();
		$(document.getElementById("point_container3")).hide();
		show_status = 0;
	}else{
		$(document.getElementById(g_txt_show)).find("text").empty().text("通常表示");
		$(document.getElementById("0:34:141:3:59:54_0")).find("image").attr({href: "g2_p63_01/image/image_54_0.png"});
		$(document.getElementById("0:34:141:3:59:56_1")).find("image").attr({href: "g2_p63_01/image/image_56_0.png"});
		circle_r = 3;
		solid = 2;
		draw_ax(g_move_a_x, g_move_b);
		$(document.getElementById("0:34:141:87:140")).show();
		$(document.getElementById("point_container0")).show();
		$(document.getElementById("point_container1")).show();
		$(document.getElementById("point_container2")).show();
		$(document.getElementById("point_container3")).show();
		show_status = 1;
	}



}

function reset_all() {
		$(document.getElementById("point_container")).empty();
		
		remove_0();
		remove_1();
		remove_2();
		remove_3();

	}

function global_AdjustTextPos() {
		// Adjust text GRAPH.
		$(document.getElementById("0:122:142")).find("text").attr({x:0, y:-2.25}).css({"font-family": "MS PMincho"});
		$(document.getElementById("0:122:142")).append($(createTag("g")).attr({"id": "new_apend"}) );
		$(document.getElementById("new_apend")).append($(createTag("text")).css({"font-family": "MS PMincho"}).attr({"id": "txt_apend","font-size": "20" , "transform": ["matrix(1,0,0,1,13,62)"].join("")}) );
		$(document.getElementById("txt_apend")).empty().text("どのように変化するかみてみよう。") ;
		$(document.getElementById(g_count1)).attr({}).hide();
		$(document.getElementById(g_count2)).attr({}).hide();
		$(document.getElementById(g_count3)).attr({}).hide();
		$(document.getElementById(g_count4)).attr({}).hide();
		$(document.getElementById(g_txt_show)).attr({}).find("text").attr({x: 5, y:10.5}).css({"font-family": "MS UI Gothic"});
		
		var arr = ["0:34:141:17:113:2:89", "0:34:141:17:113:3:90", "0:34:141:17:113:4:91", "0:34:141:17:113:5:92", "0:34:141:17:113:6:93", "0:34:141:17:113:7:94", "0:34:141:17:113:8:95", "0:34:141:17:113:9:96", "0:34:141:17:113:10:97", "0:34:141:17:113:11:98"];
		
		$.each(arr, function( index, value ) {
			$(document.getElementById(value)).find("text").attr({x:59 ,y:21}).css({"font-family": "MS UI Gothic"});
		});

		var arr_b = ["0:34:141:17:113:1:88", "0:34:141:17:113:7:94", "0:34:141:17:113:8:95", "0:34:141:17:113:9:96", "0:34:141:17:113:10:97", "0:34:141:17:113:11:98"];
		
		$.each(arr_b, function( index, value ) {
			$(document.getElementById(value)).find("text").attr({x:65 ,y:21}).css({"font-family": "MS UI Gothic"});
		});

		var arr_x = ["0:3:45:6:17", "0:3:45:5:16", "0:3:45:4:15", "0:3:45:3:14"];
		
		$.each(arr_x, function( index, value ) {
			$(document.getElementById(value)).find("text").attr({y:15}).css({"font-family": "MS PMincho"});
			
		});

		$(document.getElementById("0:3:45:5:16")).find("text").attr({"transform": ["matrix(1.1,0,0,1, -89.5, 3.95)"].join("")});
		$(document.getElementById("0:3:45:6:17")).find("text").attr({"transform": ["matrix(1.1,0,0,1, -169.5, 3.95)"].join("")});
		$(document.getElementById("0:3:45:3:14")).find("text").attr({x: 4, "transform": ["matrix(1.1,0,0,1, 71.5, 3.95)"].join("")});
		$(document.getElementById("0:3:45:4:15")).find("text").attr({x: 4, "transform": ["matrix(1.1,0,0,1, 150, 3.95)"].join("")});

		var arr_x = ["0:3:45:8:19", "0:3:45:7:18", "0:3:45:9:20", "0:3:45:10:21"];
		
		$.each(arr_x, function( index, value ) {
			$(document.getElementById(value)).find("text").attr({x:8 ,y:15}).css({"font-family": "MS PMincho"});
			
		});

		$(document.getElementById("0:3:45:8:19")).find("text").attr({x: 4, "transform": ["matrix(1.1,0,0,1, -22, -169)"].join("")});
		$(document.getElementById("0:3:45:7:18")).find("text").attr({x: 4, "transform": ["matrix(1.1,0,0,1, -22, -88.5)"].join("")});
		$(document.getElementById("0:3:45:9:20")).find("text").attr({x: -2, "transform": ["matrix(1.1,0,0,1, -22, 71)"].join("")});
		$(document.getElementById("0:3:45:10:21")).find("text").attr({x: -2, "transform": ["matrix(1.1,0,0,1, -22, 151.45)"].join("")});

		// di chuyen x
			$(document.getElementById(g_x1)).attr({
				"transform": ["matrix(1,0,0,1,-25,0)"].join("")
			});
		//"transform": ["matrix(1.1,0,0,1,-89.5,3.95)"].join("")


		$(document.getElementById("0:34:141:87:140")).find("text").css({"font-family": "MS PMincho"});

		// xóa kết ax
		$(document.getElementById("0:34:141:87:140:61:129:12:128")).find("text").empty().text();

		

		$(document.getElementById("0:34:141:87:140:61:129:5:128:3:124")).find("text").empty().text();


		//xóa vị trí x ở kết quả
		$(document.getElementById(g_x2)).hide();
		// set giá trị cho a ở kết quả = 2
		$(document.getElementById(g_txt_a)).find("text").attr({x: 25, y: 33}).empty().text(2);
		
		//$(document.getElementById(g_txt_a)).find("text").attr({x: 15, y: 32}).empty().text(2);

		$(document.getElementById(g_txt_b)).find("text").attr({x: -12, y: 32}).empty().text();
		// xu ly phan so
		$(document.getElementById(g_txt_a_minus)).find("text").attr({x: -2.85, y: 31}).empty().text();
		$(document.getElementById(g_txt_a_flash)).find("text").attr({x: -12, y:25}).hide();
		$(document.getElementById(g_txt_a_tuso)).find("text").attr({x: 16, y: 28}).empty().text();
		$(document.getElementById(g_txt_a_mauso)).find("text").attr({x: 16, y: 38}).empty().text();
		$(document.getElementById(g_txt_a_plus)).find("text").attr({x: 0, y: 31}).hide();

		// dich chuyen toan bo ax thu 1 2 3 4
		var arr_ax = ["0:34:141:87:140:9:129:5:128", "0:34:141:87:140:22:129:5:128", "0:34:141:87:140:35:129:5:128", "0:34:141:87:140:48:129:5:128"];
		$.each(arr_ax, function(index, value) {
			$(document.getElementById(value)).attr({
				"transform": ["matrix(1,0,0,1, 5,28)"].join("")
			});
			
		});
		
		$(document.getElementById("0:34:141:87:140:9:129:5:128:6:127")).hide();
		$(document.getElementById("0:34:141:87:140:35:129:12:128")).find("text").empty();
		// an vi tri thua

		var arr_y = ["0:34:141:87:140:9:129:12:128:1:122", "0:34:141:87:140:9:129:12:128:2:123", "0:34:141:87:140:9:129:12:128:5:126", "0:34:141:87:140:9:129:12:128:6:127", "0:34:141:87:140:9:129:12:128:4:125", "0:34:141:87:140:22:129:5:128:6:127", "0:34:141:87:140:35:129:5:128:6:127", "0:34:141:87:140:48:129:5:128:6:127", "0:34:141:87:140:22:129:12:128:1:122", "0:34:141:87:140:22:129:12:128:5:126", "0:34:141:87:140:22:129:12:128:2:123", "0:34:141:87:140:22:129:12:128:6:127", "0:34:141:87:140:22:129:12:128:4:125"];
		$.each(arr_y, function( index, value ) {
			$(document.getElementById(value)).hide();
			
		});
		$(document.getElementById("0:34:141:87:140:35:129:12:128")).find("text").empty();
		$(document.getElementById("0:34:141:87:140:48:129:12:128")).find("text").empty();
		//console.log(g_AllSlots.length);
		for (var i = 0; i < 4; i++) {
			$(document.getElementById(g_AllSlots[i].g_txt_a)).find("text").attr({x: 12, y: 8});
			$(document.getElementById(g_AllSlots[i].g_txt_a_mauso)).find("text").attr({x: 12, y: 6});
			$(document.getElementById(g_AllSlots[i].g_txt_a_tuso)).find("text").attr({x: 12, y: 6});
			$(document.getElementById(g_AllSlots[i].g_txt_b)).find("text").attr({x: -5, y: 35}).empty();

			$(document.getElementById(slot_panel[i])).hide();
		};

		//console.log(slot_panel[0]);


		// xóa path màu đen
		$(document.getElementById("0:34:141:17:113:64:112:108_1:2:107")).hide();
		$(document.getElementById("0:34:141:17:113:67:112:108_1:2:107")).hide();
		// xóa path màu đen khi hover
		$(document.getElementById("0:34:141:17:113:64:112:111_2:2:107:1:26")).hide();
		$(document.getElementById("0:34:141:17:113:67:112:111_2:2:107:1:26")).hide();

	
		
		//$(document.getElementById(g_txt_a)).find("text").attr({x: 15, y: 32});

	}


function fillSlot(a, b, slotId){

		
		//console.log(check_phanso);
		if(check_phanso == 0){
			$(document.getElementById(g_AllSlots[slotId].g_txt_a_flash)).find("text").hide();
		    $(document.getElementById(g_AllSlots[slotId].g_txt_a_tuso)).find("text").empty().text();
			$(document.getElementById(g_AllSlots[slotId].g_txt_a_mauso)).find("text").empty().text();
			$(document.getElementById(g_AllSlots[slotId].g_txt_a_minus)).hide();
			if(a == 0){
				$(document.getElementById(g_AllSlots[slotId].g_txt_a)).show();
				$(document.getElementById(g_AllSlots[slotId].g_txt_b)).hide();
				$(document.getElementById(g_AllSlots[slotId].g_txt_a)).find("text").empty().text($(document.getElementById(g_txt_a)).find("text").text());
				$(document.getElementById(g_AllSlots[slotId].g_txt_x)).hide();

			}else{
				$(document.getElementById(g_AllSlots[slotId].g_txt_a)).show();
				$(document.getElementById(g_AllSlots[slotId].g_txt_b)).show();
				$(document.getElementById(g_AllSlots[slotId].g_txt_a)).find("text").empty().text($(document.getElementById(g_txt_a)).find("text").text());
				$(document.getElementById(g_AllSlots[slotId].g_txt_x)).show();
			}
		}else{
			$(document.getElementById(g_AllSlots[slotId].g_txt_a)).hide();
			$(document.getElementById(g_AllSlots[slotId].g_txt_a_flash)).find("text").show();
			$(document.getElementById(g_AllSlots[slotId].g_txt_a_tuso)).find("text").empty().text($(document.getElementById(g_txt_a_tuso)).find("text").text());
			$(document.getElementById(g_AllSlots[slotId].g_txt_a_mauso)).find("text").empty().text($(document.getElementById(g_txt_a_mauso)).find("text").text());
			$(document.getElementById(g_AllSlots[slotId].g_txt_a_minus)).show();
			$(document.getElementById(g_AllSlots[slotId].g_txt_x)).show();
			$(document.getElementById(g_AllSlots[slotId].g_txt_b)).show();


		}
		//console.log(a , g_AllSlots[slotId].g_txt_a_minus);
		if(a<0){
			$(document.getElementById(g_AllSlots[slotId].g_txt_a)).find("text").attr({x: -10});
			
		}else{
			$(document.getElementById(g_AllSlots[slotId].g_txt_a)).find("text").attr({x: 12});
			$(document.getElementById(g_AllSlots[slotId].g_txt_a_minus)).hide();
		}
		// if(a != 0){

		// }


		$(document.getElementById(g_AllSlots[slotId].g_txt_b)).find("text").empty().text($(document.getElementById(g_txt_b)).find("text").text());
		
		g_AllSlots[slotId].status = 1;

		$(document.getElementById(COOR_ID)).append($(createTag("g")).attr({
			"id": "point_container"+slotId, "transform": ["matrix(1.09998,0,0,1.09998,530,275)"].join("")
		}));
		
		draw_ax(g_move_a_x, g_move_b, slotId);
		

		var x_image = 0;
		var y_image = 0;

		if(check_i == "I1"){
			x_image = -x1*distant-15;
			y_image = y1*distant+5;
		}

		if(check_i == "I2"){
			x_image = x2*distant+5;
			y_image = -y2*distant-15;
		}

		if(check_i == "I3"){
			if(x1 == 5){
				x_image = x1*distant+5;
				y_image = -y1*distant-15;
			}else if(x1 > 0){
				x_image = x1*distant-15;
				y_image = -y1*distant-35;
			}else{
				x_image = x2*distant-15;
				y_image = -y2*distant+5;
			}
		}

		if(check_i == "I4"){
			
			if(x1 == 5){
				x_image = x1*distant+5;
				y_image = -y1*distant-15;
				//console.log("aaa");
			}else if(x1 == -5){
				x_image = -x1*distant+5;
				y_image = y1*distant-15;
			}else{
				if(y1<0){
					x_image = x1*distant-15;
					y_image = -y1*distant+5;
				}else{
					x_image = x1*distant-15;
					y_image = -y1*distant-35;
					console.log("aaa");
				}
				

			}
			console.log(x1, y1);
		}

		

		var image = document.createElementNS('http://www.w3.org/2000/svg','image');
		image.setAttributeNS("http://www.w3.org/1999/xlink", "href", g_AllSlots[slotId].href);
		$(image).attr({
			width: 75,
			height: 75,
			transform:["matrix(0.399994,0,0,0.399994,",x_image ,", ",y_image,")"].join("")
		});

		_$("point_container"+slotId).append(image);

		
}

function drawSlot() {
		for (var i = 0; i < 4; i++) {
			if(g_AllSlots[i].status == 0){
				fillSlot(g_move_a_x, g_move_b, i);
				$(document.getElementById(slot_panel[i])).show();
				break;
			}
		};
		save_status = 1;
}

function remove_0(){
		$(document.getElementById(slot_0)).hide();
		g_AllSlots[0].status = 0;
		$(document.getElementById("point_container0")).remove();	
}

function remove_1(){
		$(document.getElementById(slot_1)).hide();
		g_AllSlots[1].status = 0;
		$(document.getElementById("point_container1")).remove();
}

function remove_2(){
		$(document.getElementById(slot_2)).hide();
		g_AllSlots[2].status = 0;
		$(document.getElementById("point_container2")).remove();
}

function remove_3(){
		$(document.getElementById(slot_3)).hide();
		g_AllSlots[3].status = 0;
		$(document.getElementById("point_container3")).remove();
}