package collage.model {
	import collage.model.vo.ImageVO;
	import collage.signals.UpdateCollageSignal;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author tuvisum.com, Oleksandr Zazhytskyi
	 */
	public class CollageImagesModel extends Actor 
	{
		private var _images : Array;
		
		public static const BOUWKAMP : String = "10 105 104 (60,45)(19,26)(44,16)(12,7)(33)(28)"; // "11 185 183 (105,80)(33,47)(78,27)(19,14)(5,56)(51)";
		public var collageImagesCount : int;
		
		[Inject]
		public var updateCollage : UpdateCollageSignal;

		public function CollageImagesModel() 
		{
			collageImagesCount = BOUWKAMP.split(" ")[0];
		}
		
		public function getRandomImage() : ImageVO
		{
			return images[Math.floor(Math.random()*images.length)];
		}
		
		public function set images(images : Array) : void 
		{
			_images = images;
			updateCollage.dispatch();
		}
		
		public function get images() : Array 
		{
			return _images;
		}
	}
}
