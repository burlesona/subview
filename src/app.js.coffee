# JS Manifest
# Use Sprockets to define JS load order here
#= require templates
#= require subview

window.App =
  init: ->
    @layout = new App.Layout

class App.Layout extends SV.Layout
  template: TPL['test']
  initialize: ->
    @message = "Hello compilation!"
    @li = "I'm the first LI"
    @node = document.createElement('p')
    @node.innerHTML = "I'm a <i>generated</i> node!"
    @node.addEventListener 'click', -> console.log "Clicked the node!"
