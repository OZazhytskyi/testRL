package collage 
{
	import collage.view.CollageContext;

	import net.hires.debug.Stats;

	import tests.AsUnitTestRunner;

	import flash.display.*;
	import flash.events.Event;
	import flash.system.Security;

	/**
	 * @author Gumenyuk
	 */
	public class Main extends Sprite 
	{
		private var _context : CollageContext;
		private var _runner : AsUnitTestRunner;

		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(_event : Event) : void
		{
			// Instantiate the ApplicationFacade
			stage.scaleMode 				= StageScaleMode.NO_SCALE;
			stage.align 					= StageAlign.TOP_LEFT;
			stage.showDefaultContextMenu 	= false;
			stage.stageFocusRect 			= false;
			stage.quality					= StageQuality.HIGH;
			
			Security.allowDomain("*"); 
			
			_context = new CollageContext(this);
			
			addChild(new Stats());
			
			// tests
			_runner = new AsUnitTestRunner();
		}
		
		private function merge(a: Array, b: Array) : Array
		{
			var merged : Array = []; 
			
			var aL : int = a.length;
			var bL: int = b.length;
			var mergedL : int = aL + bL;
			
			var i : int = 0;
			var j : int = 0;
			
			for(var k:int = 0; k < mergedL; k++)
			{
				if(i >= aL)
				{
					merged[k] = b[j];
					j++;
				}else if(j >= bL)
				{
					merged[k] = a[i];
					i++;
				}else{
					if(a[i] < b[j])
					{
						merged[k] = a[i];
						i++;
					}else
					{
						merged[k] = b[j];
						j++;
					}
				}
			}
			
			return merged;
		}
	}
}
