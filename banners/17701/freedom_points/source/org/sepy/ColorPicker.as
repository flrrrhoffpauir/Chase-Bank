[IconFile("ColorPicker.png")]

/**
 * Simple Color Picker component
 *
 * @author Alessandro Crugnola [sephiroth]
 * @email  alessandro@sephiroth.it
 * @url    http://www.sephiroth.it
 */

class org.sepy.ColorPicker extends MovieClip {

    private var _colors:Array
    private var _opening_color:Number
    private var _color:Number
    private var cpicker:MovieClip
    private var _direction:String
    private var _columns:Number
    private var panel:MovieClip
    private var _baseColors:Array
    private var selectedColor:MovieClip
    private var _opened:Boolean
    private var _allowUserColor:Boolean
    private var keyListener:Object

    public static var DOWN_LEFT:String = "DL"
    public static var DOWN_RIGHT:String = "DR"
    public static var UP_LEFT:String = "UL"
    public static var UP_RIGHT:String = "UR"

    private static var MIN_WIDTH:Number = 105

    public var addListener:Function
    public var removeListener:Function
    private var broadcastMessage:Function



    function ColorPicker(){
        AsBroadcaster.initialize(this)
        _color = 0x000000
        _direction      = ColorPicker.DOWN_RIGHT
        _allowUserColor = true
        _baseColors = [0xff00ff,0x00ffff,0xffff00,0x0000ff,0x00ff00,0xff0000,0xffffff,0xcccccc,0x999999,0x666666,0x333333,0x000000]
        _colors = this.getStandardColors()
        initComponent();

        this.addListener(this)
    }

    private function initComponent():Void
    {
        keyListener = new Object();
        keyListener.target = this
        keyListener.onKeyUp = function()
        {
            if(Key.getCode() == Key.ESCAPE && this.target.getIsOpened())
            {
                this.target.setIsOpened(false)
                this.target.color = this.target._opening_color
            }
        }
        Key.addListener(keyListener)
        cpicker.onPress = function(){
            this._parent.broadcastMessage("open")
        }

        cpicker.useHandCursor = false;
    }

    /**
     * open the color panel
     */
    public function setIsOpened(opened:Boolean):Void{
        if(opened && !_opened){
            _opening_color = _color
            attachPanel();
        } else {
            panel.removeMovieClip();
        }
        _opened = opened
    }

    /**
     * Return the current panel opened status
     */
    public function getIsOpened():Boolean
    {
        return _opened
    }

    private function attachPanel():Void
    {
        panel = this.createEmptyMovieClip("panel", 1)
        panel.createEmptyMovieClip("background", 2)
        panel.createEmptyMovieClip("colors",     3)
        panel.colors._x = 3
        panel.colors._y = 26
        populateColorPanel()


        var w:Number = (panel.colors._width < ColorPicker.MIN_WIDTH ? ColorPicker.MIN_WIDTH : panel.colors._width) + 6 + panel.colors._x
        var h:Number = panel.colors._height + 6 + panel.colors._y

        panel.background.lineStyle(1, 0xFFFFFF, 100)
        panel.background.beginFill(0xD4D0C8, 100)
        panel.background.moveTo(0,0)
        panel.background.lineTo(w, 0)
        panel.background.lineStyle(1, 0x808080, 100)
        panel.background.lineTo(w, h)
        panel.background.lineTo(0, h)
        panel.background.lineStyle(1, 0xFFFFFF, 100)
        panel.background.lineTo(0, 0)
        panel.background.endFill();
        panel.background.lineStyle(1, 0x000000, 100)
        panel.background.moveTo(w+1,0)
        panel.background.lineTo(w+1, h+1)
        panel.background.lineTo(0, h+1)

        panel.background.attachMovie("color_display", "color_display", 1)
        panel.background.color_display.color = color
        panel.background.color_display._x = 3
        panel.background.color_display._y = 3
        panel.background.color_display.addListener(this)

        panel.background.attachMovie("color_input", "color_input", 2)
        panel.background.color_input.color = color
        panel.background.color_input._x = 48
        panel.background.color_input._y = 3
        panel.background.color_input.enabled = _allowUserColor
        panel.background.color_input.addListener(this)

        panel.colors.attachMovie("face_borders", "face_borders", panel.colors.getNextHighestDepth())
        var c:Color = new Color(panel.colors.face_borders)
        c.setRGB(0xFFFFFF)

        panel.colors.face_borders._x = selectedColor._x
        panel.colors.face_borders._y = selectedColor._y

        switch(direction){
            case ColorPicker.DOWN_RIGHT:
                panel._x = cpicker._x
                panel._y = cpicker._y + cpicker._height + 5
                break;
            case ColorPicker.DOWN_LEFT:
                panel._x = cpicker._x - panel._width + cpicker._width
                panel._y = cpicker._y + cpicker._height + 5
                break;
            case ColorPicker.UP_LEFT:
                panel._x = cpicker._x - panel._width + cpicker._width
                panel._y = cpicker._y - panel._height - 5
                break;
            case ColorPicker.UP_RIGHT:
                panel._x = cpicker._x
                panel._y = cpicker._y - panel._height - 5
                break;
        }

        panel.onMouseDown = function()
        {
            this.onMouseUp = function()
            {
                if(this._parent.getIsOpened())
                {
                    var point:Object = {x:_xmouse, y:_ymouse}
                    this.localToGlobal(point)
                    if(!this.hitTest(point.x, point.y))
                    {
                        this._parent.color = this._parent._opening_color
                        this._parent.setIsOpened(false)
                    }
                }
            }
        }

    }

