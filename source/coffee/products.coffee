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
    console.log info
    # init elements
    $list = document.getElementById "products"
    $item = document.createElement "li"

    # make summary
    $summary = document.createElement "h3"
    $summary.innerHTML = info.title

    # make description
    $description = document.createElement "p"
    if info.thumbnail != null
      description = "<a href='#{info.url}'><img src='#{info.thumbnail}'></a>"
      $description.innerHTML = description
    else
      description = "";

    # deploy elements
    $item.appendChild $summary
    $item.appendChild $description
    $list.appendChild $item

module.exports = Products
