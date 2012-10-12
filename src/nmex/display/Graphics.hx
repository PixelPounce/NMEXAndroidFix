package nmex.display;

import nme.geom.Matrix;
import nme.display.IBitmapDrawable;
import nme.display.BitmapData;
import nme.display.GradientType;
import nme.display.SpreadMethod;
import nme.display.InterpolationMethod;
import nme.display.LineScaleMode;
import nme.display.CapsStyle;
import nme.display.JointStyle;
import nme.display.IGraphicsData;
import nme.display.Tilesheet;
import nme.display.TriangleCulling;
import nme.Loader;
import nmex.Device;

class Graphics{	
	
	public static inline var TILE_SCALE = 0x0001;
	public static inline var TILE_ROTATION = 0x0002;
	public static inline var TILE_RGB = 0x0004;
	public static inline var TILE_ALPHA = 0x0008;
	
	private static inline var TILE_SMOOTH = 0x1000;
	
	private var nmeHandle:Dynamic;
	
	
	public function new(inHandle:Dynamic)
	{	
		nmeHandle = inHandle;	
	}
	
	
	public function arcTo(inCX:Float, inCY:Float, inX:Float, inY:Float)
	{	
		inCX *=  Device.scaleFactor();
	  	inCY *=  Device.scaleFactor();
	  	inX *=  Device.scaleFactor();
	  	inY *=  Device.scaleFactor();
		nme_gfx_arc_to(nmeHandle, inCX, inCY, inX, inY);	
	}

	
	public function beginBitmapFill(bitmap:BitmapData, ?matrix:Matrix, repeat:Bool = true, smooth:Bool = false)
	{	
		nme_gfx_begin_bitmap_fill(nmeHandle, bitmap.nmeHandle, matrix, repeat, smooth);
	}
	
	
	public function beginFill(color:Int, alpha:Float = 1.0)
	{	
		nme_gfx_begin_fill(nmeHandle, color, alpha);
	}


