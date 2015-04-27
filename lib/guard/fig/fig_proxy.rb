require 'guard/plugin'

module Guard
  class Fig < Plugin
    class FigProxy
      attr_reader :command

      def initialize(options)
        @command = options.fetch(:command, 'fig')
      end

      def build(service = nil)
        system "#{command} build #{service}"
      end

      def up recreate: true
        cmd = "#{command} up -d"
        unless recreate
          cmd << " --no-recreate"
        end
        system cmd
      end

      def stop(service = nil)
        system "#{command} stop #{service}"
      end

      def remove(service)
        system "#{command} rm --force #{service}"
      end
    end
  end
end
