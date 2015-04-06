package tests {
	import asunit.framework.TestCase;

	import collage.model.CollageImagesModel;
	import collage.service.FlickrGetImagesService;
	import collage.signals.UpdateCollageSignal;

    public class ServiceTest extends TestCase 
	{
		
		private var _model : CollageImagesModel;
		private var _service : FlickrGetImagesService;
        
        public function ServiceTest(methodName:String=null) 
		{
            super(methodName);
        }

        override protected function setUp():void 
		{
            super.setUp();
			_model = new CollageImagesModel();
			_model.updateCollage = new UpdateCollageSignal();
			_service = new FlickrGetImagesService();
			_service.collageImagesModel = _model;
			_service.getImages();
        }

        override protected function tearDown():void 
		{
            super.tearDown();
			_model = null;
			_service = null;
        }

        public function testInstantiated():void 
		{
           assertTrue("_model is CollageImagesModel", _model is CollageImagesModel);
		   assertTrue("_service is FlickrGetImagesService", _service is FlickrGetImagesService);
        }
		
		public function testLoadingData():void 
		{
        	var handler:Function = addAsync(checkLoadedData, 5000);
			_model.updateCollage.add(handler);
        }
		
		private function checkLoadedData() : void
		{
			assertTrue("_model.images.length > 0", _model.images.length > 0);
		}
    }
}
