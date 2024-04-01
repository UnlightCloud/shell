package view.image.common {

import flash.events.Event;

import view.image.BaseImage;

/**
 * ScrollBarUp表示クラス
 *
 */

public class ScrollBarUp extends BaseImage {

    // 表示元SWF
    [Embed(source="../../../../data/image/common/scl_list_up.swf")]
    private var _Source:Class;

    /**
     * コンストラクタ
     *
     */
    public function ScrollBarUp() {
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
