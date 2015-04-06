package utils
{
	import org.casalib.load.DataLoad;

	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	/**
	 * @author Alexander Zazicky
	 */
	public class DataSendAndLoad extends DataLoad 
	{
		private var _urlVariables : URLVariables;
		
		public function DataSendAndLoad(request : *,urlRequestMethod : String = URLRequestMethod.POST, urlLoaderDataFormat : String = URLLoaderDataFormat.TEXT)
		{
			super(request);
			urlLoader.dataFormat = urlLoaderDataFormat;
			urlRequest.method = urlRequestMethod;
			_urlVariables = new URLVariables();
		}
		
		public function addVariable(varible : String, value : String) : void
		{
			_urlVariables[varible] = value;
			urlRequest.data = _urlVariables;
		}
	}
}
