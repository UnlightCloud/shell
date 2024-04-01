package sound.se {
import flash.media.*;
import flash.net.URLRequest;

public class DeckTabClickSE extends BaseSESound {

    private static const URL:String = "/public/sound/se/ulse22.mp3";
    private var _url:URLRequest = new URLRequest(URL);
    private var _sound_obj:Sound = new Sound();

    // コンストラクタ
    public function DeckTabClickSE() {

    }

    // オーバライド前提
    protected override function get url():String {
        return URL;
    }


}
}


