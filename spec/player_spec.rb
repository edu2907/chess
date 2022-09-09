require './lib/player'

describe Player do
  let(:players_data) { double('InitPlayerData') }
  let(:board) { double('Board') }
  let(:piece) { double('Piece') }
  before do
    allow_any_instance_of(described_class).to receive(:create_name)
    allow_any_instance_of(described_class).to receive(:mark_piece)
    allow_any_instance_of(described_class).to receive(:place_pieces)
    allow(players_data).to receive(:color).and_return('white')
    allow(players_data).to receive(:main_row)
    allow(players_data).to receive(:pawn_row)
  end

  describe '#valid_piece?' do
    subject(:valid_piece_player) { described_class.new(board, players_data) }
    before do
      allow(valid_piece_player).to receive(:puts)
    end

    context 'when a valid coordinate is given and the piece is valid' do
      before do
        allow(board).to receive(:at).with('A7').and_return(piece)
        allow(piece).to receive(:color).and_return('white')
      end

      it 'returns the piece' do
        valid_coord = 'A7'
        valid_piece = valid_piece_player.valid_piece?(valid_coord)
        expect(valid_piece).to be piece
      end
    end

    context 'when a invalid coordinate is given' do
      before do
        allow(board).to receive(:at).with('X9').and_return(nil)
      end

      it 'returns a falsy value' do
        invalid_coord = 'X9'
        piece = valid_piece_player.valid_piece?(invalid_coord)
        expect(piece).to be_falsy
      end
    end

    context 'when a valid coordinate is given but the piece is from other player' do
      before do
        allow(piece).to receive(:color).and_return('black')
        allow(board).to receive(:at).with('A2').and_return(piece)
      end

      it 'returns a falsy value' do
        coord = 'A2'
        piece = valid_piece_player.valid_piece?(coord)
        expect(piece).to be_falsy
      end
    end

    context 'when a valid coordinate is given but there is no piece' do
      it 'returns a falsy value' do
        allow(board).to receive(:at).with('D5').and_return(nil)

        coord = 'D5'
        piece = valid_piece_player.valid_piece?(coord)
        expect(piece).to be_falsy
      end
    end
  end

  describe '#valid_target?' do
    subject(:valid_target_player) { described_class.new(board, players_data) }
    before do
      allow(valid_target_player).to receive(:puts)
    end

    context 'when target is valid and piece can move to it' do
      it 'returns the target' do
        allow(piece).to receive(:can_move_to?).and_return(true)

        coord = 'A6'
        target = valid_target_player.valid_target?(piece, coord)
        expect(target).to eq(coord)
      end
    end

    context 'when target is invalid' do
      it 'returns a falsy value' do
        allow(piece).to receive(:can_move_to?).and_return(false)

        coord = 'T8'
        target = valid_target_player.valid_target?(piece, coord)
        expect(target).to be_falsy
      end
    end

    context 'when target is valid but the piece cannot move to it' do
      it 'returns a falsy value' do
        allow(piece).to receive(:can_move_to?).and_return(false)

        coord = 'B6'
        target = valid_target_player.valid_target?(piece, coord)
        expect(target).to be_falsy
      end
    end

    context 'when player wants to undo its action' do
      it 'returns "back"' do
        undo_input = 'back'
        target = valid_target_player.valid_target?(piece, undo_input)
        expect(target).to eq(undo_input)
      end
    end
  end
end
