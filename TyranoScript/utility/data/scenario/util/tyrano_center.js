var tyrano_center = {
  uAgent  : navigator.userAgent.toLowerCase(),
  tDisplay: ''
};
with(tyrano_center) {
  if (uAgent.indexOf("phone") == -1 && uAgent.indexOf("ipad") == -1 && uAgent.indexOf("android") == -1) {
    tDisplay = {
      center: function() {
        $("#tyrano_base").css({
          "top": ($(window).height() - $("#tyrano_base").height()) / 2,
          "left":  ($(window).width() - $("#tyrano_base").width()) / 2
        });
      }
    };
    tDisplay.center();
    $(window).resize(function(){
      tDisplay.center();
    });
  }
}