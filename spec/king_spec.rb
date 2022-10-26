require './lib/notation_utils'
require './lib/piece'
require './lib/king'

describe King do
  let(:board) { double('Board') }
  let(:king_data) { { color: 'white', pos: [3, 4] } }
  subject(:king) { described_class.new(board, **king_data) }
  let(:enemy_piece) { double('Piece') }
  let(:ally_piece) { double('Piece') }

  before do
    allow(board).to receive(:at).and_return(nil)
    allow(enemy_piece).to receive(:color).and_return('black')
    allow(ally_piece).to receive(:color).and_return('white')
  end

  describe '#generate_pseudo_moves?' do
    context 'when the move is d5' do
      it 'include the move in the array of moves' do
        coordinate = [3, 3]
        pseudo_moves = king.generate_pseudo_moves
        expect(pseudo_moves).to include(coordinate)
      end
    end

    context 'when the move is e5' do
      it 'include the move in the array of moves' do
        coordinate = [4, 3]
        pseudo_moves = king.generate_pseudo_moves
        expect(pseudo_moves).to include(coordinate)
      end
    end

    context 'when the move is out of range of piece moves' do
      it 'exclude the move in the array of moves' do
        coordinate = [3, 2]
        pseudo_moves = king.generate_pseudo_moves
        expect(pseudo_moves).not_to include(coordinate)
      end
    end

    context 'when there is a ally piece in move target' do
      before do
        allow(board).to receive(:at).with([3, 3]).and_return(ally_piece)
      end

      it 'exclude the move in the array of moves' do
        coordinate = [3, 3]
        pseudo_moves = king.generate_pseudo_moves
        expect(pseudo_moves).not_to include(coordinate)
      end
    end

    context 'when there is a enemy piece in move target' do
      before do
        allow(board).to receive(:at).with([3, 3]).and_return(enemy_piece)
      end

      it 'include the move in the array of moves' do
        coordinate = [3, 3]
        pseudo_moves = king.generate_pseudo_moves
        expect(pseudo_moves).to include(coordinate)
      end
    end

    context 'when the move is a valid queenside castling' do
      let(:castling_king_data) { { color: 'white', pos: 'e1' } }
      subject(:castling_king) { described_class.new(board, **king_data) }
      before do
        allow(board).to receive(:at).with('47').and_return(enemy_piece)
      end

      xit 'include the move in the array of moves' do
        move = 'O-O-O'
        pseudo_moves = king.generate_pseudo_moves
        expect(pseudo_moves).not_to include(coordinate)
      end
    end
  end
end
