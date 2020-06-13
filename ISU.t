var window : int := Window.Open ("graphics: 800, 400")
setscreen ("offscreenonly")
%%%%%%%%%%%%%%%%%%%        GLOBAL VARIABLES     %%%%%%%%%%%%%%%%%%%%%%%%
var moon1 : int := Sprite.New (Pic.FileNew ("moon.bmp"))
var star1 : int := Sprite.New (Pic.FileNew ("star.bmp"))
var star2 : int := Sprite.New (Pic.FileNew ("star.bmp"))
var star3 : int := Sprite.New (Pic.FileNew ("star.bmp"))
var star4 : int := Sprite.New (Pic.FileNew ("star.bmp"))
var star5 : int := Sprite.New (Pic.FileNew ("star.bmp"))
var star6 : int := Sprite.New (Pic.FileNew ("star.bmp"))
var star7 : int := Sprite.New (Pic.FileNew ("star.bmp"))
var restart : int := Sprite.New (Pic.FileNew ("restart.bmp"))
var gameover : int := Sprite.New (Pic.FileNew ("gameover.bmp"))
var cactus := Pic.FileNew ("cactus.bmp")
var dino1 := Pic.FileNew ("new1.bmp")
var dino2 := Pic.FileNew ("run1.bmp")
var dino3 := Pic.FileNew ("run2.bmp")
var dino4 := Pic.FileNew ("duck1.bmp")
var dino5 := Pic.FileNew ("duck3.bmp")
var triple := Pic.FileNew ("triple.bmp")
var double := Pic.FileNew ("double.bmp")
var small := Pic.FileNew ("small.bmp")
var bird1 := Pic.FileNew ("bird1.bmp")
var bird2 := Pic.FileNew ("bird2.bmp")
var mousex, mousey, blah, bleh : int

var i : real := 58
var c : real := 850

%%%%%%%%%%%%%%%%%%%          PREP CODE          %%%%%%%%%%%%%%%%%%%%%%%%%%


Draw.ThickLine (0, 37, 600, 37, 2, black)
Sprite.SetPosition (moon1, 700, 250, true)
Sprite.Show (moon1)
Sprite.SetPosition (star1, 100, 320, true)
Sprite.Show (star1)
Sprite.SetPosition (star2, 230, 210, true)
Sprite.Show (star2)
Sprite.SetPosition (star3, 700, 100, true)
Sprite.Show (star3)
Sprite.SetPosition (star4, 355, 150, true)
Sprite.Show (star4)
Sprite.SetPosition (star5, 441, 260, true)
Sprite.Show (star5)
Sprite.SetPosition (star6, 150, 250, true)
Sprite.Show (star6)
Sprite.SetPosition (star7, 300, 370, true)
Sprite.Show (star7)
Sprite.SetPosition (restart, 20, 284, true)
Sprite.Show (restart)
Sprite.SetPosition (gameover, 300, 200, true)


%%%%%%%%%%%%%%%%%      HIGH SCORE TEXT FILE      %%%%%%%%%%%%%%%%%%%%%%%%

var getscore : int
open : getscore, "highscore.txt", get


var text : string
var putscore : int
open : putscore, "highscore.txt", put


%%%%%%%%%%%%%%%%%%        PROCEDURES           %%%%%%%%%%%%%%%%%%%%%%%%

procedure crash
    if c <= 100 and c >= 35 then
	if i <= 70 then
	    Window.Close (window)
	end if
    end if
end crash

procedure bird (timea : int)
    if (Time.Elapsed - timea) < 100 then
	%Draw.ThickLine (0, 37, 800, 37, 2, black)
	Pic.Draw (bird1, round (c), 80, picMerge)
    elsif (Time.Elapsed - timea) > 100 then
	%Draw.ThickLine (0, 37, 800, 37, 2, black)
	Pic.Draw (bird2, round (c), 80, picMerge)
    end if
end bird
procedure quickdown (timea : int, pos : real)

    loop
	Draw.ThickLine (0, 37, 800, 37, 2, black)
	c -= 1
	bird(timea)
	%Pic.Draw (cactus, round (c), 20, picMerge)
	View.Update
	cls
	delay (-5)
	if c = -30 then
	    c := 850
	end if
	var timeb : int := Time.Elapsed
	var dif : real := (timeb - timea) / 1000
	i := pos + ((320 * dif) + (1 / 2) * (-6000) * dif * dif)
	Pic.Draw (dino1, 55, round (i), picMerge)
	exit when i < 55
	crash ()
    end loop

end quickdown

procedure highjump (timea : int)

    loop
	Draw.ThickLine (0, 37, 800, 37, 2, black)
	c -= 1
	bird(timea)
	%Pic.Draw (cactus, round (c), 20, picMerge)
	View.Update
	cls
	delay (-5)
	if c = -30 then
	    c := 850
	end if
	var timeb : int := Time.Elapsed
	var dif : real := (timeb - timea) / 1000
	i := 25 + ((940 * dif) + (1 / 2) * (-3000) * dif * dif)
	exit when i < 25
	Pic.Draw (dino1, 55, round (i), picMerge)
	var chars : array char of boolean
	Input.KeyDown (chars)
	if chars (KEY_DOWN_ARROW) then
	    quickdown (Time.Elapsed, i)
	    exit
	end if
	crash ()
    end loop
    Pic.Draw (dino1, 55, 25, picMerge)
