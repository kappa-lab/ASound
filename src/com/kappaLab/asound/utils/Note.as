/*
 *cf)
 *http://sazameki.org/ 
 */
package com.kappaLab.asound.utils
{
    public class Note 
    {
        
        static public const DO:Number  = 261.626;
        static public const DOS:Number = 277.183;
        static public const RE:Number  = 293.665;
        static public const RES:Number = 311.127;
        static public const MI:Number  = 329.628;
        static public const FA:Number  = 349.228;
        static public const FAS:Number = 369.994;
        static public const SO:Number  = 391.995;
        static public const SOS:Number = 415.305;
        static public const RA:Number  = 440;
        static public const RAS:Number = 466.164;
        static public const SI:Number  = 493.883;
        
        
        public function Note() 
        {
            throw new ArgumentError("Consts class !!")
        }
        
        
        static public function note2Frequency(noteNumber:uint):Number 
        {
            return(8.1758 * Math.pow(2,noteNumber/12));
		}
    }
}