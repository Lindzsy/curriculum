Open Closed Principle (OCP)
===========================

This is part of the [Designing Code](designing-code.md) material.

> "software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification";[1] that is, such an entity can allow its behaviour to be extended without modifying its source code.
-- [wikipedia](https://en.wikipedia.org/wiki/Open/closed_principle)

This usually takes the form of a big if statement / case statement,
where you will need to modify its code to add branches, when you
want to work for other similar cases.

For example, in tic tac toe, you might have an if statement to see
whether the player is human or a computer. Maybe your computer just
takes random moves, and you want to add another computer that plays
intelligently. You're going to have to go to wherever the source is
and add an additional case.

```ruby
# this code must be modified to extend its functionality
def make_move(player_type)
  if player_type == :human
    move = get_human_move()
  elsif player_type == :random_ai
    move = get_random_move()
  elsif player_type == :intelligent_ai
    move = get_intelligent_move()
  end
  make_move(move)
end
```

In terms of my design guideline, the different player types are all
coupled together, thus the code cannot be used without considering
the other player types.

The guideline is to push the integration point earlier, so rather than having
an if statement everywhere we need to deal with the player, we'll
create a class for each type of player

```ruby
# this code allows you to extend its functionality by creating a new type of player
def make_move(player)
  make_move(player.get_move)
end

class HumanPlayer
  def get_move
    # ...
  end
end

class RandomAi
  def get_move
    # ...
  end
end

class IntelligentAi
  def get_move
    # ...
  end
end

make_move(HumanPlayer.new)
```

### Practice

* Try this out on the Gilded Rose kata.

