package view.image.common {

import flash.events.Event;
import flash.events.MouseEvent;

import view.*;
import view.image.BaseImage;

/**
 * AchievementListButton表示クラス
 *
 */

public class AchievementListButton extends BaseImage {

    // 表示元SWF
    [Embed(source="../../../../data/image/achievement/btn_achi.swf")]

    private var _Source:Class;

    /**
     * コンストラクタ
     *
     */
    public function AchievementListButton() {
        super();
    }

    override protected function swfinit(event:Event):void {
        super.swfinit(event);
        addEventListener(MouseEvent.CLICK, clickHandler);
    }

    override protected function get Source():Class {
        return _Source;
    }

    private function clickHandler(e:MouseEvent):void {

        AchievementListView.show();
    }


}

}
