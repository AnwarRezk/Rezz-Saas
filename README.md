# RailsSaaS

A Software as a Service (SaaS) application built with Ruby on Rails, featuring multi-tenancy, user authentication, and invitation system.

## Tech Stack

* Ruby 3.1.2
* Rails 7.1.5
* PostgreSQL
* Devise & DeviseInvitable for authentication and user invitations
* Acts As Tenant for multi-tenancy
* Hotwire (Turbo & Stimulus)
* Sprockets & SassC for asset pipeline
* Import Maps for JavaScript modules
* Docker support for containerization

## Prerequisites

* Ruby 3.1.2 or higher
* PostgreSQL
* Node.js
* Docker (optional, for containerized deployment)

## Setup

### Standard Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd railsaas
```

2. Install dependencies:
```bash
bundle install
```

3. Database setup:
```bash
rails db:create
rails db:migrate
```

4. Start the server:
```bash
bin/dev
```

### Docker Setup

1. Build the Docker image:
```bash
docker build -t railsaas .
```

2. Run the container:
```bash
docker run -p 3000:3000 railsaas
```

Visit `http://localhost:3000` to access the application.

## Features

* Multi-tenancy support with Acts As Tenant
* User authentication with Devise
* User invitation system
* Modern JavaScript with Hotwire (Turbo & Stimulus)
* Responsive UI with Sass styling
* PostgreSQL database
* Docker support for easy deployment

## Development

The application uses:
* Hotwire for reactive UI updates
* Import maps for JavaScript management
* Standard Rails conventions
* Letter Opener for email preview in development
* Annotate for model/schema documentation

## Environment Variables

Create a `.env` file in the root directory with:

```
DATABASE_URL=your_database_url
RAILS_MASTER_KEY=your_master_key
```

## Deployment

The application can be deployed using:
* Docker containers
* Traditional Rails deployment platforms:
  * Heroku
  * AWS
  * Digital Ocean

## Contributing

1. Fork the repository
2. Create your feature branch
3. Make your changes
4. Run the test suite
5. Submit a pull request

## License

This project is licensed under the MIT License.
