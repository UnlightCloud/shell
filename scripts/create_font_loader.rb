# frozen_string_literal: true

require 'find'
require 'pathname'

SUPPORT_CHARACTERS = {}
File.readlines('data/all_griph_HanWangMingHeavy.txt').each do |line|
  line.scan(/./m) { |ch| SUPPORT_CHARACTERS[ch] = 'OK' }
end

# 文字をカウント
GAME_CHARACTERS = {}
if File.directory?('./data/export')
  Find.find('./data/export') do |f|
    next if File.directory?(f)

    Find.prune if f.split('/').size > 4

    File.readlines(f).each do |line|
      line.scan(/./m) { |ch| GAME_CHARACTERS[ch] = format 'U+%04X', ch.unpack1('U*') }
    end
  end
end

error_count = 0

CHECK_TABLE = GAME_CHARACTERS.dup
CHECK_TABLE.update(SUPPORT_CHARACTERS)
CHECK_TABLE.each do |char, unicode|
  next if unicode == 'OK'

  puts "This griph undefind #{char},#{unicode}"
  error_count += 1
end
puts "Unsupported Characters: #{error_count}."

file = Pathname.new('src/FontLoader.as')
file.open('w') do |f|
  f.puts DATA.read
             .gsub('__font_UTF_NO__', ", unicodeRange='#{GAME_CHARACTERS.values.sort!.join(',')}'")
             .gsub('__FONT_H__', 'wt004.ttf')
             .gsub('__FONT_R__', 'cwming.ttf')
end
puts "#{GAME_CHARACTERS.size} 文字を登録しました"

__END__
[Embed(source='../data/__FONT_H__', fontName='minchoB'__font_UTF_NO__, embedAsCFF='false')]
private static const Font:Class;
[Embed(source='../data/__FONT_R__', fontName='mincho'__font_UTF_NO__, embedAsCFF='false')]
private static const Font2:Class;
[Embed(source='../data/nbr.ttf', fontName='bradley', embedAsCFF='false')]
private static const Font3:Class;


