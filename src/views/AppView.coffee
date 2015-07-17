class window.AppView extends Backbone.View
  template: _.template '
    <button class="new-game is-hidden">Play Again</button>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> 
      @model.get('playerHand').hit()
      if _(@model.get('playerHand').scores()).min() > 21
        @gameOver()

    'click .stand-button': ->
      @model.get('playerHand').stand()

    'click .new-game': ->
      @model = new App()
      @render()

  initialize: ->
    @render()

  gameOver: ->
    @$('.new-game').removeClass 'is-hidden'
    @$('.hit-button').addClass 'is-hidden' 
    @$('.stand-button').addClass 'is-hidden'

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

