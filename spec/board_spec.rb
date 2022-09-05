require './lib/board'

describe Board do
  describe '#place_at' do
    subject(:empty_board) { described_class.new }
    let(:piece) { double('Piece') }

    context 'when the given position is empty' do
      it 'stores "piece" in the coorect position in board' do
        expect { empty_board.place_at(piece, 'A0') }.to change { empty_board.arr[0][0] }.to piece
      end
    end
  end
end
