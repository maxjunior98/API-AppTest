const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const db = require('./queries')
const port = 3000

app.use(bodyParser.json())

app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)

app.get('/', (request, response) => {
  response.json({Welcome: 'How to create API with Node.js, EXPRESS and PostgreSQL'})
})

app.get('/countries', db.getAll)
app.get('/countries/:id', db.getById)
app.post('/countries', db.insertCountry)
app.put('/countries/:id', db.updateCountry)
app.delete('/countries/:id', db.deleteCountry)

app.listen(port, () => {
  console.log(`App running on port ${port}.`)
})
