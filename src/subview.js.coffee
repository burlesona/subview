#= require fragment

# Global Scope
root = exports ? this

# Namespace Object
root.SV = {}

# One Layout per application. This view behaves the same as others,
# except that it does not have a root node. Rather it appends its
# view to the document body.

class SV.Layout
  template: null
  constructor: ->
    @initialize()
    @render()

  render: ->
    if @template
      frag = Fragment.parse(@template,this)
      document.body.appendChild(frag)
    else
      throw "#{@constructor.name} invalid: template required"


class SV.View
  tagName: 'div'
  className: null
  template: null
  events: null
  constructor: ->
    @setNode()
    @initialize()
    @setEvents()
    @render()

  setNode: ->
    @node = document.createElement @tagName
    @node.className = @className if @className

  initialize: -> null

  setEvents: ->
    if @events
      for estring,fname of @events
        fn = this[fname].bind(this)
        [s,evt,selector] = estring.match(/^(\S+)\s*(.*)$/)
        if selector
          $(@node).on evt, selector, fn
        else
          $(@node).on evt, fn

  render: ->
    @node.innerHTML = ""
    if @template
      frag = Fragment.parse(@template,this)
      @node.appendChild(frag)
    else
      throw "#{@constructor.name} invalid: template required"
