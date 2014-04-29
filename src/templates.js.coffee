# NOTE: any Node inserted into the template can only happen once
# If a node is inserted a second time it will be moved, not cloned
window.TPL =
  test: """
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
