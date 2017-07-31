$(document).on 'turbolinks:load', ->
  result = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.whitespace
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote:
      url: '/search?query=%QUERY'
      wildcard: '%QUERY')
  $('#search_field').typeahead null,
    source: result
    templates:
      empty: [
        '<div class="empty-message">'
        'unable to find any'
        '</div>'
      ].join('\n')
      suggestion: (result) ->
        if result.object_type == 'Album'
          """
          <a href= "#{result.url}" >
            <div class="row flex-feed">
              <div class="col-xs-3">
                #{result.object_type}
              </div>
              <div class="col-xs-9">
                #{result.title} at #{result.author}
              </div>
            </div>
          </a>
          """
        else if result.object_type == 'User'
          if !result.avatar
            result.avatar = '/avatar_empty.png'
          """
          <a href= "#{result.url}" >
            <div class="row flex-feed">
              <div class="col-xs-3">
                <img src="#{result.avatar}", class="photo-preview">
              </div>
              <div class="col-xs-9">
                #{result.author}
              </div>
            </div>
          </a>
          """
        else
          """
          <a href= "#{result.url}" >
            <div class="row flex-feed">
              <div class="col-xs-3">
                <img src="#{result.image}", class="photo-preview">
              </div>
              <div class="col-xs-9">
                #{result.object_type}
              </div>
            </div>
          </a>
          """
