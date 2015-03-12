
// code.as
import Tweens;


// variables  -------------------------------------------------------------------------------------
_quality = "BEST";
var countInterval:Number;
var inc:Number = 0;

_global._tweens = new Tweens();


// functions  -------------------------------------------------------------------------------------

function startCounting(mc1:MovieClip, mc2:MovieClip):Void {
	clearInterval(countInterval);
	countInterval = setInterval(this, "countUp", 80, mc1, mc2);
}

function countUp(mc1:MovieClip, mc2:MovieClip):Void {
	mc1.counter.text = inc + 1;
	
	inc++;
	
	if(inc >= 15) {
		clearInterval(countInterval);
		_tweens.fadeTween(mc2, 0, 100, .8);
		mc2.gotoAndPlay("echo");
	}
}

// handlers  --------------------------------------------------------------------------------------
// hotSpot_btn.onRollOver = defaultClick;



// run at once  -----------------------------------------------------------------------------------




