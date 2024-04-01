package view.image.common {

import flash.events.Event;

import view.image.BaseLoadImage;

/**
 * AvatarItemImage表示クラス
 *
 */


public class AvatarItemImage extends BaseLoadImage {
    private static const URL:String = "/public/image/avatar_items/";
    private var _frame:int;

    /**
     * コンストラクタ
     *
     */
    public function AvatarItemImage(url:String, frame:int = 0) {
        _frame = frame;
//            log.writeLog(log.LV_INFO, this, "url", URL+url);
        super(URL + url);
    }

    override protected function swfinit(event:Event):void {
        super.swfinit(event);
        _root.gotoAndStop(_frame);
        _root.cacheAsBitmap = true;

    }

}
}
