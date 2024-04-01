package view.image.common {

import flash.events.Event;

import mx.controls.*;

import view.image.BaseImage;

/**
 * FriendStateImage表示クラス
 *
 */

public class FriendStateImage extends BaseImage {

    // 表示元SWF
    [Embed(source="../../../../res/data/image/friend/friendlist_state.swf")]
    private var _Source:Class;

    private var _label:Label = new Label();
    private var _text:String;

    /**
     * コンストラクタ
     *
     */
    public function FriendStateImage() {
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
