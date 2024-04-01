// ShowとHideのスレッド返すメソッドのインターフェイス

package view.image.item {
public interface IInventoryBaseImage {
    function onUse():void;

    function offUse():void;

    function backButtonsEnable(b:Boolean):void;

    function nextButtonsEnable(b:Boolean):void;

}

}

