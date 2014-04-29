#= require fragment

# Global Scope
root = exports ? this

# Namespace Object
root.SV = {}

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

  update: -> null

