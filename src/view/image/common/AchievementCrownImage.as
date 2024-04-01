package view.image.common {

import flash.events.Event;

import view.image.BaseImage;

/**
 * FriendStateImage表示クラス
 *
 */

public class AchievementCrownImage extends BaseImage {

    // 表示元SWF
    [Embed(source="../../../../data/image/achievement/trophy.swf")]
    private var _Source:Class;

    /**
     * コンストラクタ
     *
     */
    public function AchievementCrownImage() {
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
