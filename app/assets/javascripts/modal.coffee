$(document).on 'turbolinks:load', ->
  $('.modal').on 'show.bs.modal', ->
    if App.modal
      return false
    App.modal = true
    return
  $('.modal').on 'hidden.bs.modal', ->
    App.modal = false
    return
