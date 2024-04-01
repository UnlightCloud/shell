package view.image.common {

import view.image.BaseLoadImage;

/**
 * StoryImage表示クラス
 *
 */


public class StoryImage extends BaseLoadImage {


    private var _obverse:Boolean = false;

    /**
     * コンストラクタ
     *
     */
    public function StoryImage(url:String) {
        super(url);
    }

    public override function init():void {
        _root.cacheAsBitmap = true;
    }


}

}
