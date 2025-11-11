# Rails + Vite POC

A proof-of-concept Rails 7.2.2.1 application demonstrating polymorphic associations with Vite.js integration for modern frontend development.

## Overview

This application showcases a Property Management System with a complete domain model featuring polymorphic associations. Properties serve as the root entity with associated contractors, lawyers, and documents. The Document model demonstrates polymorphic associations by belonging to multiple entity types (Property, Contractor, and Lawyer).

Additionally, the application integrates Vite.js to demonstrate modern JavaScript tooling with Hot Module Replacement (HMR) in a Rails environment.

## Features

### Domain Model
- **Property Management System** with polymorphic associations
- **Property** (root entity) with:
  - Multiple contractors
  - Multiple lawyers
  - Multiple documents (polymorphic)
- **Contractor** with documents (polymorphic)
- **Lawyer** with documents (polymorphic)
- **Document** (polymorphic) can belong to Property, Contractor, or Lawyer

### Frontend
- **Vite.js Integration** for lightning-fast development
- **Hot Module Replacement (HMR)** for instant code updates
- **Tailwind CSS** for modern styling
- **Interactive Demo Page** showcasing:
  - ES6+ features and modules
  - Real-time clock updates
  - Interactive counter
  - Async/await dynamic content loading

### Testing
- Comprehensive model tests for polymorphic associations
- Tests verifying dependent destroy behavior
- All associations properly validated

## Tech Stack

- **Ruby**: 3.3.6
- **Rails**: 7.2.2.1
- **Database**: SQLite3
- **Frontend Build Tool**: Vite 5.4.21
- **CSS Framework**: Tailwind CSS 4.1.16
- **JavaScript**: ES6+ with native ESM
- **Node.js**: Required for Vite

## Prerequisites

- Ruby 3.3.6 or higher
- Node.js 18+ and npm
- SQLite3

## Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd rails-vite-poc
   ```

2. **Install Ruby dependencies**
   ```bash
   bundle install
   ```

3. **Install JavaScript dependencies**
   ```bash
   npm install
   ```

4. **Setup the database**
   ```bash
   bin/rails db:setup
   ```

   This will:
   - Create the development and test databases
   - Run all migrations
   - Load seed data with sample properties, contractors, lawyers, and documents

## Development

### Running the Application

The application uses `foreman` to run multiple processes (Rails server, Tailwind CSS compiler, and Vite dev server) simultaneously:

```bash
bin/dev
```

This starts:
- **Rails server** on http://localhost:3000
- **Tailwind CSS** compiler (watch mode)
- **Vite dev server** on http://localhost:3036

Alternatively, you can run services individually:

```bash
# Rails server only
bin/rails server

# Vite dev server
bin/vite dev

# Tailwind CSS compiler
bin/rails tailwindcss:watch
```

### Database Operations

```bash
# Create databases
bin/rails db:create

# Run migrations
bin/rails db:migrate

# Load seed data
bin/rails db:seed

# Reset database (drop, create, migrate, seed)
bin/rails db:reset

# Rollback last migration
bin/rails db:rollback
```

### Running Tests

```bash
# Run all tests
bin/rails test

# Run specific test file
bin/rails test test/models/property_test.rb

# Run specific test
bin/rails test test/models/property_test.rb:4
```

### Vite Commands

```bash
# Start Vite dev server (with HMR)
bin/vite dev

# Build assets for production
bin/vite build

# Clean build artifacts
bin/vite clobber

