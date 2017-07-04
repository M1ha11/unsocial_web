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
        title: 'Hey'
        message: data.text
        position: 'bottomRight'
        progressBarColor: 'rgb(0, 255, 184)'
        buttons: [
          [
            '<button>Ok</button>'
            (instance, toast) ->
              alert 'Hello world!'
              return
          ]
          [
            '<button>Close</button>'
            (instance, toast) ->
              instance.hide {
                transitionOut: 'fadeOutUp'
                onClose: (instance, toast, closedBy) ->
                  console.info 'closedBy: ' + closedBy
                  #btn2
                  return

              }, toast, 'close', 'btn2'
              return
          ]
        ]
        onOpen: (instance, toast) ->
          console.info 'callback abriu!'
          return
        onClose: (instance, toast, closedBy) ->
          console.info 'closedBy: ' + closedBy
          # tells if it was closed by 'drag' or 'button'
          return
