package view.scene.item {
import model.*;

import view.image.common.AvatarItemImage;
import view.scene.BaseScene;
import view.scene.common.*;

/**
 * BaseinventoryClipの表示クラス
 *
 */

public class BaseInventoryClip extends BaseScene implements IInventoryClip {

    /**
     * コンストラクタ
     *
     */
    public function BaseInventoryClip() {
        // アバターアイテムを保存

    }

    // 装備する
    public function onEquip():void {
    }

    // 装備を外す
    public function offEquip():void {
    }

    // 選択する
    public function onSelect():void {
    }

    // 装備を外す
    public function offSelect():void {
    }

    //
    public function get avatarItem():AvatarItem {
        return null;
    }

    //
    public function get avatarItemImage():AvatarItemImage {
        return null;
    }

    //
    public function get avatarPart():AvatarPart {
        return null;
    }

    //
    public function get avatarPartIcon():AvatarPartIcon {
        return null;
    }

    //
    public function get realMoneyItem():RealMoneyItem {
        return null;
    }

    //
    public function get count():int {
        return 0;
    }

    //
    public function set count(c:int):void {

    }

    //
    public function get coins():Array {
        return [0, 0, 0, 0, 0];
    }

    //
    public function set coins(c:Array):void {
    }

    //
    public function get price():int {
        return 0;
    }

    //
    public function set price(c:int):void {
    }


    public function get card():ICard {
        return null;
    }

    public function getUpdateCount():int {
        return 0;
    }

}
}

