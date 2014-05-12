# JS Manifest
# Use Sprockets to define JS load order here
#= require templates
#= require subview

window.App =
  init: ->
    @layout = new App.Layout el: 'body'

TPL =
  header: """
    <h1>I'm a header</h1>
  """

  content: """
    <div class="view-select">
      <button id="mode1" class="mode">Mode 1</button>
      <button id="mode2" class="mode">Mode 2</button>
      <button id="mode3" class="mode">Mode 3</button>
    </div>
    <div class="inner">
    </div>
  """

  footer: """
    I'm the footer
  """

  mode1: """
    <p>
      I am mode 1
      <button class="clicky">Click Me</button>
    </p>
    <p>I have subviews too:</p>
    <ul class="subviews">
    </ul>
  """

  mode2: """
    <p>
      I am mode 2
      <button class="clicky">Click Me</button>
    </p>
  """

  mode3: """
    <p>
      I am mode 3
      <button class="clicky">Click Me</button>
    </p>
  """

  m1subview: """
    <%= message %>
    <button>Click me!</button>
  """

### LAYOUT ###
class App.Layout extends Backbone.View
  initialize: ->
    @headerView = new App.HeaderView
    @contentView = new App.ContentView
    @footerView = new App.FooterView
    @render()

  render: ->
    @$el.empty()
    @$el.append @headerView.render().el
    @$el.append @contentView.render().el
    @$el.append @footerView.render().el
    this

### HEADER ###
class App.HeaderView extends Backbone.View
  template: _.template(TPL['header'])
  tagName: 'header'
  className: 'main'
  render: ->
    @$el.html @template(this)
    this


### CONTENT ###
class App.ContentView extends Backbone.View
  template: _.template(TPL['content'])
  className: 'content-view'
  events:
    'click .mode':'setMode'

  initialize: ->
    @mode1 = new App.ModeOneView
    @mode2 = new App.ModeTwoView
    @mode3 = new App.ModeThreeView
    @currentMode = @mode1
    console.log 'init contentview with currentMode:',@currentMode

  render: ->
    @$el.html @template(this)
    @currentMode.setElement(@$('.inner')).render()
    this

  setMode: (event) ->
    @currentMode = this[ $(event.target).attr('id') ]
    @render()


### FOOTER ###
class App.FooterView extends Backbone.View
  template: _.template(TPL['footer'])
  tagName: 'footer'
  render: ->
    @$el.html @template(this)
    this


### MODE VIEWS ###
class App.ModeOneView extends Backbone.View
  template: _.template(TPL['mode1'])
  tagName: 'div'
  className: 'inner'
  events:
    'click .clicky':'clicked'
  initialize: ->
    @subview1 = new App.ModeOneSubView message: "I'm subview 1", number: 1
    @subview2 = new App.ModeOneSubView message: "I'm subview 2", number: 2

  render: ->
    @$el.html @template(this)
    @$('.subviews').append @subview1.render().el
    @$('.subviews').append @subview2.render().el
    @subview1.delegateEvents()
    @subview2.delegateEvents()
    this

  clicked: -> console.log 'You clicked mode 1'

class App.ModeTwoView extends Backbone.View
  template: _.template(TPL['mode2'])
  tagName: 'div'
  className: 'inner'
  events:
    'click .clicky':'clicked'

  render: ->
    @$el.html @template(this)
    this

  clicked: -> console.log 'You clicked mode 2'

class App.ModeThreeView extends Backbone.View
  template: _.template(TPL['mode3'])
  tagName: 'div'
  className: 'inner'
  events:
    'click .clicky':'clicked'

  render: ->
    @$el.html @template(this)
    this

  clicked: -> console.log 'You clicked mode 3'

### MODE SUBVIEWS ###
class App.ModeOneSubView extends Backbone.View
  template: _.template(TPL['m1subview'])
  tagName: 'li'
  className: 'subview'
  events:
    'click button':'clicked'
  initialize: (options) ->
    @message = options.message
    @number = options.number

  render: ->
    @$el.html @template(this)
    this

  clicked: ->
    console.log "You clicked mode 1 subview #{@number}"
