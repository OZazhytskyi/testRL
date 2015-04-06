package tests {
	import asunit.framework.TestCase;
	import collage.model.CollageImagesModel;
	import collage.view.components.CollageView;
	import collage.view.components.display.ICollageImage;

    public class ViewTest extends TestCase 
	{
		
		private var _view : CollageView;
        
        public function ViewTest(methodName:String=null) 
		{
            super(methodName);
        }

        override protected function setUp():void 
		{
            super.setUp();
			_view = new CollageView();
			_view.createLayaut(CollageImagesModel.BOUWKAMP, 10);
        }

        override protected function tearDown():void 
		{
            super.tearDown();
			_view = null;
        }

        public function testInstantiated():void 
		{
           assertTrue("_collageView is CollageView", _view is CollageView);
        }
		
		public function testCreateCollageImage():void 
		{
        	assertTrue("CollageImage is ICollageImage", CollageView.createCollageImage() is ICollageImage);
        }
		
		public function testCreateLayaut():void 
		{
         	assertEquals(_view.imagesCount, 10);
        }
    }
}
