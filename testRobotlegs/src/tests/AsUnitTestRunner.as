package tests {
	import asunit.textui.TestRunner;

	/**
	 * @author tuvisum.com, Oleksandr Zazhytskyi
	 */
	public class AsUnitTestRunner extends TestRunner {
		public function AsUnitTestRunner() {
			start(AllTests, null, TestRunner.SHOW_TRACE);
		}
	}
}
