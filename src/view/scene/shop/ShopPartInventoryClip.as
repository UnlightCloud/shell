package view.scene.shop {
import model.*;

/**
 * ShopPartInventoryClipの表示クラス
 *
 */
public class ShopPartInventoryClip extends ShopBaseInventoryClip {
    public function ShopPartInventoryClip(avatarItem:AvatarPart, state:int = 0) {
        super(avatarItem, ShopBaseItemClip.BASE_TYPE_PART, state);
    }
}

}

