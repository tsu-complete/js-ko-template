
(( factory ) ->
  if "function" is typeof define and define.amd
    define ["knockout"], factory
  else if "undefined" isnt typeof module
    factory require "knockout"
  else
    factory window.ko
) ( ko ) ->

  ##
  # knockout base object
  # @namespace ko

  ##
  # class storage in ko object
  # @memberof ko
  # @class TemplateEngine
  class ko.TemplateEngine extends ko.nativeTemplateEngine

    ##
    # convenience wrapper for setting template engine in ko
    # @return {Object} constructed template engine
    @use: ->
      engine = new ko.TemplateEngine
      ko.setTemplateEngine engine
      return engine

    ##
    # invoke super and create templates registry
    constructor: ( ) ->
      super

      @_templates = { }

    ##
    # register a template
    # @param {String} name where to store template,
    # leave undefined for a shallow template (only pay attention to children)
    # @param {String|Element} template what to turn into an optimized template
    register: ( name, template, parent ) ->
      parent ?= @_templates
      unless template instanceof Element
        temp = document.createElement "template"
        temp.innerHTML = template
        template = temp

      parent[name] = new ko.templateSources.domElement template if name

      for child in template.children
        if "template" is ko.utils.tagNameLower child
          template.removeChild child
          @register (child.getAttribute "name"), child,
          if name then parent[name] else parent

      undefined

    ##
    # overridden from ko.templateEngine, not meant to be invoked externally
    makeTemplateSource: ( template ) ->
      if "string" is typeof template
        result = @_templates[template]

        unless result
          result = @_templates

          for property in template.split "."
            result = result[property]
            break unless result

      unless result
        result = super

        # cache to stop ko from dom crawling every time
        if "string" is typeof template
          @_templates[template] = result

      return result

