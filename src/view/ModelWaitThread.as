package view {
import model.BaseModel;

import org.libspark.thread.Thread;

// もらったクロージャを一定スリープ語実行するだけのスレッド
public class ModelWaitThread extends Thread {
    private var _func:Function;
    private var _args:Array;
    private var _m:BaseModel;

    public function ModelWaitThread(m:BaseModel, func:Function, args:Array = null) {
        _m = m;
        _func = func;
        _args = args;

    }

    protected override function run():void {
//            log.writeLog(log.LV_INFO, this, "run?");
        if (_m.loaded == false) {
            log.writeLog(log.LV_INFO, this, "waiting?", _m, _m.id);
            _m.wait();
        }
        next(callFunc);
    }

    private function callFunc():void {
        _func.apply(this, _args);
    }
}
}