package view.image.lobby {

import controller.LobbyCtrl;

import flash.display.*;
import flash.events.*;

import view.image.*;

/**
 * ItemButton表示クラス
 *
 */


public class TalkButton extends BaseImage {
    // HP表示元SWF
    [Embed(source="../../../../res/data/image/lobby/entrance_talk_icon.swf")]
    private var _Source:Class;

    private static const X:int = 0;
    private static const Y:int = 0;

    private static const BUTTON_ITEM:String = "btn_map_item"; // 2

    public static const STATE_NONE:int = 0;
    public static const STATE_INPROGRESS:int = 1;

    private var _talkButton:SimpleButton;

    private var _ctrl:LobbyCtrl = LobbyCtrl.instance;

    private var _state:int;

    /**
     * コンストラクタ
     *
     */
    public function TalkButton() {
        super();
    }

    protected override function get Source():Class {
        x = 50;
        y = 270;
        mouseEnabled = true;
        mouseChildren = true;
        return _Source;
    }

    override protected function swfinit(event:Event):void {
        super.swfinit(event);
//            _talkButton = SimpleButton(_root.getChildByName(BUTTON_ITEM));

    }


    public override function init():void {
//            log.writeLog(log.LV_FATAL, this, _lobbyStartButton.name,_lobbyQuitButton.name);
        addEventListener(MouseEvent.CLICK, itemClickHandler);

    }

    public override function final():void {
        removeEventListener(MouseEvent.CLICK, itemClickHandler);

    }


    private function itemClickHandler(e:MouseEvent):void {
        _ctrl.startLobbyTalk();
    }


}

}