	public function beginGradientFill(type:GradientType, colors:Array<Dynamic>, alphas:Array<Dynamic>, ratios:Array<Dynamic>, ?matrix:Matrix, ?spreadMethod:Null<SpreadMethod>, ?interpolationMethod:Null<InterpolationMethod>, focalPointRatio:Float = 0.0):Void
	{	
		if (matrix == null)
		{	
			matrix = new Matrix();
			matrix.createGradientBox(200, 200, 0, -100, -100);
		}
		
		nme_gfx_begin_gradient_fill(nmeHandle, Type.enumIndex(type), colors, alphas, ratios, matrix, spreadMethod == null ? 0 : Type.enumIndex(spreadMethod), interpolationMethod == null ? 0 : Type.enumIndex(interpolationMethod), focalPointRatio);
	}
	
	
	public function clear()
	{	
		nme_gfx_clear(nmeHandle);	
	}
	
	
	public function curveTo(inCX:Float, inCY:Float, inX:Float, inY:Float)
	{	
		inCX *=  Device.scaleFactor();
	  	inCY *=  Device.scaleFactor();
	  	inX *=  Device.scaleFactor();
	  	inY *=  Device.scaleFactor();
		nme_gfx_curve_to(nmeHandle, inCX, inCY, inX, inY);	
	}
	
	
	public function drawCircle(inX:Float, inY:Float, inRadius:Float)
	{
		inRadius *=  Device.scaleFactor();
	  	inX *=  Device.scaleFactor();
	  	inY *=  Device.scaleFactor();
		nme_gfx_draw_ellipse(nmeHandle, inX, inY, inRadius, inRadius);
	}

	
	public function drawEllipse(inX:Float, inY:Float, inWidth:Float, inHeight:Float)
	{	
		inWidth *=  Device.scaleFactor();
	  	inHeight *=  Device.scaleFactor();
		inX *=  Device.scaleFactor();
	  	inY *=  Device.scaleFactor();
		nme_gfx_draw_ellipse(nmeHandle, inX, inY, inWidth, inHeight); 
	}
	
	
	public function drawGraphicsData(graphicsData:Array<IGraphicsData>):Void
	{	
		var handles = new Array<Dynamic>();
		
		for (datum in graphicsData)
			handles.push(datum.nmeHandle);
		
		nme_gfx_draw_data(nmeHandle, handles);
	}
	
	
	public function drawGraphicsDatum(graphicsDatum:IGraphicsData):Void
	{
		nme_gfx_draw_datum(nmeHandle, graphicsDatum.nmeHandle);
	}
	
	
	public function drawPoints(inXY:Array<Float>, inPointRGBA:Array<Int> = null, inDefaultRGBA:Int = #if neko 0x7fffffff #else 0xffffffff #end, inSize:Float = -1.0)
	{
		nme_gfx_draw_points(nmeHandle, inXY, inPointRGBA, inDefaultRGBA, #if neko true #else false #end, inSize);
	}
	
	
	public function drawRect(inX:Float, inY:Float, inWidth:Float, inHeight:Float)
	{
		inWidth *=  Device.scaleFactor();
	  	inHeight *=  Device.scaleFactor();
	  	inX *=  Device.scaleFactor();
	  	inY *=  Device.scaleFactor();
		nme_gfx_draw_rect(nmeHandle, inX, inY, inWidth, inHeight);
	}
	
	
	public function drawRoundRect(inX:Float, inY:Float, inWidth:Float, inHeight:Float, inRadX:Float, ?inRadY:Float)
	{
		inWidth *=  Device.scaleFactor();
	  	inHeight *=  Device.scaleFactor();
	  	inX *=  Device.scaleFactor();
	  	inY *=  Device.scaleFactor();
	  	inRadX *=  Device.scaleFactor();
	  	inRadY *=  Device.scaleFactor();
		nme_gfx_draw_round_rect(nmeHandle, inX, inY, inWidth, inHeight, inRadX, inRadY == null ? inRadX : inRadY);
	}
	
	
	/**
	 * @private
	 */
	public function drawTiles(sheet:Tilesheet, inXYID:Array<Float>, inSmooth:Bool = false, inFlags:Int = 0):Void
	{
		beginBitmapFill(sheet.nmeBitmap, null, false, inSmooth);
		
		if (inSmooth)
			inFlags |= TILE_SMOOTH;
			
		for(i in 0...inXYID.length){
			if ( (i +1) % 3 != 0 ){
			 	inXYID[i] = Device.scaleFactor() * inXYID[i];
			}
		 }
		
		nme_gfx_draw_tiles(nmeHandle, sheet.nmeHandle, inXYID, inFlags);
	}
	
	
	public function drawTriangles(vertices:Array<Float>, ?indices:Array<Int>, ?uvtData:Array<Float>, ?culling:TriangleCulling, ?colours:Array<Int>, blendMode:Int = 0, viewport:Array<Float> = null)
	{
		var cull:Int = culling == null ? 0 : Type.enumIndex(culling) - 1;
		nme_gfx_draw_triangles(nmeHandle, vertices, indices, uvtData, cull, colours, blendMode, viewport);
	}
	
	
	public function endFill()
	{
		nme_gfx_end_fill(nmeHandle);	
	}
	
	
	public function lineBitmapStyle(bitmap:BitmapData, ?matrix:Matrix, repeat:Bool = true, smooth:Bool = false)
	{
		nme_gfx_line_bitmap_fill(nmeHandle, bitmap.nmeHandle, matrix, repeat, smooth);
	}
	
	
	public function lineGradientStyle(type:GradientType, colors:Array<Dynamic>, alphas:Array<Dynamic>, ratios:Array<Dynamic>, ?matrix:Matrix, ?spreadMethod:Null<SpreadMethod>, ?interpolationMethod:Null<InterpolationMethod>, focalPointRatio:Float = 0.0):Void
	{	
		if (matrix == null)
		{	
			matrix = new Matrix();
			matrix.createGradientBox(200, 200, 0, -100, -100);	
		}
		
		nme_gfx_line_gradient_fill(nmeHandle, Type.enumIndex(type), colors, alphas, ratios, matrix, spreadMethod == null ? 0 : Type.enumIndex(spreadMethod), interpolationMethod == null ? 0 : Type.enumIndex(interpolationMethod), focalPointRatio);
	}
	
	
	public function lineStyle(?thickness:Null<Float>, color:Int = 0, alpha:Float = 1.0, pixelHinting:Bool = false, ?scaleMode:LineScaleMode, ?caps:CapsStyle, ?joints:JointStyle, miterLimit:Float = 3):Void
	{	
		nme_gfx_line_style (nmeHandle, thickness, color, alpha, pixelHinting, scaleMode == null ?  0 : Type.enumIndex(scaleMode), caps == null ?  0 : Type.enumIndex(caps), joints == null ?  0 : Type.enumIndex(joints), miterLimit);	
	}
	
	
	public function lineTo(inX:Float, inY:Float)
	{	
		inX *=  Device.scaleFactor();
	  	inY *=  Device.scaleFactor();
		nme_gfx_line_to(nmeHandle, inX, inY); 
	}
	
	
	public function moveTo(inX:Float, inY:Float){
		inX *=  Device.scaleFactor();
		inY *=  Device.scaleFactor();
	    nme_gfx_move_to(nmeHandle,inX,inY);
	}
	
	
	inline static public function RGBA(inRGB:Int, inA:Int = 0xff):Int
	{	
		#if neko	
		return inRGB | ((inA & 0xfc) << 22);
		#else
		return inRGB | (inA << 24);
		#end
	}
	
	
	
	// Native Methods
	
	
	
	private static var nme_gfx_clear = Loader.load("nme_gfx_clear", 1);
	private static var nme_gfx_begin_fill = Loader.load("nme_gfx_begin_fill", 3);
	private static var nme_gfx_begin_bitmap_fill = Loader.load("nme_gfx_begin_bitmap_fill", 5);
	private static var nme_gfx_line_bitmap_fill = Loader.load("nme_gfx_line_bitmap_fill", 5);
	private static var nme_gfx_begin_gradient_fill = Loader.load("nme_gfx_begin_gradient_fill", -1);
	private static var nme_gfx_line_gradient_fill = Loader.load("nme_gfx_line_gradient_fill", -1);
	private static var nme_gfx_end_fill = Loader.load("nme_gfx_end_fill", 1);
	private static var nme_gfx_line_style = Loader.load("nme_gfx_line_style", -1);
	private static var nme_gfx_move_to = Loader.load("nme_gfx_move_to", 3);
	private static var nme_gfx_line_to = Loader.load("nme_gfx_line_to", 3);
	private static var nme_gfx_curve_to = Loader.load("nme_gfx_curve_to", 5);
	private static var nme_gfx_arc_to = Loader.load("nme_gfx_arc_to", 5);
	private static var nme_gfx_draw_ellipse = Loader.load("nme_gfx_draw_ellipse", 5);
	private static var nme_gfx_draw_data = Loader.load("nme_gfx_draw_data", 2);
	private static var nme_gfx_draw_datum = Loader.load("nme_gfx_draw_datum", 2);
	private static var nme_gfx_draw_rect = Loader.load("nme_gfx_draw_rect", 5);
	private static var nme_gfx_draw_tiles = Loader.load("nme_gfx_draw_tiles", 4);
	private static var nme_gfx_draw_points = Loader.load("nme_gfx_draw_points", -1);
	private static var nme_gfx_draw_round_rect = Loader.load("nme_gfx_draw_round_rect", -1);
	private static var nme_gfx_draw_triangles = Loader.load("nme_gfx_draw_triangles", -1);
	
	
}