    private function populateColorPanel()
    {
        var temp_colors:Array = _colors.slice();
        var currentColor:Number
        var currentItem:MovieClip
        var x:Number = 0
        var y:Number = 0
        var index:Number = 0
        while(temp_colors.length)
        {
            currentColor = Number(temp_colors.shift());
            currentItem  = panel.colors.attachMovie("single", "single_" + panel.colors.getNextHighestDepth(), panel.colors.getNextHighestDepth())
            currentItem.addListener(this)
            currentItem.color = currentColor;
            if(currentColor == color)
            {
                selectedColor = currentItem
            }

            if(index%columns == 0 && index > 0)
            {
                y += currentItem._height
                x = 0
            }
            currentItem._x = x
            currentItem._y = y
            x += currentItem._width
            index++
        }
    }


    /**
     * Return an array containing the common used web-colors
     */
    public function getStandardColors():Array
    {
        var ret:Array = new Array();
        var c1:Number    = 0xFFFFFF
        var diff1:Number = 0x3300
        var diff2:Number = 0x320100
        var diff3:Number = 0x9900ff
        var diff5:Number = 0x33
        var diff6:Number = 0x98ff01

        var tcolor:Number = c1
        var ycolor:Number = c1

        for(var b = 0; b < 12; b++){
            for(var a = 0; a < 21; a++){
                if(a > 0){
                    if(a == 18){
                        tcolor = 0x00
                    } else if(a == 19){
                        tcolor = _baseColors[b]
                    } else if(a == 20){
                        tcolor = 0x00000
                    } else if(a%6 == 0 && a > 0){
                        tcolor -=diff2
                    } else {
                        tcolor -=diff1
                    }
                }
                ret.push(tcolor)
            }
            if(b==5){
                ycolor -= diff6
            } else {
                ycolor -= diff5
            }
            tcolor = ycolor
        }
        ret.reverse()
        return ret
    }

    /**
     *
     * @usage
     * @param   newcolor
     * @return
     */
    [Inspectable(type="Color",defaultValue=0x000000)]
    public function set color (newcolor:Number):Void {
        _color = newcolor
        updateColors(newcolor, true);
    }

    /**
     *
     * @usage
     * @return
     */
    public function get color ():Number {
        return _color;
    }

    [Inspectable]
    public function set direction(value:String){
        _direction = value
    }

    public function get direction():String{
        return _direction
    }

    [Inspectable(type="Number", defaultValue=21)]
    public function set columns(value:Number):Void
    {
        _columns = value
    }

    public function get columns():Number
    {
        return _columns
    }

    public function set enabled(value:Boolean)
    {
        cpicker.enabled = value
    }

    public function get enabled():Boolean
    {
        return cpicker.enabled
    }


    [Inspectable(type="Boolean", defaultValue=true)]
    public function set allowUserColor(value:Boolean)
    {
        _allowUserColor = value
    }

    public function get allowUserColor():Boolean
    {
        return _allowUserColor
    }

    public function set colors(value:Array)
    {
        _colors = value
    }

    public function get colors():Array
    {
        return _colors
    }



    /**
     * Return the current color
     * in a string format (FFCC00)
     */
    public function getRGB():String
    {
        return ColorPicker.ColorToString(color)
    }

    /**
     * Convert color value into string formatted color
     */
    public static function ColorToString(value:Number):String
    {
        var c:String = value.toString(16)
        while(c.length < 6)
        {
            c = "0"+c
        }
        return c.toUpperCase();
    }

    /**
     * convert a string into a color hex value
     */
    public static function StringToColor(value:String):Number
    {
        return parseInt(value, 16)
    }

    private function updateColors(value:Number, updateInput:Boolean)
    {
        var c:Color = new Color(cpicker.face)
        c.setRGB(_color);

        panel.background.color_display.color = value
        if(updateInput){
            panel.background.color_input.color = value
        }
    }

    /** listeners **/

    private function over(mc:MovieClip)
    {
        color = mc.color
        panel.colors.face_borders._x = mc._x
        panel.colors.face_borders._y = mc._y
    }

    private function click(mc:MovieClip)
    {
        color = mc.color
        setIsOpened(false)
        broadcastMessage("change", this)
    }

    private function changed(value:String)
    {
        if(value.charAt(0) == "#")
        {
            value = value.substr(1)
        }
        _color = ColorPicker.StringToColor(value)
        updateColors(_color, false)
    }

    private function open():Void
    {
        setIsOpened(!getIsOpened());
    }

}