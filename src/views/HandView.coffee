class window.HandView extends Backbone.View

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2><div class="hand"></div>'

  initialize: ->
    @listenTo @collection, 'add', @addNewCard
    @listenTo @collection, 'flip', @updateScore
    @render()

  updateScore: ->
    minScore = @collection.scores()[0]
    maxScore = @collection.scores()[1]

    if @collection.isDealer
      score = minScore
    else
      score = maxScore
      if minScore != maxScore
        if maxScore <= 21
          score = minScore + ' or ' + maxScore
        else
          score = minScore

    @$('.score').text score

  addNewCard: (card) ->
    @$('.hand').append(new CardView(model: card).$el)
    @updateScore()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @updateScore()
    @$('.hand').append @collection.map (card) ->
      new CardView(model: card).$el

