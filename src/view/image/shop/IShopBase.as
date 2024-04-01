// ShowとHideのスレッド返すメソッドのインターフェイス

package view.image.shop {
public interface IShopBase {
    function onEquip():void;

    function offEquip():void;

    function onSelect():void;

    function offSelect():void;

    function onTitle():void;

    function offTitle():void;

}

}

