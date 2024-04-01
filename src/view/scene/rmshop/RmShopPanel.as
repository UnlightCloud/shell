package view.scene.rmshop {
import flash.display.*;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.*;

import mx.controls.*;
import mx.core.UIComponent;

import view.*;
import view.image.rmshop.*;
import view.scene.BaseScene;

/**
 * ShopInventoryClipの表示クラス
 *
 */

public class RmShopPanel extends BaseScene {
    // 描画コンテナ
    private var _container:UIComponent = new UIComponent();
    public var BG:Shape = new Shape();
    private var _button:RealMoneyShopCloseButton = new RealMoneyShopCloseButton();


    // タイトル表示
    private var _title:Label = new Label();
    private var _titleJ:Label = new Label();

    // 定数
    private const _TITLE_X:int = 15;
    private const _TITLE_Y:int = 5;
    private const _TITLE_WIDTH:int = 100;
    private const _TITLE_HEIGHT:int = 25;

    /**
     * コンストラクタ
     *
     */
    public function RmShopPanel() {
        BG.graphics.beginFill(0x101010);
        BG.graphics.drawRect(0, 0, Unlight.WIDTH, 240);
        BG.graphics.endFill();
        BG.y = 250;
        BG.alpha = 0.9;
        BG.filters = [new GlowFilter(0x101010, 0.9, 0, 110, 4, 1),];
//            _button.label = "X";
        _button.width = 25;
        _button.height = 25;
        _button.x = 710;
        _button.y = 227;
        _button.addEventListener(MouseEvent.CLICK, clickHandler);
        addChild(BG);
        addChild(_button);
    }


    private function clickHandler(e:Event):void {
        RealMoneyShopView.hide();
    }

    private function setClipPayType():void {
    }

    public function get closeButton():UIComponent {
        return _button;
    }

}
}
