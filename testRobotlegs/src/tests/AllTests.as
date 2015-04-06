package tests {
	import asunit.framework.TestSuite;

	/**
	 * @author tuvisum.com, Oleksandr Zazhytskyi
	 */
	public class AllTests extends TestSuite 
	{
		public function AllTests() 
		{
			super();
			addTest(new ViewTest());
			addTest(new ModelTest());
			addTest(new ServiceTest());
		}
	}
}
