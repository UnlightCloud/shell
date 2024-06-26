package view.image.raid {

import flash.geom.*;

import view.image.game.HPGauge;

/**
 * HPゲージ表示クラス
 *
 */

public class ListHPGauge extends HPGauge {
    private static const _X:int = 0;
    private static const _Y:int = 0;

    private static const _W:int = 144;
    private static const _H:int = 1;

    /**
     * コンストラクタ
     *
     */
    public function ListHPGauge() {
        super();
        addChild(_gauge);
        x = _X;
        y = _Y;
    }

    override protected function initGauge():void {
        _gauge.graphics.clear();
        _gauge.graphics.lineStyle(0, 0x000000, 0);
        _gauge.graphics.beginFill(0x000000);
        _gauge.graphics.drawRect(0, 0, _W, _H);
        _gauge.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0);
    }


}

}
