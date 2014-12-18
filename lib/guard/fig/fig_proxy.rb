require 'guard/plugin'

module Guard
  class Fig < Plugin
    class FigProxy
      def build(service = nil)
        system "fig build #{service}"
      end

      def up recreate: true
        cmd = "fig up -d"
        unless recreate
          cmd << " --no-recreate"
        end
        system cmd
      end

      def stop(service = nil)
        system "fig stop #{service}"
      end

      def remove(service)
        system "fig rm --force #{service}"
      end
    end
  end
end
