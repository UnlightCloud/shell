package view.image.common {

import flash.display.*;
import flash.events.Event;

import view.image.BaseImage;

/**
 * FriendStateImage表示クラス
 *
 */

public class AchievementIconImage extends BaseImage {

    // 表示元SWF
    [Embed(source="../../../../res/data/image/achievement/achievement_list.swf")]
    private var _Source:Class;
    private var _iconMC:MovieClip;
    private var _selectMC:MovieClip;

    private var _iconType:int = 0;

    /**
     * コンストラクタ
     *
     */
    public function AchievementIconImage(type:int = 0) {
        _iconType = type;
        super();
    }


    override protected function swfinit(event:Event):void {
        log.writeLog(log.LV_INFO, this, "swfinit");
        super.swfinit(event);
        _iconMC = MovieClip(_root.getChildByName("icon_category"));
        _iconMC.gotoAndStop(_iconType + 1);
        _selectMC = MovieClip(_root.getChildByName("select"));
        _selectMC.visible = false;
    }

    override protected function get Source():Class {
        return _Source;
    }

    public function setSelectMCVisible(flag:Boolean = false):void {
        if (_selectMC) {
            _selectMC.visible = flag;
        }
    }


}

}
