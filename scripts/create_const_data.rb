# frozen_string_literal: true

require 'find'
require 'pathname'
require 'json'

DATA_PATH = Pathname.new('./tmp/export')
SEPARATOR = ','

# rubocop:disable Style/Documentation
class Serializer
  def call(items)
    items.map do |item|
      "            [#{build(item)}]"
    end.join("#{SEPARATOR}\n")
  end

  private

  def build(item)
    raise NotImplementedError
  end

  def quote?(value)
    value.is_a?(String) || value.is_a?(Time) || value.nil?
  end
end

class ColumnSerializer < Serializer
  attr_reader :columns

  def initialize(*columns)
    super()
    @columns = columns.map(&:to_s)
  end

  private

  def build(item)
    item.values_at(*columns).map do |value|
      next "\"#{value}\"" if quote?(value)

      value
    end.join(SEPARATOR)
  end
end

class AvatarPartSerializer < Serializer
  private

  def build(item) # rubocop:disable Metrics
    [
      item['id'],
      "\"#{item['name']}\"",
      "\"#{extract_image(item['image'])}\"",
      item['parts_type'] || 0,
      item['color'] || 0,
      item['offset_x'] || 0,
      item['offset_y'] || 0,
      item['offset_scale'] || 0,
      item['power_type'] || 0,
      item['power'] || 0,
      item['duration'] || 0,
      "\"#{trans_caption(item['caption'], item['power'])}\""
    ].join(SEPARATOR)
  end

  def extract_image(image)
    image.gsub(/\+dummy_.{1,3}/, '')
  end

  def trans_caption(caption, power)
    return '' unless caption

    caption.gsub('__POW__', power.to_s)
  end
end
# rubocop:enable Style/Documentation

SERIALIZERS = {
  'chara_cards' => nil,
  'action_cards' => ColumnSerializer.new(*%w[id u_type u_value b_type b_value event_no image caption]),
  'weapon_cards' => nil,
  'feats' => ColumnSerializer.new(*%w[id name effect_image caption]),
  'passive_skills' => nil,
  'avatar_items' => ColumnSerializer.new(*%w[id name item_no kind sub_kind cond image image_frame effect_image
                                             caption]),
  'event_cards' => ColumnSerializer.new(*%w[id name event_no card_cost color max_in_deck restriction image caption]),
  'quests' => nil,
  'quest_lands' => nil,
  'quest_maps' => ColumnSerializer.new(*%w[id name caption region level ap difficulty]),
  'rare_card_lots' => ColumnSerializer.new(*%w[id lot_kind article_kind article_id order visible description num]),
  'real_money_items' => ColumnSerializer.new(*%w[id name price rm_item_type item_id num order state image_url tab
                                                 description view_frame extra_id sale_type deck_image_url]),
  'avatar_parts' => AvatarPartSerializer.new,
  'shops' => nil,
  'achievements' => nil,
  'profound_datas' => nil,
  'profound_treasure_datas' => ColumnSerializer.new(*%w[id level prf_trs_type rank_min rank_max treasure_type
                                                        treasure_id slot_type value]),
  'charactors' => nil
}.freeze

generated_data = {}
SERIALIZERS.each do |table, serializer|
  puts "Processing #{table}..."
  next if serializer.nil?

  dataset = JSON.parse(DATA_PATH.join("#{table}.json").read)
  next if dataset.empty?

  puts "|> Generating data for #{table}, #{dataset.size} items found..."
  generated_data[table] = serializer.call(dataset)
rescue StandardError => e
  puts e
  next
end

# TODO: Generate correct data
cc_data = ''
wc_data = ''
passive_skill_data = ''
quest_data = ''
quest_land_data = ''
shop_data = ''
achievement_data = ''
profound_data = ''
chara_data = ''

file = Pathname.new('./src/model/utils/ConstData.as')

