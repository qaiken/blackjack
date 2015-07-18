class window.AppView extends Backbone.View
  template: _.template '
    <button class="new-game is-hidden">Play Again</button>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> 
      playerHand = @model.get('playerHand')
      playerHand.hit()
      playerHand.isBust()

    'click .stand-button': ->
      @model.get('playerHand').stand()

    'click .new-game': ->
      @model = new App()
      @initialize()

  initialize: ->
    @render()

    @listenTo(@model.get('playerHand'), 'bust', @dealerWins)
    @listenTo(@model.get('dealerHand'), 'bust', @playerWins)

    @listenTo(@model,'dealerWins', @dealerWins);

  gameOver: ->
    @$('.new-game').removeClass 'is-hidden'
    @$('.hit-button').addClass 'is-hidden' 
    @$('.stand-button').addClass 'is-hidden'

  dealerWins: ->
    @gameOver()
    @$el.prepend('<p>You Lose</p>')

  playerWins: ->
    @gameOver()
    @$el.prepend('<p>You Win</p>')

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

