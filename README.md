# Hulaki
[![Code Climate](https://codeclimate.com/github/shivabhusal/hulaki/badges/gpa.svg)](https://codeclimate.com/github/shivabhusal/hulaki)
[![Test Coverage](https://codeclimate.com/github/shivabhusal/hulaki/badges/coverage.svg)](https://codeclimate.com/github/shivabhusal/hulaki/coverage)
[![Issue Count](https://codeclimate.com/github/shivabhusal/hulaki/badges/issue_count.svg)](https://codeclimate.com/github/shivabhusal/hulaki)
[ ![Codeship Status for shivabhusal/hulaki](https://codeship.com/projects/49470f10-ba22-0133-af95-025ac38368ea/status?branch=master)](https://codeship.com/projects/135625)

#### Hulaki is a CLI tool to search contact details from your CSV file and sending easy SMS and Emails with single command.
![Hulaki Logo](images/hulaki.png)  

Hulaki makes communication easier by providing ability to search through the contact list. The CLI tool also allows sending direct SMS and/or email to desired person in contact list

## Installation
Before you install this, make sure `Ruby >= 1.9` is installed in your system. To install Ruby

```bash
$ sudo apt-get install ruby

# or use RVM to install latest Ruby
```

Install this in your system using command.

    $ gem install hulaki

    # To install default configs and templates
    $ hulaki --install

> **Note**: To users having multiple versions of Ruby installed  
    - Make sure to install this in your default ruby-version gem-set. Other wise you may not be able to use the command from anywhere in your terminal emulator.  
    - Or install in every ruby-version gem-set; to make the command `$ hulaki` accessible from anywhere.


## Usage:
### Search
```bash
$ hulaki -s search-string
# Example: Hulaki features fuzzy search
#  $ hulaki -s smithjohn
#  $ hulaki -s johsmith
#  $ hulaki -s smijohnth

```
**Example Output**
```
$ hulaki -s 'jhn'
+-----+--------------------------------+------------+------------+--------------------+
|                                       Hulaki 1.0                                    |  
+-----+--------------------------------+------------+------------+--------------------+
| S.N | Name                           | Phone 1    | Phone 2    | Email              |
+-----+--------------------------------+------------+------------+--------------------+
| 1   | John Bhusal                    | 984xxx8271 |            | hisemail@gmail.com |
| 2   | Joe Dhakal                     | 984xxx8627 | 980xxx1820 |                    |
| 3   | Jhalak Parajuli                | 985xxx3695 |            |                    |
| 4   | Jonathan Dai  Subedi           | 984xxx4397 |            |                    |
+-----+--------------------------------+------------+------------+--------------------+

```
### SMS
```bash
$ hulaki -t +977xxxxxxxxxx -m "Message to be sent"

# You can even select a specific SMS Gateway
$ hulaki -t +977xxxxxxxxxx -m "Message to be sent" -g nexmo
$ hulaki -t +61xxxxxxxxxx  -m "Message to be sent" -g twilio
$ hulaki -t +1xxxxxxxxxx   -m "Message to be sent" -g sparrow

# You can even broadcast SMSes selecting a specific SMS Gateway
#   However, keep in mind that multiple SMS request will go to the server
$ hulaki -t +977xxxxxxxxxx,+9779832xxxxxx -m "Message to be sent" -g nexmo

# You can also change the name that appears on recipient's Phone using `-f` switch. This only works with Nexmo
$ hulaki -t +977xxxxxxxxxx,+9779832xxxxxx -m "Message to be sent" -g nexmo -f "Hero Dai!"

```

### EMail
```bash
$ hulaki -t someone@example.com -S "Subject of the email" -m "Message to be sent"
$ hulaki -t someone@example.com --subject "Subject of the email" -m "Message to be sent"

# You can even broadcast emails, i.e. mutiple recipients
#   However, keep in mind that multiple SMTP request will go to the server. No `CC`, `BCC` will be used
$ hulaki -t someone@example.com,nextperson@email.com --subject "Subject of the email" -m "Message to be sent"

# You can also change your sender id using `-f` switch
$ hulaki -t someone@example.com -S "Subject of the email" -m "Message to be sent" -f "My Name<anonymous@example.com>"
```

### Email Templates/Layouts
You are allowed to have an Email template in HTML format at `~/hulaki/template.html.erb` which will be copied when you use `-i` switch. If you have `use_template` setting set to `true` then only you will be able to use the template. Templates are like `Layouts` in Rails.
```bash
$ hulaki -t someone@example.com -S "Subject of the email" -m "Message to be sent"
```

### Specific options:
```bash
    -t, --to x,y,z                   list of recipient, can be
    -m, --message [Message]          Message to be sent to recipient
    -S, --subject [Subject]          Subject to email
    -g, --gateway [Gateway Name]     Name of the gateway, `nexmo`, `twilio`, `sparrow` are currently supported
    -f, --from [Sender]              name <email> | PhoneNumber; this will take precedence over `from` in `config.yml`.
    -s, --search [name/contact]      Search keyword
    -h, --help                       Help / Examples
    -l, --list                       list all the options available
    -i, --install                    Creates ~/hulaki/config.yml, `template.html.erb`. Will ask you if have to replace them
```

## Configuration
- `Hulaki` requires the file `~/hulaki/contact.csv` to be present.
    -  The file must be a valid `CSV` file.
- When you install the gem, a sample config and template filea are copied to `~/hulaki/`
    - You need to update the template per requirement.
    - You need to update your SMS gateway(eg. `Twilio`, `nexmo`) creds
        - `Hulaki` only supports `Twilio` and `nexmo` at the moment.
    - Also, update the SMTP settings accordingly

---

## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shivabhusal/hulaki. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
