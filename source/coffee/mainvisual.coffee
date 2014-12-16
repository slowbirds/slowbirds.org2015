class Mainvisual

  $content = null

  constructor: (content) ->
    $content = content

  gotJson: (res) ->
    data = JSON.parse res
    html = makeVimeo data[0]
    $content.innerHTML = html
    return this

  addEvent: () ->
    json_type = 'vimeo'
    wrap = @
    $content.addEventListener "click", (e)->
      $content.innerHTML=""
      helper.setLoading $content
      helper.getJson json_type, wrap.gotJson
      e.currentTarget.removeEventListener e.type,arguments.callee,false

  error = (e) ->
    $content.innerHTML = e

  makeVimeo = (info) ->
    $content.style.width = info.width
    $content.style.height = info.height
    return '<iframe src="//player.vimeo.com/video/'+info.id+'" width="'+info.width+'" height="'+info.height+'" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>'

module.exports = Mainvisual
