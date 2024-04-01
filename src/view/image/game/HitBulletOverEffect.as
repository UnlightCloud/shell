package view.image.game {

import flash.events.Event;

/**
 * ヒットエフェクト表示クラス
 *
 */

public class HitBulletOverEffect extends BaseHitEffect {
    // atkダイス表示元SWF
    [Embed(source="../../../../data/image/game/effect_hit_bullet_p.swf")]
    private static var _source:Class;

    // ゲームのコントローラ

    /**
     * コンストラクタ
     *
     */
    public function HitBulletOverEffect() {
        super();
    }

    override protected function swfinit(event:Event):void {
        super.swfinit(event);
        _root.visible = false;
        _root.stop();
    }

    override protected function get Source():Class {
        return _source;
    }

    public function onAnime():void {
        waitComplete(onAnimeComplete);
    }

    public function onAnimeComplete():void {
        _root.visible = true;
        _root.play();
        SE.getDamageGunSEThread(0).start();
    }
}
}
