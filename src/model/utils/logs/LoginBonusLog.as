package model.utils.logs {
import model.*;
import model.utils.*;

/**
 * メッセージのログ情報を扱うクラス
 * チャットやゲームログを保存する
 */
public class LoginBonusLog extends ClientLog {
    CONFIG::LOCALE_JP
    private static const _GOT_LOGIN_STR:String = "__DATA__:__NAME____RARE____LV__をログインボーナスで取得しました。";

    CONFIG::LOCALE_EN
    private static const _GOT_LOGIN_STR:String = "__DATA__:You received __NAME__ __RARE____LV__ as a login bonus.";

    CONFIG::LOCALE_TCN
    private static const _GOT_LOGIN_STR:String = "__DATA__:您得到登錄獎勵的__NAME____RARE____LV__。";

    CONFIG::LOCALE_SCN
    private static const _GOT_LOGIN_STR:String = "__DATA__:通过登陆奖励获得__NAME____RARE____LV__。";

    CONFIG::LOCALE_KR
    private static const _GOT_LOGIN_STR:String = "__DATA__:__NAME____RARE____LV__をログインボーナスで取得しました。";

    CONFIG::LOCALE_FR
    private static const _GOT_LOGIN_STR:String = "__DATA__:Vous avez obtenu __NAME__ __RARE____LV__  avec le Bonus Login.";

    CONFIG::LOCALE_ID
    private static const _GOT_LOGIN_STR:String = "__DATA__:__NAME____RARE____LV__をログインボーナスで取得しました。";

    CONFIG::LOCALE_TH
    private static const _GOT_LOGIN_STR:String = "__DATA__:ได้รับ __NAME____RARE____LV__ เป็น login bonus";


    public function LoginBonusLog() {
        super();
    }

    public override function get type():int {
        return ClientLog.GOT_LOGIN;
    }


    public override function getLog(i:int):String {
        if (_textSet[i] != null) {
            return _textSet[i];
        }

        return setText(i);
    }

    private function setText(i:int):String {
        var dateArr:Array = dateSet;
        var nameArr:Array = nameSet;

        var date:Date = dateArr[i];
        var nameData:Array = nameArr[i];
        var ret:String = "";
        if (date != null && nameData != null) {
            // キャラカードの場合
            if (nameData[0] == Const.TG_CHARA_CARD) {
                ret = _GOT_LOGIN_STR.replace(/__DATA__/, TimeFormat.transDateStr(date)).replace(/__NAME__/, nameData[2]);
                if (nameData[1] < 1000) {
                    ret = ret.replace(/__LV__/, " Lv." + nameData[4]);
                    if (nameData[3] > 5) {
                        var rarity:String = "R" + (nameData[3] - 5);
                        ret = ret.replace(/__RARE__/, rarity);
                    } else {
                        ret = ret.replace(/__RARE__/, "");
                    }
                } else {
                    ret = ret.replace(/__RARE__/, "").replace(/__LV__/, "");
                }
            }// GEMの場合
            else if (nameData[0] == Const.TG_GEM) {
                ret = _GOT_LOGIN_STR.replace(/__DATA__/, TimeFormat.transDateStr(date)).replace(/__NAME__/, nameData[2] + "GEM");
                ret = ret.replace(/__RARE__/, "").replace(/__LV__/, "");
            }// その他の場合
            else {
                ret = _GOT_LOGIN_STR.replace(/__DATA__/, TimeFormat.transDateStr(date)).replace(/__NAME__/, nameData[2]);
                ret = ret.replace(/__RARE__/, "").replace(/__LV__/, "");
            }
            _textSet.unshift(ret);
        }
        checkMax();
        return ret;
    }

    public override function setLog(a:Object, save:Boolean = false):String {
        var tgType:int = int(a[0]);
        var sctType:int = int(a[1]);
        var id:int = int(a[2]);

        var name:String = "";
        var rare:int = 0;
        var lv:int = 0;
        // タイプに合わせて情報を取得する
        switch (tgType) {
            case Const.TG_AVATAR_ITEM:
                name = AvatarItem.ID(id).name;
                break;
            case Const.TG_AVATAR_PART:
                name = AvatarPart.ID(id).name;
                break;
            case Const.TG_SLOT_CARD:
                switch (sctType) {
                    case Const.SCT_EQUIP:
                        name = EquipCard.ID(id).name;
                        break;
                    case Const.SCT_EVENT:
                        name = EventCard.ID(id).name;
                        break;
                    case Const.SCT_WEAPON:
                        name = WeaponCard.ID(id).name;
                        break;
                    default:
                        name = EventCard.ID(1).name;
                }
                break;
            case Const.TG_GEM:
                name = String(id); // id がそのまま取得した値
                break;
            case Const.TG_CHARA_CARD:
                name = CharaCard.ID(id).name;
                rare = CharaCard.ID(id).rarity;
                lv = CharaCard.ID(id).level;
                break;
            default:
                name = CharaCard.ID(1).name;
                rare = CharaCard.ID(1).rarity;
                lv = CharaCard.ID(1).level;
        }

        dateSet.unshift(new Date());
        var setData:Array = [tgType, id, name, rare, lv, sctType];
        nameSet.unshift(setData);
        if (save) {
            _sharedObj.flush();
        }

        // テキストを先に作ってしまう
        return setText(0);
//            return nameSet.length - 1;
    }


}


}