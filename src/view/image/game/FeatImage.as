package view.image.game {

import flash.events.Event;

import view.image.BaseLoadImage;

/**
 * FeatImage表示クラス
 *
 */


public class FeatImage extends BaseLoadImage {

    // ゲームのコントローラ

    /**
     * コンストラクタ
     *
     */
    public function FeatImage(url:String) {
        super(url);
    }


    override protected function swfinit(event:Event):void {

        super.swfinit(event);
        _root.gotoAndStop(0);
    }

    public function plAnime():void {
        waitComplete(plAnimation);
    }

    public function foeAnime():void {
        waitComplete(foeAnimation);
    }

    private function plAnimation():void {
        x = 0;
        scaleX = 1;
        SE.getFeatInsertSEThread(0).start();
        _root.gotoAndPlay(1);
    }

    private function foeAnimation():void {
        x = Unlight.WIDTH;
        scaleX = -1;
        SE.getFeatInsertSEThread(0).start();
        _root.gotoAndPlay(1);
    }
}
}
