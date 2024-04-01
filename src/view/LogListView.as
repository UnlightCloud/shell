package view {

import controller.LobbyCtrl;

import flash.events.TimerEvent;

import mx.core.UIComponent;

import org.libspark.betweenas3.BetweenAS3;
import org.libspark.betweenas3.easing.*;

import view.image.log.*;
import view.scene.log.*;

/**
 * ログのビュークラス
 *
 */
public class LogListView extends UIComponent {

    private static var __logView:LogListView;
    private static var __enable:Boolean;
    private static var __activate:Boolean = true;

    private static const _START_Y:int = -120;
    private static const _X:int = 152;
    private static const _Y:int = 150;

    // ロビーのコントローラ
    private var _lobbyCtrl:LobbyCtrl = LobbyCtrl.instance;

    private static var __type:int;
    private var _bg:BG = new BG();


    // 初期化（まっさきに先読みさせる）
    public static function initData():void {
        if (__logView == null) {
            initView()
        }
    }


    // ログビューを呼び出す
    public static function show():void {
        if (__activate) {           // 初期化されていない場合は作る
            if (__logView == null) {
                initView()
            }

            // 作ったVIEWをトップビューに突っ込んで背景はクリックできなくする
            BetweenAS3.serial(
                    BetweenAS3.addChild(__logView, UnlightLegacy.INS.topContainer.parent),
                    BetweenAS3.to(__logView, {y: _Y}, 0.3, Quad.easeOut)
            ).play();
            UnlightLegacy.INS.topContainer.mouseEnabled = false;
            UnlightLegacy.INS.topContainer.mouseChildren = false;
            __enable = true;
            updateLogInfo();
            LogListContainer.update();
        }
    }

    private static function updateLogInfo():void {

    }


    public static function activate(b:Boolean):void {
        __activate = b;
    }


    public static function get enable():Boolean {
        return __enable;
    }

    public static function hide():void {
        BetweenAS3.serial(
                BetweenAS3.tween(__logView, {y: _START_Y}, null, 0.15, Sine.easeOut),
                BetweenAS3.removeFromParent(__logView)
        ).play()
        UnlightLegacy.INS.topContainer.mouseEnabled = true;
        UnlightLegacy.INS.topContainer.mouseChildren = true;
        __enable = false;
    }

    private static function initView():void {
        __logView = new LogListView()
    }

    /**
     * コンストラクタ
     * @param stage 親ステージ
     */

    public function LogListView() {
        x = _X;
        y = _START_Y;
        _bg.setCloseHandler(hide);
        _bg.getShowThread(this, 0).start();
        _bg.addChild(LogListContainer.instance);
        _bg.setNextHandler(LogListContainer.instance.nextPage);
        _bg.setPrevHandler(LogListContainer.instance.prevPage);
        _bg.setListSortHandler(LogListContainer.instance.setTab);
        LogListContainer.instance.bg = _bg;
    }

    private function updateHandler(e:TimerEvent):void {
        LogListView.updateLogInfo()
    }

}
}



