# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @listenTo @get('playerHand'),'stand',@runDealer

  runDealer: ->

    playerScore = @get('playerHand').maxScore()

    @get('dealerHand').at(0).flip()

    dealerPlay = =>
      if @get('dealerHand').maxScore() <= playerScore
        @get('dealerHand').hit()
        if !@get('dealerHand').isBust()
          setTimeout dealerPlay, 1000
      else
        @trigger('dealerWins')
      
    setTimeout dealerPlay, 1000

