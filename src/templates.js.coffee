# NOTE: any Node inserted into the template can only happen once
# If a node is inserted a second time it will be moved, not cloned
window.TPL =
  layout: """
    == @headerView.node
    == @contentView.node
    == @footerView.node
    """

  header: """
    header.main
      h1 I'm a header
    """

  content: """
    .content_view
      .view-select
        button#mode1.mode Mode 1
        button#mode2.mode Mode 2
        button#mode3.mode Mode 3
      == @currentMode.node
    """

  footer: """
    .footer
      | I'm the footer
    """

  mode1: """
    p
      ' I am mode 1
      button.clicky Click Me
    p
      ' I have subviews too:'
    ul
      == @subview1.node
      == @subview2.node
    """

  mode2: """
    p
      ' I am mode 2
      button.clicky Click Me
    """

  mode3: """
    p
      ' I am mode 3
      button.clicky Click Me
    """

  m1subview: """
    = @message
    button Click me!
    """

