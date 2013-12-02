var clickable_map = [];
with(tyrano.plugin.kag.variable) {
  //引き継ぎ変数
  clickable_map.graphic = tf.clickable_map.graphic;
  clickable_map.disable = tf.clickable_map.disable;
  clickable_map.storage = (tf.clickable_map.storage)? tf.clickable_map.storage : '';
  clickable_map.target  = (tf.clickable_map.target)? tf.clickable_map.target : '';
  clickable_map.x       = (tf.clickable_map.x)? tf.clickable_map.x : 0;
  clickable_map.y       = (tf.clickable_map.y)? tf.clickable_map.y : 0;
  clickable_map.folder  = (tf.clickable_map.folder)? tf.clickable_map.folder : 'image';
}

//使用変数
//clickable_map.tag = $('.layer_free');
clickable_map.tag = $('#tyrano_base');
clickable_map.cursor = 'pointer';
clickable_map.click = '';
clickable_map.canvas = '';
clickable_map.canvas_ctx = '';
clickable_map.img = new Image();
clickable_map.offsetX = '';
clickable_map.offsetY = '';
clickable_map.colorPicker = '';
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
  //tag.after('<canvas class="clickable_map" style="display:none"></canvas>');
  tag.prepend('<canvas class="clickable_map" style="position:absolute; z-index: 99999999; opacity:0;"></canvas>');

  //キャンバス取得・画像設定
  canvas = $('canvas.clickable_map:first');
  canvas_ctx = canvas.get(0).getContext('2d');
  img.src = './data/' + folder + '/' + graphic  +'?' + new Date().getTime();
  img.onload = function() {
    //位置の設定
    canvas.css({left: x + 'px', top: y + 'px'});
    canvas.attr({width:img.width, height:img.height});

    canvas_ctx.drawImage(img, 0, 0);
  }

  //マウス移動時
  canvas.on('mousemove', function(e) {
    //Firefoxの考慮;
    if (isNaN(e.offsetX) || isNaN(e.offsetY)) {
      offsetX = e.pageX - clickable_map.tag.offset().left;
      offsetY = e.pageY - clickable_map.tag.offset().top;
    } else {
      offsetX = e.offsetX;
      offsetY = e.offsetY;
    }
    colorPicker = canvas_ctx.getImageData(offsetX, offsetY, 1, 1);
    colorPicker = toHex(colorPicker.data[0]) +
      toHex(colorPicker.data[1]) +
      toHex(colorPicker.data[2]);

    if (colorPicker == disable.toUpperCase()) {
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
    if (colorPicker != disable.toUpperCase()) {
      if (target != '' && colorPicker != '') {
        tyrano.plugin.kag.ftag.startTag("jump", {storage:storage, target:target});
      }
    }
  });
}