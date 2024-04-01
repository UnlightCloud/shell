package controller {
/**
 * ゲーム画面コントロールクラス
 *
 */
public class GameCtrl extends DuelCtrl {
    public static const DUEL:int = 0;
    public static const QUEST:int = 1;
    public static const RAID:int = 2;

    private static var __type:int = DUEL;

//         private static function createInstance():DuelCtrl
//         {
//             return new GameCtrl(arguments.callee);
//         }

    public static function get instance():DuelCtrl {
        if (__type == DUEL) {
            return DuelCtrl.instance;
        } else if (__type == QUEST) {
            return QuestCtrl.instance;
        } else if (__type == RAID) {
            return RaidCtrl.instance;
        } else {
            return DuelCtrl.instance;
        }
    }

    public static function switchMode(mode:int):void {
        __type = mode;
    }

}
}