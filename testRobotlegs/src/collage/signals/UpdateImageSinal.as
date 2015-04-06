package collage.signals {
	import collage.model.vo.ImageVO;

	import org.osflash.signals.Signal;

	/**
	 * @author tuvisum.com, Oleksandr Zazhytskyi
	 */
	public class UpdateImageSinal extends Signal 
	{
		public function UpdateImageSinal() 
		{
			super(ImageVO);
		}
	}
}
