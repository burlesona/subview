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
    @currentMode = this[ $(event.target).attr('id') ]
    @render()


class App.FooterView extends SV.View
  template: TPL['footer']



class App.ModeOneView extends SV.View
  template: TPL['mode1']
  tagName: 'div'
  className: 'inner'
  events:
    'click':'clicked'
  clicked: -> console.log 'You clicked mode 1'

class App.ModeTwoView extends SV.View
  template: TPL['mode2']
  tagName: 'div'
  className: 'inner'
  events:
    'click':'clicked'
  clicked: -> console.log 'You clicked mode 2'

class App.ModeThreeView extends SV.View
  template: TPL['mode3']
  tagName: 'div'
  className: 'inner'
  events:
    'click':'clicked'
  clicked: -> console.log 'You clicked mode 3'
