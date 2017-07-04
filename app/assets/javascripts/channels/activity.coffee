$(document).on 'turbolinks:load', ->
  App.activity = App.cable.subscriptions.create "ActivityChannel",
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      console.log(data)

      # Called when there's incoming data on the websocket for this channel
      # iziToast.success
      #   title: 'New comment!'
      #   message: data.text
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