INLINE_FUNC = <<INLINE_AREA
        public static function dataInit(msg:String):void
        {
            __dec_msg = msg;
            var i:int = 0;
            var cst_data_len:int = DATA.length;
            for ( i = 0; i < cst_data_len; i++ ) {
                 __DATA[i] = DATA[i];
            }
            log.writeLog(log.LV_INFO, "[ConstData] dataInit is Success.");
            __isInit = true;
        }

INLINE_AREA

cc_zero_str = '[0,"","",0,0,0,0,0,0,0,"","","","","","",0,0,0, "", "",0,"",,[]],'

file.open('w') do |f| # rubocop:disable Metrics/BlockLength
  f.puts DATA.read
             .gsub('__actioncard_zero__', '            [0,0,0,0,0,0,"",""],')
             .gsub('__feat_zero__', '            [0,"","",""],')
             .gsub('__passive_skill_zero__', '            [0,0,"","","",""],')
             .gsub('__cc_zero__', "            #{cc_zero_str}")
             .gsub('__avatritem_zero__', '            [0, "", 0, 0, "", "", "",0,"",""],')
             .gsub('__eventcard_zero__', '            [0, "", 0, 0, 0, 0, "", "", ""],')
             .gsub('__quest_zero__', '            [0, "", "", 0, 0, 0, 0, "", "", 0, 0],')
             .gsub('__questland_zero__', '            [0, "",  0, 0, 0, 0, ""],')
             .gsub('__questmap_zero__', '            [0, "", "", 0, 0, 0, 0],')
             .gsub('__weapon_zero__', '            [0, "", 0, 0, [], "", "",0,0,0,0,0,0,[]],')
             .gsub('__rmi_zero__', '            [0,"",0,0,0,0,0,0,"",0,"",0,0,0,""],')
             .gsub('__lot_zero__', '            [0, 0, 0, 0, 0, 0, ""],')
             .gsub('__ap_zero__', '            [0, "", "", 0, 0, 0, 0, 0,0,0,0,""],')
             .gsub('__achievement_zero__', '            [0, 0,"","",0,""],')
             .gsub('__profound_data_zero__', '            [0, 0,"",0,0,0,0,0,"",0,"","",0],')
             .gsub('__prf_trs_data_zero__', '            [0,0,0,0,0,0,0,0,0],')
             .gsub('__chara_zero__', '            [0, "",""],')
             .gsub('__actioncarddata__', generated_data['action_cards'].dup.force_encoding('UTF-8'))
             .gsub('__featdata__', generated_data['feats'].dup.force_encoding('UTF-8'))
             .gsub('__passiveskilldata__', passive_skill_data.dup.force_encoding('UTF-8'))
             .gsub('__ccdata__', cc_data.dup.force_encoding('UTF-8'))
             .gsub('__avatritemdata__', generated_data['avatar_items'].dup.force_encoding('UTF-8'))
             .gsub('__eventcarddata__', generated_data['event_cards'].dup.force_encoding('UTF-8'))
             .gsub('__questdata__', quest_data.dup.force_encoding('UTF-8'))
             .gsub('__questlanddata__', quest_land_data.dup.force_encoding('UTF-8'))
             .gsub('__questmapdata__', generated_data['quest_maps'].dup.force_encoding('UTF-8'))
             .gsub('__weapondata__', wc_data.dup.force_encoding('UTF-8'))
             .gsub('__lotdata__', generated_data['rare_card_lots'].dup.force_encoding('UTF-8'))
             .gsub('__rmidata__', generated_data['real_money_items'].dup.force_encoding('UTF-8'))
             .gsub('__apdata__', generated_data['avatar_parts'].dup.force_encoding('UTF-8'))
             .gsub('__shopdata__', shop_data.dup.force_encoding('UTF-8'))
             .gsub('__achidata__', achievement_data.dup.force_encoding('UTF-8'))
             .gsub('__prfdata__', profound_data.dup.force_encoding('UTF-8'))
             .gsub('__prf_trs_data__', generated_data['profound_treasure_datas'].dup.force_encoding('UTF-8'))
             .gsub('__charadata__', chara_data.dup.force_encoding('UTF-8'))
             .gsub('__init_func__', INLINE_FUNC.dup.force_encoding('UTF-8'))
