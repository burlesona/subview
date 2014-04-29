# JS Manifest
# Use Sprockets to define JS load order here

window.test = ->
  node = document.createElement('p')
  node.innerHTML = "I'm a <i>generated</i> node!"
  node.addEventListener 'click', -> console.log 'clicked!'
  frag = parser.parse strtemplate, {message: "Hello compilation!", li: "first li", node: node}
  document.body.appendChild(frag)

# NOTE: any Node inserted into the template can only happen once
# If a node is inserted a second time it will be moved, not cloned
strtemplate = """
p = this.message

p
  | one line
  | two lines
  | three lines

div == this.node

ol
  li = this.li
  li two levels

ol
  li
    b three levels
  li
    b three levels
  li
    b three levels
"""

parser =
  parse: (template,data) ->
    rawLines = @splitLines(template)
    objLines = @readLines(rawLines)
    tree = @buildObjectTree(objLines,0)
    frag = @buildDOMTree(tree,data)

  splitLines: (text) ->
    text.split(/\r?\n/)

  readLines: (lines) ->
    @readLine(line) for line in lines when line

  readLine: (string) ->
    [l,i,t,a,c] = string.match(/(\s*)([a-z\.#]*)?(\(.*\))?\s?(.*)?/)
    {indent: (i.length/2), tagName: t, attributes:a, content: c}

  buildObjectTree: (objLines,depth) ->
    out = []
    while line = objLines.shift()
      if line.indent < depth
        objLines.unshift(line)
        break
      else if line.content
        out.push line
      else
        children = @buildObjectTree(objLines,line.indent + 1)
        line.children = children if children.length
        out.push line
    out

  buildDOMTree: (objTree,data) ->
    frag = document.createDocumentFragment()
    for obj in objTree
      frag.appendChild @makeNode(obj,data)
    frag

  makeNode: (obj,data) ->
    if obj.tagName
      node = document.createElement(obj.tagName)
      if obj.content
        c = @parseContent(obj.content)
        if c.type is 'string'
          node.innerHTML = c.body
        else if c.type is 'expression'
          expr = new Function("return #{c.body}")
          node.innerHTML = expr.call(data)
        else if c.type is 'element'
          expr = new Function("return #{c.body}")
          node.appendChild expr.call(data)
      if obj.children
        node.appendChild @buildDOMTree(obj.children,data)

    else
      c = @parseContent(obj.content)
      console.log 'parse content result:',c
      if c.type is 'string'
        node = document.createTextNode c.body
      if c.type is 'expression'
        expr = new Function("return #{c.body}")
        node = document.createTextNode expr.call(data)
      else if c.type is 'element'
        expr = new Function("return #{c.body}")
        node = expr.call(data)

    console.log "MakeNode return:", node
    node

  parseContent: (content) ->
    switch
      when r = content.match(/^=\s(.*)/)
        {type: 'expression', body: r[1]}
      when r = content.match(/^==\s(.*)/)
        {type: 'element', body: r[1]}
      when r = content.match(/^\|\s(.*)/)
        {type: 'string', body: r[1]+" "}
      else
        {type: 'string', body:content}
