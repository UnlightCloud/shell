package view.scene.common {

import model.AvatarPart;

import view.image.common.*;
import view.scene.BaseScene;
import view.utils.*;

/**
 * AvatarPartのアイコン表示クラス
 * 全部ビットマップでキャッシュすべできか。同時に二つでることがない？
 */

public class AvatarPartIcon extends BaseScene {
    // イメージ
    private var _image:AvatarPartIconImage;
    protected var _avatarPart:AvatarPart;
    private const SCALE:Number = 0.5;
    private const X:int = 8;
    private const Y:int = 20;
//      private var _index:int;
//        private var _selectedItemShape:Shape = new Shape();
//      private var _container:Sprite = new Sprite()
    //    private var _selectedItemShape2:Shape = new Shape();
//      private var _test:Sprite = new Sprite()

    private var _isResetScale:Boolean = true;

    /**
     * コンストラクタ
     *
     */
    public function AvatarPartIcon(ap:AvatarPart, isResetScale:Boolean = true) {
        _avatarPart = ap;
        _isResetScale = isResetScale;
        mouseEnabled = false;
        mouseChildren = false;
        _image = new AvatarPartIconImage(_avatarPart.id);
        addChild(_image);
    }

    // 初期化
    public override function init():void {
        _image.getShowThread(this).start();
//            log.writeLog(log.LV_FATAL, this, "icon parts gen",_avatarPart.image,_avatarPart.offsetScale);
        if (_isResetScale) {
            scaleX = SCALE;
            scaleY = SCALE;
        }
        x = x + X;
        y = y + Y;
//            AvatarPartClip.getAttachShowThread(Vector.<AvatarPartClip>([_image]),this).start();
//             _image.getAttachShowThread(this).start();
    }


    // 後処理
    public override function final():void {
//            _image.getHideThread().start();
        // removeChild(_image)
        RemoveChild.apply(_image)
    }

//         // 表示用スレッドを返す
//         public override function getShowThread(stage:DisplayObjectContainer,  at:int = -1, type:String=""):Thread
//         {
// //            log.writeLog(log.LV_FATAL, this, "show?!!!!!!!!!!!!!!!!!!!");
//             _depthAt = at;
//             // 必ずパーツが読み込み済みでないといけない
//             return new ModelWaitShowThread(this, stage, _avatarPart);
//         }

    public function get partID():int {
        return _avatarPart.id;
    }


}

}
