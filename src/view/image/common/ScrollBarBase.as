package view.image.common {

import flash.events.Event;

import view.image.BaseImage;

/**
 * ScrollBarBase表示クラス
 *
 */

public class ScrollBarBase extends BaseImage {

    // 表示元SWF
    [Embed(source="../../../../res/data/image/common/scl_list_bar.swf")]
    private var _Source:Class;

    /**
     * コンストラクタ
     *
     */
    public function ScrollBarBase() {
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
