package collage.view {
	import collage.model.CollageImagesModel;
	import collage.model.vo.ImageVO;
	import collage.service.IGetImagesService;
	import collage.signals.CollageImageSelectedSignal;
	import collage.signals.UpdateImageSinal;
	import collage.view.components.CollageView;

	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author tuvisum.com, Oleksandr Zazhytskyi
	 */
	public class CollageViewMediator extends Mediator implements IMediator 
	{
		[Inject]
		public var view:CollageView;
		
		[Inject]
		public var updateImage : UpdateImageSinal;
		
		[Inject]
		public var imageSelected : CollageImageSelectedSignal;
		
		[Inject]
		public var service : IGetImagesService;
		
		[Inject]
		public var model : CollageImagesModel;

		override public function onRegister() : void 
		{	
			updateImage.add(updateImageHandler);
			imageSelected.add(onImageSelected);
			
			view.createLayaut(CollageImagesModel.BOUWKAMP, model.collageImagesCount);	
			service.getImages();
		}

		private function updateImageHandler(image : ImageVO) : void 
		{
			view.loadImage(image.url, image.index);
		}
		
		private function onImageSelected(index : int) : void 
		{
			view.loadImage(model.getRandomImage().url, index, true);
		}
	}
}