# Show Vite version
bin/vite --version
```

## Application Routes

### Main Routes
- **`/`** - Property Management System (root)
  - Displays first property with all associations
  - Shows contractors, lawyers, and documents
  - Includes summary statistics

- **`/vite/demo`** - Vite Demo Page
  - Interactive demonstrations of Vite features
  - Live clock, counter, and dynamic content loading
  - Hot Module Replacement showcase

### Utility Routes
- **`/up`** - Health check endpoint
- **`/properties/index`** - Properties listing

## Project Structure

```
rails-vite-poc/
├── app/
│   ├── controllers/
│   │   ├── properties_controller.rb    # Property management
│   │   └── vite_controller.rb          # Vite demo
│   ├── models/
│   │   ├── property.rb                 # Root domain model
│   │   ├── contractor.rb               # Associated with properties
│   │   ├── lawyer.rb                   # Associated with properties
│   │   └── document.rb                 # Polymorphic model
│   ├── views/
│   │   ├── properties/
│   │   │   └── index.html.erb          # Property display page
│   │   └── vite/
│   │       └── demo.html.erb           # Vite demo page
│   └── javascript/
│       └── entrypoints/
│           ├── application.js          # Main Vite entrypoint
│           └── vite-demo.js            # Demo functionality
├── config/
│   ├── vite.json                       # Vite Rails configuration
│   └── routes.rb                       # Application routes
├── db/
│   ├── migrate/                        # Database migrations
│   ├── seeds.rb                        # Sample data
│   └── schema.rb                       # Database schema
├── test/
│   ├── models/                         # Model tests
│   └── controllers/                    # Controller tests
├── vite.config.ts                      # Vite configuration
├── package.json                        # Node.js dependencies
├── Gemfile                             # Ruby dependencies
└── Procfile.dev                        # Development processes
```

## Database Schema

### Properties
- `id` (primary key)
- `name` (string)
- `address` (string)
- `description` (text)
- `created_at`, `updated_at`

### Contractors
- `id` (primary key)
- `name` (string)
- `specialty` (string)
- `property_id` (foreign key)
- `created_at`, `updated_at`

### Lawyers
- `id` (primary key)
- `name` (string)
- `firm` (string)
- `property_id` (foreign key)
- `created_at`, `updated_at`

### Documents (Polymorphic)
- `id` (primary key)
- `title` (string)
- `content` (text)
- `document_type` (string)
- `documentable_type` (string) - Polymorphic type
- `documentable_id` (integer) - Polymorphic ID
- `created_at`, `updated_at`

## Polymorphic Associations Explained

The `Document` model uses Rails polymorphic associations to belong to multiple model types:

```ruby
# app/models/document.rb
class Document < ApplicationRecord
  belongs_to :documentable, polymorphic: true
end

# app/models/property.rb
class Property < ApplicationRecord
  has_many :documents, as: :documentable
end

# app/models/contractor.rb
class Contractor < ApplicationRecord
  has_many :documents, as: :documentable
end

# app/models/lawyer.rb
class Lawyer < ApplicationRecord
  has_many :documents, as: :documentable
end
```

This allows a single `documents` table to store documents for properties, contractors, and lawyers, with `documentable_type` storing the class name and `documentable_id` storing the record ID.

## Seed Data

The application includes comprehensive seed data:
- **3 Properties** (Sunset Plaza, Riverside Apartments, Tech Hub Office Park)
- **6 Contractors** with various specialties
- **4 Lawyers** from different firms
- **8 Documents** demonstrating polymorphic associations across all entity types

## Testing

The test suite includes:

### Model Tests
- **PropertyTest**: Verifies has_many associations (contractors, lawyers, documents)
- **DocumentTest**: Verifies polymorphic belongs_to associations
- **Association Tests**: Ensures dependent destroy behavior works correctly

Run tests with:
```bash
bin/rails test
```

All tests should pass with 9 runs, 36 assertions, 0 failures.

## Vite + Rails Integration

This application demonstrates modern JavaScript development in Rails using Vite:

### Key Features
- **Native ESM** in development for instant server start
- **Hot Module Replacement** for instant updates without page refresh
- **Optimized Production Builds** using Rollup
- **ES6+ Support** including classes, modules, async/await
- **Fast Compilation** with esbuild

### File Structure
- **Entrypoints**: `app/javascript/entrypoints/` - Vite entry files
- **Configuration**: `vite.config.ts` - Vite TypeScript config
- **Build Output**: `public/vite/` - Production builds (gitignored)

### Development Workflow
1. Start dev server with `bin/dev`
2. Edit JavaScript files in `app/javascript/entrypoints/`
3. See changes instantly with HMR (no page refresh needed)
4. Check browser console for Vite logs

## Production Build

To build assets for production:

```bash
# Build Vite assets
bin/vite build

# Precompile all assets
bin/rails assets:precompile
```

Built assets are placed in `public/vite/` and referenced via manifest files.

## Troubleshooting

### Vite not loading
- Ensure Vite dev server is running: `bin/vite dev`
- Check that port 3036 is not in use
- Verify `app/views/layouts/application.html.erb` includes Vite tags

### Database issues
- Reset database: `bin/rails db:reset`
- Check migrations: `bin/rails db:migrate:status`

### JavaScript not working
- Check browser console for errors
- Verify Node modules are installed: `npm install`
- Ensure Vite dev server is running

### Tests failing
- Reset test database: `RAILS_ENV=test bin/rails db:reset`
- Clear test cache: `rm -rf tmp/cache`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests to ensure they pass
5. Commit your changes
6. Push to the branch
7. Create a Pull Request

## License

This project is available as open source under the terms of the MIT License.