end highjump

procedure lowjump (timea : int)

    loop
	Draw.ThickLine (0, 37, 800, 37, 2, black)
	c -= 1
	%Pic.Draw (cactus, round (c), 20, picMerge)
	bird(timea)
	View.Update
	cls
	delay (-5)
	if c = -30 then
	    c := 850
	end if
	var timeb : int := Time.Elapsed
	var dif : real := (timeb - timea) / 1000
	i := 25 + ((780 * dif) + (1 / 2) * (-3000) * dif * dif)
	Pic.Draw (dino1, 55, round (i), picMerge)
	var chars : array char of boolean
	Input.KeyDown (chars)
	if chars (KEY_DOWN_ARROW) then
	    quickdown (Time.Elapsed, i)
	    exit
	end if
	crash ()
	exit when i < 25
    end loop
    Pic.Draw (dino1, 55, 25, picMerge)
end lowjump

procedure duck (timea : int)
    loop
	if (Time.Elapsed - timea) < 100 then
	    Draw.ThickLine (145, 37, 800, 37, 2, black)
	    Draw.ThickLine (0, 37, 50, 37, 2, black)
	    Pic.Draw (dino4, 55, 25, picMerge)
	    c -= 1
	    bird(timea)
	    %Pic.Draw (cactus, round (c), 20, picMerge)
	    View.Update
	    crash ()
	    cls
	    delay (-5)
	    if c = -30 then
		c := 850
	    end if
	elsif (Time.Elapsed - timea) > 100 then
	    Pic.Draw (dino5, 55, 25, picMerge)
	    Draw.ThickLine (145, 37, 800, 37, 2, black)
	    Draw.ThickLine (0, 37, 50, 37, 2, black)
	    c -= 1
	    bird(timea)
	    %Pic.Draw (cactus, round (c), 20, picMerge)
	    View.Update
	    crash ()
	    cls
	    delay (5)
	    if c = -30 then
		c := 850
	    end if
	end if

	exit when (Time.Elapsed - timea) > 200
    end loop
end duck

procedure backToGame

    Sprite.Show (moon1)
    Sprite.Show (star1)
    Sprite.Show (star2)
    Sprite.Show (star3)
    Sprite.Show (star4)
    Sprite.Show (star5)
    Sprite.Show (star6)
    Sprite.Show (star7)
    Sprite.Show (restart)
    Draw.ThickLine (0, 37, 600, 37, 2, black)

end backToGame

procedure mainmenu

    backToGame ()

end mainmenu

procedure backToMain
    Sprite.Hide (moon1)
    Sprite.Hide (star1)
    Sprite.Hide (star2)
    Sprite.Hide (star3)
    Sprite.Hide (star4)
    Sprite.Hide (star5)
    Sprite.Hide (star6)
    Sprite.Hide (star7)
    Sprite.Hide (restart)
    delay (500)
    mainmenu ()

end backToMain

procedure check

    var chars : array char of boolean
    Input.KeyDown (chars)
    if chars (KEY_DOWN_ARROW) then
	var timea : int := Time.Elapsed
	duck (timea)
	i := 25
    elsif chars (KEY_UP_ARROW) then
	var timea : int := Time.Elapsed
	lowjump (timea)
	i := 25
    elsif chars (KEY_SHIFT) then
	var timea : int := Time.Elapsed
	highjump (timea)
	i := 25
    elsif Mouse.ButtonMoved ("down") then
	Mouse.ButtonWait ("down", mousex, mousey, blah, bleh)
	if mousex < 20 and mousey > 380 then
	    backToMain ()
	end if
    end if
end check



procedure run
    var timea : int := Time.Elapsed
    loop
	if (Time.Elapsed - timea) < 100 then
	    Draw.ThickLine (100, 37, 800, 37, 2, black)
	    Draw.ThickLine (0, 37, 55, 37, 2, black)
	    c -= 1
	    bird (timea)
	    View.Update
	    cls
	    delay (-5)
	    if c = -30 then
		c := 850
	    end if
	    check ()
	    crash ()
	    Pic.Draw (dino2, 55, 25, picMerge)

	elsif (Time.Elapsed - timea) > 100 then
	    Draw.ThickLine (100, 37, 800, 37, 2, black)
	    Draw.ThickLine (0, 37, 55, 37, 2, black)
	    c -= 1
	    bird (timea)
	    %Pic.Draw (cactus, round (c), 20, picMerge)
	    View.Update
	    cls
	    delay (-5)
	    if c = -30 then
		c := 850
	    end if
	    check ()
	    crash ()
	    Pic.Draw (dino3, 55, 25, picMerge)

	end if
	exit when (Time.Elapsed - timea) > 200
    end loop
end run

var gamestatus : int := 0 %irrelevant for now. if collision, gamestatus := 1



loop
    var chars : array char of boolean
    loop
	run ()
    end loop

    Input.KeyDown (chars)
    if chars ('q') then
	exit
    elsif gamestatus > 0 then
	exit
    end if
end loop
var finaltime : int := round (Time.Elapsed / 200)
%if finaltime > high then
%    put : putscore, round (Time.Elapsed / 200)
%    Sprite.Show (gameover)
%else
%    put : putscore, high
%    Sprite.Show (gameover)
%end if


/*

 for fork:

 */













