assert = chai.assert

describe "blackjack view", ->

  view = null

  beforeEach ->
    view = new AppView(model: new App());

  it "should have a player hand with two cards", ->
    assert(view.$el.find('.player-hand-container').children().length,2);

  it "should have a dealer hand with two cards", ->
    assert(view.$el.find('.dealer-hand-container').children().length,2);
    