package view.image.common
{

    import flash.display.*;
    import flash.filters.GlowFilter;
    import flash.events.Event;
    import flash.events.MouseEvent;

    import mx.core.UIComponent;
    import mx.controls.Text;

    import org.libspark.thread.*;
    import org.libspark.thread.utils.*;
    import org.libspark.thread.threads.between.BeTweenAS3Thread;

    import view.image.BaseImage;

    /**
     * ScrollBarUp表示クラス
     *
     */

    public class ScrollBarUp extends BaseImage
    {

        // 表示元SWF
        [Embed(source="../../../../data/image/common/scl_list_up.swf")]
        private var _Source:Class;

        /**
         * コンストラクタ
         *
         */
        public function ScrollBarUp()
        {
            super();
        }

        override protected function swfinit(event: Event):void
        {
            super.swfinit(event);
        }

        override protected function get Source():Class
        {
            return _Source;
        }

    }

}
