package view.image.common {

import flash.events.Event;

import view.image.BaseImage;

/**
 * 武器パッシブアイコン表示クラス
 *
 */

public class WeaponCardPassiveSkillIcon extends BaseImage {

    // CharaCardFrame表示元SWF
    [Embed(source="../../../../data/image/icon_p_skill.swf")]
    private var _source:Class;

    private var _weaponPassiveNo:int;


    /**
     * コンストラクタ
     *
     */
    public function WeaponCardPassiveSkillIcon(passiveNo:int = 0) {
        _weaponPassiveNo = passiveNo;
        super();
    }

    override protected function swfinit(event:Event):void {
        super.swfinit(event);
        _root.gotoAndStop(_weaponPassiveNo + 1);
    }

    override protected function get Source():Class {
        return _source;
    }

    public function changePassiveNo(passiveNo:int):void {
        _weaponPassiveNo = passiveNo;
        waitComplete(changePassiveNoComplete);
    }

    private function changePassiveNoComplete():void {
        _root.gotoAndStop(_weaponPassiveNo + 1);
    }

}

}
