
js-ko-template [![LICENSE](https://img.shields.io/github/license/tsu-complete/js-ko-template.svg)](https://github.com/tsu-complete/js-ko-template/blob/master/LICENSE)
===
[![Dependencies](https://david-dm.org/tsu-complete/js-ko-template.svg)](https://david-dm.org/tsu-complete/js-ko-template)
[![Dev Dependencies](https://david-dm.org/tsu-complete/js-ko-template/dev-status.svg)](https://david-dm.org/tsu-complete/js-ko-template#info=devDependencies)

> template engine for knockout

Install
---

```sh
$ npm i --save tsu-complete/js-ko-template

# --or--

$ bower i --save tsu-complete/js-ko-template
```

Usage
---

### To extend

```coffee
TemplateEngine = require "ko-template"

class MyTemplateEngine extends TemplateEngine

  constructor: ->
    super

    # code ...
```

### To use

#### Option 1

```coffee
TemplateEngine = require "ko-template"

ko.setTemplateEngine new TemplateEngine
```

#### Option 2

```coffee
ko.setTemplateEngine new ko.TemplateEngine
```

#### Option 3

```coffee
do ko.TemplateEngine.use
```

### Templates

> nodes or strings, can have nested templates

```jade
//- flat.jade
span konnichiha sekai!
span(data-bind="text:$data")
```

```jade
//- nested.jade
template(name="first")
  // ko template: "first.person"
  // /ko

  template(name="person")
    span(data-bind="text:name")

template(name="second")
  // ko template: {name:"first.person", with: {name:$data}}
  // /ko
```

```coffee
engine = do ko.TemplateEngine.use

engine.register "hello", require "./flat.jade"

engine.register undefined, require "./nested.jade"
```
