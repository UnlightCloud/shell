package view.scene.shop {
/**
 * ShopDeckInventoryClipの表示クラス
 *
 */
public class ShopDeckInventoryClip extends ShopBaseInventoryClip {
    public function ShopDeckInventoryClip(card:*, url:String = "", state:int = 0, frame:int = 0) {
        super(card, ShopBaseItemClip.BASE_TYPE_DECK, state, false, url, frame);
    }
}
}
