// ShowとHideのスレッド返すメソッドのインターフェイス

package view.image.item {
public interface IItemBase {
    function onEquip():void;

    function offEquip():void;

    function onSelect():void;

    function offSelect():void;

}

}

