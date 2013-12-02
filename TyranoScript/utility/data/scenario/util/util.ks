; Utility プラグイン v0.4
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
;   ティラノスクリプトVer2.91 で動作確認
;
[macro name="tyrano_center"]
[iscript]
$.getScript('./data/scenario/util/tyrano_center.js');
[endscript]
[endmacro]

[macro name="button_hover"]
[iscript]
with(tyrano.plugin.kag) {
  variable.tf.button_hover = stat.mp.hover;
}
$.getScript('./data/scenario/util/button_hover.js');
[endscript]
[endmacro]

[macro name="clickable_map"]
[iscript]
with(tyrano.plugin.kag) {
  variable.tf.clickable_map = [];
  variable.tf.clickable_map.graphic = stat.mp.graphic;
  variable.tf.clickable_map.disable = stat.mp.disable;
  variable.tf.clickable_map.storage = stat.mp.storage;
  variable.tf.clickable_map.target  = stat.mp.target;
  variable.tf.clickable_map.x       = stat.mp.x;
  variable.tf.clickable_map.y       = stat.mp.y;
  variable.tf.clickable_map.folder  = stat.mp.folder;
}
$.getScript('./data/scenario/util/clickable_map.js');
[endscript]
[endmacro]

[macro name="clickable_map_clear"]
[iscript]
$('.clickable_map').remove();
[endscript]
[endmacro]

[return]