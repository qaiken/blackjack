assert = chai.assert

describe 'hand', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    
  describe 'bust', ->
    it 'should bust if score is over 21', ->
      while hand.minScore() <= 21
        hand.hit()
      assert.isTrue hand.isBust()