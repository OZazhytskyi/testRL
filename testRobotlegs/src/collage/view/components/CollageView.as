package collage.view.components 
{
	import collage.signals.CollageImageSelectedSignal;
	import collage.view.components.display.ICollageImage;
	import collage.view.components.display.ImageViewer;

	import com.greensock.TweenLite;

	import org.casalib.events.LoadEvent;
	import org.casalib.util.StringUtil;

	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;

	/**
	 * @author tuvisum.com, Oleksandr Zazhytskyi
	 */
	public class CollageView extends Sprite 
	{	
		private const WIDTH_LAYOUT : Number = 700;
		
		private var _collageImages : Array = [];
		private var _loadingMap : Dictionary = new Dictionary();
		
		[Inject]
		public var imageSelected : CollageImageSelectedSignal;
		
		public function CollageView() 
		{
			_loadingMap = new Dictionary();
			addEventListener(MouseEvent.CLICK, onClick);
		}

		private function onClick(event : MouseEvent) : void 
		{
			if(event.target is ICollageImage)
			{
				var image : ICollageImage = event.target as ICollageImage;
				imageSelected.dispatch(_collageImages.indexOf(image));
			}
		}
		
		private function bk2layout(bouwkamp : String, images : Array, targetSize : Number) : void
		{
			// convert bouwkamp to tablecode
			var tableCodeStr : String = StringUtil.trim(bouwkamp.replace(/[(),]/g, " ").replace(/ +/g, " "));
			var c : Array = tableCodeStr.split(" ");
			
			 // first three elements from the bouwkamp/tablecode string are order, width, height.
    		var o : int = parseInt(c[0]);
    		var w : int = parseInt(c[1]);
    		var h : int = parseInt(c[2]);
			
			var s : Number = Math.round((targetSize/w));
			
			// scale up width / height
    		w = w*s;
    		h = h*s;
			
			var i : int;
			var j : int;
			var k : int;
			
			var code : Array = [];
    		var f : Array = [];
			
			for(var z : int =3;z<c.length;z++)
			{
        		// convert the strings to ints and multiply by our scale factor s
       	 		code.push(parseInt(c[z])*s);
    		} 
			
			for(i=0;i<w;i++) 
			{
        		f[i]=0;
    		}
			
			var image : ICollageImage;
			for(k=0;k<o;k++) 
			{
        		i=0; 
		        for(j=1;j<w;j++) 
				{ 
		            if(f[j]<f[i]) 
					{
		                i=j;
		            }
		        }
	        	
	        	image = images[k] as ICollageImage;
	        	image.w = code[k];
				image.h = code[k];
				image.x = i;
				image.y = f[i];
				 
		        for(j=0;j<code[k];j++) 
				{
		            f[i+j]+=code[k];
		        }       
    		}
		}
		
		public function createLayaut(bouwkamp : String, count : int) : void
		{
			var image : ICollageImage;
			for(var i : int = 0;i < count; i++)
			{
        		image = createCollageImage();
				_collageImages.push(image);
				addChild(image as DisplayObject);
    		} 
			
			bk2layout(bouwkamp, _collageImages, WIDTH_LAYOUT);
		}
		
		public function loadImage(url : String, index : int, fade : Boolean = false) : void
		{
			var image : ICollageImage = _collageImages[index];
			
			if(fade)
			{
				InteractiveObject(image).mouseEnabled = false;
				
				var nextImage : ICollageImage = createCollageImage();
				nextImage.x = image.x;
				nextImage.y = image.y;
				nextImage.w = image.w;
				nextImage.h = image.h;
				DisplayObject(nextImage).alpha = 0;
				InteractiveObject(nextImage).mouseEnabled = false;
				addChild(nextImage as DisplayObject);
				IEventDispatcher(nextImage).addEventListener(LoadEvent.COMPLETE, onCompleteLoadImage);
				
				_loadingMap[nextImage] = index;
				nextImage.url = url;
				
				return;
			}
			
			image.url = url;
		}

		private function onCompleteLoadImage(event : LoadEvent) : void 
		{
			var nextImage : ICollageImage = event.target as ICollageImage;
			var index : int = _loadingMap[nextImage];
			var currentImage : ICollageImage = _collageImages[index];

			TweenLite.to(nextImage, 1.2, {alpha:1, onComplete :onComplete, onCompleteParams:[nextImage, currentImage]});
		}
		
		private function onComplete(nextImage: ICollageImage, currentImage : ICollageImage) : void
		{
			currentImage.url = null;
			removeChild(currentImage as DisplayObject);
		
			InteractiveObject(nextImage).mouseEnabled = true;
			_collageImages[_collageImages.indexOf(currentImage)] = nextImage;
			delete _loadingMap[nextImage];
		}
		
		public static function createCollageImage():ICollageImage
		{
			return new ImageViewer(false);
		}
		
		public function get imagesCount() : int
		{
			return _collageImages.length;
		}
		
	}
}
