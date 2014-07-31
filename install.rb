module OS
  def OS.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
   (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
    !OS.windows?
  end

  def OS.linux?
    OS.unix? and not OS.mac?
  end
end

if OS.linux?
	ruby_exe = `which ruby`.chomp
	if !File.exists?(ruby_exe)
		puts 'ERR: Ruby not found... but this is a ruby script... weird.'
		return
	end
	script = File.join(__dir__, 'dynipo.rb')
	if !File.exists?(script)
		puts "ERR: Can't find the dynipo.rb script."
		return
	end
	# Install
	`crontab -l | { cat; echo "\n#Dynipo updates every minute\n* * * * * #{ruby_exe} #{File.join(__dir__, 'dynipo.rb')}"; } | crontab -`
elsif OS.windows?
	puts 'Windows support coming soon...'
else
	puts 'Your platform is not supported.'
end
