package view.scene.shop {
import model.*;

/**
 * ShopItemInventoryClipの表示クラス
 *
 */
public class ShopItemInventoryClip extends ShopBaseInventoryClip {
    /**
     * コンストラクタ
     *
     */
    public function ShopItemInventoryClip(avatarItem:AvatarItem, state:int = 0) {
        super(avatarItem, ShopBaseItemClip.BASE_TYPE_ITEM, state, true);
    }
}
}

