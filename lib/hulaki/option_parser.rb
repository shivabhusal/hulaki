require_relative 'recursive_ostruct'
require 'fileutils'
require 'optparse'

class Hulaki::OptionParser
  def initialize
    @config = RecursiveOstruct.ostruct(
        {
            to: [],
            from: [],
            message: 'sample message',
            command: 'help'
        })
  end

  def parse(args)
    options.parse!(args)
    @config
  end

  def options
    OptionParser.new do |opts|
      opts.banner = [
          'Usage: ',
          '------- Search --------',
          "$ hulaki search 'ram'",
          '',
          '------- SMS --------',
          "$ hulaki send to:'ram' msg:'Hello' [-s] [--sms]",
          "$ hulaki send to:'9843486993' msg:'Hello' [-s] [--sms]",
          "$ hulaki send -t shiva@example.com msg:'Hello' [-s] [--sms]",
          '',
          '------- EMAIL --------',
      ].join("\n")

      opts.separator ''
      opts.separator 'Specific options:'

      # # Mandatory argument.
      # opts.on('-s', '--sms', Float, 'Flag to set target as sms gateway') do |lib|
      # end
      #
      # # Mandatory argument.
      # opts.on('-e', '--email', Float, 'Flag to set target as email gateway') do |lib|
      #   @config.sms.to = list
      # end

      opts.on('-t x,y,z', '--to x,y,z', Array, 'Help / Examples') do |list|
        # puts list.inspect
        @config.to = list
      end

      # ----------------------------------------------------------------------
      opts.on('-h', '--help', 'Help / Examples') do |lib|
        puts opts.banner
        exit
      end

      opts.on('-l', '--list', 'list all the options available') do |lib|
        puts opts
        exit
      end

      opts.on('-i', '--install', 'Creates ~/hulaki/config.yml') do |lib|
        create_dir
        start_copying_file
        exit
      end

      opts.on('', '', 'Help / Examples') do |lib|
        puts opts.banner
        exit
      end
    end
  end

  def create_dir
    FileUtils.mkdir(File.expand_path('~/hulaki'))
  rescue Errno::EEXIST
    puts 'Directory already exists.'
  end

  def start_copying_file
    this_file = __FILE__
    file_path = File.expand_path('../../lib/hulaki/config/config_sample.yml',
                                 File.dirname(this_file))
    desc_file = File.expand_path('~/hulaki/config.yml')
    if File.exists?(desc_file)
      puts "Looks like the file '#{desc_file}' already exists."
      puts 'shall we forcefully override the file?(yes/no)'
      handle_conflict(file_path, desc_file)
    else
      copy_file(file_path, desc_file)
    end
  end

  def handle_conflict(file_path, desc_file)
    input = gets().chomp()
    if %w{yes y}.include?(input.downcase)
      copy_file(file_path, desc_file)
    else
      puts 'You choose to leave it as it is.'
    end
  end

  def copy_file(file_path, desc_file)
    puts "Creating file '~/hulaki/config.yml' ..."
    FileUtils.cp(file_path, desc_file)
    puts "Created file '~/hulaki/config.yml' ..."
  end
end
