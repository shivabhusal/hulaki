# Hulaki
[![Code Climate](https://codeclimate.com/github/shivabhusal/hulaki/badges/gpa.svg)](https://codeclimate.com/github/shivabhusal/hulaki)
[![Test Coverage](https://codeclimate.com/github/shivabhusal/hulaki/badges/coverage.svg)](https://codeclimate.com/github/shivabhusal/hulaki/coverage)
[![Issue Count](https://codeclimate.com/github/shivabhusal/hulaki/badges/issue_count.svg)](https://codeclimate.com/github/shivabhusal/hulaki)
[ ![Codeship Status for shivabhusal/hulaki](https://codeship.com/projects/49470f10-ba22-0133-af95-025ac38368ea/status?branch=master)](https://codeship.com/projects/135625)

#### Hulaki is a CLI tool to search contact details from your CSV file.

Hulaki makes communication easier by providing ability to search through the contact list. The CLI tool also allows sending direct SMS and/or email to desired person in contact list

## Installation

Install this in your system using command.

    $ gem install hulaki

>**Note:**  
    - Make sure to install this in your default ruby-version gemset. Other wise you may not be able to use the command from anywhere in your terminal emulator.  
    - Or install in every ruby-version gemset; to make the command `$ hulaki` accessible from anywhere.

## Usage
Use the following command for help
```bash
$ hulaki -h
$ hulaki --help
```
### Search phone number or other contact detail
```bash
$ hulaki -s search-string
# Example: Hulaki features fuzzy search
# $ hulaki -s smithjohn
# $ hulaki -s johsmith
# $ hulaki -s smijohnth
```

### Sending SMS
> First search for contact number, copy it

```
$ hulaki -t +977xxxxxxxxxx -m "Message to be sent"
```

## Configuration
- `Hulaki` requires the file `~/hulaki/contact.csv` to be present. 
    -  The file must be a valid `CSV` file.
- When you install the gem, a sample config file is copied to `~/hulaki/config.yml`
    - You need to update your `Twilio` creds
        - `Hulaki` only supports `Twilio` at the moment. 
    - Also, update the SMTP settings accordingly

---

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shivabhusal/hulaki. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

