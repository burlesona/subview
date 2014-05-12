# JS Manifest
# Use Sprockets to define JS load order here
#= require templates
#= require subview

window.App =
  init: ->
    @layout = new App.Layout

### LAYOUT ###
class App.Layout extends SV.Layout
  template: TPL['layout']
  initialize: ->
    @headerView = new App.HeaderView
    @contentView = new App.ContentView
    @footerView = new App.FooterView


### HEADER ###
class App.HeaderView extends SV.View
  template: TPL['header']
  tagName: 'header'
  className: 'main'


### CONTENT ###
class App.ContentView extends SV.View
  template: TPL['content']
  className: 'content-view'
  events:
    'click .mode':'setMode'

  initialize: ->
    @mode1 = new App.ModeOneView
    @mode2 = new App.ModeTwoView
    @mode3 = new App.ModeThreeView
    @currentMode = @mode1

  setMode: (event) ->
    @currentMode = this[ $(event.target).attr('id') ]
    @render()


### FOOTER ###
class App.FooterView extends SV.View
  template: TPL['footer']
  tagName: 'footer'


### MODE VIEWS ###
class App.ModeOneView extends SV.View
  template: TPL['mode1']
  tagName: 'div'
  className: 'inner'
  events:
    'click .clicky':'clicked'
  initialize: ->
    @subview1 = new App.ModeOneSubView message: "I'm subview 1", number: 1
    @subview2 = new App.ModeOneSubView message: "I'm subview 2", number: 2
  clicked: -> console.log 'You clicked mode 1'

class App.ModeTwoView extends SV.View
  template: TPL['mode2']
  tagName: 'div'
  className: 'inner'
  events:
    'click .clicky':'clicked'
  clicked: -> console.log 'You clicked mode 2'

class App.ModeThreeView extends SV.View
  template: TPL['mode3']
  tagName: 'div'
  className: 'inner'
  events:
    'click .clicky':'clicked'
  clicked: -> console.log 'You clicked mode 3'

### MODE SUBVIEWS ###
class App.ModeOneSubView extends SV.View
  template: TPL['m1subview']
  tagName: 'li'
  className: 'subview'
  events:
    'click button':'clicked'
  initialize: (options) ->
    @message = options.message
    @number = options.number
  clicked: ->
    console.log "You clicked mode 1 subview #{@number}"
