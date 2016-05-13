class Products

  $loading = null
  $target = null

  constructor: ()->
    return @

  getList: ($target) ->
    par = this
    url ="/api/getLatestProducts"
    $loading = helper.setLoading $target
    helper.getJson url,par.gotList
    return $loading

  gotList: (json) ->
    json = JSON.parse json

    # remove loading content
    helper.removeLoading($loading)
    for item in json
      makeView({
        'title'     : item.title,
        'date'      : item.date,
        'timestamp' : item.timestamp,
        'url'       : item.url,
        'desc'      : item.desc,
        'thumbnail' : item.thumbnail,
        'tags'      : item.tags,
        'channel'   : item.channel
      })

  makeView = (info) ->
    #console.log info
    # init elements
    $list = document.getElementById "products"
    $item = document.createElement "li"
    $item.style.backgroundImage = "url(#{info.thumbnail})"

    $content = document.createElement "div"
    $content.className = "productsContent"

    # make summary
    $summary = document.createElement "h3"
    $summary.innerHTML = info.title

    # make description
    $description = document.createElement "p"
    if info.thumbnail != null
      description = "#{info.channel}"
      $description.innerHTML = description
    else
      description = ""

    $item.addEventListener "click", ()->
      location.href="#{info.url}"

    # deploy elements
    $content.appendChild $summary
    $content.appendChild $description
    $item.appendChild $content
    $list.appendChild $item

module.exports = Products
