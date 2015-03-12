package org.papervision3d.view
{
	import org.papervision3d.cameras.DebugFrustumCamera3D;	
	import org.papervision3d.cameras.FrustumCamera3D;	
	import org.papervision3d.cameras.FreeCamera3D;	
	import org.papervision3d.cameras.Camera3D;	
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.core.view.IView;
	import org.papervision3d.render.BasicRenderEngine;

	/**
	 * <p>
	 * BasicView provides a simple template for quickly setting up
	 * basic Papervision3D projects by creating a viewport, scene,
	 * camera, and renderer for you. Because BasicView is a subclass of
	 * Sprite, it can be added to any DisplayObject.
	 * </p>
	 * 
	 * <p>
	 * <p>
	 * Example:
	 * </p>
	 * <pre><code>
	 * var width:Number = 640;
	 * var heigth:Number = 480;
	 * var scaleToStage:Boolean = true;
	 * var interactive:Boolean = true;
	 * var cameraType:String = Camera3D.TYPE;
	 * 
	 * var myBasicView:BasicView = new BasicView(width, height, scaleToStage, interactive, cameraType);
	 * myDisplayObject.addChild(myBasicView);
	 * </code></pre>
	 * </p>
	 * @author Ralph Hauwert
	 */
	public class BasicView extends AbstractView implements IView
	{
		/**
		 * @param viewportWidth		Width of the viewport 
		 * @param viewportHeight	Height of the viewport
		 * @param scaleToStage		Whether you viewport should scale with the stage
		 * @param interactive		Whether your scene should be interactive
		 * @param cameraType		A String for the type of camera, usually referenced by a public static variable; e.g. FrustumCamera3D.TYPE. 
		 * We use "CAMERA3D" in the constuctor because it's a workaround to a bug in Flash Authoring with static constants in class constructors. @see http://bugs.adobe.com/jira/browse/ASC-2231
		 * 
		 */	
		public function BasicView(viewportWidth:Number = 640, viewportHeight:Number = 480, scaleToStage:Boolean = true, interactive:Boolean = false, cameraType:String = "CAMERA3D")
		{
			super();
			
			scene = new Scene3D();
			viewport = new Viewport3D(viewportWidth, viewportHeight, scaleToStage, interactive);
			addChild(viewport);
			renderer = new BasicRenderEngine();
			
			switch(cameraType)
			{
				case Camera3D.TYPE:
					_camera = new Camera3D();
					break;
				case FreeCamera3D.TYPE:
					_camera = new FreeCamera3D();
					break;
				case FrustumCamera3D.TYPE:
					_camera = new FrustumCamera3D(viewport);
					break;
				case DebugFrustumCamera3D.TYPE:
					_camera = new DebugFrustumCamera3D(viewport);
					break;
				default:
					_camera = new Camera3D();
					break;
			}
		}

		/**
		 * Exposes the camera as a <code>Camera3D</code>
		 */
		public function get cameraAsCamera3D():Camera3D
		{
			return _camera as Camera3D;
		}
		
		/**
		 * Exposes the camera as a <code>FreeCamera3D</code>
		 */
		public function get cameraAsFreeCamera3D():FreeCamera3D
		{
			return _camera as FreeCamera3D;
		}
		
		/**
		 * Exposes the camera as a <code>FrustumCamera3D</code>
		 */
		public function get cameraAsFrustumCamera3D():FrustumCamera3D
		{
			return _camera as FrustumCamera3D;
		}
		
		/**
		 * Exposes the camera as a <code>DebugFrustumCamera3D</code>
		 */
		public function get cameraAsDebugFrustumCamera3D():DebugFrustumCamera3D 
		{
			return _camera as DebugFrustumCamera3D;
		}
	}
}