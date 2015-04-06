package collage.service {
	import collage.model.CollageImagesModel;
	import collage.model.vo.ImageVO;

	import utils.DataSendAndLoad;

	import org.casalib.events.LoadEvent;
	import org.robotlegs.mvcs.Actor;

	import flash.system.Security;
	/**
	 * @author tuvisum.com, Oleksandr Zazhytskyi
	 */
	public class FlickrGetImagesService extends Actor implements IGetImagesService 
	{
		private const API_KEY : String = "4ef2fe2affcdd6e13218f5ddd0e2500d";
		private const USER_ID : String = "38181284@N06";
		
		[Inject]
		public var collageImagesModel : CollageImagesModel;
		
		public function FlickrGetImagesService() 
		{
			Security.loadPolicyFile("http://api.flickr.com/crossdomain.xml");
			Security.loadPolicyFile("http://static.flickr.com/crossdomain.xml");
			Security.loadPolicyFile("http://farm1.static.flickr.com/crossdomain.xml");
			Security.loadPolicyFile("http://farm2.static.flickr.com/crossdomain.xml");
			Security.loadPolicyFile("http://farm3.static.flickr.com/crossdomain.xml");
			Security.loadPolicyFile("http://farm4.static.flickr.com/crossdomain.xml");
			Security.loadPolicyFile("http://farm5.static.flickr.com/crossdomain.xml");
			Security.loadPolicyFile("http://farm6.static.flickr.com/crossdomain.xml");
			Security.loadPolicyFile("http://farm7.static.flickr.com/crossdomain.xml");
			Security.loadPolicyFile("http://farm8.static.flickr.com/crossdomain.xml");
			Security.loadPolicyFile("http://farm9.static.flickr.com/crossdomain.xml"); 
		}
			
		public function getImages(searchString : String = '') : void 
		{
			var dataSendAndLoad : DataSendAndLoad = new DataSendAndLoad('https://api.flickr.com/services/rest/');
			dataSendAndLoad.addVariable('api_key', API_KEY);
			dataSendAndLoad.addVariable('method', 'flickr.people.getPublicPhotos');
			dataSendAndLoad.addVariable('user_id', USER_ID);
			dataSendAndLoad.addEventListener(LoadEvent.COMPLETE, onCompleteLoadPhotosData);
			dataSendAndLoad.start();
		}

		private function onCompleteLoadPhotosData(event : LoadEvent) : void 
		{		
			var dataSendAndLoad	: DataSendAndLoad = event.currentTarget as DataSendAndLoad;
			
			var secret 			: String;
			var server			: String;				
			var imageVO			: ImageVO;
			var len				: int = dataSendAndLoad.dataAsXml..photo.length();
			var i				: int = -1;
			var images			: Array = [];
			//trace("images number:", len);
			while(++i < len)
			{
				server				= dataSendAndLoad.dataAsXml..photo[i].@server.toString();
				secret				= dataSendAndLoad.dataAsXml..photo[i].@secret.toString();
				
				imageVO				= new ImageVO();
				imageVO.id 			= dataSendAndLoad.dataAsXml..photo[i].@id.toString();
				imageVO.url			= "http://static.flickr.com/" + server + "/" + imageVO.id + "_" + secret + ".jpg";
				//trace("url:", imageVO.url);
				images.push(imageVO);
			}
			
			collageImagesModel.images = images;
		}
	}
}
