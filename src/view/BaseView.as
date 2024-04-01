package view {
import org.libspark.thread.Thread;

public class BaseView extends Thread {

    private var _stage:UnlightLegacy;

    // コンストラクタ
    public function BaseView(stage:UnlightLegacy) {
        _stage = stage;
    }
}

}
