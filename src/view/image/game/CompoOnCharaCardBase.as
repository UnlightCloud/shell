package view.image.game {
import flash.events.Event;

import view.image.BaseImage;

/**
 * コンポ選択中背景
 *
 */
public class CompoOnCharaCardBase extends BaseImage {
    // result表示元SWF
    [Embed(source="../../../../res/data/image/compo/compo_cardbase_on.swf")]
    private var _Source:Class;

    /**
     * コンストラクタ
     *
     */
    public function CompoOnCharaCardBase() {
        super();
    }

    override protected function swfinit(event:Event):void {
        super.swfinit(event);
    }

    override protected function get Source():Class {
        return _Source;
    }

    public function onAnime():void {
        waitComplete(onAnimeComplete);
    }

    public function onAnimeComplete():void {
//            MovieClip(_root.getChildAt(0)).gotoAndStop("on");
    }

    public function offAnime():void {
        waitComplete(offAnimeComplete);
    }

    public function offAnimeComplete():void {
//            MovieClip(_root.getChildAt(0)).gotoAndStop("off");
    }
}
}
