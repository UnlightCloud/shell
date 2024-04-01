package view.image.common {

import flash.events.Event;

import mx.controls.*;

import view.image.BaseImage;

/**
 * FriendListCloseButton表示クラス
 *
 */

public class FriendCloseButton extends BaseImage {

    // 表示元SWF
    [Embed(source="../../../../data/image/friend/btn_delete.swf")]
    private var _Source:Class;

    private var _label:Label = new Label();
    private var _text:String;

    /**
     * コンストラクタ
     *
     */
    public function FriendCloseButton() {
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
