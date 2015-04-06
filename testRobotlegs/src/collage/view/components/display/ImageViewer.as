package collage.view.components.display 
{
	import com.foomonger.utils.Later;

	import org.casalib.events.LoadEvent;
	import org.casalib.load.ImageLoad;
	import org.casalib.util.StringUtil;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.system.LoaderContext;

	/**
	 * @author tuvisum.com, Oleksandr Zazhytskyi
	 */
	public class ImageViewer extends Sprite implements ICollageImage
	{
		private var _bitmapDataViewer	: BitmapDataViewer;
		private	var _imageLoader		: ImageLoad;
		private	var _loaderContext		: LoaderContext;
		private var _defaultImage		: Boolean;
		
		public static var DEFAULT_IMAGE	: BitmapData;
		
		public function ImageViewer(defaultImage : Boolean = true, scaleType : String = 'SCALE_TO_FILL_IMAGE', align : String = 'ALIGN_CENTER', bgAlpha : Number = 0) 
		{
			_defaultImage		= defaultImage;
			_loaderContext 		= new LoaderContext(true);
			_bitmapDataViewer	= new BitmapDataViewer(scaleType, align, bgAlpha);
			mouseChildren = false;
			
			addChild(_bitmapDataViewer);
		}
		
		private function clear() : void
		{
			if (_bitmapDataViewer.containsBitmapData && _bitmapDataViewer.bitmapData != DEFAULT_IMAGE)
				_bitmapDataViewer.bitmapData.dispose();
			_bitmapDataViewer.clear();
		}

		private function onCompleteLoadImage(event : LoadEvent) : void 
		{
			clear();
			
			_bitmapDataViewer.show(_imageLoader.contentAsBitmapData);
			_imageLoader.destroy();
			_imageLoader = null;
			
			dispatchEvent(event);
		}
		
		private function onLoadErrorImage(event : Event) : void
		{
			clear();
			
			if(_defaultImage)
				setDefaultImage();
			_imageLoader.destroy();
			_imageLoader = null;
		}
		
		private function setDefaultImage() : void
		{
			if (DEFAULT_IMAGE)
				_bitmapDataViewer.show(DEFAULT_IMAGE, true);
		}
		
		public function set url(url : String) : void
		{
			if (_imageLoader && _imageLoader.loading)
			{
				_imageLoader.stop();
				_imageLoader.destroy();
				_imageLoader = null;
			}
			
			if (url && StringUtil.trim(url))
			{
				_imageLoader = new ImageLoad(url, 											_loaderContext);
        		_imageLoader.addEventListener(LoadEvent.COMPLETE,							onCompleteLoadImage);
				_imageLoader.loaderInfo.addEventListener(ErrorEvent.ERROR,					onLoadErrorImage);
        		_imageLoader.loaderInfo.addEventListener(IOErrorEvent.IO_ERROR,				onLoadErrorImage);
				_imageLoader.loaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,	onLoadErrorImage);
        		_imageLoader.start();
				
			}else if(url == null)
			{
				clear();
			}else 
			{
				clear();
				if (_defaultImage)
					Later.call(setDefaultImage, 1);
			}
		}
		
		public function set scaleType(scaleType : String) : void
		{
			_bitmapDataViewer.scaleType = scaleType;
		}
		
		public function set boundWidth(boundWidth : Number) : void
		{
			_bitmapDataViewer.boundWidth = boundWidth;
		}

		public function set boundHeight(boundHeight : Number) : void
		{
			_bitmapDataViewer.boundHeight = boundHeight;
		}
		
		public function set w(w : Number) : void
		{
			boundWidth = w;
		}
		
		public function set h(h : Number) : void
		{
			boundHeight = h;
		}
		
		public function get boundWidth() : Number
		{
			return _bitmapDataViewer.boundWidth;
		}
		
		public function get boundHeight() : Number
		{
			return _bitmapDataViewer.boundHeight;
		}
		
		public function get w() : Number
		{
			return boundWidth;
		}
		
		public function get h() : Number
		{
			return boundHeight;
		}

		public function get bitmapDataViewer() : BitmapDataViewer
		{
			return _bitmapDataViewer;
		}
	}
}
