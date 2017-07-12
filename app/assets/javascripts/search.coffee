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
          '<p><strong>' + result.object_type + '</strong> – ' + result.title + '</p>'
        else if result.object_type == 'User'
          '<p><strong>' + result.object_type + '</strong> – ' + result.full_name + '</p>'
        else
          '<p><strong>' + result.object_type + '</strong> – ' + result.description + '</p>'
