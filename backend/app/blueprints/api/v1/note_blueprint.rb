module Api
  module V1
    class NoteBlueprint < Blueprinter::Base
      identifier :id

      fields :title, :content, :created_at
    end
  end
end
