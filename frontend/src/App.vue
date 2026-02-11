<script setup>
import { ref, onMounted } from 'vue'
import api from './services/api'

const notes = ref([])
const title = ref('')
const content = ref('')
const errors = ref([])

const loadNotes = async () => {
  const { data } = await api.get('/notes')
  notes.value = data
}

const createNote = async () => {
  errors.value = []

  try {
    await api.post('/notes', {
      note: { title: title.value, content: content.value }
    })

    title.value = ''
    content.value = ''
    loadNotes()
  } catch (e) {
    errors.value = e.response?.data?.errors || ['Erro ao salvar']
  }
}

onMounted(loadNotes)
</script>

<template>
  <div class="page">
    <div class="card">
      <h2>Nova anotação</h2>
      <hr />

      <div class="field">
        <label>Título:</label>
        <input
          v-model="title"
          type="text"
          placeholder="Digite o título"
        />
      </div>

      <div class="field">
        <label>Conteúdo:</label>
        <textarea
          v-model="content"
          placeholder="Digite o conteúdo..."
        />
      </div>

      <div v-if="errors.length" class="errors">
        <p v-for="error in errors" :key="error">{{ error }}</p>
      </div>

      <button @click="createNote">Salvar</button>
    </div>

    <div class="card">
      <h2>Anotações</h2>
      <hr />

      <ul class="notes">
        <li v-for="note in notes" :key="note.id">
          <strong>{{ note.title }}</strong>
          <p>{{ note.content }}</p>
        </li>
      </ul>
    </div>
  </div>
</template>

<style scoped>
.page {
  min-height: 100vh;
  background: #f5f7fa;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 40px 16px;
  font-family: Arial, Helvetica, sans-serif;
}

.card {
  width: 100%;
  max-width: 720px;
  background: #ffffff;
  border-radius: 4px;
  padding: 24px;
  margin-bottom: 24px;
}

h2 {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
}

hr {
  margin: 12px 0 20px;
  border: none;
  border-top: 1px solid #e0e0e0;
}

.field {
  display: flex;
  flex-direction: column;
  margin-bottom: 16px;
}

label {
  font-size: 14px;
  margin-bottom: 6px;
  color: #333;
}

input,
textarea {
  padding: 10px;
  border: 1px solid #dcdcdc;
  border-radius: 4px;
  font-size: 14px;
}

textarea {
  min-height: 80px;
  resize: vertical;
}

button {
  margin-top: 8px;
  width: 120px;
  padding: 10px 0;
  background: #1f66d1;
  color: #fff;
  border: none;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
}

button:hover {
  background: #1854ad;
}

.errors {
  margin-bottom: 12px;
}

.errors p {
  color: #d32f2f;
  font-size: 13px;
  margin: 0;
}

.notes {
  list-style: disc;
  padding-left: 20px;
}

.notes li {
  margin-bottom: 16px;
}

.notes strong {
  font-size: 14px;
}

.notes p {
  margin: 4px 0 0;
  font-size: 13px;
  color: #555;
}
</style>
