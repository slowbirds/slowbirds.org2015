config = {
  'debug': true
}

$content = document.getElementById 'latest'

getJson = (type) ->
  xhr = new XMLHttpRequest()
  xhr.open('GET', '/api/'+type)

  xhr.onreadystatechange = () ->
    if xhr.readyState == 4 && xhr.status == 200
      gotJson(xhr.responseText)
    else if xhr.readyState == 4 && xhr.status != 200
      error("error")
    return this
  xhr.send()
  return this

getJson('vimeo')

gotJson = (res) ->
  data = JSON.parse res
  debug data
  html = makeVimeo(data[0])
  $content.innerHTML = html
  return this

error = (e) ->
  alert e

debug = (data) ->
  if config.debug is yes
    console.log data
  return this

makeVimeo = (info) ->
  debug info
  $content.style.width = info.width
  '<iframe src="//player.vimeo.com/video/'+info.id+'" width="'+info.width+'" height="'+info.height+'" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>'
