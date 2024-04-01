package view.image.shop {
import view.image.BaseImage;

/**
 * ShopBuyParamBar表示クラス
 *
 */


public class ShopBuyParamBar extends BaseImage {

    // HP表示元SWF
    [Embed(source="../../../../res/data/image/shop/shop_buy.swf")]
    private var _Source:Class;

    /**
     * コンストラクタ
     *
     */
    public function ShopBuyParamBar() {
        super();
    }

    override protected function get Source():Class {
        return _Source;
    }


}

}

