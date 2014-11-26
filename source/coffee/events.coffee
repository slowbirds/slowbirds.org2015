init = () ->
  json = 'gcal'
  $loading = helper.setLoading document.getElementById "events"
  helper.getJson json,gotList
  return $loading

gotList = (json) ->
  json = JSON.parse json

  # remove loading content
  helper.removeLoading($loading)
  for item in json.items
    makeView(item.start, item.summary, item.description)

makeView = (start,summary,description) ->
  # init elements
  $list = document.getElementById "events"
  $item = document.createElement "li"
  start = helper.formatDate(new Date(start.dateTime), "YYYY. MM.DD hh:mm -")

  # make summary
  $summary = document.createElement "h3"
  $summary.innerHTML = helper.htmlize("<strong>"+start + '</strong><br>' + summary)

  # make description
  $description = document.createElement "p"
  $description.classList.add("unactive")
  detail_url = description.match /(https?:\/\/[\x21-\x7e]+)/
  description = description.replace /(https?:\/\/[\x21-\x7e]+\n)/, ""
  $description.innerHTML = description.replace(/\n/,"<br>")

  # deploy elements
  $item.appendChild $summary
  $item.appendChild $description
  $list.appendChild $item

  # add events
  if detail_url != null
    $item.addEventListener "click", ()->
      window.open detail_url[0]
  $item.addEventListener "mouseover", ()->
    $description.classList.remove("unactive")
    $description.classList.add("active")
    $summary.classList.remove("active")
    $summary.classList.add("unactive")
  $item.addEventListener "mouseout", ()->
    $description.classList.remove("active")
    $description.classList.add("unactive")
    $summary.classList.remove("unactive")
    $summary.classList.add("active")
  $description.addEventListener "mouseout", ()->
    $description.classList.remove("active")
    $description.classList.add("unactive")
    $summary.classList.remove("unactive")
    $summary.classList.add("active")

$loading = init()
