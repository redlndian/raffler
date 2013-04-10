class Raffler.Views.EntriesIndex extends Backbone.View

  template: JST['entries/index']

  events:
  	"submit #new_entry": "createEntry"

  initialize: ->
  	@collection.on('reset', @render, this)
  	@collection.on('add', @render, this)

  render: ->
  	$(@el).html(@template())
  	@collection.each(@appendEntry)
  	this

  appendEntry: (entry) ->
  	view = new Raffler.Views.Entry(model: entry)
  	$('#entries').append(view.render().el)

  createEntry: (event) ->
  	event.preventDefault()
  	attributes = name: $('#new_entry_name').val()
  	@collection.create attributes,
  	  wait: true
  	  success: -> $('#new_entry_name').val('')
  	  error: @handleError

  handleError: (entry, response) ->
  	if response.status == 422
  		errors = $.parseJSON(response.responseText).errors
  		for attribute, messages of errors
  			alert "#{attribute} #{message}" for message in messages