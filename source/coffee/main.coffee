$content = document.getElementById 'mainvisual'

getJson = (type) ->
  xhr = new XMLHttpRequest()
  xhr.open('GET', '/api/proxy/'+type)

  xhr.onreadystatechange = () ->
    if xhr.readyState == 4 && xhr.status == 200
      gotJson(xhr.responseText)
    else if xhr.readyState == 4 && xhr.status != 200
      error(xhr.status)
    return this
  xhr.send()
  return this

gotJson = (res) ->
  data = JSON.parse res
  html = makeVimeo(data[0])
  $content.innerHTML = html
  return this

error = (e) ->
  $content.innerHTML = e

makeVimeo = (info) ->
  $content.style.width = info.width
  $content.style.height = info.height
  return '<iframe src="//player.vimeo.com/video/'+info.id+'" width="'+info.width+'" height="'+info.height+'" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>'

setLoading = (target) ->
  target.innerHTML = '<div class="spinner"><div class="bounce1"></div><div class="bounce1"></div><div class="bounce1"></div></div>'

init = ->
  $content.addEventListener "click", (e)->
    setLoading($content);
    getJson('vimeo')
    e.currentTarget.removeEventListener e.type,arguments.callee,false

init()
