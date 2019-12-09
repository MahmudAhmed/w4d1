require_relative 'tic_tac_toe'
require "byebug"
class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def children
    # debugger
    children = []
    (0..2).each do |i| 
      (0..2).each do |j| 
        if self.board.empty?([i,j])
          pos = [i,j]
          new_board = board.dup
          new_board[pos] = next_mover_mark
          # next_mover_mark = (next_mover_mark == :x ? (:o) : (:x))
          next_mover_mark == :x ? next_mover_mark = :o : next_mover_mark = :x

          children << TicTacToeNode.new(new_board,next_mover_mark, pos)
        end
      end
    end
    children
      
  end

  def losing_node?(evaluator) #:x
     if board.over?
      return board.winner != evaluator && board.winner != nil
    end
    # if board.winner != evaluator && board.won? # do we need to cvall board.over?
    #   return true 
    # end
     

    if next_mover_mark == evaluator
      self.children.all? do |node|
        node.losing_node?(evaluator)
      end
    else 
      self.children.any? do |node|
        node.losing_node?(evaluator)
      end
    end
  end

  def winning_node?(evaluator) :X
    # debugger
    if board.over?
      return board.winner == evaluator 
    end
     
    if next_mover_mark == evaluator
      self.children.any? do |node|
        node.winning_node?(evaluator)
      end
    else 
      self.children.all? do |node|
        node.winning_node?(evaluator)
      end
    end

  end
  

  # This method generates an array of all moves that can be made after
  # the current move.
  # def children
  # end
end

