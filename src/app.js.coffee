# JS Manifest
# Use Sprockets to define JS load order here
#= require templates
#= require subview

window.App =
  init: ->
    @layout = new App.Layout



class App.Layout extends SV.Layout
  template: TPL['layout']
  initialize: ->
    @headerView = new App.HeaderView
    @contentView = new App.ContentView
    @footerView = new App.FooterView



class App.HeaderView extends SV.View
  template: TPL['header']


class App.ContentView extends SV.View
  template: TPL['content']
  events:
    'click .mode':'setMode'

  initialize: ->
    @mode1 = new App.ModeOneView
    @mode2 = new App.ModeTwoView
    @mode3 = new App.ModeThreeView
    @currentMode = @mode1

  setMode: (event) ->
    mode = $(event.target).attr('id')
    console.log 'setMode event:',mode
    @currentMode = this[mode]
    @render()


class App.FooterView extends SV.View
  template: TPL['footer']



class App.ModeOneView extends SV.View
  template: TPL['mode1']
  events:
    'click':'clicked'
  clicked: -> console.log 'You clicked mode 1'

class App.ModeTwoView extends SV.View
  template: TPL['mode2']
  events:
    'click':'clicked'
  clicked: -> console.log 'You clicked mode 2'

class App.ModeThreeView extends SV.View
  template: TPL['mode3']
  events:
    'click':'clicked'
  clicked: -> console.log 'You clicked mode 3'
