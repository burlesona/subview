Fragment / Subview
==================

A thought experiment, in progress.

Two ideas:

1. When building client-side templates, what if you generated actual dom nodes, instead
   of just strings.

2. If you had a templating language that generated dom nodes instead of strings,
   how much nicer could your view models be, and how much easier would it be to
   manage trees of subviews?

## The Experiment

This project has a few simple files:

- **fragment.js.coffee:** a simple template parser that reads a slim-like syntax and converts it to document fragments.
- **templates.js.coffee:** some barebones templates stored as coffeescript strings.
- **subview.js.coffee:** two minimal base models, one for layouts, one for views, emulating Backbone.View, but designed to use fragment templates.
- **app.js.coffee:** a very basic demo app to test the view/template relationship.

The main neat thing about this project is the ability of a layout or parent view to define subviews
in the templates themselves, and to only declare events once. In the template, this is accomplished via the `==` directive.
In most templating systems using `==` (or similar) means "don't escape this HTML". In fragment, it means: "this will return a dom node".
The dom node that gets returned is added to the template in place.

## Setup

This project has a simple rack file that uses Sprockets to compile CoffeeScript
for quick and easy experimentation.

To use it:

1. Clone the repo into a directory
2. `bundle`
3. `rackup`
