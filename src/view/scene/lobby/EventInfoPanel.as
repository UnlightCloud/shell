package view.scene.lobby {

import mx.core.UIComponent;

import org.libspark.betweenas3.BetweenAS3;
import org.libspark.betweenas3.easing.*;

import view.ItemListView;
import view.image.lobby.*;
import view.scene.BaseScene;

/**
 * イベント情報パネル表示クラス
 *
 */

public class EventInfoPanel extends BaseScene {
    private var _panel:EventInfoPanelImage = new EventInfoPanelImage();

    // 描画コンテナ
    private var _container:UIComponent = new UIComponent();

    private static const _START_X:int = UnlightLegacy.WIDTH / 2;
    private static const _START_Y:int = UnlightLegacy.HEIGHT / 2;

    /**
     * コンストラクタ
     *
     */
    public function EventInfoPanel() {
        _panel.x = _START_X;
        _panel.y = _START_Y;
        _panel.scaleX = 0.0;
        _panel.alpha = 0.0;
        _panel.scaleX = 0.0;
        _panel.scaleY = 0.0;

        super();
    }

    public override function init():void {
        log.writeLog(log.LV_DEBUG, this, "!!!Set Close Func!");
        _panel.setCloseFunc(hide);
        // _container.addChild(_panel);
        // addChild(_container);

    }

    public function show():void {
        // アイテムリスト排他になければいけないので閉じる
        ItemListView.hide();

        // 作ったVIEWをトップビューに突っ込んで背景はクリックできなくする
        BetweenAS3.serial(
                BetweenAS3.addChild(_panel, UnlightLegacy.INS.topContainer.parent),
                BetweenAS3.to(_panel, {x: 0, y: 0, scaleX: 1.0, scaleY: 1.0, alpha: 1.0}, 0.15, Quad.easeOut)
        ).play();
        UnlightLegacy.INS.topContainer.mouseEnabled = false;
        UnlightLegacy.INS.topContainer.mouseChildren = false;
        _panel.setCloseFunc(hide);
    }

    private function hide():void {
        log.writeLog(log.LV_DEBUG, this, "Info Close Click!");
        BetweenAS3.serial(
                BetweenAS3.tween(_panel, {
                    x: _START_X,
                    y: _START_Y,
                    scaleX: 0.0,
                    scaleY: 0.0,
                    alpha: 0.0
                }, null, 0.15, Sine.easeOut),
                BetweenAS3.removeFromParent(_panel)
        ).play()
        UnlightLegacy.INS.topContainer.mouseEnabled = true;
        UnlightLegacy.INS.topContainer.mouseChildren = true;
    }

}
}
