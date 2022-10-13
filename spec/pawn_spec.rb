require './lib/piece'
require './lib/pawn'

describe Pawn do
  describe '#can_move?' do
    let(:board) { double('Board') }
    let(:enemy_piece) { double('Piece') }
    let(:ally_piece) { double('Piece') }

    before do
      allow(board).to receive(:at).and_return(nil)
      allow(enemy_piece).to receive(:color).and_return('black')
      allow(ally_piece).to receive(:color).and_return('white')
    end

    context 'when the move is a normal push' do
      let(:pawn_data) { { color: 'white', pos: [3, 6] } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      it 'returns true' do
        coordinate = [3, 5]
        result = pawn.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is a double push and pawn didn\'t move' do
      let(:pawn_data) { { color: 'white', pos: [3, 6], has_moved: false } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      it 'returns true' do
        coordinate = [3, 4]
        result = pawn.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is a double push and pawn already has moved' do
      let(:pawn_data) { { color: 'white', pos: [3, 5], has_moved: true } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      it 'returns false' do
        coordinate = [3, 3]
        result = pawn.can_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when the move is a normal push and there is a ally piece at the coordinate' do
      let(:pawn_data) { { color: 'white', pos: [3, 6] } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      before do
        allow(board).to receive(:at).with([3, 5]).and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = [3, 5]
        result = pawn.can_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when the move is a double push and there is a ally piece at the coordinate' do
      let(:pawn_data) { { color: 'white', pos: [3, 6] } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      before do
        allow(board).to receive(:at).with([3, 4]).and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = [3, 4]
        result = pawn.can_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when the move is a left capture and there is an enemy piece' do
      let(:pawn_data) { { color: 'white', pos: [3, 6] } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      before do
        allow(board).to receive(:at).with([2, 5]).and_return(enemy_piece)
      end

      it 'returns true' do
        coordinate = [2, 5]
        result = pawn.can_move?(coordinate)
        expect(result).to be true
      end
    end

    context 'when the move is a left capture and there is an ally piece' do
      let(:pawn_data) { { color: 'white', pos: [3, 6] } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      before do
        allow(board).to receive(:at).with('25').and_return(ally_piece)
      end

      it 'returns false' do
        coordinate = [2, 5]
        result = pawn.can_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when the move is a right capture and there is no piece' do
      let(:pawn_data) { { color: 'white', pos: [3, 6] } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      it 'returns false' do
        coordinate = [4, 5]
        result = pawn.can_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when the move is out of range of pawn moves' do
      let(:pawn_data) { { color: 'white', pos: [3, 6] } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      it 'returns false' do
        coordinate = [3, 3]
        result = pawn.can_move?(coordinate)
        expect(result).to be false
      end
    end

    context 'when the move is a valid en passant' do
      let(:pawn_data) { { color: 'white', pos: [3, 6] } }
      subject(:pawn) { described_class.new(board, **pawn_data) }

      xit 'returns true' do
        coordinate = [3, 3]
        result = pawn.can_move?(coordinate)
        expect(result).to be true
      end
    end
  end
end
