require './lib/notation_utils'
require './lib/piece'
require './lib/queen'

describe Queen do
  describe '#pseudo_move?' do
    let(:board) { double('Board') }
    let(:queen_data) { { color: 'white', pos: [3, 4] } }
    subject(:queen) { described_class.new(board, **queen_data) }
    let(:enemy_piece) { double('Piece') }
    let(:ally_piece) { double('Piece') }

    before do
      allow(board).to receive(:at).and_return(nil)
      allow(enemy_piece).to receive(:color).and_return('black')
      allow(ally_piece).to receive(:color).and_return('white')
    end

    before :example do
      queen.update_pseudo_moves
    end

    context 'when the move is d6' do
      it 'include the move in the array of moves' do
        coordinate = [3, 2]
        pseudo_moves = queen.pseudo_move?(coordinate)
        expect(pseudo_moves).to be true
      end
    end

    context 'when the move is a4' do
      it 'include the move in the array of moves' do
        coordinate = [0, 4]
        pseudo_moves = queen.pseudo_move?(coordinate)
        expect(pseudo_moves).to be true
      end
    end

    context 'when the move is e5' do
      it 'include the move in the array of moves' do
        coordinate = [4, 3]
        pseudo_moves = queen.pseudo_move?(coordinate)
        expect(pseudo_moves).to be true
      end
    end

    context 'when the move is b6' do
      it 'include the move in the array of moves' do
        coordinate = [1, 2]
        pseudo_moves = queen.pseudo_move?(coordinate)
        expect(pseudo_moves).to be true
      end
    end

    context 'when move is out of range of piece moves' do
      it 'exclude the move in the array of moves' do
        coordinate = [1, 3]
        pseudo_moves = queen.pseudo_move?(coordinate)
        expect(pseudo_moves).to be false
      end
    end

    context 'when there is a ally piece in move target' do
      before do
        allow(board).to receive(:at).with([3, 2]).and_return(ally_piece)
        queen.update_pseudo_moves
      end

      it 'exclude the move in the array of moves' do
        coordinate = [3, 2]
        pseudo_moves = queen.pseudo_move?(coordinate)
        expect(pseudo_moves).to be false
      end
    end

    context 'when there is a enemy piece in move target' do
      before do
        allow(board).to receive(:at).with([3, 2]).and_return(enemy_piece)
        queen.update_pseudo_moves
      end

      it 'include the move in the array of moves' do
        coordinate = [3, 2]
        pseudo_moves = queen.pseudo_move?(coordinate)
        expect(pseudo_moves).to be true
      end
    end

    context 'when a enemy piece is blocking the path to the move target' do
      before do
        allow(board).to receive(:at).with([3, 3]).and_return(enemy_piece)
        queen.update_pseudo_moves
      end

      it 'exclude the move in the array of moves' do
        coordinate = [3, 2]
        pseudo_moves = queen.pseudo_move?(coordinate)
        expect(pseudo_moves).to be false
      end
    end

    context 'when a ally piece is blocking the path to the move target' do
      before do
        allow(board).to receive(:at).with([3, 3]).and_return(ally_piece)
        queen.update_pseudo_moves
      end

      it 'exclude the move in the array of moves' do
        coordinate = [3, 2]
        pseudo_moves = queen.pseudo_move?(coordinate)
        expect(pseudo_moves).to be false
      end
    end
  end
end
