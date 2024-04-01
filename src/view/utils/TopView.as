package view.utils {
/**
 *  取得確認パネル
 *
 */

public class TopView extends Object {


    public static function enable(e:Boolean):void {
        Unlight.INS.topContainer.mouseEnabled = e;
        Unlight.INS.topContainer.mouseChildren = e;
    }


}
}