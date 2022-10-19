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

  describe '#piece_move?' do
    context 'when the move is d5' do
      it 'returns true' do
        coordinate = [3, 3]
        result = king.piece_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is e5' do
      it 'returns true' do
        coordinate = [4, 3]
        result = king.piece_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is out of range of piece moves' do
      it 'returns false' do
        coordinate = [3, 2]
        result = king.piece_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when there is a ally piece in move target' do
      before do
        allow(board).to receive(:at).with([3, 3]).and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = [3, 3]
        result = king.piece_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when there is a enemy piece in move target' do
      before do
        allow(board).to receive(:at).with([3, 3]).and_return(enemy_piece)
      end

      it 'returns true' do
        coordinate = [3, 3]
        result = king.piece_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is a valid queenside castling' do
      let(:castling_king_data) { { color: 'white', pos: 'e1' } }
      subject(:castling_king) { described_class.new(board, **king_data) }
      before do
        allow(board).to receive(:at).with('47').and_return(enemy_piece)
      end

      xit 'returns true' do
        move = 'O-O-O'
        result = king.piece_move?(move)
        expect(result).to be true
      end
    end

    context 'when the move can leave the king to a self-checking' do
      before do
        allow(enemy_piece).to receive(:valid_move?).with([3, 3]).and_return(true)
      end

      xit 'returns false' do
        coordinate = [3, 3]
        result = king.can_move?(coordinate)
        expect(result).to be false
      end
    end
  end
end
