package view.image.common {

import flash.events.Event;

import view.image.BaseImage;

/**
 * SocialLogTextBase表示クラス
 *
 */

public class SocialLogTextBase extends BaseImage {

    // CharaCardFrame表示元SWF
    [Embed(source="../../../../data/image/common/log_hukidashi.swf")]
    private var _Source:Class;
    private var _frame:int;

    /**
     * コンストラクタ
     *
     */
    public function SocialLogTextBase() {
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
