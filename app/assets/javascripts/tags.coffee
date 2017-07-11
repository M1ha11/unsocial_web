$(document).on 'turbolinks:before-cache', ->
  $('#tags').select2 'destroy'

$(document).on "turbolinks:load", ->
  return unless $('#tags').length
  $('#tags').empty()
  $("#tags").select2
    minimumInputLength: 1
    theme: "bootstrap"
    tags: true
    allowClear: true
    tokenSeparators: [',', ' ']
    ajax:
      url: '/tag_search'
      delay: 250
      dataType: 'json'
      cache: true
      processResults: (data, params) ->
        results: data.map (tag) ->
          { id: tag.id, text: tag.content }


