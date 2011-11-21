/*
Class: asf.plugins.analytics.ConsoleLogAnalyticsPlugin
Author: Neto Leal
Created: May 17, 2011

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
package asf.plugins.analytics
{
	import asf.interfaces.IAnalyticsPlugin;
	
	import flash.external.ExternalInterface;
	
	public class ConsoleLogAnalyticsPlugin implements IAnalyticsPlugin
	{
		public function track( uri:String ):void
		{
			try
			{
				ExternalInterface.call( "console.log", "	== TRACK: " + uri );
			}
			catch( e:Error )
			{
				log( uri );
			}
		}
		
		public function trackEvent( uri:String ):void
		{
			track( uri );
		}
		
		public function dispose():void
		{
			//Not needed here
		}
	}
}