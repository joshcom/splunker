require 'optparse'

if ENV["SPLUNKER_CONSOLE"].nil?
  require 'splunker'
else
  puts "Enabling console mode for local gem"
  Bundler.require(:default, "development") if defined?(Bundler)
  path = File.expand_path(File.dirname(__FILE__) + "/../../lib/")
  $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
  require path + '/splunker'
end

module Splunker
  module CLI
    class ConsoleCLI

      OPTIONS_ENV = {
        :debug=> "DEBUG",
        :console => "SPLUNKER_CONSOLE"
      }

      def self.execute(stdout, arguments=[])
        options = setup_options(stdout,arguments)

        libs =  " -r irb/completion"
        setup = " -r #{File.dirname(__FILE__) + '/../../lib/splunker/cli/setup.rb'}"

        bundler = (options[:console] ? "bundle exec" : "")  
        cmd = "#{export_env(options)} #{bundler} #{irb} #{libs} #{setup} --simple-prompt"
        puts "Loading splunker gem..."
        exec "#{cmd}"
      end
      
      def self.irb()
        RUBY_PLATFORM =~ /(:?mswin|mingw)/ ? 'irb.bat' : 'irb'
      end

      private

      def self.setup_options(stdout,arguments)
        env_options = {
          :console => ENV[OPTIONS_ENV[:console]]
        }
        cli_options = {}
        file_options = {}
        parser = OptionParser.new do |opts|
          opts.banner = <<-BANNER.gsub(/^          /,'')
            #{version}
            Splunk Client Console

            Proudly copied from Wade Mcewen's CLI code from the spark_api client.
            
            Usage: #{File.basename($0)} [options]
            
            Environment Variables: some options (as indicated below), will default to values of keys set in the environment. 
        
            Options are:
          BANNER
          opts.separator ""
          opts.on("-e","--endpoint ENDPOINT",
                  "URI of the API.",
                  "Default: ENV['#{OPTIONS_ENV[:endpoint]}']") { |arg| cli_options[:endpoint] = arg }

                    
          opts.on("-v", "--version",
                  "Show client version.") { stdout.puts version; exit }
          opts.on("-h", "--help",
                  "Show this help message.") { stdout.puts opts; exit }
          opts.parse!(arguments)
        
        end
        options = env_options.merge(file_options.merge(cli_options))
        return options
      end

      def self.export_env(options)
        run_env = ""
        OPTIONS_ENV.each do |k,v|
          run_env << " #{v}=\"#{options[k]}\"" unless options[k].nil?
        end
        run_env
      end

      def self.version
        "Splunker v#{Splunker::VERSION}"
      end
    end
  end
end
