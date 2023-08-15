//ハンバーガーメニューがham(X印)を持つかどうかにより、メニューを表示するか、見えなくするか。
function db() {
	if($('#menubar_hdr').hasClass('ham')) {
		$('#menubar').addClass('db');
	} else {
		$('#menubar').removeClass('db');
	}
}


//タイマー
$(function() {
	var timer = false;
		$(window).resize(function() { //ウィンドウがリサイズされるたびに指定された関数を実行
			//タイマーがすでにセットされている場合
			if(timer !== false){
				clearTimeout(timer);
			}
				timer = setTimeout(function() {
			}, 500);
		});
});


//小さな端末、大きな端末にそれぞれクラスを振り分ける。
$(window).on("load resize", function() { //ウィンドウのイベント（ロード、リサイズ）を同時監視
	setTimeout(function() {

	var winW = window.innerWidth; //ウィンドウの現在の幅を取得
	var winBP = 900;	// ウィンドウ幅に対する判断基準を900（ブレイクポイント）として設定

		//小さな端末用
		if(winW < winBP) {
			$('body').removeClass('pc').addClass('sh');

			//大きな端末用
		} else {
			$('body').removeClass('sh').addClass('pc');
			$('#logo').show();
		}

	}, 100);
});


//開閉処理
$(function() {
	$('.openclose').next().hide();
	$('.openclose').click(function() {
		$(this).next().slideToggle();
		$('.openclose').not(this).next().slideUp();
	});
});


$(function() {
    var scroll = $('.pagetop'); //.pagetopクラスを持つ要素をscrollという変数に格納。ページトップへのスクロールボタンを表す要素
    var scrollShow = $('.pagetop-show'); //ボタンが表示される際に適用されるクラス
        $(scroll).hide(); 
        $(window).scroll(function() {
            if($(this).scrollTop() >= 300) { //ページの上端からスクロール量が300ピクセル以上かどうか判断
                $(scroll).fadeIn().addClass(scrollShow); //300ピクセル以上の場合、ボタンを表示し、scrollshowクラスを追加
            } else {
                $(scroll).fadeOut().removeClass(scrollShow); //そうではない場合、ボタンを非表示にし、scrollshowクラスを削除
            }
        });
});


//ページ内リンクのスムーズスクロール
$(window).on('load', function() { //ページのロード完了時に実行される処理を定義。ページが完全に読み込まれた後に実行
	var hash = location.hash; //URLのハッシュ部分（アンカー）を取得。ハッシュはページ内リンクの目標セクションを指定するために使用。
	if(hash) { //ページロード時に特定のアンカーリンクが指定されている場合
		$('body,html').scrollTop(0);
		setTimeout(function() {
			var target = $(hash); //ハッシュ変数に格納されているアンカー名（セクションID）を使用して、対応する要素をtargetという変数に格納
			var scroll = target.offset().top; //target要素のページ上端からの距離（オプセット）を取得
			$('body,html').animate({scrollTop:scroll},500);
		}, 100);
	}
});
$(window).on('load', function() {
    $('a[href^="#"]').click(function() { //ページ内リンクがクリックされたときに実行される
        var href = $(this).attr('href'); //クリックされた要素のhref属性の値を取得。
        var target = href == '#' ? 0 : $(href).offset().top; //トップに戻るリンクの場合、targetを0に設定、それ以外の場合はアンカー名に対応する要素のページ上端からの距離を取得。
            $('body,html').animate({scrollTop:target},500);
            return false; //リンクのクリックによるデフォルトの挙動を無効化
    });
});


//h2の中に下線用のスタイルを作る
$(function() {
	$('main h2').wrapInner('<span class="uline">'); //main要素内の全てのh2要素を選択し、新しいspan要素で囲む
});


// 同一ページへのリンクの場合に開閉メニューを閉じる処理
$(function() {
	$('#menubar a[href^="#"]').click(function() { //#menubar内のhref属性の値が、#で始まるリンクがクリックされたときに実行
		$('#menubar').removeClass('db'); //
		$('#menubar_hdr').removeClass('ham');
	});
});


//ハンバーガーメニューをクリックした際の処理
$(function() {
	$('#menubar_hdr').click(function() {
		$('#menubar_hdr').toggleClass('ham'); //menubar_hdr要素に対して、hamクラスをトグルする。トグルすることでクリックごとに、hamクラスを追加または削除する。
		db();
	});
});


//小さな端末でロゴをフェードアウトさせる
$(function() {
	var point = 100; //ロゴが消えるポイント
	$(window).scroll(function() {
		var scroll = $(window).scrollTop(); //ウィンドウの現在のスクロール位置を取得。
			if(point <= scroll) { //スクロール位置がポイントより大きか等しいかどうかを判断
				$('.sh #logo').fadeOut(); //.sh #logoというセレクタに該当する要素に対して、フェードアウト（非表示）の操作を行う。
			} else {
				$('.sh #logo').fadeIn(); //.sh #logoというセレクタに該当する要素に対して、フェードイン（表示）の操作を行う。
			}
	});
});