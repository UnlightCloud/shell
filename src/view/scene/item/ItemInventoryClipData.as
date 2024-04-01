package view.scene.item {
import model.*;

import view.scene.BaseScene;

/**
 * ItemInventoryClipが持つ情報クラス
 *
 */
public class ItemInventoryClipData extends BaseScene {
    // アバターアイテム
    private var _avatarItem:AvatarItem;
    // 個数
    private var _count:int = 0;

    public function ItemInventoryClipData(item:AvatarItem) {
        _avatarItem = item;
        _count = 0;
    }

    public function get item():AvatarItem {
        return _avatarItem;
    }

    public function get image():String {
        return _avatarItem.image;
    }

    public function get imageFrame():int {
        return _avatarItem.imageFrame;
    }

    public function get shopImageFrame():int {
        return _avatarItem.shopImageFrame;
    }

    public function get count():int {
        return _count;
    }

    public function set count(c:int):void {
        _count = c;
    }
}

}