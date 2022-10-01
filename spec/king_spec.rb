require './lib/piece'
require './lib/king'

describe King do
  describe '#can_move_to?' do
    let(:board) { double('Board') }
    let(:king_data) { { color: 'white', pos: 'd4' } }
    subject(:king) { described_class.new(board, **king_data) }
    let(:enemy_piece) { double('Piece') }
    let(:ally_piece) { double('Piece') }

    before do
      allow(board).to receive(:convert_to_indexes).with('d4').and_return([3, 4])
      allow(board).to receive(:at).and_return(nil)
      allow(enemy_piece).to receive(:color).and_return('black')
      allow(ally_piece).to receive(:color).and_return('white')
    end

    context 'when the move is d5' do
      it 'returns true' do
        coordinate = 'd5'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 3])
        result = king.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is e5' do
      it 'returns true' do
        coordinate = 'e5'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([4, 3])
        result = king.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is out of range of piece moves' do
      it 'returns false' do
        coordinate = 'd6'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 2])
        result = king.can_move_to?(coordinate)
        expect(result).to be false
      end
    end

    context 'when there is a ally piece in move target' do
      before do
        allow(board).to receive(:at).with('33').and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = 'd5'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 3])
        result = king.can_move_to?(coordinate)
        expect(result).to be false
      end
    end

    context 'when there is a enemy piece in move target' do
      before do
        allow(board).to receive(:at).with('33').and_return(enemy_piece)
      end

      it 'returns true' do
        coordinate = 'd5'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 3])
        result = king.can_move_to?(coordinate)
        expect(result).to be true
      end
    end
  end
end
