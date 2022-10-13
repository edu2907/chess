require './lib/piece'
require './lib/bisp'

describe Bisp do
  describe '#can_move?' do
    let(:board) { double('Board') }
    let(:bisp_data) { { color: 'white', pos: [3, 4] } }
    subject(:bisp) { described_class.new(board, **bisp_data) }
    let(:enemy_piece) { double('Piece') }
    let(:ally_piece) { double('Piece') }

    before do
      allow(board).to receive(:at).and_return(nil)
      allow(enemy_piece).to receive(:color).and_return('black')
      allow(ally_piece).to receive(:color).and_return('white')
    end

    context 'when the move is e5' do
      it 'returns true' do
        coordinate = [4, 3]
        result = bisp.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is b6' do
      it 'returns true' do
        coordinate = [1, 2]
        result = bisp.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is a1 ' do
      it 'returns true' do
        coordinate = [0, 7]
        result = bisp.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is e3 ' do
      it 'returns true' do
        coordinate = [4, 5]
        result = bisp.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is out of range of piece moves' do
      it 'returns false' do
        coordinate = [3, 3]
        result = bisp.can_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when there is a ally piece in move target' do
      before do
        allow(board).to receive(:at).with([0, 7]).and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = [0, 7]
        result = bisp.can_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when there is a enemy piece in move target' do
      before do
        allow(board).to receive(:at).with([0, 7]).and_return(enemy_piece)
      end

      it 'returns true' do
        coordinate = [0, 7]
        result = bisp.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when a enemy piece is blocking the path to the move target' do
      before do
        allow(board).to receive(:at).with([1, 6]).and_return(enemy_piece)
      end

      it 'returns false' do
        coordinate = [0, 7]
        result = bisp.can_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when a ally piece is blocking the path to the move target' do
      before do
        allow(board).to receive(:at).with([1, 6]).and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = [0, 7]
        result = bisp.can_move?(coordinate)
        expect(result).to be false
      end
    end
  end
end
