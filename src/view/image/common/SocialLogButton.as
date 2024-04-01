package view.image.common {

import flash.events.Event;

import view.image.BaseImage;

/**
 * SocialLogTab表示クラス
 *
 */

public class SocialLogButton extends BaseImage {
    // 表示元SWF
    [Embed(source="../../../../res/data/image/common/log_send.swf")]
    private var _Source:Class;

    /**
     * コンストラクタ
     *
     */
    public function SocialLogButton() {
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
