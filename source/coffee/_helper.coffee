@helper = ->
  return this

helper.getJson = (type,cb) ->
  xhr = new XMLHttpRequest()
  xhr.open('GET', '/api/proxy/'+type)

  xhr.onreadystatechange = () ->
    if xhr.readyState == 4 && xhr.status == 200
      cb(xhr.responseText)
    else if xhr.readyState == 4 && xhr.status != 200
      error(xhr.status)
    return this

  xhr.send()
  return this

helper.htmlize = (str) ->
  str = str.replace /\n/gi,'<br>'
  str = str.replace /(https?:\/\/[\x21-\x7e]+)/gi, "<a href=$1>$1</a>"
  str = str.replace /&/gi,'&amp;'
  str = str.replace /\"/gi, '&quote'
  return str

helper.formatDate = (date, format) ->
  if format is no
    format = 'YYYY-MM-DD hh:mm:ss.SSS'

  format = format.replace /YYYY/g, date.getFullYear()
  format = format.replace /MM/g, ('0' + (date.getMonth() + 1)).slice(-2)
  format = format.replace /DD/g, ('0' + date.getDate()).slice(-2)
  format = format.replace /hh/g, ('0' + date.getHours()).slice(-2)
  format = format.replace /mm/g, ('0' + date.getMinutes()).slice(-2)
  format = format.replace /ss/g, ('0' + date.getSeconds()).slice(-2)

  if format.match(/S/g) is yes
    milliSeconds = ('00' + date.getMilliseconds()).slice(-3)
    length = format.match(/S/g).length
    for i in length
      format = format.replace /S/, milliSeconds.substring(i, i + 1)

  return format

helper.setLoading = ($target) ->
  $loading = document.createElement "div"
  $loading.classList.add "spinner"
  $loading.innerHTML = '<div class="bounce1"></div><div class="bounce1"></div><div class="bounce1"></div>'
  $target.appendChild $loading
  return $loading

helper.removeLoading = ($target) ->
  $parent = $target.parentNode
  $parent.removeChild $target
