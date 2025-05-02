# RailsSaaS

A Software as a Service (SaaS) application built with Ruby on Rails, featuring multi-tenancy and user authentication.

## Tech Stack

* Ruby 3.1.2
* Rails 7.1.5
* PostgreSQL
* Devise for authentication
* Hotwire (Turbo & Stimulus)
* Sprockets for asset pipeline
* Import Maps for JavaScript modules

## Prerequisites

* Ruby 3.1.2 or higher
* PostgreSQL
* Node.js
* Yarn

## Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd railsaas
```

2. Install dependencies:
```bash
bundle install
yarn install
```

3. Database setup:
```bash
rails db:create
rails db:migrate
rails db:seed
```

4. Start the server:
```bash
bin/dev
```

Visit `http://localhost:3000` to access the application.

## Features

* Multi-tenancy support
* User authentication with Devise
* Modern JavaScript with Hotwire
* Responsive UI
* PostgreSQL database

## Running Tests

```bash
rails test
```

## Development

The application uses:
* Hotwire for reactive UI updates
* Import maps for JavaScript management
* Standard Rails conventions

## Deployment

The application can be deployed to any platform supporting Ruby on Rails applications like:
* Heroku
* AWS
* Digital Ocean

## Environment Variables

Create a `.env` file in the root directory with:

```
DATABASE_URL=your_database_url
RAILS_MASTER_KEY=your_master_key
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Make your changes
4. Run the test suite
5. Submit a pull request

## License

This project is licensed under the MIT License.
