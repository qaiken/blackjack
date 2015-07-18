# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @listenTo @get('playerHand'),'stand',@runDealer
    @listenTo @get('playerHand'), 'bust', -> @trigger 'dealerWins'
    @listenTo @get('dealerHand'), 'bust', -> @trigger 'playerWins'

  runDealer: ->
    @get('dealerHand').at(0).flip()

    dealerPlay = =>
      if @get('dealerHand').minScore() < 17
        @get('dealerHand').hit()
        if !@get('dealerHand').isBust()
          setTimeout dealerPlay, 1000
      else
        @findWinner()
      
    setTimeout dealerPlay, 1000

  findWinner: ->
    playerScore = @get('playerHand').maxScore()
    dealerScore = @get('dealerHand').minScore()
    if dealerScore > playerScore
      @trigger 'dealerWins'
    else if dealerScore == playerScore
      @trigger 'tie'
    else
      @trigger 'playerWins'
