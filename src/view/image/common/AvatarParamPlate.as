package view.image.common {

import flash.events.Event;

import view.image.BaseImage;

/**
 * AvatarParamPlate表示クラス
 *
 */

public class AvatarParamPlate extends BaseImage {

    // CharaCardFrame表示元SWF
    [Embed(source="../../../../data/image/quest/social_plate.swf")]
    private var _Source:Class;
    private var _frame:int;

    /**
     * コンストラクタ
     *
     */
    public function AvatarParamPlate() {
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
