package view.image.shop {
import view.image.BaseImage;

/**
 * SignImaage表示クラス
 *
 */


public class SignImage extends BaseImage {

    // HP表示元SWF
    [Embed(source="../../../../res/data/image/shop/sign_price.swf")]
    private var _Source:Class;
    private var _type:int = 0;

    /**
     * コンストラクタ
     *
     */
    public function SignImage() {
        super();
    }

    override protected function get Source():Class {
        return _Source;
    }


}

}

