package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;
import box2D.collision.shapes.B2Shape;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_80_80_03JumpSaver extends SceneScript
{
	public var _DateHolder:String;
	public var _Button:Actor;
	public var _Item:Array<Dynamic>;
	public var _SmallCounter:Float;
	public var _counter:Float;
	public var _False:Actor;
	public var _PercentRight:Float;
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("DateHolder", "_DateHolder");
		_DateHolder = "";
		nameMap.set("Button", "_Button");
		nameMap.set("Item", "_Item");
		nameMap.set("SmallCounter", "_SmallCounter");
		_SmallCounter = 0.0;
		nameMap.set("counter", "_counter");
		_counter = 0.0;
		nameMap.set("False", "_False");
		nameMap.set("PercentRight", "_PercentRight");
		_PercentRight = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_PercentRight = asNumber(0);
		propertyChanged("_PercentRight", _PercentRight);
		Engine.engine.setGameAttribute("Level03FalseLeewayGA", 0);
		Engine.engine.setGameAttribute("Level03FalseLeewayBool", false);
		Engine.engine.setGameAttribute("Level03Canceler", false);
		Engine.engine.setGameAttribute("Level03Falser", true);
		_counter = asNumber(0);
		propertyChanged("_counter", _counter);
		_Item = new Array<Dynamic>();
		propertyChanged("_Item", _Item);
		Engine.engine.setGameAttribute("LevelTrial", 0);
		_DateHolder = Date.now().toString();
		propertyChanged("_DateHolder", _DateHolder);
		for(actorOfType in getActorsOfType(getActorType(46)))
		{
			if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
				_Button = actorOfType;
				propertyChanged("_Button", _Button);
			}
		}
		runLater(1000 * 2, function(timeTask:TimedTask):Void
		{
			Engine.engine.setGameAttribute("Level03Falser", true);
		}, null);
		
		/* =========================== On Actor =========================== */
		addMouseOverActorListener(_Button, function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && 3 == mouseState)
			{
				trace("" + "TRUE-01");
				/* This will only work if the button hasn't been pushed yet... */
				if((Engine.engine.getGameAttribute("Level03Pushed") == false))
				{
					trace("" + "TRUE-02");
					Engine.engine.setGameAttribute("Level03StopGap", true);
					Engine.engine.setGameAttribute("Level03Falser", false);
					getActor(12).growTo(Engine.engine.getGameAttribute("ButtonSizeL03")/100, Engine.engine.getGameAttribute("ButtonSizeL03")/100, .1, Linear.easeNone);
					_PercentRight = asNumber((_PercentRight + 1));
					propertyChanged("_PercentRight", _PercentRight);
					_counter = asNumber((_counter + 1));
					propertyChanged("_counter", _counter);
					Engine.engine.setGameAttribute("LevelTrial", (Engine.engine.getGameAttribute("LevelTrial") + 1));
					_Item[Std.int(0)] = (("" + (("" + (("" + (("" + (("" + Engine.engine.getGameAttribute("day")) + ("" + ", "))) + ("" + (("" + Engine.engine.getGameAttribute("Month")) + ("" + " "))))) + ("" + Date.now().getDate()))) + ("" + ", "))) + ("" + Date.now().getFullYear()));
					_Item[Std.int(1)] = Engine.engine.getGameAttribute("L03TotalNum");
					_Item[Std.int(2)] = (("" + (("" + Date.now().getHours()) + ("" + ":"))) + ("" + (("" + (("" + Date.now().getMinutes()) + ("" + ":"))) + ("" + Date.now().getSeconds()))));
					_Item[Std.int(3)] = (("" + _PercentRight) + ("" + "0%25Correct"));
					_Item[Std.int((Engine.engine.getGameAttribute("LevelTrial") + 3))] = "T";
					Engine.engine.getGameAttribute("L03Date01")[Std.int(Engine.engine.getGameAttribute("L03TotalNum"))] = _Item;
					trace("" + Engine.engine.getGameAttribute("L03Date01"));
					if((_counter == 10))
					{
						saveGame("mySave", function(success:Bool):Void
						{
							switchScene(GameModel.get().scenes.get(46).getID(), null, createCrossfadeTransition(.5));
						});
					}
					saveGame("mySave", function(success:Bool):Void
					{
						Engine.engine.setGameAttribute("Level03CounterFalsie", 0);
						Engine.engine.setGameAttribute("Level03CountFalsie", true);
					});
				}
			}
		});
		
		/* =========================== On Actor =========================== */
		addMouseOverActorListener(_False, function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && 3 == mouseState)
			{
				trace("" + "False-01");
				if((Engine.engine.getGameAttribute("Level03Pushed") == false))
				{
					trace("" + "False-02");
					if((Engine.engine.getGameAttribute("Level03Falser") == true))
					{
						trace("" + "False-03");
						if((_Button.isMouseOver() == false))
						{
							trace("" + "False-04");
							Engine.engine.setGameAttribute("Level03Falser", false);
							_counter = asNumber((_counter + 1));
							propertyChanged("_counter", _counter);
							Engine.engine.setGameAttribute("LevelTrial", (Engine.engine.getGameAttribute("LevelTrial") + 1));
							_Item[Std.int(0)] = (("" + (("" + (("" + (("" + (("" + Engine.engine.getGameAttribute("day")) + ("" + ", "))) + ("" + (("" + Engine.engine.getGameAttribute("Month")) + ("" + " "))))) + ("" + Date.now().getDate()))) + ("" + ", "))) + ("" + Date.now().getFullYear()));
							_Item[Std.int(1)] = Engine.engine.getGameAttribute("L03TotalNum");
							_Item[Std.int(2)] = (("" + (("" + Date.now().getHours()) + ("" + ":"))) + ("" + (("" + (("" + Date.now().getMinutes()) + ("" + ":"))) + ("" + Date.now().getSeconds()))));
							_Item[Std.int(3)] = (("" + _PercentRight) + ("" + "0%25Correct"));
							_Item[Std.int((Engine.engine.getGameAttribute("LevelTrial") + 3))] = "F";
							Engine.engine.getGameAttribute("L03Date01")[Std.int(Engine.engine.getGameAttribute("L03TotalNum"))] = _Item;
							trace("" + Engine.engine.getGameAttribute("L03Date01"));
							if((_counter == 10))
							{
								switchScene(GameModel.get().scenes.get(46).getID(), createFadeOut(1), createFadeIn(.5));
							}
							saveGame("mySave", function(success:Bool):Void
							{
								
							});
							Engine.engine.setGameAttribute("Level03CounterFalsie", 0);
							Engine.engine.setGameAttribute("Level03CountFalsie", true);
						}
					}
				}
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				g.setFont(getFont(102));
				g.drawString("" + (("" + _PercentRight) + ("" + "0%")), 0, 180);
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}