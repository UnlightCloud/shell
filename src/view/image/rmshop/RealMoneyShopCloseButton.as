package view.image.rmshop {

import flash.events.Event;

import view.image.BaseImage;

/**
 * EventCardValue表示クラス
 *
 */

public class RealMoneyShopCloseButton extends BaseImage {
    [Embed(source="../../../../res/data/image/rmshop/close_shop.swf")]
    private var _Source:Class;

    /**
     * コンストラクタ
     *
     */
    public function RealMoneyShopCloseButton() {
        super();
    }

    override protected function swfinit(event:Event):void {
        super.swfinit(event);
    }

    override protected function get Source():Class {
        return _Source;
    }


}

}
