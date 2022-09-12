require './lib/board'

describe Board do
  describe '#at' do
    let(:piece) { double('Piec') }
    subject(:get_at_board) { described_class.new }
    before do
      get_at_board.instance_variable_set(:@arr, Array.new(8) { Array.new(8) { double('Piece') } })
    end

    context 'when a coordinate string (A2) is given' do
      it 'returns piece' do
        piece = get_at_board.at('A2')
        expect(piece).to equal get_at_board.instance_variable_get(:@arr)[1][0]
      end
    end

    context 'when an indexes string (01) is given' do
      it 'returns piece' do
        piece = get_at_board.at('01')
        expect(piece).to equal get_at_board.instance_variable_get(:@arr)[1][0]
      end
    end

    context 'when a invalid argument is given' do
      it 'returns nil' do
        piece = get_at_board.at('H9')
        expect(piece).to be nil
      end
    end
  end
end
