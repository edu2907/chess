require './lib/piece'
require './lib/pawn'

describe Pawn do
  describe '#can_move_to?' do
    let(:board) { double('Board') }
    let(:enemy_piece) { double('Piece') }
    let(:ally_piece) { double('Piece') }

    before do
      allow(board).to receive(:at).and_return(nil)
      allow(enemy_piece).to receive(:color).and_return('black')
      allow(ally_piece).to receive(:color).and_return('white')
    end

    context 'when the move is a normal push' do
      let(:pawn_data) { { color: 'white', pos: 'd2', initial_pos: 'd2' } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      before do
        allow(board).to receive(:convert_to_indexes).with('d2').and_return([3, 6])
      end

      it 'returns true' do
        coordinate = 'd3'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 5])
        result = pawn.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is a double push and pawn is in initial pos' do
      let(:pawn_data) { { color: 'white', pos: 'd2', initial_pos: 'd2' } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      before do
        allow(board).to receive(:convert_to_indexes).with('d2').and_return([3, 6])
      end

      it 'returns true' do
        coordinate = 'd4'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 4])
        result = pawn.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is a double push and pawn isn\'t in initial pos' do
      let(:pawn_data) { { color: 'white', pos: 'd3', initial_pos: 'd2' } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      before do
        allow(board).to receive(:convert_to_indexes).with('d3').and_return([3, 5])
      end

      it 'returns false' do
        coordinate = 'd5'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 3])
        result = pawn.can_move_to?(coordinate)
        expect(result).to be false
      end
    end

    context 'when the move is a normal push and there is a ally piece at the coordinate' do
      let(:pawn_data) { { color: 'white', pos: 'd2', initial_pos: 'd2' } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      before do
        allow(board).to receive(:convert_to_indexes).with('d2').and_return([3, 6])
        allow(board).to receive(:at).with('35').and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = 'd3'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 5])
        result = pawn.can_move_to?(coordinate)
        expect(result).to be false
      end
    end

    context 'when the move is a double push and there is a ally piece at the coordinate' do
      let(:pawn_data) { { color: 'white', pos: 'd2', initial_pos: 'd2' } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      before do
        allow(board).to receive(:convert_to_indexes).with('d2').and_return([3, 5])
        allow(board).to receive(:at).with('34').and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = 'd5'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 4])
        result = pawn.can_move_to?(coordinate)
        expect(result).to be false
      end
    end

    context 'when the move is a left capture and there is an enemy piece' do
      let(:pawn_data) { { color: 'white', pos: 'd2', initial_pos: 'd2' } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      before do
        allow(board).to receive(:convert_to_indexes).with('d2').and_return([3, 6])
        allow(board).to receive(:at).with('25').and_return(enemy_piece)
      end

      it 'returns true' do
        coordinate = 'c3'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([2, 5])
        result = pawn.can_move_to?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is a left capture and there is an ally piece' do
      let(:pawn_data) { { color: 'white', pos: 'd2', initial_pos: 'd2' } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      before do
        allow(board).to receive(:convert_to_indexes).with('d2').and_return([3, 6])
        allow(board).to receive(:at).with('25').and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = 'c3'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([2, 5])
        result = pawn.can_move_to?(coordinate)
        expect(result).to be false
      end
    end

    context 'when the move is a right capture and there is no piece' do
      let(:pawn_data) { { color: 'white', pos: 'd2', initial_pos: 'd2' } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      before do
        allow(board).to receive(:convert_to_indexes).with('d2').and_return([3, 6])
      end

      it 'returns false' do
        coordinate = 'e3'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([4, 5])
        result = pawn.can_move_to?(coordinate)
        expect(result).to be false
      end
    end

    context 'when the move is out of range of pawn moves' do
      let(:pawn_data) { { color: 'white', pos: 'd2', initial_pos: 'd2' } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      before do
        allow(board).to receive(:convert_to_indexes).with('d2').and_return([3, 6])
      end

      it 'returns false' do
        coordinate = 'd5'
        allow(board).to receive(:convert_to_indexes).with(coordinate).and_return([3, 3])
        result = pawn.can_move_to?(coordinate)
        expect(result).to be false
      end
    end
  end
end
