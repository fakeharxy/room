var showText = function (target, message, index, interval) {
  if (index < message.length) {
    $(target).append(message[index++]);
    setTimeout(function () { showText(target, message, index, interval); }, interval);
  }
  else {
    $(target).append('<span class="blinking-cursor">|</span>');
  }
}

$(function () {
  showText("#msg", "Real-time reading, writing and learning", 0, 100);

});
