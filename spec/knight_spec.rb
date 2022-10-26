require './lib/notation_utils'
require './lib/piece'
require './lib/knight'

describe Knight do
  describe '#generate_pseudo_moves' do
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
      it 'include the move in the array of moves' do
        coordinate = [4, 2]
        pseudo_moves = knight.generate_pseudo_moves
        expect(pseudo_moves).to include(coordinate)
      end
    end

    context 'when the move is f5' do
      it 'include the move in the array of moves' do
        coordinate = [5, 3]
        pseudo_moves = knight.generate_pseudo_moves
        expect(pseudo_moves).to include(coordinate)
      end
    end

    context 'when move is out of range of piece moves' do
      it 'exclude the move in the array of moves' do
        coordinate = [3, 2]
        pseudo_moves = knight.generate_pseudo_moves
        expect(pseudo_moves).not_to include(coordinate)
      end
    end

    context 'when there is a ally piece in move target' do
      before do
        allow(board).to receive(:at).with([4, 2]).and_return(ally_piece)
      end

      it 'exclude the move in the array of moves' do
        coordinate = [4, 2]
        pseudo_moves = knight.generate_pseudo_moves
        expect(pseudo_moves).not_to include(coordinate)
      end
    end

    context 'when there is a enemy piece in move target' do
      before do
        allow(board).to receive(:at).with([4, 2]).and_return(enemy_piece)
      end

      it 'include the move in the array of moves' do
        coordinate = [4, 2]
        pseudo_moves = knight.generate_pseudo_moves
        expect(pseudo_moves).to include(coordinate)
      end
    end
  end
end
