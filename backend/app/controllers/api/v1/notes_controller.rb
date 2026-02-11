module Api
  module V1
    class NotesController < ApplicationController
      def index
        notes = Note.order(created_at: :desc)
        render json: Api::V1::NoteBlueprint.render(notes)
      end

      def create
        note = Note.new(note_params)

        if note.save
          render json: Api::V1::NoteBlueprint.render(note), status: :created
        else
          render json: { errors: note.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      private

      def note_params
        params.require(:note).permit(:title, :content)
      end
    end
  end
end
