package view.image.quest {

import flash.events.Event;

import view.image.*;

/**
 * MapBackButton表示クラス
 *
 */


public class MapBackButton extends BaseImage {
    // HP表示元SWF
    [Embed(source="../../../../res/data/image/quest/btn_mapback.swf")]
    private var _Source:Class;

    /**
     * コンストラクタ
     *
     */
    public function MapBackButton() {
        super();
    }


    protected override function get Source():Class {
        return _Source;
    }

    override protected function swfinit(event:Event):void {
        super.swfinit(event);
    }


}

}

