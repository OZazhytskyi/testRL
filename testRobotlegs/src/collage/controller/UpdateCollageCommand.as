package collage.controller {
	import collage.model.CollageImagesModel;
	import collage.model.vo.ImageVO;
	import collage.signals.UpdateImageSinal;

	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author tuvisum.com, Oleksandr Zazhytskyi
	 */
	public class UpdateCollageCommand extends SignalCommand 
	{
		[Inject]
		public var model : CollageImagesModel;
		
		[Inject]
		public var updateImage : UpdateImageSinal;
		
		override public function execute():void
		{
			var images : Array = model.images;
			var image : ImageVO;
			for(var i : int = 0; i < model.collageImagesCount; i++)
			{
				image = images[i];
				image.index = i;
				updateImage.dispatch(image);
			}
		}
	}
}
