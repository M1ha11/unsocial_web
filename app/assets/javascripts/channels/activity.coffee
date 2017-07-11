$(document).on 'turbolinks:load', ->
  return if App.activity
  App.activity = App.cable.subscriptions.create "ActivityChannel",
    connected: ->

    disconnected: ->

    received: (data) ->
      console.log(data)
      iziToast.show
        color: 'dark'
        icon: 'icon-person'
        image: data.avatar
        title: data.name
        message: data.text
        position: 'bottomRight'
        progressBarColor: 'rgb(0, 255, 184)'
        buttons: [
          [
            '<button>Ok</button>'
            (instance, toast) ->
              window.open data.url
              return
          ]
        ]
