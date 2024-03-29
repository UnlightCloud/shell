# frozen_string_literal: true

require 'pathname'

MAIN_VERSION = 'Abyss.'
REVISION = ENV.fetch('GITHUB_SHA', 'main').slice(0, 7)

file = Pathname.new('./lib/Version.as')
file.open('w') { |f| f.puts DATA.read.gsub('__NO__', MAIN_VERSION).gsub('__REVISION__', REVISION) }

__END__
package
{
    public class Version
    {
        public static const NO:String = "__NO__";
        public static const REVISION:String = "__REVISION__";

    }
}
