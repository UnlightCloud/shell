// ShowとHideのスレッド返すメソッドのインターフェイス

package view.scene.common {
import model.ICardInventory;

//     import flash.display.DisplayObjectContainer;
//     import org.libspark.thread.*;

public interface ICardClip {
    // 関連づけられたインベントリを返す
    function set cardInventory(inv:ICardInventory):void;

    function get cardInventory():ICardInventory;

//        function getEditHideThread():Thread;
}

}

