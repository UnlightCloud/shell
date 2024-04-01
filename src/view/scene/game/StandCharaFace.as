package view.scene.game {
import flash.display.DisplayObjectContainer;

import model.CharaCard;

import org.libspark.thread.*;

import view.image.game.*;
import view.scene.*;
import view.utils.RemoveChild;

/**
 * 状態異常クリップ
 *
 */

public class StandCharaFace extends BaseScene {
    private var _charaCard:CharaCard;
    private var _image:StandCharaFaceImage;
    private var _enabled:Boolean;

    // チップヘルプの設定（上記HELPステート分必要）
    private var _helpTextArray:Array =
            [];
    // チップヘルプを設定される側のUIComponetオブジェクト
    private var _toolTipOwnerArray:Array = [];

    private var _playerFace:Boolean;

    /**
     * コンストラクタ
     *
     */
    public function StandCharaFace(p:Boolean, cc:CharaCard, e:Boolean = false) {
        _charaCard = cc;
        _playerFace = p;
        _enabled = e;
    }


    public override function init():void {
        if (_image == null) {
            if (_enabled) {
                _image = new StandCharaFaceImage(_playerFace, _charaCard.standImage + "ch");
            } else {
                _image = new StandCharaFaceImage(_playerFace, _charaCard.standImage);
            }
            addChild(_image);
        }
    }

    public override function final():void {
        RemoveChild.apply(_image);
        _image = null;
        super.final();
    }

    // 表示用のスレッドを返す
    public override function getShowThread(stage:DisplayObjectContainer, at:int = -1, type:String = ""):Thread {
        _depthAt = at;
        return new ModelWaitShowThread(this, stage, _charaCard);
    }


    public function inFace():void {
        if (_image != null) {
            _image.inFace();
        }
    }


    public function outFace():void {
        if (_image != null) {
            _image.outFace();
        }
    }


}

}


import flash.display.DisplayObjectContainer;

import model.Duel;

import view.BaseHideThread;
import view.BaseShowThread;
import view.scene.game.StandCharaFace;

// 基本的なShowスレッド
class ShowThread extends BaseShowThread {

    public function ShowThread(bc:StandCharaFace, stage:DisplayObjectContainer) {
        super(bc, stage);
    }

    protected override function run():void {
        // デュエルの準備を待つ
        if (Duel.instance.inited == false) {
            Duel.instance.wait();
        }

        next(close);
    }
}

// 基本的なHideスレッド
class HideThread extends BaseHideThread {
    public function HideThread(bc:StandCharaFace) {
        super(bc);
    }
}
