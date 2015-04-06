/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package collage.view {
	import collage.controller.UpdateCollageCommand;
	import collage.model.CollageImagesModel;
	import collage.service.FlickrGetImagesService;
	import collage.service.IGetImagesService;
	import collage.signals.CollageImageSelectedSignal;
	import collage.signals.UpdateCollageSignal;
	import collage.signals.UpdateImageSinal;
	import collage.view.components.CollageView;

	import utils.Output;

	import org.robotlegs.mvcs.SignalContext;

	import flash.display.DisplayObjectContainer;
	
	public class CollageContext extends SignalContext
	{
		private const VIEW_PACKAGE:String = "collage.view.components";
		
		public function CollageContext(contextView:DisplayObjectContainer)
		{
			super(contextView);
		}
		
		override public function startup():void
		{
			viewMap.mapPackage(VIEW_PACKAGE);
			
			mediatorMap.mapView(CollageView, CollageViewMediator);
			
			injector.mapSingleton(UpdateImageSinal);
			injector.mapSingleton(CollageImageSelectedSignal);
			injector.mapSingleton(CollageImagesModel);
			
			injector.mapSingletonOf(IGetImagesService, FlickrGetImagesService);
			
			signalCommandMap.mapSignalClass(UpdateCollageSignal, UpdateCollageCommand);
			
			contextView.addChild(new CollageView());
			
			//contextView.addChild(new Output());
			
			super.startup();
		}
	
	}
}