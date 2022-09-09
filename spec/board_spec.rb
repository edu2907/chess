require './lib/board'

describe Board do
  describe '#place_at' do
    subject(:empty_board) { described_class.new }
    let(:piece) { double('Piece') }
    before do
      allow(piece).to receive(:pos=)
    end

    context 'when the given position is empty' do
      it 'stores "piece" in the correct position in board' do
        expect { empty_board.place_at(piece, 'A1') }.to change { empty_board.arr[0][0] }.to piece
      end
    end
  end
end
