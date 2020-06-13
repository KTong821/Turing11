var window : int := Window.Open ("graphics: 800, 400")
setscreen ("offscreenonly")
%%%%%%%%%%%%%%%%%%%        GLOBAL VARIABLES     %%%%%%%%%%%%%%%%%%%%%%%%
% initiates pic and sprite images to be use in animation
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

% variable i is vertical position of dinosaur
% variable c is the horizontal position of obstacles
var i : real := 58
var c : real := 850
%highscore list top 5
var store : array 1 .. 5 of int
%%%%%%%%%%%%%%%%%%%          PREP CODE          %%%%%%%%%%%%%%%%%%%%%%%%%%

% drawing background and setting in position background ornaments
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


%%%%%%%%%%%%%%%%%%        PROCEDURES           %%%%%%%%%%%%%%%%%%%%%%%%

function crash : boolean
    % checks for collision between dinosaur and obstacle
    if c <= 100 and c >= 35 then
	if i <= 70 then
	    result true
	end if
    end if
end crash

function quickdown (timea : int, pos : real) : boolean
    % accelerated downward movement when user presses down arrow key during jump
    loop
	Draw.ThickLine (0, 37, 800, 37, 2, black)
	c -= 1
	Pic.Draw (cactus, round (c), 20, picMerge)
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

	if crash () then
	    result true
	end if
    end loop
    result false
end quickdown

function highjump (timea : int) : boolean
    % procedure for high jump (right shift)
    loop
	Draw.ThickLine (0, 37, 800, 37, 2, black)
	c -= 1
	Pic.Draw (cactus, round (c), 20, picMerge)
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
	    if quickdown (Time.Elapsed, i) then
		result true
	    end if

	end if
	if crash () then
	    result true
	end if
    end loop
    Pic.Draw (dino1, 55, 25, picMerge)
    result false
end highjump

function lowjump (timea : int) : boolean
    % procedure for lowjump (up arrow)
    loop
	Draw.ThickLine (0, 37, 800, 37, 2, black)
	c -= 1
	Pic.Draw (cactus, round (c), 20, picMerge)
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
	    if quickdown (Time.Elapsed, i) then
		result true
	    end if

	end if

	if crash () then
	    result true
	end if
	exit when i < 25
    end loop
    Pic.Draw (dino1, 55, 25, picMerge)
    result false
end lowjump

function duck (timea : int) : boolean
    % procedure for ducking motion
    loop
	if (Time.Elapsed - timea) < 100 then
	    Draw.ThickLine (145, 37, 800, 37, 2, black)
	    Draw.ThickLine (0, 37, 50, 37, 2, black)
	    Pic.Draw (dino4, 55, 25, picMerge)
	    c -= 1
	    Pic.Draw (cactus, round (c), 20, picMerge)
	    View.Update
	    if crash () then
		result true
	    end if
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
	    Pic.Draw (cactus, round (c), 20, picMerge)
	    View.Update
	    if crash () then
		result true
	    end if
	    cls
	    delay (5)
	    if c = -30 then
		c := 850
	    end if
	end if

	exit when (Time.Elapsed - timea) > 200
    end loop
    result false
end duck

function check () : boolean

    var chars : array char of boolean
    Input.KeyDown (chars)
    if chars (KEY_DOWN_ARROW) then
	var timea : int := Time.Elapsed
	if duck (timea) then
	    result true
	end if
	i := 25
    elsif chars (KEY_UP_ARROW) then
	var timea : int := Time.Elapsed
	if lowjump (timea) then
	    result true
	end if
	i := 25
    elsif chars (KEY_SHIFT) then
	var timea : int := Time.Elapsed
	if highjump (timea) then
	    result true
	end if
	i := 25
    end if
    result false
end check

procedure bird
    var timea : int := Time.Elapsed
    loop
	if (Time.Elapsed - timea) < 100 then
	    Draw.ThickLine (0, 37, 800, 37, 2, black)
	    Pic.Draw (bird1, round (c), 80, picMerge)
	elsif (Time.Elapsed - timea) > 100 then
	    Draw.ThickLine (0, 37, 800, 37, 2, black)
	    Pic.Draw (bird2, round (c), 80, picMerge)
	end if
	Draw.ThickLine (0, 37, 800, 37, 2, black)
    end loop
end bird


