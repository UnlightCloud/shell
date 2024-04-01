package view.scene.shop {
import model.*;
import model.events.*;

import view.image.item.*;
import view.image.shop.*;

/**
 * ShopClothListPanelの表示クラス
 *
 */

public class ShopClothListPanel extends ShopBodyListPanel {

    // アイテムパネル
    private var _shopInventoryPanelImage:ShopInventoryPanelImage = new ShopInventoryPanelImage(AvatarPart.PARTS_CLOTHES_TYPE);

    /**
     * コンストラクタ
     *
     */
    public function ShopClothListPanel(shopID:int = 0) {
        super(shopID);
    }


    override protected function get tabTypes():Array {
        return AvatarPart.PARTS_CLOTHES_TYPE;
    }

    override protected function getItemTypeIdx(i:int):int {
        return i;
    }

    protected override function get itemInventoryPanelImage():BasePanelImage {
        return _shopInventoryPanelImage;
    }


    // インベントリからデータを生成する
    override protected function inventoryToData():void {
        var i:int;
        var itemNum:int = 0; // アイテムの個数
        var items:Array = Shop.ID(_shopID).clothPartsList;
        var prices:Array = Shop.ID(_shopID).clothPartsPriceList;
        var coins:Array = Shop.ID(_shopID).clothPartsCoinList;

        var part:AvatarPart;

        log.writeLog(log.LV_INFO, this, "items", items);
        log.writeLog(log.LV_INFO, this, "price", prices);

        // データプロバイダーにタイプごとのアイテムを設定する
        for (i = 0; i < items.length; i++) {
            part = items[i];
            if (part && !checkPremiumCoin(coins[part.id])) {
                // アイテムのイメージを作成
                setItem(part);
                // アイテムの個数をインクリメント
                _itemDic[part].price = prices[part.id];
                _itemDic[part].coins = coins[part.id];

                log.writeLog(log.LV_INFO, this, "dp p c", prices[part.id], coins[part.id]);
                log.writeLog(log.LV_INFO, this, "dp dp", _dpList[part.type - part.genre]);
                _dpList[part.type - AvatarPart.PARTS_GENRE_ID[part.genre]].push(_itemDic[part]);
            }
        }

        log.writeLog(log.LV_INFO, this, "dp seted");
        // アイテムの個数
        var partsInvSet:Array = AvatarPartInventory.getGenreItems(AvatarPart.GENRE_CLOTH); /* of api */
        for (i = 0; i < partsInvSet.length; i++) {
            part = partsInvSet[i].avatarPart;
            // アイテムのイメージを作成
            if (_itemDic[part] != null) {
//                 setItem(part);
                // アイテムの個数をインクリメント
                _itemDic[part].count += 1;
            }
        }
    }


    // アイテム購入に成功した時のイベント
    override protected function getAvatarPartSuccessHandler(e:AvatarPartEvent):void {
        if (AvatarPart.ID(e.id).genre == AvatarPart.GENRE_CLOTH) {
            var dp:Array = _dpList[AvatarPart.ID(e.id).type - AvatarPart.GENRE_CLOTH] as Array;
            updateCount(dp, e.id);
        }
    }


}

}

