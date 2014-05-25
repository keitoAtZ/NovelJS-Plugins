; Utility プラグイン v0.4.5
; keito http://keito-works.com/
;
; ＜導入すると、以下の機能が追加されます＞
; [button_hover]     マウスホバー時に、ボタンの画像を切り替えます
; [tyrano_center]    画面を、センターに表示します
; [clickable_map]    画面を、クリッカブルマップ化します
;
;
; ＜使い方＞
; 最初に、util.ksを読み込んでください。
; [call storage="util/util.ks"]
;
; ■[button_hover]
;   ボタン[button]の後に、呼び出してください
;   [button …省略…]
;   [button_hover hover="hover.png"]
;
; ■[tyrano_center]
;   画面をセンター表示します
;   [tyrano_center]
;
; ■[clickable_map]
;   クリッカブルマップを貼ります
;   [clickable_map graphic="map.png" disable=000000 target=*click]
;   終了後はクリアください
;   [clickable_map_clear]
;
;   ※クリックした値は、clickable_map.clickに格納されます
;   使用例
;   [if exp="clickable_map.click=='FF0000'"]
;     クリックしたカラーは、赤(FF0000)です。
;   [else]
;     クリックしたカラーは、[emb exp="clickable_map.click"]です。
;   [endif]
;
;
; ＜パラメータ一覧＞
; [button_hover]
;   hover (必須) : マウスホバーの画像を指定します。
;
; [tyrano_center]
;   パラメータなし。※スマホでは、あえて無効化しています
;
; [clickable_map]
;   graphic(必須): 画像を指定します。ファイルは、imageフォルダに入れて下さい。
;   disable(必須): 無効化するカラーを、Webカラー(000000やFFFFFF)で指定します。
;                   ※先頭は、#を付けない形で指定ください。(#000000 → 000000)
;   storage : ジャンプ先のシナリオファイルを指定します。
;               ※省略すると、現在のシナリオファイル内であると見なされます
;   target  : ジャンプ先のラベルを指定します。
;               ※省略すると、ファイルの先頭から実行されます
;   x       : 横位置を指定します。
;   y       : 縦位置を指定します。
;   folder  : フォルダの場所を変える場合は、指定ください。(デフォルト:image)
;
;
; ＜注意点＞
;   ティラノスクリプトVer2.92 で動作確認
;
[macro name="tyrano_center"]
[iscript]
$.getScript('./data/scenario/util/tyrano_center.js');
[endscript]
[endmacro]

[macro name="button_hover"]
[iscript]
TG.variable.tf.button_hover = TG.stat.mp.hover;
$.getScript('./data/scenario/util/button_hover.js');
[endscript]
[endmacro]

[macro name="clickable_map"]
[iscript]
TG.variable.tf.clickable_map = [];
TG.variable.tf.clickable_map.graphic = TG.stat.mp.graphic;
TG.variable.tf.clickable_map.disable = TG.stat.mp.disable;
TG.variable.tf.clickable_map.storage = TG.stat.mp.storage;
TG.variable.tf.clickable_map.target  = TG.stat.mp.target;
TG.variable.tf.clickable_map.x       = TG.stat.mp.x;
TG.variable.tf.clickable_map.y       = TG.stat.mp.y;
TG.variable.tf.clickable_map.folder  = TG.stat.mp.folder;
TG.variable.tf.clickable_map.loaded  = false;
$.getScript('./data/scenario/util/clickable_map.js');
[endscript]

*loading
[if exp="tyrano.plugin.kag.variable.tf.clickable_map.loaded==false"]
  [wait time=500]
  [jump target="*loading"]
[else]
  [jump target="*loaded"]
[endif]
[s]

*loaded
[endmacro]

[macro name="clickable_map_clear"]
[iscript]
$('.clickable_map').remove();
[endscript]
[endmacro]

[return]