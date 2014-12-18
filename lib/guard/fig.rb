require 'guard'
require 'guard/plugin'
require 'yaml'
require "guard/fig/version"

module ::Guard
  class Fig < Plugin
    def initialize(options = {})
      super(options)
      @config = YAML.load_file('fig.yml')
      @fig = FigProxy.new
    end

    def start
      boot2docker_setup if @options[:boot2docker_start]
      @fig.build if @options[:build_on_start]
      @fig.up recreate: false
    end

    def stop
      @fig.stop
    end

    def run_all
      @fig.up
    end

    def run_on_changes(paths)
      debug paths.inspect

      if paths.any? { |x| x =~ /fig\.yml/ }
        @fig.up
      else
        restart_services(paths)
      end
    end

    private

    def restart_services(paths)
      directories = paths.flat_map { |p| p.split("/").first }.uniq
      services = []
      linked_services = []
      @config.each do |service, options|
        if directories.include? options['build']
          services << service
        end
      end
      @config.each do |service, options|
        debug "SERVICE: #{service}. Links #{options['links'].inspect}"
        if options['links'] && options['links'].any? { |l| services.include? l }
          linked_services << service
        end
      end
      debug services.inspect
      services.each do |service|
        @fig.stop service
        @fig.remove service
        @fig.build service
      end
      debug linked_services.inspect
      linked_services.uniq.each do |service|
        @fig.stop service
      end
      unless services.empty?
        @fig.up recreate: false
      end
    end

    def boot2docker_setup
      system "boot2docker up"

      %x{boot2docker shellinit}.scan /export\s+(\S+)=(\S+)/ do |k, v|
        ENV[k] = v
      end
    end

    def debug(msg)
      puts msg if ENV['DEBUG']
    end
  end
end

require "guard/fig/fig_proxy"
