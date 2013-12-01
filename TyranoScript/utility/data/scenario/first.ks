[call storage="tyrano.ks"]
[call storage="util/util.ks"]
[tyrano_center]

[image storage="rouka.jpg" page=fore layer=base]
;[jump target=*clickable_map]

ユーティリティプラグインのサンプルへようこそ。[l][r]
こちらはサンプル版です。[l][r]
まだ、バグチェック中な点に、ご注意ください。[l]

[cm]
まず、マウスホバー(ユーティリティ)ですが[l][r]
使用すると「マウスホバー時のボタン切り替え」が簡単になります。

[button graphic="next.png" x=200 y=200 target=*clickable_map]
[button_hover hover="next_hover.png"]
[s]

*clickable_map
[cm]
次に、クリッカブルマップですが[l][r]
使用すると「全画面がクリッカブルマップ化」します。[r][l]
[r]
選択できるのは、ドア、通路、通路奥です。

[back storage="rouka_map.jpg" time=1000]
[clickable_map graphic="rouka_color_map.png" disable=040404 target=*click folder=bgimage]
[s]

*click
[back storage="rouka.jpg" time=100]
[clickable_map_clear]

[cm]
[if exp="clickable_map.click=='FF9999'"]
ドアをクリックしました。[l][r]
[elsif exp="clickable_map.click=='99FF99'"]
廊下をクリックしました。[l][r]
[else]
通路奥をクリックしました。[l][r]
[endif]
クリックしたカラーは、[emb exp="clickable_map.click"]です。[l][r]
[r]

もう一度、クリッカブルマップへ移動します。[l]
[jump target=*clickable_map]
[s]