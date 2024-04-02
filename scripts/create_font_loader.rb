# frozen_string_literal: true

require 'find'
require 'pathname'

EXPORT_PATH = 'tmp/export'

ACTIONSCRIPT_CONSTANT_PATH = "#{EXPORT_PATH}/constants.txt"
ACTIONSCRIPT_END = /;/.freeze
EXCLUDE_LOCALE = /LOCALE_EN|LOCALE_JP|LOCALE_SCN|LOCALE_KR|LOCALE_FR|LOCALE_ID|LOCALE_TH/.freeze
STRING_QUOTE = /"(.*)"|'(.*)'/.freeze

SUPPORT_CHARACTERS = 'res/data/all_griph_HanWangMingHeavy.txt'

support_characters = {}
File.readlines(SUPPORT_CHARACTERS).each do |line|
  line.scan(/./m) { |ch| support_characters[ch] = true }
end

system('grep -C2 -r  "\".*\"" src/ |' \
       'grep -v "tmp" |' \
       'grep -v "#" |' \
       'grep -v -e "writeLog" -e "TAGS" >' +
       ACTIONSCRIPT_CONSTANT_PATH)

constants = []
skip_next = false
File.readlines(ACTIONSCRIPT_CONSTANT_PATH).each do |line|
  encoded_line = line.force_encoding('UTF-8')
  if encoded_line.match?(EXCLUDE_LOCALE)
    skip_next = true
    next
  end

  if skip_next
    skip_next = false if encoded_line.match?(ACTIONSCRIPT_END)
    next
  end

  string = encoded_line.match(STRING_QUOTE)
  constants << string[1] if string
end
File.write(ACTIONSCRIPT_CONSTANT_PATH, constants.join("\n"))

# 文字をカウント
game_characters = {}
if File.directory?(EXPORT_PATH)
  Find.find(EXPORT_PATH) do |f|
    next if File.directory?(f)

    Find.prune if f.split('/').size > 4

    File.readlines(f).each do |line|
      line.scan(/./m) { |ch| game_characters[ch] = format 'U+%04X', ch.unpack1('U*') }
    end
  end
end

error_count = 0

CHECK_TABLE = game_characters.dup
CHECK_TABLE.update(support_characters)
CHECK_TABLE.each do |char, is_unicode|
  next if is_unicode

  puts "This griph undefind #{char},#{unicode}"
  error_count += 1
end
puts "Unsupported Characters: #{error_count}."

file = Pathname.new('src/FontLoader.as')
file.open('w') do |f|
  f.puts DATA.read
             .gsub('__font_UTF_NO__', ", unicodeRange='#{game_characters.values.sort!.join(',')}'")
             .gsub('__FONT_H__', 'wt004.ttf')
             .gsub('__FONT_R__', 'cwming.ttf')
end
puts "#{game_characters.size} 文字を登録しました"

__END__
[Embed(source='../res/data/__FONT_H__', fontName='minchoB'__font_UTF_NO__)]
private static const Font:Class;
[Embed(source='../res/data/__FONT_R__', fontName='mincho'__font_UTF_NO__)]
private static const Font2:Class;
[Embed(source='../res/data/nbr.ttf', fontName='bradley')]
private static const Font3:Class;