end

__END__
package model.utils
{
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.utils.ByteArray;
    import flash.net.SharedObject;
    import com.hurlant.crypto.symmetric.ICipher;
    import com.hurlant.crypto.symmetric.IVMode;
    import com.hurlant.crypto.symmetric.IMode;
    import com.hurlant.crypto.symmetric.NullPad;
    import com.hurlant.crypto.symmetric.PKCS5;
    import com.hurlant.crypto.symmetric.IPad;
    import com.hurlant.crypto.prng.Random;
    import com.hurlant.crypto.hash.HMAC;
    import com.hurlant.util.Base64;
    import com.hurlant.util.Hex;
    import com.hurlant.crypto.Crypto;
    import com.hurlant.crypto.hash.IHash;
    /**
     * モデルの定義済み数値ファイル
     *
     *
     */
    public class ConstData
    {
        public static const ACTION_CARD:int     = 0;
        public static const FEAT:int            = 1;
        public static const PASSIVE_SKILL:int   = 2;
        public static const CHARA_CARD:int      = 3;
        public static const AVATAR_ITEM:int     = 4;
        public static const EVENT_CARD:int      = 5;
        public static const QUEST:int           = 6;
        public static const QUEST_LAND:int      = 7;
        public static const QUEST_MAP:int       = 8;
        public static const WEAPON_CARD:int     = 9;
        public static const RARE_CARD_LOT:int   = 10;
        public static const REAL_MONEY_ITEM:int = 11;
        public static const AVATAR_PART:int     = 12;
        public static const SHOP:int            = 13;
        public static const ACHIEVEMENT:int     = 14;
        public static const PROFOUND_DATA:int   = 15;
        public static const PRF_TRS_DATA:int    = 16;
        public static const CHARACTOR:int       = 17;
        private static var __id:int;

        public static const ACTION_CARD_DATA:Array = [
__actioncard_zero__
__actioncarddata__
            ];

       public static const FEAT_DATA:Array = [
__feat_zero__
__featdata__
     ];
       public static const CHARA_CARD_DATA:Array = [
__cc_zero__
__ccdata__
     ];
        public static const AVATAR_ITEM_DATA:Array = [
__avatritem_zero__
__avatritemdata__
            ];

        public static const EVENT_CARD_DATA:Array = [
__eventcard_zero__
__eventcarddata__
            ];

        public static const QUEST_DATA:Array = [
__quest_zero__
__questdata__
            ];

//   0       1      2    3    4    5    6
//  :int, :String,:int,:int,:int, :int,:String,

        public static const QUEST_LAND_DATA:Array = [
__questland_zero__
__questlanddata__
            ];
//      0        1         2    3     4     5     6
    // :int,:String, :String, :int, :int, :int, :int,
        public static const QUEST_MAP_DATA:Array = [
__questmap_zero__
__questmapdata__
            ];
//      0    1       2     3     4       5       6
     // :int,:String :int, :int, :Array,:String,:String,
        public static const WEAPON_CARD_DATA:Array = [
__weapon_zero__
__weapondata__
            ];

//      0     1     2     3     4     5        6
     // :int, :int, :int, :int, :int, :String, :int
        public static const RARE_CARD_LOT_DATA:Array = [
__lot_zero__
__lotdata__
            ];

//      0     1       2     3     4     5     6    7    8       9    10
     // :int, :String,:int, :int, :int, :int, :int,:int,:String,:int,:String
        public static const REAL_MONEY_ITEM_DATA:Array = [
__rmi_zero__
__rmidata__
            ];

      //[:id,:name,:image,:parts_type,:color,:offset_x,:offset_y,:offset_scale,:power_type,:power,:duration,:caption]);
//      0     1       2       3     4     5     6     7
     // :int, :String,:String,:int, :int, :int, :int, :int,:int,:int,:int,:String
        public static const AVATAR_PART_DATA:Array = [
__ap_zero__
__apdata__
            ];

      //[:id,:name,:image,:parts_type,:color,:offset_x,:offset_y,:offset_scale,:power_type,:power,:duration,:caption]);
//      0     1       2       3     4     5     6     7
     // :int, :String,:String,:int, :int, :int, :int, :int,:int,:int,:int,:String
        public static const SHOP_DATA:Array = [
__shopdata__
            ];


      //[:id,:kind,:caption,:exp,]);
//      0     1    2      ,3      ,4      ,5    ,6
     // :int, :int,:String,:String,:String
        public static const ACHIEVEMENT_DATA:Array = [
__achievement_zero__
__achidata__
            ];

        // [:id,:prf_type,:name,:rarity,:level,:ttl,:quest_map_id,:treasure_data,:stage,:boss_name,:boss_max_hp,:caption,:allItems]
        public static const PROFOUND_DATAS:Array = [
__profound_data_zero__
__prfdata__
            ];

        // [:id,:level,:prf_trs_type,:rank_min,:rank_max,:treasure_type,:treasure_id,:slot_type,:value]
        public static const PRF_TRS_DATAS:Array = [
__prf_trs_data_zero__
__prf_trs_data__
            ];

         public static const PASSIVE_SKILL_DATA:Array = [
                                                         __passive_skill_zero__
                                                         __passiveskilldata__
                                                        ];

      //[:id,:name,:lobby_image]);
      // 0     1
      // :int,:String,:String
        public static const CHARACTOR_DATA:Array = [
__chara_zero__
__charadata__
            ];

      public static const DATA:Array = [
                                        ACTION_CARD_DATA,
                                        FEAT_DATA,
                                        PASSIVE_SKILL_DATA,
                                        CHARA_CARD_DATA,
                                        AVATAR_ITEM_DATA,
                                        EVENT_CARD_DATA,
                                        QUEST_DATA,
                                        QUEST_LAND_DATA,
                                        QUEST_MAP_DATA,
                                        WEAPON_CARD_DATA,
                                        RARE_CARD_LOT_DATA,
                                        REAL_MONEY_ITEM_DATA,
                                        AVATAR_PART_DATA,
                                        SHOP_DATA,
                                        ACHIEVEMENT_DATA,
                                        PROFOUND_DATAS,
                                        PRF_TRS_DATAS,
                                        CHARACTOR_DATA,
                                       ];

        private static var __DATA:Array = [];
        private static var __dec_msg:String = "";
        private static var __isInit:Boolean = false;

__init_func__

        public static function isInited():Boolean
        {
            return __isInit;
        }

        public static function getData(type:int, id:int):Array
        {
            __id = id;
            return  __DATA[type].filter(getID)[0];
        }

        public static function getDataList(type:int):Array
        {
            return __DATA[type];
        }

        private static function getID(item:*, index:int, array:Array):Boolean
        {
           return item[0] == __id;
        }

        private static function decrypt(text:String):Array
        {
           var kdata:ByteArray;
           kdata = Hex.toArray(Hex.fromString(__dec_msg));

           var data:ByteArray;
           data =  Base64.decodeToByteArray(text);

           var name:String;
           name = "rc4-cbc";

           var pad:IPad = new PKCS5;
           var mode:ICipher = Crypto.getCipher( name, kdata, pad );
           pad.setBlockSize(mode.getBlockSize());
           if ( mode is IVMode ) {
               var ivmode:IVMode = mode as IVMode;
               ivmode.IV = Hex.toArray(text);
           }
           mode.decrypt(data);
           data.position = 0;
           var data_arr:Array = data.readObject();
           return data_arr;
        }
    }
}
