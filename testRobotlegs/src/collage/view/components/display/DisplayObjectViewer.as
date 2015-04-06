package collage.view.components.display  
{
	import org.casalib.util.RatioUtil;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	/**
	 * @author Alexander Zazicky
	 */
	public class DisplayObjectViewer extends Sprite 
	{
		protected var _boundWidth 	: Number;
		protected var _boundHeight	: Number;
		protected var _displayObj	: DisplayObject;
		
		private var _bgColor		: uint;
		private var _bgAlpha		: Number;
		private var _scaleType		: String;
		private var _align			: String;
		
		public function DisplayObjectViewer(scaleType : String = 'NO_SCALE', align : String = 'ALIGN_CENTER', bgAlpha : Number = 1.0, bgColor : uint = 0x000000)
		{
			_scaleType	= scaleType;
			_align		= align;
			_bgColor 	= bgColor;
			_bgAlpha	= bgAlpha;
		}
		
		private function darawBg() : void
		{
			graphics.clear();
			if(_bgAlpha)
			{
				graphics.beginFill(_bgColor,_bgAlpha);
				if(_boundWidth && _boundHeight)
				{
					graphics.drawRect(0, 0, _boundWidth, _boundHeight);
				}else if(_displayObj)
				{
					graphics.drawRect(0, 0,_displayObj.width, _displayObj.height);
				}
				graphics.endFill();
			}
		}
		
		protected function setViewWindow() : void
		{
			if (_scaleType == LayoutType.SCALE_TO_FILL_IMAGE && _boundWidth && _boundHeight)
				scrollRect = new Rectangle(0,0,_boundWidth,_boundHeight);
		}
		
		protected  function resize(displayObj : DisplayObject):void
		{
			var newSize : Rectangle;
			switch (_scaleType) 
			{
				case LayoutType.SCALE_TO_FIT_IMAGE:
					newSize = RatioUtil.scaleToFit(new Rectangle(0,0,displayObj.width,displayObj.height), new Rectangle(0,0,_boundWidth,_boundHeight));
					break;
				case LayoutType.SCALE_TO_FILL_IMAGE:
					newSize = RatioUtil.scaleToFill(new Rectangle(0,0,displayObj.width,displayObj.height), new Rectangle(0,0,_boundWidth,_boundHeight));
					break;
				case LayoutType.NO_SCALE:
					return;
					break;
			}
			displayObj.width	= newSize.width;
			displayObj.height	= newSize.height;
		}
		
		protected function place(displayObj : DisplayObject) : void
		{
			if(_boundWidth && _boundHeight)
			{			
				if(_align == LayoutType.ALIGN_CENTER || _scaleType == LayoutType.SCALE_TO_FILL_IMAGE)
				{
					displayObj.x = (_boundWidth-displayObj.width) >> 1;
					displayObj.y = (_boundHeight-displayObj.height) >> 1;
				}
				if(_align == LayoutType.ALIGN_LEFT_TOP && _scaleType == LayoutType.SCALE_TO_FIT_IMAGE)
				{
					displayObj.x = 0;
					displayObj.y = 0;
				}
			}
		}
		
		public function show(displayObj : DisplayObject) : void
		{			
			if(_displayObj)
				clear();
				
			_displayObj = displayObj;
			resize(_displayObj);
			place(_displayObj);
			setViewWindow();
			addChild(_displayObj);
			darawBg();
		} 
		
		public function clear() : void
		{
			if(_displayObj)
				removeChild(_displayObj);	
			_displayObj = null;
		}
		
		public function set boundWidth(boundWidth : Number) : void
		{
			_boundWidth = boundWidth;
			if(!_boundHeight)
				_boundHeight = _displayObj?_displayObj.height:1;
			if(_displayObj)
			{
				resize(_displayObj);
				place(_displayObj);
			}
			setViewWindow();
			darawBg();
		}

		public function set boundHeight(boundHeight : Number) : void
		{
			_boundHeight= boundHeight;
			if(!_boundWidth)
				_boundWidth = _displayObj?_displayObj.width:1;
			if(_displayObj)
			{
				resize(_displayObj);
				place(_displayObj);
			}
			setViewWindow();
			darawBg();
		}
		
		public function set scaleType(scaleType : String) : void
		{
			_scaleType = scaleType;
			if(_displayObj)
			{
				resize(_displayObj);
				place(_displayObj);
			}
		}
		
		public function set bgColor(bgColor : uint) : void
		{
			_bgColor = bgColor;
			darawBg();
		}
		
		public function set bgAlpha(bgAlpha : Number) : void
		{
			_bgAlpha = bgAlpha;
			darawBg();
		}
		
		public function set align(align : String) : void
		{
			_align = align;
			if(_displayObj)
				place(_displayObj);
		}
		
		public function get boundWidth() : Number
		{
			return _boundWidth;
		}
		
		public function get boundHeight() : Number
		{
			return _boundHeight;
		}
		
		public function get displayObj() : DisplayObject
		{
			return _displayObj;
		}
		
		public function get scaleType() : String
		{
			return _scaleType;
		}
	}
}
