package view.image.common {

import flash.events.Event;

import view.image.BaseImage;

/**
 * SocialLogPanel表示クラス
 *
 */

public class SocialLogPanel extends BaseImage {

    // 表示元SWF
    [Embed(source="../../../../res/data/image/common/log_base.swf")]
    private var _Source:Class;

    /**
     * コンストラクタ
     *
     */
    public function SocialLogPanel() {
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
