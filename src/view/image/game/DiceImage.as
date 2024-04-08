package view.image.game {

import flash.display.*;
import flash.events.Event;

import view.image.BaseImage;

/**
 * ダイス表示クラス
 *
 */

public class DiceImage extends BaseImage {
    public static const LABEL_NORMAL:String = "normal";
    public static const LABEL_HIT:String = "hit";
    public static const LABEL_CRASH:String = "peke";

    public static const DICE_ATK:String = "dice_atk";
    public static const DICE_DEF:String = "dice_def";

    public static const TYPE_ATK:int = 0;
    public static const TYPE_DEF:int = 1;

    // atkダイス表示元SWF
    [Embed(source="../../../../res/data/image/dice_atk.swf")]
    private static var _atk:Class;
    // defダイス表示元SWF
    [Embed(source="../../../../res/data/image/dice_def.swf")]
    private static var _def:Class;



    // 条件チップの配列
    private static var ClassArray:Array = [_atk, _def];

    // 表示タイプ
    private var _type:int;

    /**
     * コンストラクタ
     *
     */
    public function DiceImage(type:int) {
        _type = type;
        super();
    }

    override protected function swfinit(event:Event):void {
        super.swfinit(event);
        waitComplete(normalComplete);
    }

    override protected function get Source():Class {
        return ClassArray[_type];
    }

    public function crash():void {
        waitComplete(crashComplete);
    }

    public function normal():void {
        waitComplete(normalComplete);
    }

    public function hit():void {
        waitComplete(hitComplete);
    }

    public function isAtk(): Boolean {
        return _type == TYPE_ATK;
    }

    public function getDice(): MovieClip {
        return (isAtk() ? _root.getChildByName(DICE_ATK) : _root.getChildByName(DICE_DEF)) as MovieClip;
    }

    public function crashComplete():void {
        getDice().gotoAndPlay(LABEL_CRASH);
    }

    public function normalComplete():void {
        // NOTE: The normal animation is add cross symbol to the dice. No need to play the animation.
    }

    public function hitComplete():void {
        getDice().gotoAndPlay(LABEL_HIT);
    }
}
}
