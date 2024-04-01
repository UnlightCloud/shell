package view.image.game {

import flash.events.Event;

import view.image.BaseImage;

/**
 * ヒットエフェクト表示クラス
 *
 */
public class BaseHitEffect extends BaseImage {
    // atkダイス表示元SWF
    private static var _source:Class;

    /**
     * コンストラクタ
     *
     */
    public function BaseHitEffect() {
        super();
        x = Math.random() * 30;
        y = Math.random() * 50;
        rotation = Math.random() * 360;

    }

    override protected function swfinit(event:Event):void {
        super.swfinit(event);
    }

    override protected function get Source():Class {
        return _source;
    }

    // 初期化処理
    public function initializeEffect():void {
    }

}
}
