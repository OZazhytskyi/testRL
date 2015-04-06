package tests {
	import asunit.framework.TestCase;

	import collage.model.CollageImagesModel;

    public class ModelTest extends TestCase 
	{
		
		private var _model : CollageImagesModel;
        
        public function ModelTest(methodName:String=null) 
		{
            super(methodName);
        }

        override protected function setUp():void 
		{
            super.setUp();
			_model = new CollageImagesModel();
        }

        override protected function tearDown():void 
		{
            super.tearDown();
			_model = null;
        }

        public function testInstantiated():void 
		{
           assertTrue("_model is CollageImagesModel", _model is CollageImagesModel);
        }
		
		public function testCollageImagesCount():void 
		{
        	assertEquals(_model.collageImagesCount, 10);
        }
    }
}
