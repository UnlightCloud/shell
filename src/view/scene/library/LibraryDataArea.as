package view.scene.library {
import model.*;
import model.events.*;

import view.scene.edit.*;

/**
 * エディット画面のデータ部分のクラス
 *
 */
public class LibraryDataArea extends DataArea {

    /**
     * コンストラクタ
     *
     */
    public static function getCharaCardData():LibraryDataArea {
        log.writeLog(log.LV_INFO, "chara card data");
        return new LibraryDataArea(InventorySet.TYPE_CHARA);
    }

    public function LibraryDataArea(type:int) {
        super(type);
    }

    public function selectListCardHandler(e:EditCardEvent):void {
        selectCardHandler(e);
    }

    // カード選択
    protected override function selectCardHandler(e:EditCardEvent):void {
        super.selectCardHandler(e);
    }
}
}

