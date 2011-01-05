/**
 * Copyright (c) 2010 Johnson Center for Simulation at Pine Technical College
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package As3Math.general 
{
	import As3Math.am_friend;
	import As3Math.general.amUpdateEvent;
	import flash.events.EventDispatcher;
	
	use namespace am_friend;
	
	/** Abstract base class for all 2d and 3d geometric entities.
	 */
	public class amEntity extends EventDispatcher
	{
		
		public function amEntity() {}
		
		am_friend static const ENTITY_UPDATED_BIT:uint = 0x00000001;
		
		am_friend static const cachedEvent_entityUpdated:amUpdateEvent = new amUpdateEvent(amUpdateEvent.ENTITY_UPDATED);
		
		am_friend static const EVENT_TYPE_TO_FLAG_DICT:Object =
		{
			entityUpdated: ENTITY_UPDATED_BIT
		};
		
		am_friend var eventFlags:uint = 0;
		
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			
			eventFlags |= (EVENT_TYPE_TO_FLAG_DICT[type] as uint);
		}
		
		public override function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void
		{
			super.removeEventListener(type, listener, useCapture);
			
			if ( !hasEventListener(type) ) // clear the bit for this event if the object isn't listening for it anymore.
			{
				eventFlags &= ~EVENT_TYPE_TO_FLAG_DICT[type] as uint;
			}
		}
	}
}