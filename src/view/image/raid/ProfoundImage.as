package view.image.raid {

/**
 * ProfoundImage表示クラス
 *
 */

public class ProfoundImage extends ProfoundBaseImage {
    [Embed(source="../../../../res/data/image/raid/vortex_normal.swf")]
    private var _nSource:Class;
    [Embed(source="../../../../res/data/image/raid/vortex_another.swf")]
    private var _aSource:Class;
    [Embed(source="../../../../res/data/image/raid/vortex_event.swf")]
    private var _eSource:Class;

    private var _sourceArray:Array = [_nSource, _aSource, _eSource];

    public static const PRF_IMG_TYPE_NORMAL:int = 0;
    public static const PRF_IMG_TYPE_ANOTHER:int = 1;
    public static const PRF_IMG_TYPE_EVENT:int = 2;

    private var _imgType:int = PRF_IMG_TYPE_NORMAL;

    /**
     * コンストラクタ
     *
     */
    public function ProfoundImage(rarity:int = 0, iconVisible:Boolean = false, btnVisible:Boolean = true, type:int = PRF_IMG_TYPE_NORMAL) {
        _imgType = type;
        super(_sourceArray[_imgType], rarity, iconVisible, btnVisible);
    }
}

}
