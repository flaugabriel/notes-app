puts '🌱 Rodando seeds com FactoryBot...'

require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

# Evita duplicar
return if Note.exists?

create(:note,
       title: 'Primeira anotação',
       content: 'Criada automaticamente pelo seed'
)

create(:note,
       title: 'Checklist',
       content: "• Rails\n• Vue\n• Docker\n• Teste técnico"
)

create(:note,
       title: 'Observação',
       content: 'O conteúdo é opcional'
)

puts "✅ #{Note.count} anotações criadas"