procedure titlescreen
    cls
    Draw.ThickLine (0, 37, 800, 37, 2, black)
    var title1 : int := Sprite.New (Pic.FileNew ("run1.bmp"))
    var title2 : int := Sprite.New (Pic.FileNew ("run2.bmp"))
    var titlefont := Font.New ("Britannic Bold:45")
    var smallfont := Font.New ("Britannic Bold:20")
    var midfont := Font.New ("Britannic Bold:30")
    Sprite.SetPosition (title1, 40, 68, true)
    Sprite.SetPosition (title2, 40, 68, true)
    Font.Draw ("The", 50, 303, titlefont, darkgrey)
    Font.Draw ("Chow", 50, 250, titlefont, darkgrey)
    Font.Draw ("Dinosaur", 50, 196, titlefont, darkgrey)
    Font.Draw ("Game", 50, 138, titlefont, darkgrey)
    Font.Draw ("Leaderboard: ", 300, 300, smallfont, darkgrey)

    for cnt : 1 .. 5
	Font.Draw (intstr(store (cnt)), 308, (300 - (20 * cnt)), smallfont, darkgrey)
    end for


    Font.Draw ("Press Up Arrow to Start", 240, 69, smallfont, darkgrey)

    Font.Draw ("Score: ", 300, 260, smallfont, darkgrey)

    Font.Draw ("Instructions: ", 540, 330, smallfont, darkgrey)
    Font.Draw ("Up Arrow: Low Jump", 500, 300, smallfont, darkgrey)
    Font.Draw ("Right Shift: High Jump", 500, 260, smallfont, darkgrey)
    Font.Draw ("Down Arrow: Duck", 500, 220, smallfont, darkgrey)
    Font.Draw ("Avoid Obstacles!", 500, 180, smallfont, darkgrey)
    loop
	var timea : int := Time.Elapsed
	var chars : array char of boolean
	var exitcondition : boolean := false
	loop
	    if (Time.Elapsed - timea) < 100 then
		Sprite.Hide (title1)
		Sprite.Show (title2)
		Input.KeyDown (chars)
		if chars (KEY_UP_ARROW) then
		    exitcondition := true
		end if
	    elsif (Time.Elapsed - timea) > 100 then
		Input.KeyDown (chars)
		if chars (KEY_UP_ARROW) then
		    exitcondition := true
		end if
		Sprite.Hide (title2)
		Sprite.Show (title1)
	    end if
	    exit when (Time.Elapsed - timea) > 200
	end loop

	exit when exitcondition
    end loop


    Sprite.Hide (title1)
    Sprite.Hide (title2)


    for px : 1 .. 800 by 10
	Draw.FillBox (0, 60, px, 400, white)
	delay (20)

    end for
    cls

end titlescreen

procedure run
    titlescreen ()
    var timea : int := Time.Elapsed
    loop
	if (Time.Elapsed - timea) < 100 then
	    Draw.ThickLine (100, 37, 800, 37, 2, black)
	    Draw.ThickLine (0, 37, 55, 37, 2, black)
	    c -= 1
	    Pic.Draw (cactus, round (c), 20, picMerge)
	    View.Update
	    cls
	    delay (-5)
	    if c = -30 then
		c := 850
	    end if
	    if check () then
		return
	    end if
	    if crash () then
		return
	    end if
	    Pic.Draw (dino2, 55, 25, picMerge)

	elsif (Time.Elapsed - timea) > 100 then
	    Draw.ThickLine (100, 37, 800, 37, 2, black)
	    Draw.ThickLine (0, 37, 55, 37, 2, black)
	    c -= 1
	    Pic.Draw (cactus, round (c), 20, picMerge)
	    View.Update
	    cls
	    delay (-5)
	    if c = -30 then
		c := 850
	    end if
	end if
	if check () then
	    return
	end if
	if crash () then
	    return
	end if
	Pic.Draw (dino3, 55, 25, picMerge)


	exit when (Time.Elapsed - timea) > 200
    end loop
end run

var starttime : real
var finaltime : real
loop
    var getscore : int
    open : getscore, "highscore.txt", get
    for cnt : 1 .. 5
	get : getscore, store (cnt)
    end for


    titlescreen ()
    starttime := Time.Elapsed
    loop
	run ()
    end loop
    finaltime := Time.Elapsed
    var searchvalue : int := round (finaltime - starttime)



    var putscore : int
    open : putscore, "highscore.txt", put

    for cnt : 1 .. 5
	var temp : int
	if searchvalue > store (cnt) then
	    temp := store (cnt)
	    store (cnt) := searchvalue
	    searchvalue := temp
	end if
    end for

    for cnt : 1 .. 5
	put : putscore, store (cnt)
    end for
end loop

%if finaltime > high then
%    put : putscore, round (Time.Elapsed / 200)
%    Sprite.Show (gameover)
%else
%    put : putscore, high
%    Sprite.Show (gameover)
%end if

/*
 elsif Mouse.ButtonMoved ("down") then
 Mouse.ButtonWait ("down", mousex, mousey, blah, bleh)
 if mousex < 20 and mousey > 380 then
 titlescreen ()
 end if
 */

/*

 for fork:

 */















