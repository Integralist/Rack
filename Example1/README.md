## Running the application using the Puma webserver

### Different options (pick one)

- `bundle exec puma`
- `rackup -s Puma`
- `#\ -s puma` (add as first line to your `config.ru`)

> Note: last option can be used to set other flags  
Such as the port number -p (see `rackup --help` for all flags)
