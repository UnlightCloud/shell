package view.utils {
/**
 *  取得確認パネル
 *
 */

public class TopView extends Object {


    public static function enable(e:Boolean):void {
        UnlightLegacy.INS.topContainer.mouseEnabled = e;
        UnlightLegacy.INS.topContainer.mouseChildren = e;
    }


}
}