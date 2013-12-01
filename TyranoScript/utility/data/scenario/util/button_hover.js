var button_hover = {};
button_hover.tag = $('.layer_free img[style*=cursor]:last');
button_hover.src = button_hover.tag.attr('src');
button_hover.hover = button_hover.src.split("/").reverse().slice(1).reverse().join("/");
button_hover.hover += '/' + tyrano.plugin.kag.variable.tf.button_hover;

with(button_hover) {
  tag.on('mouseenter', function() {
    tag.attr('src', hover);
  });
  tag.on('mouseleave', function() {
    tag.attr('src', src);
  });
}