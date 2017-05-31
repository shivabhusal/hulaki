module Utils
  def create_dir
    FileUtils.mkdir(File.expand_path('~/hulaki'))
  rescue Errno::EEXIST
    puts 'Looks like directory `~/hulaki` already exists.'.brown
  end

  def install_dependencies
    if `which xclip`.match('not found')
      puts "Looks like you don't `xclip` installed in your system. It is required to copy phone numbers to ClipBoard"
      puts 'We are installing it right now ... '
      puts 'It will ask you password: Be ready'
      puts `sudo apt-get install xclip`.red
      puts '`xclip` successfully installed!'.green
    else
      puts '`xclip` is already installed!'
    end
  end

  def start_copying_file
    # this line is for debugging purposes
    this_file = __FILE__
    files_to_be_copied = {
      'sample.contact.csv'        => 'contact.csv',
      'sample.config.yml'         => 'config.yml',
      'sample.template.html.erb'  => 'template.html.erb'
    }

    # Start copying the files
    files_to_be_copied.each do|source, dest|
      file_path = File.expand_path("../../lib/hulaki/config/#{source}", File.dirname(this_file))
      desc_file = File.expand_path("~/hulaki/#{dest}")
      if File.exist?(desc_file)
        puts "Looks like the file '#{desc_file}' already exists.".brown
        print 'Shall we forcefully override the file?(yes/no)'.brown
        handle_conflict(file_path, desc_file)
      else
        copy_file(file_path, desc_file)
      end
    end
    Hulaki::Logger.log '~'*100
    Hulaki::Logger.log 'Please make sure you have modified the files at `~/hulaki` a/c to your need.'
    Hulaki::Logger.log '~'*100
  end

  def handle_conflict(file_path, desc_file)
    input = gets().chomp()
    if %w{yes y}.include?(input.downcase)
      copy_file(file_path, desc_file)
    else
      Hulaki::Logger.log 'You choose to leave it as it is.'
    end
  end

  def copy_file(file_path, desc_file)
    puts "Creating file '#{desc_file}' ...".brown
    FileUtils.cp(file_path, desc_file)
    Hulaki::Logger.log  "Created file '#{desc_file}' ..."
  end

  def present(object)
    object.to_s.split("\n").map{|x|
      if x[0] == '#'
        x.gray
      elsif x[0] == '$'
        x.green
      elsif x.match('---')
        x.brown
      else
        x
      end
    }.join("\n")
  end

  module_function :create_dir, :start_copying_file, :handle_conflict, :copy_file, :install_dependencies, :present
end
