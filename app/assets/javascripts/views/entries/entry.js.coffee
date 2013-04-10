class Raffler.Views.Entry extends Backbone.View
  
  tagName: "li"

  template: JST['entries/entry']

  render: ->
  	$(@el).html(@template(entry: @model))
  	this