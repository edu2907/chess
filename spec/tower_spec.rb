require './lib/piece'
require './lib/tower'

describe Tower do
  describe '#can_move?' do
    let(:board) { double('Board') }
    let(:tower_data) { { color: 'white', pos: [3, 4] } }
    subject(:tower) { described_class.new(board, **tower_data) }
    let(:enemy_piece) { double('Piece') }
    let(:ally_piece) { double('Piece') }

    before do
      allow(board).to receive(:at).and_return(nil)
      allow(enemy_piece).to receive(:color).and_return('black')
      allow(ally_piece).to receive(:color).and_return('white')
    end

    context 'when the move is d6' do
      it 'returns true' do
        coordinate = [3, 2]
        result = tower.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is a4' do
      it 'returns true' do
        coordinate = [0, 4]
        result = tower.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is d2' do
      it 'returns true' do
        coordinate = [3, 6]
        result = tower.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is g4' do
      it 'returns true' do
        coordinate = [7, 4]
        result = tower.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when move is out of range of piece moves' do
      it 'returns false' do
        coordinate = [1, 2]
        result = tower.can_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when there is a ally piece in move target' do
      before do
        allow(board).to receive(:at).with([3, 2]).and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = [3, 2]
        result = tower.can_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when there is a enemy piece in move target' do
      before do
        allow(board).to receive(:at).with([3, 2]).and_return(enemy_piece)
      end

      it 'returns true' do
        coordinate = [3, 2]
        result = tower.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when a enemy piece is blocking the path to the move target' do
      before do
        allow(board).to receive(:at).with([3, 3]).and_return(enemy_piece)
      end

      it 'returns false' do
        coordinate = [3, 2]
        result = tower.can_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when a ally piece is blocking the path to the move target' do
      before do
        allow(board).to receive(:at).with([3, 3]).and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = [3, 2]
        result = tower.can_move?(coordinate)
        expect(result).to be false
      end
    end
  end
end
