function createTag(tag) {
	return document.createElementNS("http://www.w3.org/2000/svg", tag)
}

function createText(textId) {
	var textData = g_allSVGText[textId];
	var g = $(createTag("g"));
	for (var i = 0, len = g_allSVGText[textId].length; i < len; i++) {
		var p = g_allSVGText[textId][i];
		g.append($(createTag("path")).css(p.css).attr({
			d: p.d,
			transform: p.transform
		}));
	}
	return g;
}

var GAME = {
	patchText: function() {
		console.log("GAME.patchText");
		//==== Patch text [1m]
		var aAdjustTextXY = {
			"0:59:314:73:305": {x: 2, y: 43},	// 1. カード種類
			"0:59:314:74:306": {x: 2, y: 43},	// 2. 点数表示
			"0:59:314:75:307": {x: 2, y: 43},	// 3. トラップ枚数
			"0:59:314:76:308": {x: 2, y: 43},	// 4. 答え表示
			"0:59:314:77:309": {x: 2, y: 43},	// 5. ゲーム進行
			"0:59:314:78:310": {x: 2, y: 43},	// 6. 問題表示時間
			"0:59:314:79:311": {x: 2, y: 43}	// 7. 答え表示時間
		};
		for(var id in aAdjustTextXY) {
			var o = aAdjustTextXY[id];
			$(document.getElementById(id).firstChild.nextSibling).attr({transform: ["matrix(1,0,0,1,",o.x,",",o.y,")"].join("")});
		}


		var aAdjustButtonXY = {
			"0:59:314:3:245:14:244": {x: 0, y: 0},		// Slider handler 1.
			"0:59:314:18:245:14:244": {x: 0, y: 0},		// Slider handerl 2.
			"0:59:314:45:255": {x: 0, y: 0},			// Play Triangle button.
			"0:59:314:48:259": {x: 23, y: 43},			// トラップ
			"0:59:314:50:263": {x: 45, y: 43},			// 数字
			"0:59:314:52:267": {x: 45, y: 43},			// 表示 - Result Point
			"0:59:314:54:271": {x: 21, y: 43},			// 非表示 - Result Point
			"0:59:314:56:275": {x: 45, y: 43},			// 2枚
			"0:59:314:58:279": {x: 45, y: 43},			// 3枚
			"0:59:314:60:283": {x: 45, y: 43},			// 4枚
			"0:59:314:62:287": {x: 45, y: 43},			// 自動 - ゲーム進行
			"0:59:314:64:291": {x: 45, y: 43},			// 表示 - Answer
			"0:59:314:66:295": {x: 21, y: 43},			// 非表示 - Answer
			"0:59:314:68:299": {x: 32, y: 43},			// クリック - ゲーム進行
			"0:59:314:70:303": {x: 21, y: 43},			// ランダム - Random

			"0:59:314:72:304": {x: 32, y: 50},			// [設定] - Random
			"0:59:314:45:255": {x: 0, y: 0},			// 戻る - Random
				
			"0:59:314:33:246": {x: 67, y: 43},			// 5秒
			"0:59:314:34:247": {x: 67, y: 43}			// 5秒
		};
		for(var id in aAdjustButtonXY) {
			var o = aAdjustButtonXY[id];
			$(document.getElementById(id)).attr({transform: ["matrix(1,0,0,1,",o.x,",",o.y,")"].join("")});
		}
		
		// Set text-anchor middle for text 5秒.
		$(document.getElementById("0:59:314:33:246").firstChild.nextSibling.firstChild).attr({"text-anchor": "middle"});
		$(document.getElementById("0:59:314:34:247").firstChild.nextSibling.firstChild).attr({"text-anchor": "middle"});
		
		//==== 戻る Button (Back button).
		$(document.getElementById("0:59:314:45:255")).find("g[type=text]").each(function(i,e){
		  $(e.firstChild.nextSibling.firstChild).attr({transform: "matrix(1,0,0,1,13, 43)"});
		})
			
			
		//==== Rulers
		$(document.getElementById("0:59:314:18:245")).find("g[type=text]").each(function(i,e){
			var o = e.firstChild.nextSibling.firstChild;
			var m = $(o).attr("transform").split(/matrix\(|[, ]+|\)/).filter(Boolean);
			m[4] = Number(m[4])+3;
			m[5] = Number(m[5])+16;
			if(e.id == "0:59:314:18:245:11:238") {
				$(o).attr("transform", "matrix(1,0,0,1,-276,18)");
			} else {
				$(o).attr("transform", ["matrix(",m.join(","),")"].join(""));
			}
		})

		$(document.getElementById("0:59:314:3:245")).find("g[type=text]").each(function(i,e){
			var o = e.firstChild.nextSibling.firstChild;
			var b = o.getBoundingClientRect();
			var m = $(o).attr("transform").split(/matrix\(|[, ]+|\)/).filter(Boolean);
			m[4] = Number(m[4])+3;
			m[5] = Number(m[5])+16;
			if(e.id == "0:59:314:3:245:11:238") {
				$(o).attr("transform", "matrix(1,0,0,1,-276,18)");
			} else {
				$(o).attr("transform", ["matrix(",m.join(","),")"].join(""));
			}
		})
		

		//==== 答え		
		$(document.getElementById("0:3:189:40:185:4:184")).attr({transform: "matrix(1,0,0,1,28,51)"});
		var s = "matrix(1,0,0,1,11,18)";
		$(document.getElementById("0:3:189:38:176")).attr({transform: s})
		$(document.getElementById("0:3:189:39:177")).attr({transform: s})
		

		//=== Total		
		$(document.getElementById("0:3:189:40:185:3:183")).attr({
		  transform: "matrix(1,0,0,1,95,85)"
		})
		$(document.getElementById("0:3:189:40:185:3:183")).find("text:first").attr({"text-anchor": "middle"}).empty();
		
		//==== Adjust Bich.
		GAME.drawSettings();
	},

	drawSettings: function() {
		$(document.getElementById("0:59:314:35:250")).attr({"transform": (MODEL.nCardType == CARD_TYPE_TRAP)?"matrix(1,0,0,1,-5,2)":"matrix(1,0,0,1,235,2)"});
		$(document.getElementById("0:59:314:37:250")).attr({"transform": (MODEL.bShowResultPoint)?"matrix(1,0,0,1,-4,2)":"matrix(1,0,0,1,241,2)"});
		$(document.getElementById("0:59:314:41:250")).attr({"transform": 
			(MODEL.bRandomCardNum)?	"matrix(1,0,0,1,495,2)":
			(MODEL.nCardNum==2)?	"matrix(1,0,0,1,-2,2)":
			(MODEL.nCardNum==3)?	"matrix(1,0,0,1,156,2)":
									"matrix(1,0,0,1,315,2)"
		});
		
		$(document.getElementById("0:59:314:39:250")).attr({"transform": (MODEL.bShowAnswer)?"matrix(1,0,0,1,-7,2)":"matrix(1,0,0,1,237,2)"});
		$(document.getElementById("0:59:314:43:250")).attr({"transform": (MODEL.bGameAutoProcess)?"matrix(1,0,0,1,-11,-2)":"matrix(1,0,0,1,237,-2)"});

		//==== Time to show issue.
		var val = MODEL.dTimeToShowIssue<1? 0: MODEL.dTimeToShowIssue;
//		$(document.getElementById("0:59:314:18:245:14:244")).attr({transform: ["matrix(1,0,0,1,",(MODEL.dTimeToShowIssue-5)*STEP_SLIDER,",0)"].join("")});
		$(document.getElementById("0:59:314:18:245:14:244")).attr({transform: ["matrix(1,0,0,1,",(val-5)*STEP_SLIDER,",0)"].join("")});
		$(document.getElementById("0:59:314:33:246").firstChild.nextSibling.firstChild).empty()
			.append((MODEL.dTimeToShowIssue<1?0.5:MODEL.dTimeToShowIssue)+"秒");

		//==== Time to show answer.
		var val = MODEL.dTimeToShowAnswer<1?0: MODEL.dTimeToShowAnswer;
//		$(document.getElementById("0:59:314:3:245:14:244")).attr({transform: ["matrix(1,0,0,1,",(MODEL.dTimeToShowAnswer-5)*STEP_SLIDER,",0)"].join("")});
		$(document.getElementById("0:59:314:3:245:14:244")).attr({transform: ["matrix(1,0,0,1,",(val-5)*STEP_SLIDER,",0)"].join("")});
		$(document.getElementById("0:59:314:34:247").firstChild.nextSibling.firstChild).empty()
			.append((MODEL.dTimeToShowAnswer<1?0.5:MODEL.dTimeToShowAnswer)+"秒");
		
		
		//==== Show/Hide band above text.
		$(document.getElementById("0:59:314:82:313")).toggle(MODEL.nCardType == CARD_TYPE_NUMBER);
		$(document.getElementById("0:59:314:90:313")).toggle(MODEL.bGameAutoProcess == false);
		$(document.getElementById("0:59:314:92:313")).toggle(MODEL.bShowAnswer == false || MODEL.bGameAutoProcess == false);
		console.log("GAME.drawSettings");
	},


	calResult: function() {
		var nCard  = g_aQuestions[g_nCurrentQuestion].length;
		var nTotal = 0;
		for(var i=0; i<nCard; i++) {
			var cardValue = ((g_aQuestions[g_nCurrentQuestion][i]-1) % 40)+1;
			var num = 0;
			if(1<=cardValue && cardValue<= 10) {
				num = cardValue;
			} else if(11<=cardValue && cardValue<= 20) {
				num = -(cardValue-10);
			} else if(21<=cardValue && cardValue<= 30) {
				num = cardValue-20;
			} else if(31<=cardValue && cardValue<= 40) {
				num = -(cardValue-30);
			} 
//			console.log("====", i, cardValue, num);
			nTotal += num; 
		}
//		console.log(nTotal);
		
		return nTotal;
	},
	cardFaceBack: function() {
		var nCard  = g_aQuestions[g_nCurrentQuestion].length;
		var aPosX = CARDS_POS_X[nCard];
		var nDuration = 0.3*1000;	// 1 second.
		g_anim.reset();
		g_anim.add({
			duration: nDuration,
			delay: 0,
			isRunAtEnd: true,
			data: {x: {startValue: 1, endValue: 0, easing: "linearTween"}},
			onInit: function() {},
			onComplete: function() {
				var bShow = (MODEL.nCardType == CARD_TYPE_TRAP && MODEL.bShowResultPoint)
				for(var i=0; i<nCard; i++) {
					$(document.getElementById(NUMBER_FACE[i])).toggle(bShow);
				}
			},
				
			onStep: function(data, t) {
				for(var i=0; i<nCard; i++) {
					$(document.getElementById(CARD_FACE[i]).firstChild.nextSibling)
						.attr({transform: ["matrix(",data.x.now,",0,0,1,0,0)"].join("")});
				}
			}
		});
		g_anim.add({
			duration: nDuration,
			delay: nDuration,
			isRunAtEnd: true,
			data: {x: {startValue: 0, endValue: 1, easing: "linearTween"}},
			onInit: function() {
				mvn.mainMovie.sprites["3:189"].sprites["40:185"].sprites["1:182"].jumpToFrame(0);
				//==== Hide card backs.
				for(var i=0; i<4; i++) {
					$(document.getElementById(CARD_BACKS[i])).hide();
				}
			},
			onComplete: function() {
				for(var i=0; i<nCard; i++) {
					$(document.getElementById(CARD_FACE[i])).show();
				}
				for(var i=0; i<nCard; i++) {
					$(document.getElementById(NUMBER_FACE[i])).toggle(false);
				}				//==== Show Question No.


				
				GAME.resetCards();
				g_nCurrentQuestion++;
				$(document.getElementById("0:3:189:40:185:3:183"))
					.find("text:first").empty();
				

//				GAME.resetCards();
				//==== Clear Result.
				if((g_nCurrentQuestion)>=MAX_QUESTION_NUM) {
					console.log("GAME_MODE_END_GAME111");
					g_nCurrentQuestion = 0;
					g_nGameMode = GAME_MODE_NEW_GAME;
					GAME.createNewGame();
					$(document.getElementById(BTN_START_ID)).show();
					$(document.getElementById(BTN_NEXT_ID)).hide();
					$(document.getElementById("0:3:189:38:176"))
						.find("text:first").empty().append(1);
				} else {
					$(document.getElementById("0:3:189:38:176"))
						.find("text:first").empty().append(g_nCurrentQuestion+1);
					GAME.showSlots();
					GAME.showCardInSlot();
					g_nGameMode = GAME_MODE_FACE_OFF;
				}
				
				
				if(g_bAutoRunning) {
					console.log("Faceback. ");
					setTimeout(GAME.checkMode, 500);
				}
			},
				
			onStep: function(data, t) {
				for(var i=0; i<nCard; i++) {
					$(document.getElementById(CARD_FLIPS[i]))
						.attr({transform: ["matrix(",data.x.now,",0,0,1,0,0)"].join("")});
				}
			}
		});

		g_anim.run();
	},

	createAutoPlay() {
	},
	
	checkMode: function() {
		console.log("BTN_START_ID", g_nGameMode);
		switch (g_nGameMode) {
			case GAME_MODE_INIT:
				console.log("GAME_MODE_INIT");
				g_nGameMode = GAME_MODE_NEW_GAME;
				$(document.getElementById(SCREEN_HELP)).hide();
				TABS.updateTabIdSelected("mainScreen");
				GAME.createNewGame();
				break;
			case GAME_MODE_NEW_GAME:
				console.log("GAME_MODE_NEW_GAME");
				g_nGameMode = GAME_MODE_FACE_OFF;
				GAME.cardMoveToSlot();	// Move cards from outside to house.
				break;
			case GAME_MODE_FACE_OFF:
				console.log("GAME_MODE_FACE_OFF");
				g_nGameMode = (MODEL.bShowAnswer) ? GAME_MODE_SHOW_RESULT: GAME_MODE_NEXT;
				GAME.changeFrame();
				GAME.cardFaceOff();
				console.log("g_nCurrentQuestion", g_nCurrentQuestion, MAX_QUESTION_NUM);
				break;
			case GAME_MODE_SHOW_RESULT:
				console.log("GAME_MODE_SHOW_RESULT");
				var nTotal = GAME.calResult();
//				console.log(nTotal);
				
				//==== Show Result.
				$(document.getElementById("0:3:189:40:185:3:183"))
					.find("text:first").empty().append(GAME.calResult());
				mvn.mainMovie.sprites["3:189"].sprites["40:185"].sprites["1:182"].jumpToFrame(5);
				g_nGameMode = GAME_MODE_NEXT;
				
				if(g_bAutoRunning) {
					console.log("ShowingAnswer", MODEL.dTimeToShowAnswer);
					setTimeout(GAME.checkMode, MODEL.dTimeToShowAnswer*1000);
				}
				break;
			case GAME_MODE_NEXT:
				console.log("GAME_MODE_NEXT");
				GAME.cardFaceBack();	// Change mode in onComplete.
				
//					GAME.resetCards();
//					GAME.showSlots();
//					GAME.showCardInSlot();
//					g_nGameMode = GAME_MODE_FACE_OFF;
				break;
			case GAME_MODE_SETTING:	// 
				console.log("GAME_MODE_SETTING. oops! Cannot click start when mode is GAME_MODE_SETTING.");
				break;
			case GAME_MODE_END_GAME:
				console.log("GAME_MODE_END_GAME");
				g_nGameMode = GAME_MODE_NEW_GAME;
				GAME.createNewGame();
				break;
		}
	},

	changeFrame: function() {
		var nCard  = g_aQuestions[g_nCurrentQuestion].length;
		var aPosX = CARDS_POS_X[nCard];

		var aCardSprites = ["14:125", "18:125", "22:125", "26:125"];
		var aNumSprites = ["30:174", "32:174", "34:174", "36:174"];
		for(var i=0; i<nCard; i++) {
			var cardValue = g_aQuestions[g_nCurrentQuestion][i];
//			console.log(cardValue);
			mvn.mainMovie.sprites["3:189"].sprites[aCardSprites[i]].sprites["1:121"].jumpToFrame(cardValue-1);
			mvn.mainMovie.sprites["3:189"].sprites[aNumSprites[i]].jumpToFrame(MODEL.nCardType == CARD_TYPE_TRAP? cardValue-1 : cardValue-41);
		}
		

		for(var i=0; i<4; i++) {
			//==== Show only card fronts and move to right position.
			$(document.getElementById(CARD_FRONTS[i])).toggle(i<nCard);	// Hide unused. Show used.
			$(document.getElementById(CARD_FACE[i])).hide();
			$(document.getElementById(NUMBER_FACE[i])).hide();

			if(i<nCard) {
				$(document.getElementById(CARD_FRONTS[i]).firstChild.nextSibling)
					.attr({transform: ["matrix(0.5,0,0,0.5,",aPosX[i],",-8.5)"].join("")});
				$(document.getElementById(NUMBER_FACE[i]).firstChild.nextSibling)
					.attr({transform: ["matrix(0.5,0,0,0.5,",aPosX[i],",160)"].join("")});
			}
			
			//==== Reset Card flips.
			$(document.getElementById(CARD_FLIPS[i])).show().attr({transform: "matrix(1,0,0,1,0,0)"});
			$(document.getElementById(CARD_FACE[i]).firstChild.nextSibling).attr({transform: "matrix(0.00999451,0,0,1,0,0)"});
		}
	},

	//==================================================
	// Flip flop cards.
	//==================================================
	cardFaceOff: function() {
		var nCard  = g_aQuestions[g_nCurrentQuestion].length;
		var aPosX = CARDS_POS_X[nCard];
		var nDuration = 0.3*1000;	// 1 second.
		g_anim.reset();
		g_anim.add({
			duration: nDuration,
			delay: 0,
			isRunAtEnd: true,
			data: {x: {startValue: 1, endValue: 0, easing: "linearTween"}},
			onInit: function() {
				//==== Hide card backs.
				for(var i=0; i<4; i++) {
					$(document.getElementById(CARD_BACKS[i])).hide();
				}
			},
			onComplete: function() {
				for(var i=0; i<nCard; i++) {
					$(document.getElementById(CARD_FACE[i])).show();
				}
			},
				
			onStep: function(data, t) {
				for(var i=0; i<nCard; i++) {
					$(document.getElementById(CARD_FLIPS[i]))
						.attr({transform: ["matrix(",data.x.now,",0,0,1,0,0)"].join("")});
				}
			}
		});
		g_anim.add({
			duration: nDuration,
			delay: nDuration,
			isRunAtEnd: true,
			data: {x: {startValue: 0, endValue: 1, easing: "linearTween"}},
			onInit: function() {},
			onComplete: function() {
				var bShow = (MODEL.nCardType == CARD_TYPE_TRAP && MODEL.bShowResultPoint)
				for(var i=0; i<nCard; i++) {
					$(document.getElementById(NUMBER_FACE[i])).toggle(bShow);
				}
				
				if(g_bAutoRunning) {
					console.log("ShowingIssue", MODEL.dTimeToShowIssue);
					setTimeout(GAME.checkMode, MODEL.dTimeToShowIssue * 1000);
				}
			},
				
			onStep: function(data, t) {
				for(var i=0; i<nCard; i++) {
					$(document.getElementById(CARD_FACE[i]).firstChild.nextSibling)
						.attr({transform: ["matrix(",data.x.now,",0,0,1,0,0)"].join("")});
				}
			}
		});

		g_anim.run();
	},
		
	//==================================================
	// Move cards from outside to slots.
	//==================================================
	cardMoveToSlot: function() {
		var nCard  = g_aQuestions[g_nCurrentQuestion].length;
		// y = -8.5
		var aPosX = CARDS_POS_X[nCard];
		var endY = -8.5;
		
		g_anim.reset();
		g_anim.add({
			duration: 0.5 * 1000,
			delay: 0,
			isRunAtEnd: true,
			data: {
				x: {startValue: -1000, endValue: aPosX[0], easing: "easeOutCubic"}
			},
			onInit: function() {
				for(var i=0; i<nCard; i++) {
					$(document.getElementById(CARD_BACKS[i]).firstChild.nextSibling)
						.attr({transform: ["matrix(0.5,0,0,0.5,-1000,-8.5)"].join("")});
				}
			},
			onComplete: function() {
				if(g_bAutoRunning) {
					console.log("waiting to faceoff", 500);
					setTimeout(GAME.checkMode, 500);
				}
			},
			onStep: function(data, t) {
				for(var i=0; i<nCard; i++) {
					$(document.getElementById(CARD_BACKS[i]).firstChild.nextSibling)
						.attr({transform: ["matrix(0.5,0,0,0.5,",data.x.now+i*203.65,",-8.5)"].join("")});
				}
			}
		});

		g_anim.run();

	},
		
	bindEvents: function() {
		//==== Make zoomable buttons.
		var aButtons = [
			"0:49:225:1:196", // Reset
			"0:49:225:3:203", // Stop
			"0:49:225:5:210", // Next
			"0:49:225:7:217", // Start
			"0:49:225:9:224", // Setting

//			"0:59:314:3:245:14:244",	// slider1's handler
//			"0:59:314:18:245:14:244",	// slider1's handler
			"0:59:314:45:255",
			"0:59:314:48:259",
			"0:59:314:50:263",
			"0:59:314:52:267",
			"0:59:314:54:271",
			"0:59:314:56:275",
			"0:59:314:58:279",
			"0:59:314:60:283",
			"0:59:314:62:287",
			"0:59:314:64:291",
			"0:59:314:66:295",
			"0:59:314:68:299",
			"0:59:314:70:303"
		];
		for (var i = 0; i < aButtons.length; i++) {
			MVNButton({id: aButtons[i]});
		}

		//==== Choose card type
		$(document.getElementById("0:59:314:48:259")).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			MODEL.nCardType = CARD_TYPE_TRAP;
			GAME.drawSettings();
		});

		$(document.getElementById("0:59:314:50:263")).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			MODEL.nCardType = CARD_TYPE_NUMBER;			
			GAME.drawSettings();
		});
		
		//==== Show Result Points
		$(document.getElementById("0:59:314:52:267")).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			if(MODEL.nCardType != CARD_TYPE_TRAP) return;
			
			MODEL.bShowResultPoint = true;	
			GAME.drawSettings();
		});
		$(document.getElementById("0:59:314:54:271")).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			if(MODEL.nCardType != CARD_TYPE_TRAP) return;

			MODEL.bShowResultPoint = false;			
			GAME.drawSettings();
		});
		
		//==== nCardNum
		$(document.getElementById("0:59:314:56:275")).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			MODEL.nCardNum = 2;
			MODEL.bRandomCardNum = false;
			GAME.drawSettings();
		});
		$(document.getElementById("0:59:314:58:279")).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			MODEL.nCardNum = 3;
			MODEL.bRandomCardNum = false;
			GAME.drawSettings();
		});
		$(document.getElementById("0:59:314:60:283")).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			MODEL.nCardNum = 4;
			MODEL.bRandomCardNum = false;
			GAME.drawSettings();
		});
		$(document.getElementById("0:59:314:70:303")).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			MODEL.nCardNum = 2;
			MODEL.bRandomCardNum = true;
			GAME.drawSettings();
		});

		//==== Show/Hide answer		
		$(document.getElementById("0:59:314:64:291")).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			MODEL.bShowAnswer = true;
			GAME.drawSettings();
		});
		$(document.getElementById("0:59:314:66:295")).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			MODEL.bShowAnswer = false;
			GAME.drawSettings();
		});
		
		//==== bGameAutoProcess		
		$(document.getElementById("0:59:314:62:287")).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			MODEL.bGameAutoProcess = true;	// Auto.
			GAME.drawSettings();
		});
		$(document.getElementById("0:59:314:68:299")).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			MODEL.bGameAutoProcess = false;	// Manual
			GAME.drawSettings();
		});
		
		
		//==== dTimeToShowIssue 0:59:314:18:245:14:244	//sprite 0:59:314:18:245:14:244:243_0
		$(document.getElementById("0:59:314:18:245:14:244")).find("g[type=sprite]").remove();
		$(document.getElementById("0:59:314:18:245:14:244"))
		.bind("mouseup touchend", function(event) {
			TABS.hideTabRectangle();
		})
		.drag("draginit", function(event){
			event.preventDefault();
			TABS.hideTabRectangle();
			this.startPosition = {
				x: event.clientX,
				pos0 : ((MODEL.dTimeToShowIssue <1? 0:MODEL.dTimeToShowIssue)-5) * STEP_SLIDER
			};
		}).drag(function(event){
			event.preventDefault();
			TABS.hideTabRectangle();
			var dX = (event.clientX - this.startPosition.x)/g_zoomLevel;
			var pos = this.startPosition.pos0 + dX;
			if(pos<MIN_SLIDER) pos = MIN_SLIDER;
			if(pos>MAX_SLIDER) pos = MAX_SLIDER;

			var num = Math.round(pos/STEP_SLIDER)+5;
			if(num<1) num = 0.5;
			$(this).attr({transform: ["matrix(1,0,0,1,",pos,",0)"].join("")});
			$(document.getElementById("0:59:314:33:246").firstChild.nextSibling.firstChild).empty().append(num+"秒");
		}).drag("dragend", function(event){
			event.preventDefault();
			TABS.hideTabRectangle();
			var dX = event.clientX - this.startPosition.x;
			var pos = this.startPosition.pos0 + dX/g_zoomLevel;
			if(pos<MIN_SLIDER) pos = MIN_SLIDER;
			if(pos>MAX_SLIDER) pos = MAX_SLIDER;

			pos = Math.round(pos/STEP_SLIDER) * STEP_SLIDER;
			var num = Math.round(pos/STEP_SLIDER)+5;
			if(num<1) num = 0.5;
			$(this).attr({transform: ["matrix(1,0,0,1,",pos,",0)"].join("")});
			$(document.getElementById("0:59:314:33:246").firstChild.nextSibling.firstChild).empty().append(num+"秒");

			MODEL.dTimeToShowIssue = num;
		});
		
		//==== dTimeToShowAnswer 0:59:314:3:245:14:244
		$(document.getElementById("0:59:314:3:245:14:244")).find("g[type=sprite]").remove();
		$(document.getElementById("0:59:314:3:245:14:244"))
		.bind("mouseup touchend", function(event) {
			TABS.hideTabRectangle();
		})
		.drag("draginit", function(event){
			event.preventDefault();
			TABS.hideTabRectangle();
			this.startPosition = {
				x: event.clientX,
				pos0 : ((MODEL.dTimeToShowAnswer <1? 0:MODEL.dTimeToShowAnswer)-5) * STEP_SLIDER
			};
		}).drag(function(event){
			event.preventDefault();
			TABS.hideTabRectangle();
			var dX = (event.clientX - this.startPosition.x)/g_zoomLevel;
			var pos = this.startPosition.pos0 + dX;
			if(pos<MIN_SLIDER) pos = MIN_SLIDER;
			if(pos>MAX_SLIDER) pos = MAX_SLIDER;

			var num = Math.round(pos/STEP_SLIDER)+5;
			if(num<1) num = 0.5;
			$(this).attr({transform: ["matrix(1,0,0,1,",pos,",0)"].join("")});
			$(document.getElementById("0:59:314:34:247").firstChild.nextSibling.firstChild).empty().append(num+"秒");
		}).drag("dragend", function(event){
			event.preventDefault();
			TABS.hideTabRectangle();
			var dX = event.clientX - this.startPosition.x;
			var pos = this.startPosition.pos0 + dX/g_zoomLevel;
			if(pos<MIN_SLIDER) pos = MIN_SLIDER;
			if(pos>MAX_SLIDER) pos = MAX_SLIDER;

			pos = Math.round(pos/STEP_SLIDER) * STEP_SLIDER;
			var num = Math.round(pos/STEP_SLIDER)+5;
			if(num<1) num = 0.5;
			$(this).attr({transform: ["matrix(1,0,0,1,",pos,",0)"].join("")});
			$(document.getElementById("0:59:314:34:247").firstChild.nextSibling.firstChild).empty().append(num+"秒");

			MODEL.dTimeToShowAnswer = num;
		});
		
		//==== Button Stop
		$(document.getElementById(BTN_STOP_ID)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			g_bAutoRunning = false;
			$(document.getElementById(BTN_START_ID)).show();
			$(document.getElementById(BTN_NEXT_ID)).hide();
			$(document.getElementById(BTN_STOP_ID)).hide();
			console.log("Stopped");
//			if(g_anim.isRunning()) return;
		});
		//==== Button Start
		$(document.getElementById(BTN_START_ID)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);

			if(g_anim.isRunning()) return;
			GAME.checkMode();
			if(g_nGameMode==GAME_MODE_FACE_OFF) {
				$(document.getElementById(BTN_START_ID)).hide();
				$(document.getElementById(BTN_NEXT_ID)).show();
			}
			
			if(MODEL.bGameAutoProcess && !g_bAutoRunning) {
				g_bAutoRunning = true;
				console.log("start again");
			}
			
			if(g_bAutoRunning) {
				console.log("START. ready to run", 500);
				setTimeout(GAME.checkMode, 500);
				$(document.getElementById(BTN_START_ID)).hide();
				$(document.getElementById(BTN_NEXT_ID)).hide();
				$(document.getElementById(BTN_STOP_ID)).show();
			}
		});

		//==== Button Next
		$(document.getElementById(BTN_NEXT_ID)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle();	// Keep tab here.
			if(g_anim.isRunning()) return;

			GAME.checkMode();
		});

		//==== Button Reset.
		$(document.getElementById(BTN_RESET_ID)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			if(g_anim.isRunning()) {
				g_anim.stop();
				g_anim.reset();
			}

			//==== Do nothing if current mode is init.
			if (g_nGameMode == GAME_MODE_INIT) return;
			GAME.createNewGame();
			g_nGameMode = GAME_MODE_NEW_GAME;
			
			$(document.getElementById(BTN_START_ID)).show();
			$(document.getElementById(BTN_NEXT_ID)).hide();
			mvn.mainMovie.sprites["3:189"].sprites["40:185"].sprites["1:182"].jumpToFrame(0);
		});


		$(document.getElementById(BTN_SETTING_ID)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			TABS.updateTabIdSelected("settingScreen");	//=== Switch tab.
			g_nSaveGameMode = g_nGameMode;
			g_nGameMode = GAME_MODE_SETTING;
			$(document.getElementById(SCREEN_SETTING)).show();
			g_bAutoRunning = false;
		});


		//==== Button Back from Settings.
		$(document.getElementById(BTN_BACK_TO_GAME)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			// If saved mode = init then when return from setting, mode keeps as init.
			// Else mode = new game.
			g_nGameMode = g_nSaveGameMode == GAME_MODE_INIT ? GAME_MODE_INIT : GAME_MODE_NEW_GAME;
			if(g_nGameMode == GAME_MODE_INIT) {
				TABS.updateTabIdSelected("home");	//=== Switch tab.
			} else {
				TABS.updateTabIdSelected("mainScreen");	//=== Switch tab.
			}			
			$(document.getElementById(SCREEN_SETTING)).hide();
			GAME.createNewGame();
			$(document.getElementById(BTN_START_ID)).show();
			$(document.getElementById(BTN_NEXT_ID)).hide();
		});
	},

	resetCards: function() {
		for(var i=0; i<4; i++) {
			$(document.getElementById(CARD_BACKS[i]).firstChild.nextSibling)
				.attr({transform: ["matrix(0.5,0,0,0.5,-1000,-8.5)"].join("")});
			$(document.getElementById(CARD_FRONTS[i])).hide();
			$(document.getElementById(CARD_FACE[i])).hide();
			$(document.getElementById(CARD_BACKS[i])).show()
			$(document.getElementById(NUMBER_FACE[i])).hide()
		}
	},
		
	showCardInSlot: function() {
		var slotNum = g_aQuestions[g_nCurrentQuestion].length;
		var x = CARDS_POS_X[slotNum][0];
		for(var i=0; i<slotNum; i++) {
			$(document.getElementById(CARD_BACKS[i]).firstChild.nextSibling)
				.attr({transform: ["matrix(0.5,0,0,0.5,",x+i*203.65,",-8.5)"].join("")});
		}
	},
		
	showSlots: function(slotNum) {
		var slotNum = g_aQuestions[g_nCurrentQuestion].length;
		var nFrame = {2: 0, 3: 5, 4: 10}[slotNum];
		mvn.mainMovie.sprites["3:189"].sprites["1:132"].jumpToFrame(nFrame);
	},

	createNewGame: function() {
		g_nCurrentQuestion = 0;
		g_aQuestions = GAME.generateQuestions(MODEL.nCardType, MODEL.nCardNum, MODEL.bRandomCardNum)
		console.log(g_aQuestions);

		GAME.resetCards();
		GAME.showSlots();
		//	drawCards();

		$(document.getElementById("0:3:189:38:176"))
			.find("text:first").empty().append(g_nCurrentQuestion+1);
		//==== Clear Result.
		$(document.getElementById("0:3:189:40:185:3:183"))
			.find("text:first").empty();
		$(document.getElementById("0:3:189:40:185")).toggle(MODEL.bShowAnswer);
		
		if(MODEL.bGameAutoProcess) {
			console.log(g_bAutoRunning? "stop now=========": "running now============");
			g_bAutoRunning = !g_bAutoRunning;
		}
	},


	generateQuestions: function(nCardType, nCardNum, bRandomCardNum) {
//		console.log("generateQuestions(nCardType, nCardNum, bRandomCardNum)", nCardType, nCardNum, bRandomCardNum);
		var a = [];
		var nIndexMin = nCardType == CARD_TYPE_TRAP ? 1 : 41; // in sprite 121, TRAPs are from frame 1 to 40.
		// Numbers are from frame 41 to 80.
		for (var i = 0; i < MAX_QUESTION_NUM; i++) {
			a[i] = [];
			var nSlot = bRandomCardNum ? Math.floor(Math.random() * (4 - 2 + 1) + 2) : nCardNum;

			var d = {};
			for (var j = 0; j < nSlot; j++) {
				var num = Math.floor(Math.random() * 40);
				while(typeof(d[num]) != "undefined") {
					num = Math.floor(Math.random() * 40);
				}
				d[num] = true;
				a[i].push(num + nIndexMin);
			}
		}
		return a;
	},

	removeStuffs: function() {
		//==== Remove hidden band above text.
		var a = [
			"0:59:314:80:313",
			"0:59:314:82:313",
			"0:59:314:84:313",
			"0:59:314:86:313",
			"0:59:314:88:313",
			"0:59:314:90:313",
			"0:59:314:92:313"
		
//			"0:3:189:40:185:3:183"	// text *
		];
		for(var i=0; i<a.length; i++) {
			$(document.getElementById(a[i])).hide();
		}
		
		//==== Hide unused screen.
		var a = [
	//		"0:3:189:45:188",
			SCREEN_SETTING
		];
		
		//==== Hide unused screen.
		for(var i=0; i<a.length; i++) {
			$(document.getElementById(a[i])).hide();
		}
		
		GAME.drawSettings();
	},
	initGame: function() {
		console.log("GAME.initGame");
		GAME.patchText();
		GAME.removeStuffs();
		GAME.bindEvents();
	}
};