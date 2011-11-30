﻿package sections{	import asf.core.elements.Section;	import asf.core.util.Sequence;	import asf.interfaces.ISectionView;	import asf.view.UIView;	import view.ImagesSectionView;	import asf.core.viewcontrollers.InOutViewController;	import flash.display.Bitmap;	import asf.interfaces.ISequence;		public class ImagesSection extends ImagesSectionView implements ISectionView	{		private var controller:InOutViewController;		private var section:Section;		private var img:Bitmap;				public function ImagesSection( )		{			controller = new InOutViewController( this );		}				public function init(p_section:Section, ...parameters):void		{			section = p_section;						img = section.dependencies.getImage( "sample" );			img.alpha = 0;						section.layers.image.addChild( img );		}				public function open(p_delay:uint=0):ISequence		{			fadeIn( img, 333, 500 );			return controller.animateIn( );		}				public function close(p_delay:uint=0):ISequence		{			fadeOut( img );			return controller.animateOut( );		}				public function dispose():void		{			section.layers.image.removeChild( img );			img = null;						controller.dispose( );			controller = null;		}	}}