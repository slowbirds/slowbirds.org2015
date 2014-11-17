(function() {
  var $content, config, debug, error, getJson, gotJson, makeVimeo, setLoading;

  config = {
    'debug': true
  };

  $content = document.getElementById('mainvisual');

  getJson = function(type) {
    var xhr;
    xhr = new XMLHttpRequest();
    xhr.open('GET', '/api/proxy/' + type);
    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4 && xhr.status === 200) {
        gotJson(xhr.responseText);
      } else if (xhr.readyState === 4 && xhr.status !== 200) {
        error(xhr.status);
      }
      return this;
    };
    xhr.send();
    return this;
  };

  $content.addEventListener("click", function(e) {
    setLoading($content);
    getJson('vimeo');
    return e.currentTarget.removeEventListener(e.type, arguments.callee, false);
  });

  gotJson = function(res) {
    var data, html;
    data = JSON.parse(res);
    debug(data);
    html = makeVimeo(data[0]);
    $content.innerHTML = html;
    return this;
  };

  error = function(e) {
    debug(e);
    return $content.innerHTML = e;
  };

  debug = function(data) {
    if (config.debug === true) {
      console.log(data);
    }
    return this;
  };

  makeVimeo = function(info) {
    debug(info);
    $content.style.width = info.width;
    $content.style.height = info.height;
    return '<iframe src="//player.vimeo.com/video/' + info.id + '" width="' + info.width + '" height="' + info.height + '" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>';
  };

  setLoading = function(target) {
    return target.innerHTML = '<div class="spinner"><div class="bounce1"></div><div class="bounce1"></div><div class="bounce1"></div></div>';
  };

}).call(this);
