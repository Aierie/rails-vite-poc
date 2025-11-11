// Vite ⚡️ Rails - Modern JavaScript with Hot Module Replacement
console.log('Vite ⚡️ Rails is running!')
console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')

// Example: Load Rails libraries in Vite.
// import * as Turbo from '@hotwired/turbo'
// Turbo.start()

// Import our demo module
import './vite-demo'

// Enable HMR (Hot Module Replacement) for this module
if (import.meta.hot) {
  import.meta.hot.accept()
  console.log('🔥 Hot Module Replacement is enabled!')
}
