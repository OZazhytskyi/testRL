package collage.view.components.display {
	/**
	 * @author tuvisum.com, Oleksandr Zazhytskyi
	 */
	public interface ICollageImage 
	{
		function set url(url : String) : void
		function set x(x : Number) : void
		function set y(y : Number) : void
		function set w(w : Number) : void
		function set h(h : Number) : void
		function get x() : Number
		function get y() : Number
		function get w() : Number
		function get h() : Number
	}
}
