/*
Class: com.netoleal.asf.test.viewcontrollers.sections.BaseSectionViewController
Author: Neto Leal
Created: May 13, 2011

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
package com.netoleal.asf.test.viewcontrollers.sections
{
	import asf.core.elements.Section;
	import asf.core.util.Sequence;
	import asf.core.viewcontrollers.InOutViewController;
	import asf.events.ApplicationEvent;
	import asf.events.DependenciesProgressEvent;
	import asf.events.FlowEvent;
	import asf.events.NavigationEvent;
	import asf.events.SectionEvent;
	import asf.flow.LoadShowFlow;
	import asf.interfaces.ISequence;
	import asf.interfaces.ITransitionable;
	
	import com.netoleal.asf.sample.view.assets.Loading;
	import com.netoleal.asf.test.viewcontrollers.assets.LoadingViewController;
	import com.netoleal.asf.test.viewcontrollers.menu.MenuViewController;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class BaseSectionViewController extends InOutViewController implements ITransitionable
	{
		private var section:Section;
		private var menu:MenuViewController;
		private var loading:LoadingViewController;
		private var flow:LoadShowFlow;
		
		public function BaseSectionViewController(p_target:MovieClip, p_section:Section)
		{
			super(p_target);
			section = p_section;
			
			section.mainApplication.trackAnalytics( "test", "a", "b" );
			section.mainApplication.trackAnalytics( section.mainApplication.metrics.asf.sample.site.loaded );
			
			view.$title.$text.text = section.mainApplication._.title;
			menu = new MenuViewController( view.$menu, section );
			loading = new LoadingViewController( new Loading( ) );
			
			section.layers.loading.addChild( loading.view );
			
			flow = new LoadShowFlow( section.navigation, true );
			
			flow.addEventListener( FlowEvent.SHOW_LOADING, onFlowShowLoading );
			flow.addEventListener( FlowEvent.HIDE_LOADING, onFlowHideLoading );
			flow.addEventListener( DependenciesProgressEvent.LOAD_PROGRESS, onSectionLoadProgress );
			
			section.navigation.addEventListener( NavigationEvent.CHANGE, onSectionNavigate );
			
			section.layers.feed.x = parseInt( section.styles.getStyle( "FacebookFeedSectionView" ).x );
			menu.addEventListener( Event.RESIZE, arrange );
		}
		
		private function onFlowHideLoading(event:FlowEvent):void
		{
			section.sounds.play( "transition" );
			loading.close( ).queue( flow.resumeCurrentLoading );
		}
		
		private function onFlowShowLoading(event:FlowEvent):void
		{
			showLoading( ).queue( flow.resumeCurrentLoading );
		}
		
		private function arrange( evt:Event = null ):void
		{
			section.layers.feed.y = menu.view.y + menu.view.height + 20;
		}
		
		private function onSectionNavigate(event:NavigationEvent):void
		{
			section.mainApplication.trackAnalytics( "navigate", event.section.id );
		}
		
		private function onSectionLoadProgress(event:DependenciesProgressEvent):void
		{
			loading.setProgress( event.bytesLoaded / event.bytesTotal );
		}
		
		private function showLoading( ):ISequence
		{
			section.sounds.play( "transition" );
			loading.setProgress( 0 );
			return loading.open( );
		}
		
		public function open(p_delay:uint=0):ISequence
		{
			return this.animateIn( true ).queue( navigateHome ).queue( menu.open );
		}
		
		private function navigateHome( ):void
		{
			log( );
			section.navigation.openSection( { sectionID: "feed", closeCurrentBeforeOpen: false, setAsCurrent: false } );
		}
		
		public function close(p_delay:uint=0):ISequence
		{
			return this.animateOut( true );
		}
		
		public override function dispose():void
		{
			super.dispose( );
		}
	}
}