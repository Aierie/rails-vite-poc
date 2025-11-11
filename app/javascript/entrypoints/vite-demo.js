// Vite Demo - Showcasing modern JavaScript features
// This file demonstrates Vite's capabilities with ES6+ features

// 1. ES6+ Features Demo
class ViteDemo {
  constructor() {
    this.name = 'Vite ⚡️ + Rails 7.2.2.1'
    this.features = [
      'Hot Module Replacement (HMR)',
      'Lightning fast build times',
      'ES6+ module support',
      'Native ESM in development',
      'Optimized production builds'
    ]
  }

  init() {
    console.log(`✨ ${this.name} Demo initialized!`)
    this.addInteractivity()
    this.displayFeatures()
  }

  // Add interactive elements when page loads
  addInteractivity() {
    document.addEventListener('DOMContentLoaded', () => {
      // Add click counter functionality
      const counterButton = document.getElementById('vite-counter-btn')
      if (counterButton) {
        let count = 0
        counterButton.addEventListener('click', () => {
          count++
          const countDisplay = document.getElementById('vite-counter')
          if (countDisplay) {
            countDisplay.textContent = count
            this.animateCounter(countDisplay)
          }
        })
      }

      // Add current time display
      const timeDisplay = document.getElementById('vite-time')
      if (timeDisplay) {
        this.updateTime(timeDisplay)
        setInterval(() => this.updateTime(timeDisplay), 1000)
      }

      // Add dynamic content loader
      const loadButton = document.getElementById('vite-load-btn')
      if (loadButton) {
        loadButton.addEventListener('click', () => this.loadDynamicContent())
      }

      // Show that Vite is loaded
      const statusElements = document.querySelectorAll('.vite-status')
      statusElements.forEach(el => {
        el.classList.add('loaded')
        el.textContent = '✓ Loaded'
      })
    })
  }

  animateCounter(element) {
    element.classList.remove('animate-pulse')
    // Trigger reflow
    void element.offsetWidth
    element.classList.add('animate-pulse')
    setTimeout(() => element.classList.remove('animate-pulse'), 300)
  }

  updateTime(element) {
    const now = new Date()
    element.textContent = now.toLocaleTimeString()
  }

  async loadDynamicContent() {
    const contentArea = document.getElementById('vite-dynamic-content')
    if (!contentArea) return

    contentArea.innerHTML = '<p class="text-blue-600">Loading...</p>'

    // Simulate async data loading
    await new Promise(resolve => setTimeout(resolve, 500))

    const content = this.generateRandomContent()
    contentArea.innerHTML = `
      <div class="p-4 bg-green-50 border border-green-200 rounded-lg">
        <p class="font-semibold text-green-800">✓ Content loaded dynamically!</p>
        <p class="text-gray-700 mt-2">${content}</p>
      </div>
    `
  }

  generateRandomContent() {
    const tips = [
      'Vite uses esbuild for ultra-fast bundling',
      'Hot Module Replacement updates your code instantly without refreshing',
      'Vite serves your code via native ESM in development',
      'Production builds are optimized using Rollup',
      'Vite supports TypeScript, JSX, CSS modules, and more out of the box'
    ]
    return tips[Math.floor(Math.random() * tips.length)]
  }

  displayFeatures() {
    console.group('🚀 Vite Features')
    this.features.forEach((feature, index) => {
      console.log(`${index + 1}. ${feature}`)
    })
    console.groupEnd()
  }
}

// Initialize the demo
const demo = new ViteDemo()
demo.init()

// Export for potential use elsewhere
export default demo

// HMR support
if (import.meta.hot) {
  import.meta.hot.accept((newModule) => {
    console.log('🔄 Module updated via HMR!')
    if (newModule) {
      newModule.default.init()
    }
  })
}
