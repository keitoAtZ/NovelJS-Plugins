; クリッカブルマップ プラグイン v0.5.1
; keito http://keito-works.com/
;
; ＜導入すると、以下の機能が追加されます＞
; [clickable_map]    画面を、クリッカブルマップ化します
;
;
; ＜使い方＞
; 最初に、util.ksを読み込んでください。
; [call storage="clickable_map/clickable_map.ks"]
;
; ■[clickable_map]
;   クリッカブルマップを貼ります
;   [clickable_map graphic=rouka_map.png target=*click]
;
;   終了後はクリアください
;   [clickable_map_clear]
;
;
; ※クリックした値は、clickable_map.clickに格納されます
; ＜使用例＞
;   [bg storage=rouka.jpg time=100]
;   [clickable_map graphic=rouka_map.png target=*click]
;   [s]
;   *click
;   [if exp="clickable_map.click=='0000FF'"]
;     クリックしたカラーは、青(0000FF)です。
;   [else]
;     クリックしたカラーは、[emb exp="clickable_map.click"]です。
;   [endif]
;   [clickable_map_clear]
;
;
; ＜パラメータ一覧＞
; [clickable_map]
;   graphic(必須): 画像を指定します。ファイルは、bgimageフォルダに入れて下さい。
;                  (画像は、着色部分がクリック領域になります。透明部分はクリック無効領域になります。)
;   visible : 非表示にする場合は、falseを指定します。(デフォルト:true)
;   storage : ジャンプ先のシナリオファイルを指定します。
;               ※省略すると、現在のシナリオファイル内であると見なされます
;   target  : ジャンプ先のラベルを指定します。
;               ※省略すると、ファイルの先頭から実行されます
;   folder  : フォルダの場所を変える場合は、指定ください。(デフォルト:bgimage)
;
;
; ＜注意点＞
;   ティラノスクリプトVer4.02 で動作確認
;
[macro name="clickable_map"]
[iscript]
clickable_map = [];
//引き継ぎ変数
clickable_map.graphic = mp.graphic;
clickable_map.visible = (mp.visible)? false : true;
clickable_map.storage = (mp.storage)? mp.storage : '';
clickable_map.target  = (mp.target)? mp.target : '';
clickable_map.folder  = (mp.folder)? mp.folder : 'bgimage';

//使用変数
clickable_map.base = $('#tyrano_base');
clickable_map.disable = '000000';
clickable_map.x       = (mp.x)? mp.x : 0;
clickable_map.y       = (mp.y)? mp.y : 0;
clickable_map.cursor = 'pointer';
clickable_map.click = '';
clickable_map.canvas = '';
clickable_map.canvas_ctx = '';
clickable_map.img = new Image();
clickable_map.offsetX = '';
clickable_map.offsetY = '';
clickable_map.colorPicker = '';
clickable_map.imageData = '';
clickable_map.toHex = function(n) {
  n = parseInt(n,10);
  if (isNaN(n)) {
    return "00";
  }
  n = Math.max(0,Math.min(n,255));
  return "0123456789ABCDEF".charAt((n-n%16)/16) + "0123456789ABCDEF".charAt(n%16);
}

with(clickable_map) {
  //キャンバス追加
  base.prepend('<canvas class="clickable_map" style="position:absolute; z-index: 100000001;"></canvas>');
  if(!visible) {
    $('.clickable_map').css('opacity', 0);
  }

  //キャンバス取得・画像設定
  canvas = $('canvas.clickable_map:first');
  canvas_ctx = canvas.get(0).getContext('2d');
  img.src = './data/' + folder + '/' + graphic  +'?' + new Date().getTime();
  img.onload = function() {
    //位置の設定
    canvas.css({left: x + 'px', top: y + 'px'});
    canvas.attr({width:img.width, height:img.height});

    canvas_ctx.drawImage(img, 0, 0, $('.base_fore').width(), $('.base_fore').height());

    //マウス移動時
    canvas.on('mousemove', function(e) {
      //Firefoxの考慮;
      if (isNaN(e.offsetX) || isNaN(e.offsetY)) {
        offsetX = e.pageX - base.offset().left;
        offsetY = e.pageY - base.offset().top;
      } else {
        offsetX = e.offsetX;
        offsetY = e.offsetY;
      }
      imageData = canvas_ctx.getImageData(offsetX, offsetY, 1, 1).data;
      colorPicker = toHex(imageData[0]) +
        toHex(imageData[1]) +
        toHex(imageData[2]);
      if (colorPicker == disable.toUpperCase() && imageData[3] == 0) {
        //無効カラーの場合、カーソルクリアする
        if (canvas.css('cursor') == cursor) {
          canvas.css('cursor', '');
        }
      } else {
        //不透明の場合、カーソル設定する
        if (canvas.css('cursor') != cursor) {
          canvas.css('cursor', cursor);
        }
      }
    });

    //マウスアウト時
    canvas.on('mouseout', function(e) {
      //元に戻す
      canvas.css('cursor', '');
    });

    //クリック時
    canvas.on('click', function() {
      clickable_map.click = colorPicker;
      if (colorPicker != disable.toUpperCase() && imageData[3] != 0) {
        if (target != '' && colorPicker != '') {
          TG.kag.ftag.startTag("jump", {storage:storage, target:target});
        }
      }
    });
  }
}
[endscript]

[endmacro]

[macro name="clickable_map_clear"]
[iscript]
$('.clickable_map').remove();
[endscript]
[endmacro]

[return]