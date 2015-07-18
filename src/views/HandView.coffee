class window.HandView extends Backbone.View

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2><div class="hand"></div>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$('.score').text @collection.scores()[0]
    @$('.hand').append @collection.map (card) ->
      new CardView(model: card).$el

