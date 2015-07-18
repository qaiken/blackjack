class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @listenTo @model, 'flip', @unCover
    @render()

  unCover: ->
    @$el.removeClass 'covered'

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' if !@model.get 'revealed'
