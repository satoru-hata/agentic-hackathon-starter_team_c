import { serve } from '@hono/node-server'
import { Hono } from 'hono'
import { logger } from 'hono/logger'
import { cors } from 'hono/cors'

const app = new Hono()

// Middleware
app.use('*', logger())
app.use('*', cors())

// Routes
app.get('/', (c) => {
  return c.json({
    message: 'Welcome to Hono!',
    version: '1.0.0',
  })
})

app.get('/health', (c) => {
  return c.json({ status: 'ok' })
})

// API routes example
const api = new Hono()

api.get('/hello', (c) => {
  return c.json({ message: 'Hello from API!' })
})

api.get('/hello/:name', (c) => {
  const name = c.req.param('name')
  return c.json({ message: `Hello, ${name}!` })
})

app.route('/api', api)

// Start server
const port = Number(process.env.PORT) || 3000

console.log(`Server is running on http://localhost:${port}`)

serve({
  fetch: app.fetch,
  port,
})

export default app
