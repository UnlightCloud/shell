package view.scene.game {

import flash.display.DisplayObjectContainer;
import flash.events.Event;

import model.Duel;

import org.libspark.thread.*;

import view.image.game.*;
import view.scene.BaseScene;

/**
 * FarBGScene表示クラス
 *
 */


public class FarBGScene extends BaseScene {
    private var _farBG:FarBG;

    private var _duel:Duel = Duel.instance;
    private var _type:int;

    /**
     * コンストラクタ
     *
     */
    public function FarBGScene(id:int) {
        _type = id;
        super();
    }

    // 表示用のスレッドを返す
    public override function getShowThread(stage:DisplayObjectContainer, at:int = -1, type:String = ""):Thread {
        _depthAt = at;
        return new ShowThread(this, stage);
    }

    public override function init():void {
        _farBG = new FarBG(_type);
        addChild(_farBG)
        // イベントを追加
        _duel.addEventListener(Duel.DISTANCE_UPDATE, distanceUpdateHandler);
    }

    public override function final():void {
        removeChild(_farBG);
        _farBG = null;
        _duel.removeEventListener(Duel.DISTANCE_UPDATE, distanceUpdateHandler);
    }


    private function distanceUpdateHandler(e:Event):void {
//            log.writeLog(log.LV_FATAL, this, "eventDone");
        _farBG.updateDistance(_duel.distance);
    }
}
}


// Duelのinitを待つShowスレッド

import flash.display.DisplayObjectContainer;

import model.Duel;

import view.BaseShowThread;
import view.scene.BaseScene;

class ShowThread extends BaseShowThread {
    private var _sc:BaseScene;

    public function ShowThread(sc:BaseScene, stage:DisplayObjectContainer) {
        _sc = sc;
        super(sc, stage)
    }

    protected override function run():void {
        // ロードを待つ
        if (Duel.instance.inited == false) {
            Duel.instance.wait();
        }
        next(close);
    }

}
