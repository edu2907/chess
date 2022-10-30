require './lib/notation_utils'
require './lib/piece'
require './lib/bisp'

describe Bisp do
  describe '#pseudo_move?' do
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

    before :example do
      bisp.update_pseudo_moves
    end

    context 'when the move is e5' do
      it 'include the move in the array of moves' do
        coordinate = [4, 3]
        pseudo_moves = bisp.pseudo_move?(coordinate)
        expect(pseudo_moves).to be true
      end
    end

    context 'when the move is b6' do
      it 'include the move in the array of moves' do
        coordinate = [1, 2]
        pseudo_moves = bisp.pseudo_move?(coordinate)
        expect(pseudo_moves).to be true
      end
    end

    context 'when the move is a1 ' do
      it 'include the move in the array of moves' do
        coordinate = [0, 7]
        pseudo_moves = bisp.pseudo_move?(coordinate)
        expect(pseudo_moves).to be true
      end
    end

    context 'when the move is e3 ' do
      it 'include the move in the array of moves' do
        coordinate = [4, 5]
        pseudo_moves = bisp.pseudo_move?(coordinate)
        expect(pseudo_moves).to be true
      end
    end

    context 'when the move is out of range of piece moves' do
      it 'exclude the move in the array of moves' do
        coordinate = [3, 3]
        pseudo_moves = bisp.pseudo_move?(coordinate)
        expect(pseudo_moves).to be false
      end
    end

    context 'when there is a ally piece in move target' do
      before do
        allow(board).to receive(:at).with([0, 7]).and_return(ally_piece)
        bisp.update_pseudo_moves
      end

      it 'exclude the move in the array of moves' do
        coordinate = [0, 7]
        pseudo_moves = bisp.pseudo_move?(coordinate)
        expect(pseudo_moves).to be false
      end
    end

    context 'when there is a enemy piece in move target' do
      before do
        allow(board).to receive(:at).with([0, 7]).and_return(enemy_piece)
        bisp.update_pseudo_moves
      end

      it 'include the move in the array of moves' do
        coordinate = [0, 7]
        pseudo_moves = bisp.pseudo_move?(coordinate)
        expect(pseudo_moves).to be true
      end
    end

    context 'when a enemy piece is blocking the path to the move target' do
      before do
        allow(board).to receive(:at).with([1, 6]).and_return(enemy_piece)
        bisp.update_pseudo_moves
      end

      it 'exclude the move in the array of moves' do
        coordinate = [0, 7]
        pseudo_moves = bisp.pseudo_move?(coordinate)
        expect(pseudo_moves).to be false
      end
    end

    context 'when a ally piece is blocking the path to the move target' do
      before do
        allow(board).to receive(:at).with([1, 6]).and_return(ally_piece)
        bisp.update_pseudo_moves
      end

      it 'exclude the move in the array of moves' do
        coordinate = [0, 7]
        pseudo_moves = bisp.pseudo_move?(coordinate)
        expect(pseudo_moves).to be false
      end
    end
  end
end
