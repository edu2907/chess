require './lib/piece'
require './lib/bisp'

describe Bisp do
  describe '#can_move_to?' do
    let(:board) { double('Board') }
    let(:bisp_data) { { color: 'white', pos: 'd4' } }
    subject(:bisp) { described_class.new(board, **bisp_data) }
    let(:enemy_piece) { double('Piece') }
    let(:ally_piece) { double('Piece') }

    before do
      allow(board).to receive(:convert_to_indexes).with('d4').and_return([3, 4])
      allow(board).to receive(:at).and_return(nil)
      allow(enemy_piece).to receive(:color).and_return('black')
      allow(ally_piece).to receive(:color).and_return('white')
    end

    context 'when the move is e5' do
      it 'returns true' do
        coordinate = 'e5'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([4, 3])
        result = bisp.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is b6' do
      it 'returns true' do
        coordinate = 'b6'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([1, 2])
        result = bisp.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is a1 ' do
      it 'returns true' do
        coordinate = 'a1'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([0, 7])
        result = bisp.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is e3 ' do
      it 'returns true' do
        coordinate = 'e3'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([4, 5])
        result = bisp.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is out of range of piece moves' do
      it 'returns false' do
        coordinate = 'd5'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 3])
        result = bisp.can_move_to?(coordinate)
        expect(result).to be false
      end
    end

    context 'when there is a ally piece in move target' do
      before do
        allow(board).to receive(:at).with('07').and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = 'a1'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([0, 7])
        result = bisp.can_move_to?(coordinate)
        expect(result).to be false
      end
    end

    context 'when there is a enemy piece in move target' do
      before do
        allow(board).to receive(:at).with('07').and_return(enemy_piece)
      end

      it 'returns true' do
        coordinate = 'a1'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([0, 7])
        result = bisp.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when a enemy piece is blocking the path to the move target' do
      before do
        allow(board).to receive(:at).with('16').and_return(enemy_piece)
      end

      it 'returns false' do
        coordinate = 'a1'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([0, 7])
        result = bisp.can_move_to?(coordinate)
        expect(result).to be false
      end
    end

    context 'when a ally piece is blocking the path to the move target' do
      before do
        allow(board).to receive(:at).with('16').and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = 'a1'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([0, 7])
        result = bisp.can_move_to?(coordinate)
        expect(result).to be false
      end
    end
  end
end
