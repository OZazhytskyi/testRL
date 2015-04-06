package collage.view.components.display  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	/**
	 * @author Alexander
	 */
	public class BitmapDataViewer extends Sprite 
	{
		private var _viewer 		: DisplayObjectViewer;
		private var _bitmap 		: Bitmap;
		private var _originWidth	: int;
		private var _originHeight	: int;
		
		public function BitmapDataViewer(scaleType : String = 'NO_SCALE', align : String = 'ALIGN_CENTER', bgAlpha : Number = 1.0, bgColor : uint = 0x000000)
		{
			_viewer = new DisplayObjectViewer(scaleType, align, bgAlpha, bgColor);	
			_bitmap = new Bitmap();
			
			addChild(_viewer);
		}
		
		public function show(bitmapData : BitmapData, smoothing : Boolean = true) : void
		{			
			_bitmap.bitmapData	= bitmapData;
			_bitmap.smoothing	= smoothing;
			_bitmap.width 		= bitmapData.width; 
			_bitmap.height 		= bitmapData.height;
			_originWidth 		= bitmapData.width;
			_originHeight 		= bitmapData.height;

			if(!_viewer.displayObj)
			{
				_viewer.show(_bitmap);
			}else
			{
				var scaleType : String	= _viewer.scaleType;
				_viewer.scaleType 		= scaleType;
			}
		} 
		
		public function clear() : void
		{
			_viewer.clear();
			_bitmap.bitmapData = null;
		}
		
		public function set boundWidth(boundWidth : Number) : void
		{
			_viewer.boundWidth = boundWidth;
		}

		public function set boundHeight(boundHeight : Number) : void
		{
			_viewer.boundHeight = boundHeight;
		}
		
		public function set scaleType(scaleType : String) : void
		{
			_viewer.scaleType = scaleType;
		}
		
		public function set bgColor(bgColor : uint) : void
		{
			_viewer.bgColor = bgColor;
		}
		
		public function set bgAlpha(bgAlpha : Number) : void
		{
			_viewer.bgAlpha = bgAlpha;
		}
		
		public function set align(align : String) : void
		{
			_viewer.align = align;
		}
		
		public function get boundWidth() : Number
		{
			return _viewer.boundWidth;
		}
		
		public function get boundHeight() : Number
		{
			return _viewer.boundHeight;
		}
		
		public function get scaleType() : String
		{
			return _viewer.scaleType;
		}
		
		public function get containsBitmapData() : Boolean
		{
			return Boolean(_bitmap.bitmapData);
		}
		
		public function get bitmapData() : BitmapData
		{
			return _bitmap.bitmapData;
		}

		public function get viewer() : DisplayObjectViewer
		{
			return _viewer;
		}
		
		public function get originWidth() : int
		{
			return _originWidth;
		}

		public function get originHeight() : int
		{
			return _originHeight;
		}
	}
}
