/*
Class: asf.core.viewcontrollers.AbstractViewController
Author: Neto Leal
Created: Apr 13, 2011

The MIT License
Copyright (c) 2011 Neto Leal

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
package asf.core.viewcontrollers
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	/**
	 * Classe usada como base para todos os ViewControllers. 
	 * @author neto.leal
	 * 
	 */
	public class AbstractViewController extends EventDispatcher
	{
		private var _view:*;
		
		public function AbstractViewController( p_view:* )
		{
			super( this );
			setView( p_view );
		}
		
		public function setView( p_view:* ):void
		{
			_view = p_view;
		}
		
		/**
		 * View com tipo indeterminado 
		 * @return 
		 * 
		 */
		public function get view( ):*
		{
			return _view;
		}
		
		/**
		 * View como Sprite 
		 * @return 
		 * 
		 */
		public function get viewAsSprite( ):Sprite
		{
			return _view as Sprite;
		}
		
		/**
		 * View como MovieClip 
		 * @return 
		 * 
		 */
		public function get viewAsMovieClip( ):MovieClip
		{
			return _view as MovieClip;
		}
		
		/**
		 * View como DisplayObject 
		 * @return 
		 * 
		 */
		public function get viewAsDisplayObject( ):DisplayObject
		{
			return _view as DisplayObject;
		}
		
		/**
		 * Limpa memória 
		 * 
		 */
		public function dispose( ):void
		{
			_view = null;
		}
	}
}