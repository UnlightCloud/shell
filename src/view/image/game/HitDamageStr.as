package view.image.game {

import flash.events.Event;

import view.image.BaseImage;

/**
 * ヒットエフェクト表示クラス
 *
 */

public class HitDamageStr extends BaseImage {
    // atkダイス表示元SWF
    [Embed(source="../../../../data/image/game/text_damage.swf")]
    private static var _source:Class;

    // ゲームのコントローラ

    /**
     * コンストラクタ
     *
     */
    public function HitDamageStr() {
        super();
    }

    override protected function swfinit(event:Event):void {
        super.swfinit(event);
    }

    override protected function get Source():Class {
        return _source;
    }
}
}
