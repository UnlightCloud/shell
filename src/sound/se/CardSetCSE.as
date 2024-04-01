package sound.se {
import flash.media.*;
import flash.net.URLRequest;

public class CardSetCSE extends BaseSESound {

    private static const URL:String = "/public/sound/se/ulse05_c.mp3";
    private var _url:URLRequest = new URLRequest(URL);
    private var _sound_obj:Sound = new Sound();

    // コンストラクタ
    public function CardSetCSE() {

    }

    // オーバライド前提
    protected override function get url():String {
        return URL;
    }


}
}


