require './lib/piece'
require './lib/knight'

describe Knight do
  describe '#can_move?' do
    let(:board) { double('Board') }
    let(:knight_data) { { color: 'white', pos: [3, 4] } }
    subject(:knight) { described_class.new(board, **knight_data) }
    let(:enemy_piece) { double('Piece') }
    let(:ally_piece) { double('Piece') }

    before do
      allow(board).to receive(:at).and_return(nil)
      allow(enemy_piece).to receive(:color).and_return('black')
      allow(ally_piece).to receive(:color).and_return('white')
    end

    context 'when the move is e6' do
      it 'returns true' do
        coordinate = [4, 2]
        result = knight.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is f5' do
      it 'returns true' do
        coordinate = [5, 3]
        result = knight.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when move is out of range of piece moves' do
      it 'returns false' do
        coordinate = [3, 2]
        result = knight.can_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when there is a ally piece in move target' do
      before do
        allow(board).to receive(:at).with([4, 2]).and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = [4, 2]
        result = knight.can_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when there is a enemy piece in move target' do
      before do
        allow(board).to receive(:at).with([4, 2]).and_return(enemy_piece)
      end

      it 'returns true' do
        coordinate = [4, 2]
        result = knight.can_move?(coordinate)
        expect(result).to be true
      end
    end
  end
end
