class TicTacToe

  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def initialize(board = nil)
    @board = board || Array.new(9," ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def position_taken?(location)
    @board[location].strip != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)

    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    @board.count {|x| !x.strip.empty?}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  #For each Win Combo looks for first match else returns nil
  def won?
    WIN_COMBINATIONS.detect {|c| c.all?{|x| @board[x]=="X"} || c.all?{|x| @board[x]=="O"}}
  end

  #To determine if the board is full
  def full?
    @board.all? {|x| !x.strip.empty?}
  end

  #Determine if there is a draw on the board (fill & no winner)
  def draw?
    !won? && full?
  end

  #over? accepts a board and returns true if the board has been won, is a draw, or is full.
  def over?
    full? || won? || draw?
  end

  #winner method should accept a board and return the token, "X" or "O"
  def winner
    won? ? @board[won?[0]] : nil
  end

  #The main play loop for the game
  def play
    until over?
      turn
    end
    puts draw? ? "Cat's Game!" : "Congratulations #{winner}!"
  end
end
