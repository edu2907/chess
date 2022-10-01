require './lib/piece'
require './lib/queen'

describe Queen do
  describe '#can_move_to?' do
    let(:board) { double('Board') }
    let(:queen_data) { { color: 'white', pos: 'd4' } }
    subject(:queen) { described_class.new(board, **queen_data) }
    let(:enemy_piece) { double('Piece') }
    let(:ally_piece) { double('Piece') }

    before do
      allow(board).to receive(:convert_to_indexes).with('d4').and_return([3, 4])
      allow(board).to receive(:at).and_return(nil)
      allow(enemy_piece).to receive(:color).and_return('black')
      allow(ally_piece).to receive(:color).and_return('white')
    end

    context 'when the move is d6' do
      it 'returns true' do
        coordinate = 'd6'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 2])
        result = queen.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is a4' do
      it 'returns true' do
        coordinate = 'a4'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([0, 4])
        result = queen.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is e5' do
      it 'returns true' do
        coordinate = 'e5'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([4, 3])
        result = queen.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is b6' do
      it 'returns true' do
        coordinate = 'b6'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([1, 2])
        result = queen.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when move is out of range of piece moves' do
      it 'returns false' do
        coordinate = 'b5'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([1, 3])
        result = queen.can_move_to?(coordinate)
        expect(result).to be false
      end
    end

    context 'when there is a ally piece in move target' do
      before do
        allow(board).to receive(:at).with('32').and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = 'd6'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 2])
        result = queen.can_move_to?(coordinate)
        expect(result).to be false
      end
    end

    context 'when there is a enemy piece in move target' do
      before do
        allow(board).to receive(:at).with('32').and_return(enemy_piece)
      end

      it 'returns true' do
        coordinate = 'd6'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 2])
        result = queen.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when a enemy piece is blocking the path to the move target' do
      before do
        allow(board).to receive(:at).with('33').and_return(enemy_piece)
      end

      it 'returns false' do
        coordinate = 'd6'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 2])
        result = queen.can_move_to?(coordinate)
        expect(result).to be false
      end
    end

    context 'when a ally piece is blocking the path to the move target' do
      before do
        allow(board).to receive(:at).with('33').and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = 'd6'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 2])
        result = queen.can_move_to?(coordinate)
        expect(result).to be false
      end
    end
  end
end
