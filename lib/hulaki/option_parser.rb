require_relative 'recursive_ostruct'
require 'fileutils'
require 'optparse'
# require File.expand_path('../string_modifier', __FILE__)
require_relative 'presenter'
class Hulaki::OptionParser
  def initialize
    @config = RecursiveOstruct.ostruct(
        {
            to:      [],
            from:    nil,
            subject: 'Mic testing',
            message: 'sample message',
            command: 'help',
            gateway: nil
        })
  end

  def parse(args)
    options.parse!(args)
    @config
  end

  def options
    OptionParser.new do |opts|
      opts.banner =
          "Usage: \n"\
          "------- Search --------\n"\
          "$ hulaki -s search-string\n"\
          "# Example: Hulaki features fuzzy search\n"\
          "$ hulaki -s smithjohn\n"\
          "$ hulaki -s johsmith\n"\
          "$ hulaki -s smijohnth\n"\
          "\n"\
          "------- Copy PhoneNumber to ClipBoard -----------\n"\
          "$ hulaki -s smithjohn -c \n"\
          "# You will see phone_number of the top result copied to ClipBoard \n"\
          "# Number '+97798xxx66455' is copied to your clipboard\n"\
          "\n"\
          "------- SMS --------\n"\
          "$ hulaki -t +977xxxxxxxxxx -m \"Message to be sent\"\n"\
          "\n"\
          "# You can even select a specific SMS Gateway\n"\
          "$ hulaki -t +977xxxxxxxxxx -m \"Message to be sent\" -g nexmo\n"\
          "$ hulaki -t +61xxxxxxxxxx  -m \"Message to be sent\" -g twilio\n"\
          "$ hulaki -t +1xxxxxxxxxx   -m \"Message to be sent\" -g sparrow\n"\
          "\n"\
          "# You can even broadcast SMSes selecting a specific SMS Gateway\n"\
          "#   However, keep in mind that multiple SMS request will go to the server\n"\
          "$ hulaki -t +977xxxxxxxxxx,+9779832xxxxxx -m \"Message to be sent\" -g nexmo\n"\
          "\n"\
          "# You can also change the name that appears on recipient's Phone using `-f` switch. This only works with Nexmo\n"\
          "$ hulaki -t +977xxxxxxxxxx,+9779832xxxxxx -m \"Message to be sent\" -g nexmo -f \"Hero Dai!\"\n"\
          "\n"\
          "------- EMAIL --------\n"\
          "$ hulaki -t someone@example.com -S \"Subject of the email\" -m \"Message to be sent\"\n"\
          "$ hulaki -t someone@example.com --subject \"Subject of the email\" -m \"Message to be sent\"\n"\
          "\n"\
          "# You can even broadcast emails, i.e. mutiple recipients\n"\
          "#   However, keep in mind that multiple SMTP request will go to the server. No `CC`, `BCC` will be used\n"\
          "$ hulaki -t someone@example.com,nextperson@email.com --subject \"Subject of the email\" -m \"Message to be sent\"\n"\
          "\n"\
          "# You can also change your sender id using `-f` switch\n"\
          "$ hulaki -t someone@example.com -S \"Subject of the email\" -m \"Message to be sent\" -f \"My Name<anonymous@example.com>\" \n"\
          "\n"\
          "------- EMAIL TEMPLATES --------\n"\
          "# You are allowed to have an Email template in HTML format at `~/hulaki/template.html.erb` which\n"\
          "#   will be copied when you use `-i` switch. If you have `use_template` setting set to `true` then only\n"\
          "#   you will be able to use the template\n"\
          "$ hulaki -t someone@example.com -S \"Subject of the email\" -m \"Messagopts.to_se to be sent\"\n"



      opts.separator ''
      opts.separator 'Specific options:'

      # This can be list of emails or phonenumbers separated by commas `,`
      opts.on('-t x,y,z', '--to x,y,z', Array, 'list of recipient, can be') do |recipient_list|
        @config.to = recipient_list
      end

      opts.on('-m [Message]', '--message [Message]', String, 'Message to be sent to recipient') do |message|
        @config.message = message
      end
      "\n"\

      opts.on('-S [Subject]', '--subject [Subject]', String, 'Subject to email') do |subject|
        @config.subject = subject
      end

      opts.on('-c', '--copy', nil, 'Copy phone-number at top to ClipBoard; Linux users need to install `xclip`.') do
        @config.copy_phone_number = true
      end

      opts.on('-g [Gateway Name]', '--gateway [Gateway Name]', String, 'Name of the gateway, `nexmo`, `twilio`, `sparrow` are currently supported') do |gateway|
        @config.gateway = gateway
      end

      opts.on('-f [Sender]', '--from [Sender]', String, "name <email> | PhoneNumber; this will take precedence over `from` in `config.yml`.") do |sender|
        @config.from = sender
      end

      opts.on('-s [name/contact]', '--search [name/contact]', String, 'Search keyword') do |search_keyword|
        @config.search_keyword = search_keyword
      end

      # ----------------------------------------------------------------------
      opts.on('-h', '--help', 'Help / Examples') do
        puts Utils.present(opts)
        exit
      end

      opts.on('-l', '--list', 'list all the options available') do
        puts Utils.present(opts)
        exit
      end

      opts.on('-i', '--install', 'Creates ~/hulaki/config.yml, `template.html.erb`. Will ask you if have to replace them') do
        Utils.install_dependencies
        Utils.create_dir
        Utils.start_copying_file
        exit
      end
    end
  end
end
