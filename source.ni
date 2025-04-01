"You May Not Escape!" by Charm Cochran

Volume 1 - The Guts

Book 1 - Options

Part 1 - Use options & bibliographic data

The story headline is "An interactive parable".
The story genre is "Fiction".
The release number is 3.
The story description is "You are one of the unlucky many to enter the maze. Will you be one of the lucky few to escape?"
The story creation year is 2022.

Use American dialect and the serial comma.
Use sequential action.

Use MAX_STATIC_DATA of 360000.

Release along with an interpreter, cover art, the source text, and an introductory postcard.

Part 2 - Extensions

Chapter 1 - In the game

Include Extended Grammar by Aaron Reed. Include Numbered Disambiguation Choices by Aaron Reed.
Include Disappearing Doors by Andrew Plotkin.
Include Assorted Text Generation by Emily Short. Include Basic Help Menu by Emily Short. Include Basic Screen Effects by Emily Short. Include Complex Listing by Emily Short. Include Glulx Text Effects by Emily Short. Include Modified Exit by Emily Short. Include Punctuation Removal by Emily Short.
Include Alternatives by Eric Eve. Include Epistemology by Eric Eve. Include Exit Lister by Eric Eve. 
Include Far Away by Jon Ingold.
Include Reactable Quips by Michael Martin.

Chapter 2 - Not in the game (not for release)

Include Response Assistant by Aaron Reed. Include Object Response Tests by Juhana Leinonen.

Part 3 - Testing (not for release)

After reading a command (this is the ignore beta-comments rule): 
	if the player's command matches the regular expression "^\p": 
		say "(Noted.)"; 
		reject the player's command.

First when play begins: say "Thanks for testing this game! Before doing anything else, please type TRANSCRIPT ON and hit enter. Also, if you begin a command with and exaclamation point, you can have it appear in the transcript without actually doing anything in game[unicode 8212]essentially leaving a comment. Thanks!"

Book 2 - Variables & printing

Part 1 - Map building

The map-seed is a number that varies.
	
When play begins (this is the maze initialization rule):
	now the map-seed is a random number between 1 and 16;
	follow the barrier-construction rule.
	
A door is usually privately-named scenery. A door is usually open and not openable.
A door has a list of numbers called the absent-seeds.
	
This is the barrier-construction rule:
	now every door is present;
	repeat with portal running through doors:
		if the map-seed is listed in the absent-seeds of portal:
			now portal is absent;

Part 2 - Where you are and where to go

Chapter 1 - Looking and going

Last carry out looking:
	list the exits;
	continue the action.

The previous location is a room that varies.

First carry out going rule:
	Now the previous location is the location.
	
Understand the command "leave" as something new.
	
Understand "leave" as a mistake ("If only.").

Chapter 2 - Modified exit listing rules

To say exit list:
	let exits count be 0;
	let farplace be location;   
	say "Possible directions: ";
	repeat with way running through directions
	begin;
		let farplace be the room way from the location;
		now direction-object is the room-or-door way from the location;
		if direction-object is apparent and farplace is not darkness-occluded and way is not up
		begin;      
			increase the exits count by 1;      
			if farplace is unvisited and indicate-unvisited is show-unvisited,  say "[unvisited-mark][u-v way][end-unvisited-mark]";
			otherwise say "[way]";          
			say " ";
		end if;
	end repeat;
	if exits count is 0,
	say "[italic type][no-exits][roman type]".
	
[NOTE: This replaces a rule in Chapter 4 of Exit Lister by Eric Eve, just tweaking some word choice in the final list.]

To list the exits:
	let exits count be 0;
	let farplace be location;    
	repeat with way running through directions
	begin;
		let farplace be the room way from the location;
		now direction-object is the room-or-door way from the location;
		if the direction-object is apparent and farplace is not darkness-occluded and way is not up, increase exits count by 1;
	end repeat;
	if exits count is 0
	begin;
		say "[no-obvious-exits]";
		rule fails;
	end if;
	let i be exits count;
	if exits count is 1, say "[only-obvious-exit] ";
	otherwise say "[obvious-exits] ";
	repeat with way running through directions
	begin;
		let farplace be the room way from the location;   
		now direction-object is the room-or-door way from the location;
		if direction-object is apparent and farplace is not darkness-occluded and way is not up
		begin;
			if farplace is the previous location, say "back ";
			say "[way]";     
			decrease i by 1;
			if i is 0, say ".";
			if i is 1, say " [and-conjunction] ";
			if i > 1, say ", ";       
		end if;   
	end repeat.
	
[NOTE: This replaces a rule in Chapter 6 Section 2 of Exit Lister, making two minor tweaks:
- removing the room name parenthetical when a destination is visited, which conflicts with the dynamic room naming used in this game
- adding a "back" before the direction the player just came from]

To say only-obvious-exit: say "The only obvious way to go is".
To say obvious-exits: say "From here, you can go".
To say no-exits: say "None apparent".

[NOTE: These replace some text substitutions in Exit Lister, to customize them for this story.]

Chapter 3 - Room identity

Section 1 - Header

The printed name of a room is usually "[room-identity]".

To say room-identity:
	let X be a list of objects;
	repeat with that way running through directions:
		if the room that way from the location is not nothing and that way is not up:
			add that way to X;
	let N be the number of entries in X;
	if N is 1:
		say "A dead end";
	otherwise if N is 2:
		let A be entry 1 in X;
		let B be entry 2 in X;
		if A is the opposite of B:
			say "A hallway";
		otherwise:
			say "A corner";
	otherwise if N is 3:
		say "A fork";
	otherwise if N is 4:
		say "A crossroads".
		
Section 2 - Description
		
The description of a room is usually "[one of][high-walls][or][high-walls][or][high-walls][or][same-ness][or][all-quiet][or][this-continues][or]A bird flies overhead[or]The clouds move almost preternaturally quickly overhead[or][ground-obs][or]One foot in front of the other[or][been-here][or]You trail your fingers along one wall, painfully aware of the dangers of [getting-turned-around][or][beginning-to-wonder][or][hum-tune][or][wonder-how-long][in random order][walls-damaged]."

To say high-walls:
	let X be a list of objects;
	repeat with that way running through directions:
		if the room that way from the location is not nothing:
			add that way to X;
	let N be the number of entries in X;
	if N is 1:
		say "Oppressively high walls surround you on three sides, looming over you with their sheer bulk and leaving little space to breathe";
	otherwise if N is 2:
		let A be entry 1 in X;
		let B be entry 2 in X;
		if A is the opposite of B:
			say "Oppressively high walls loom over you to the left and right, making the path feel even narrower than it actually is";
		otherwise:
			say "An oppressively high wall stands before you; another is off to one side. They loom tall, leaving you little choice where to go";
	otherwise if N is 3:
		say "One of the high walls drops away, leaving you with a choice of which direction to go. [choice-feeling]";
	otherwise if N is 4:
		say "You could go any direction here[unicode 8212]the walls have dropped away, leaving you with a choice entirely your own. [choice-feeling]".
		
To say choice-feeling: say "For a moment, you feel [one of]curiously unmoored[or]slightly dizzy[or]a heady elation[or]a sense of unhappy indecision[at random]"

Definition: something is other if it is not the player.
Definition: a room is occupied if something other is in it.

To say same-ness:
	say "[if the location is occupied][high-walls][otherwise if turn count < 10]This part of the maze looks essentially the same as the rest you've seen so far: high walls and [darkmud][otherwise]Overall, this part of the maze looks exactly like most of it does: high walls and [darkmud], as far as you can see[end if]".
	
To say darkmud: say "[if It Drizzles is happening]dark mud[otherwise]barren ground[end if]".

To say all-quiet:
	if the location is jukebox-adjacent and the jukebox is switched on, say "[same-ness]";
	otherwise say "It's quiet in the maze[unicode 8212]quieter than you've ever heard before. [if It Drizzles is happening]All you can hear is the sound of the rain[otherwise]The high walls block all sound".
	
To say this-continues:
	if turn count < 10, say "[high-walls]";
	otherwise say "[if a random chance of 2 in 5 succeeds]This continues[otherwise][high-walls][end if]".
	
To say ground-obs:
	if the mud is in the location, say "The ground has grown soft and treacherous";
	otherwise say "The ground is hard and warm under your feet".
	
To say been-here:
	if the location is beyarned:
		say "The yarn on the ground tells you that you've been here before";
	otherwise if turn count > 10:
		say "You think you may have been here before, but you can't be sure";
	otherwise:
		say "[same-ness]".

To say getting-turned-around: say "[one of]getting turned around[or]becoming lost[or]losing your way[or]losing track of where you are[or]forgetting where you've been[as decreasingly likely outcomes]".

To say beginning-to-wonder:
	unless the location is either Room4-7 or Room5-7 or Room6-7 or Room7-7 or Room8-7:
		if turn count > 10:
			if The Gate Out is familiar:
				say "You wonder to yourself what the point is in building a maze and then locking the exit";
			otherwise:
				say "[one of]You're beginning to wonder if this maze even has an exit[or]You wonder again if this maze even has an exit[stopping]";
		otherwise:
			if The Gate Out is familiar:
				say "You wonder to yourself what the point is in building a maze and then locking the exit";
			otherwise:
				say "You wonder how you can be expected to find the exit when everything looks so much the same";
	otherwise:
		say "[high-walls]".
		
To say hum-tune:
	if the location is jukebox-adjacent and the jukebox is switched on:
		say "You hum along to a few bars of the song on the jukebox";
	otherwise:
		say "You hum a little tune to keep yourself occupied".
		
To say wonder-how-long:
	if turn count > 30 and the location is neither Room4-7 nor Room5-7 nor Room6-7 nor Room7-7 nor Room8-7 and the number of familiar gates out is 0:
		say "You wonder how long you've been in the maze. You wonder how much longer it will be before you're out";
	otherwise:
		say "[one of][high-walls][or][same-ness][or][all-quiet][or][been-here][or][ground-obs][or][this-continues][as decreasingly likely outcomes]".
		
Understand "bird" or "flying" or "fly" or "flown" or "overhead" as "[bird]".

After reading a command:
	if the player's command includes "[bird]":
		say "The bird has already flown on.";
		rule succeeds;
	otherwise:
		make no decision.
		
To say walls-damaged:
	if the wall-damage of the location < 3:
		do nothing;
	otherwise:
		say ".
		
		Here, you smashed some of the concrete in the walls until it gave way, revealing the metal rebar underneath[run paragraph on]".
		
Chapter 4 - Far Off

When play begins (this is the new far mess rule):
	now the far-off message is "[The far-off item] [are] far out of your reach."
	
[After deciding the scope of the player (this is the continuous space rule):
	let nearby-places be a list of rooms;
	let farplace be the location;
	repeat with way running through directions:
		let farplace be the room way from the location;
		now direction-object is the room-or-door way from the location;
		if the direction-object is apparent and farplace is not darkness-occluded, add farplace to nearby-places;
	repeat with otherside running through nearby-places:
		place the contents of otherside in scope;
		repeat with obj running through things in otherside:
			now obj is distant;
	repeat with obj2 running through things in the location:
		unless obj2 is an LED ticker sign or obj2 is a security camera:
			now obj2 is near;
		otherwise:
			now obj2 is distant.]
			
After deciding the scope of the player (this is the continuous space rule):
	let nearby-things be a list of things;
	let farplace be the location;
	repeat with way running through directions:
		let farplace be the room way from the location;
		now direction-object is the room-or-door way from the location;
		if the direction-object is apparent and farplace is not darkness-occluded:
			repeat with item running through things in farplace:
				add item to nearby-things;
	repeat with obj running through nearby-things:
		if obj is an LED ticker sign:
			remove obj from nearby-things;
	repeat with thng running through nearby-things:
		place thng in scope;
		now thng is distant;
	repeat with obj2 running through things in the location:
		unless obj2 is an LED ticker sign or obj2 is a security camera:
			now obj2 is near;
		otherwise:
			now obj2 is distant.

Part 3 - Parsing

After reading a command:
	remove stray punctuation.
	
After reading a command:
	resolve punctuated titles.
	
Understand "arm/arms" or "leg/legs" or "hair" or "face" or "me" or "groin/crotch" or "torso" or "hand/hands" or "foot/feet" or "finger/fingers" or "toe/toes" or "eye/eyes" or "ear/ears" or "nose" or "mouth" or "chest" or "stomach" as yourself.
		
Book 3 - Things and kinds

Part 1 - Kinds of things

Chapter 1 - LED ticker signs

An LED ticker sign is a kind of thing. An LED ticker sign is usually fixed in place and distant. The printed name of an LED ticker sign is usually "LED ticker sign".
Understand "LED/light/lights" or "bright/brightly/brightly-colored/colored/color" or "ticker" or "sign/box" or "scroll/scrolling/move/moved/moving/slide/slid/sliding" or "text/writing/message/word/words" or "rectangle/rectangular" or "black" or "affixed/fixed" as "[signs]". Understand "[signs]" as an LED ticker sign. 
The description of an LED ticker sign is usually "It's a rectangular black box affixed high on the wall. [unless busted]Brightly-colored words scroll across the lights on its front. They're going fast enough that you'll have to focus on them specifically, but you can READ them if you so choose[otherwise]The glass on the front is cracked and many of the lights no longer work. Some of them still blink on and off in an effort to convey a message, but you couldn't make it out if you tried[end unless]."
The initial appearance of an LED ticker sign is usually "High up on the wall, an LED ticker sign scrolls through a message."
The maximum saturation of an LED ticker sign is usually 3.

A distant stuff rule for an LED ticker sign while reading: rule succeeds.

An LED ticker sign has some text called a message.

An LED ticker sign can be busted. An LED ticker sign is usually not busted.

A distant stuff rule for an LED ticker sign when attacking or burning or cutting: say "The sign is far out of your reach. If only you had something to throw."; rule fails.

A distant stuff rule for an LED ticker sign when attacking with: say "The sign is far out of your reach. If only you had something to throw."; rule fails.

Instead of consulting an LED ticker sign about: try examining the noun.
	
Instead of listening to an LED ticker sign:
	unless It Drizzles is happening, say "You hear a faint electrical buzzing.";
	otherwise say "You know the signs make a very faint noise, but you can't hear it over the rain."
	
A distant stuff rule for an LED ticker sign when switching off: say "The sign is far too high to reach, and you can't see a visible switch, anyway. If only you had something to throw."; rule fails.
	
A distant stuff rule for an LED ticker sign when taking: say "The sign is far out of your reach, and probably firmly affixed to the wall."; rule fails.
	
[Chapter 2 - Skeletons

A skeleton is a kind of thing. A skeleton is usually fixed in place. The printed name of a skeleton is usually "a skeleton".
Understand "skeleton" or "bones/bone/remains/corpse" or "skull/cranium/tooth/teeth/jaw" or "rib/ribs/breastbone" or "pelvis" or "phalange/phalanges/metacarpal/metacarpals" or "spine/vertebra/vertebrae/vertebrate" or "tibia/fibula/fibia/tibula" or "radius/ulna" or "scapula/collar/collarbone/collarbones" or "humerus" or "femur" or "talus/metatarsal/metatarsals" or "patella/kneecap" or "cartilege" or "ankle/ankles/wrist/wrists" or "elbow/elbows/knee/knees" or "face" or "hip/hips" or "breast/chest" or "shoulder/blade/blades/shoulderblade/shoulderblades" or "arm/arms/upper/fore/forearm/forearms" or "thigh/calf/thighs/calves" as "[corpse]". Understand "[corpse]" as a skeleton.
The initial appearance of a skeleton is usually "A skeleton [one of]lies[or]languishes[or]rests[or]sprawls[or]sits[or]is here[cycling] on the ground."
The maximum saturation of a skeleton is usually 3.

Instead of attacking or burning or cutting a skeleton: say "That feels a little too close to desecration for comfort. The skeleton never did anything to you."

Instead of consulting a skeleton about: try examining the noun.
	
Instead of looking under a skeleton: say "The skeleton is a bit too heavy to lift. You can see there's nothing but [dirt-mud] underneath, anyway."
	
Instead of smelling a skeleton: say "That feels weirdly perverse to you. Too intimate. You decide against it."
	
Instead of giving something to a skeleton: say "That feels a little too close to desecration for comfort."
	
Instead of inserting something into a skeleton: say "That feels a little too close to desecration for comfort."
	
Instead of putting something on a skeleton: say "That feels a little too close to desecration for comfort."

Instead of removing something from a skeleton: say "That feels a little too close to desecration for comfort."

Instead of listening to a skeleton: say "Their vocal cords have long since rotted away."

Instead of taking a skeleton: say "That would be a little macabre, don't you think? Besides, the skeleton is too heavy to be lugging around."
	
Instead of touching or rubbing a skeleton: say "The bone feels unexpectedly rough."]

Chapter 3 - Benches

A park bench is a kind of enterable supporter. A park bench is usually fixed in place. A park bench usually has carrying capacity 4. The printed name of a park bench is usually "park bench". The indefinite article of a park bench is usually "a".
Understand "seat/stool/chair" or "park/garden/public" or "bench" or "wood/wooden" or "metal/metallic/iron/cast" or "legs/arms/leg/arm/seat/back" or "dark/green" or "curved/curve" as "[bench]". Understand "[bench]" as a park bench. 
The description of a park bench is usually "The bench sits with its back to one wall, metal legs and arms painted a dark green and supporting a curved wooden seat and back[if the number of things on the noun > 0]. On it sits [a list of things on the noun][end if]."
The initial appearance of a park bench is usually "A park bench sits off to the side of the path."
The maximum saturation of a park bench is usually 3.

Instead of attacking or burning or cutting a park bench: say "You doubt that would accomplish much. Besides, how unfair is it that it has no way to fight back?"

Instead of attacking a park bench with: say "You don't really want to destroy the bench. What if someone else needs it? What if [italic type]you[roman type] do?"

Instead of drinking or eating or tasting a park bench: say "Gross. Better to refrain."

Instead of listening to a park bench: say "You're sure it knows countless secrets, but it remains stubbornly mum."
	
Instead of looking under a park bench: say "You discover nothing of use underneath."
	
Instead of smelling a park bench: say "You don't detect any unexpected odor."
	
Instead of climbing a park bench: try entering the noun.
	
Instead of giving something to a park bench: try putting the noun on the second noun.
	
Instead of inserting something into a park bench: try putting the noun on the second noun.
	
Instead of removing something from a park bench: try taking the noun.

Instead of taking a park bench: say "The bench would be far too heavy to carry around, and it seems to be bolted to the ground regardless."
	
Instead of touching or rubbing a park bench: say "The metal is cool under your fingers."

Instead of pulling or pushing or turning a park bench: say "The bench is thoroughly attached to the ground. It won't budge."

Instead of pushing a park bench to: say "The bench is bolted to the ground. It won't budge."

Some bolts are a kind of thing. Some bolts are part of every park bench. Understand "attachment/attachments" or "screw/screws" or "bolt" as bolts.
The description of bolts is usually "They're screwed in tight."

Instead of attacking or burning or cutting bolts: say "That's not likely to accomplish much."

Instead of attacking bolts with: say "That's not likely to accomplish much."

Instead of drinking or eating or tasting bolts: say "Gross. Better to refrain."

Instead of listening to bolts: say "You're sure the bench knows countless secrets, but it remains stubbornly mum."

Instead of smelling bolts: say "You don't detect any unexpected odor."

Instead of taking or turning bolts: say "The bolts are screwed in tight. They won't budge."

Instead of touching or rubbing bolts: say "The metal is cool under your fingers."

Instead of pulling or pushing or turning bolts: say "The bolts are thoroughly attached to the ground. They won't budge."
	
Chapter 4 - Security cameras

A security camera is a kind of thing. The printed name of a security camera is usually "security camera".
A security camera is usually distant and fixed in place. Understand "cam/camera" or "sec/security" or "monitor" or "cctv" or "recorder" or "scanner" or "system" as "[cam]". Understand "[cam]" or "camera" as a security camera. 
A security camera can be busted. A security camera is usually not busted.
A security camera can be obscured or clear. A security camera is usually clear.
The description of a security camera is usually "[if busted][busted-camera][otherwise if obscured]Its rectangular metal body is supported by an arm connected high up to the wall. Its lens is obscured by the mud you threw, leaving it unable to survey the hallway, or you[otherwise]Its rectangular metal body is supported by an arm connected high up to the wall. Its circular lens surveys the hallway, and you[end if]."
The maximum saturation of a security camera is usually 3.

A distant stuff rule for a security camera when attacking or burning or cutting or switching off:
	unless the player carries a river rock:
		say "The camera is far too high to reach. If only you had something to throw.";
	otherwise:
		let N be the number of river rocks carried by the player;
		say "You can't reach it directly, but you are carrying [N in words] river rock[if N > 1]s[end if], any one of which might make a good projectile.";
	rule fails.
	
A distant stuff rule for a security camera when attacking with:
	unless the second noun is a river rock and the player carries a river rock:
		say "The camera is far too high to reach. If only you had something to throw.";
		rule fails;
	otherwise:
		try throwing a random carried river rock at the noun instead.

Instead of consulting a security camera about: try examining the noun.
	
Before showing something to a security camera: say "You hold [the noun] up for the camera to see. You let it take a good long look." instead.

A distant stuff rule for a security camera when switching off: 
	unless the player carries a river rock:
		say "The camera is far too high to reach, and you can't see a visible switch, anyway. If only you had something to throw.";
	otherwise:
		let N be the number of river rocks carried by the player;
		say "You can't reach it directly, but you are carrying [N] river rock[if N > 1]s[end if], any one of which might make a good projectile.";
	rule fails.
			
Definition: a thing is insecure if it is not a security camera.
	
Chapter 5 - Graves & tombstones

Section 1 - Graves

A thing can be diggable. A thing is usually not diggable.

A grave is a kind of supporter. Understand "grave" or "plot" or "burial/buried" or "soft" or "earth" as "[grave]". Understand "[grave]" as a grave. The printed name of a grave is usually "grave". A grave is usually fixed in place. A grave is usually diggable. A grave usually has carrying capacity 1.
The description of a grave is usually "The earth is freshly churned[unicode 8212]no grass has yet had the chance to grow back over it."
The maximum saturation of a grave is usually 15.

Instead of attacking or burning or cutting a grave: say "You think that might be just a bit disrespectful."

Instead of attacking a grave with: say "You think that might be just a bit disrespectful."

Instead of consulting a grave about: try examining the noun.

Instead of digging in a grave (called the spot):
	if the relic of the spot is on the spot:
		say "The occupant's soul has been laid to rest. Why would you disturb it now?";
	otherwise:
		say "You think that might be just a bit disrespectful."
		
Instead of drinking or eating or tasting a grave: say "Gross. Better to refrain."
	
Instead of looking under a grave: say "You're not particularly interested in digging up a corpse today."
	
Instead of smelling a grave: say "It smells of earth."
	
Instead of giving something to a grave: try putting the noun on the second noun.
	
Instead of showing something to a grave: try putting the noun on the second noun.

Instead of inserting something into a grave: try putting the noun on the second noun.
	
Instead of removing something from a grave: try taking the noun.

Instead of listening to a grave: say "It is cold and still and silent."

Instead of throwing something at a grave: say "You think that might be just a bit disrespectful."
	
Instead of touching or rubbing a grave: say "The earth is damp and soft."

Instead of reading a grave:
	if the noun is marked by a tombstone (called the marker):
		try reading the marker.

Check taking something (this is the don't undo the resting rule):
	if the noun is an artifact:
		if the noun is on a grave (called the spot) and the noun is the relic of the spot:
			say "You get the sense that [the noun] [are] right where [they're] supposed to be." instead.
			
Check putting something on a grave (called the spot) (this is the next to godliness rule):
	if the noun is dirtied:
		if the noun is an artifact:
			if the noun is the relic of the second noun:
				say "This seems like the proper place for [the noun], but it doesn't feel quite right to lay [the noun] there while it's so dirty." instead;
			otherwise:
				say "You're not quite sure this is the proper place to put [the noun]. Regardless, it doesn't feel quite right to lay [the noun] there while it's so dirty." instead;
		otherwise:
			say "You're not quite sure that [the noun] is the proper thing to put here. Regardless, it doesn't feel quite right to lay [the noun] there while it's so dirty." instead.

Section 2 - Tombstones

A tombstone is a kind of thing. Understand "tomb/tombstone" or "marker" or "gravestone" or "stone" or "epitaph" as "[tomb]". Understand "[tomb]" as a tombstone. The printed name of a tombstone is usually "tombstone". A tombstone is usually fixed in place.
A tombstone has some text called the message.
The description of a tombstone is usually "The stone is old and weathered, with a rounded top and a solemn slate finish. There's an epitaph on the front."
Does the player mean reading a tombstone: it is likely.

Instead of attacking or burning or cutting stone1: say "You think that might be just a bit disrespectful."
Instead of attacking or burning or cutting stone2: say "You think that might be just a bit disrespectful."
Instead of attacking or burning or cutting stone4: say "You think that might be just a bit disrespectful."

Instead of attacking a stone1 with: say "You have no doubt that the sledgehammer could obliterate the tombstone, but you think doing so might be just a bit disrespectful."
Instead of attacking a stone2 with: say "You have no doubt that the sledgehammer could obliterate the tombstone, but you think doing so might be just a bit disrespectful."
Instead of attacking a stone4 with: say "You have no doubt that the sledgehammer could obliterate the tombstone, but you think doing so might be just a bit disrespectful."

Instead of consulting a tombstone about: try reading the noun.
	
Instead of looking under a tombstone: say "It's far too heavy to lift."
	
Instead of smelling a tombstone: say "It smells of cold earth."
	
Instead of climbing a tombstone: say "You think that might be just a bit disrespectful."

Instead of drinking or eating or tasting a tombstone: say "Gross. Better to refrain."
	
Instead of giving something to a tombstone:
	if the second noun marks a grave (called the marked):
		try putting the noun on the marked.
	
Instead of showing something to a tombstone:
	if the second noun marks a grave (called the marked):
		try putting the noun on the marked.

Instead of inserting something into a tombstone:
	if the second noun marks a grave (called the marked):
		try putting the noun on the marked.
	
Instead of putting something on a tombstone:
	if the second noun marks a grave (called the marked):
		try putting the noun on the marked.

Instead of listening to a tombstone: say "It is cold and still and silent."

Instead of taking a tombstone: say "It's far too heavy to lift."
	
Instead of throwing something at a tombstone: say "You think that might be just a bit disrespectful."
	
Instead of touching or rubbing a tombstone: say "The stone is rough[if It Drizzles is happening], cold, and damp[otherwise] and cold[end if]."

Section 3 - Relations and artifacts

An artifact is a kind of thing. Understand "artifact" [or "memory"] as an artifact.
A grave has an artifact called the relic.

Instead of attacking or burning or cutting an artifact: say "You get the feeling that somehow, that might be disrepsectful to someone, somewhere."

Instead of giving an artifact to someone: say "You have a feeling deep in your gut that that would be a very, very bad idea."

Instead of showing an artifact to John Everyman: say "You have a feeling deep in your gut that that would be a very, very bad idea."

Marking relates one tombstone to one grave. The verb to mark means the marking relation.

Last report putting something on a grave:
	if the noun is the relic of the second noun:
		say "You feel a sense of[unicode 8230] [one of]not justice, but perhaps rightness[or]if not justice, at least satisfaction[or]approval, and gratitude, from somewhere outside yourself[or]completeness, and warmth[cycling]."
		
Chapter 5 - Gates Out

Section 1 - The Gates

A gate out is a kind of door. A gate out is usually publicly-named, not scenery, closed, and not openable. The printed name of a gate out is usually "gate out". Understand "green" or "escape" or "way" or "gate" or "out" or "exit" or "door" as a gate out. The plural of gate out is gates out.
The initial appearance of a gate out is usually "The gate out stands to the east, [if busted]smashed into being permanently open[otherwise]closed[end if]."
The description of a gate out is usually "[gate-status]".
A gate out can be busted. A gate out is usually not busted.
A gate out has a number called the fortitude. The fortitude of a gate out is usually 3.

To say gate-status:
	let F be the fortitude of a random present gate out;
	if F is 3:
		say "This is clearly the way out of this place. The gate stands closed, its green wrought-iron swirls keeping you penned in.[paragraph break]An inscription is carved into the frame above the door. ";
	otherwise if F is 2:
		say "This is clearly the way out of this place. You've made a dent in the green wrought-iron swirls, but they still stand strong. ";
	otherwise if F is 1:
		say "You can see the connections between the wrought-iron pieces weakening! It's working! ";
	otherwise:
		say "You've busted a hole in the lattice wide enough to climb through. Freedom lies on the other side. "

Check attacking a Gate Out with the sledgehammer:
	if the gate out is busted, say "You've already destroyed it as much as you need to." instead.

Carry out attacking a Gate Out (called the portal) with the sledgehammer:
	decrement the fortitude of the portal;
	if the fortitude of the portal is 0:
		now the portal is open;
		now the portal is busted.
		
Report attacking a Gate Out with the sledgehammer:
	let F be the fortitude of a random present gate out;
	if F is 2:
		say "You strike the gate with the sledgehammer. It rings like a bell and dents slightly, yet holds firm.";
	otherwise if F is 1:
		say "You strike the gate once more. It groans and begins to buckle. It's weakening!";
	otherwise if F is 0:
		say "[one of]You strike the gate a final, decisive blow. With a squeal of metal, it gives way, opening up the exit to the east[unicode 8212]or at least a hole large enough to squeeze through[or]There's no need for that anymore[unicode 8212]the gate already stands wide open[stopping]."
		
Understand the command "squeeze" as something new. Understand the command "squeeze" as "go".
Understand "through/thru" as east.

Instead of attacking or burning or cutting a gate out:
	unless the sledgehammer is carried, say "You have nothing that could do any damage to it."

Instead of consulting a gate out about: try examining the noun.

Instead of drinking or eating or tasting a gate out: say "Gross. Better to refrain."
	
Instead of smelling a gate out: say "It smells of blood."
	
Instead of climbing a gate out: say "The spaces between the swirls are too small for you to get a good hold."
	
Instead of inserting something into a gate out: say "There's no keyhole. If you were to push [the noun] through the holes in between the wrought-iron swirls, you'd likely lose it to the other side."
	
Instead of unlocking a gate out (called the portal) with when the portal is closed: say "You have no key. You never found a key. You were never told you would need a key!"
	
Instead of opening a gate out (called the portal) when the portal is closed:
	say "It won't open. [first time]It[unicode 8230] won't open. It must be locked, but you can see no keyhole and no handle. You look around, and see no switch or lever. [only]You look through the gate and see freedom, inaccessible.";
	try requesting an ending.
	
Instead of closing a gate out (called the portal) when the portal is open: say "You've made well and sure this gate can never be meaningfully closed again."

Instead of touching or rubbing a gate out: say "The wrought-iron is cold and forbidding."

Instead of tying the ball of yarn to a gate out: say "The yarn will do just as good a job guiding you back here laid on the ground as it will tied to the gate."

Section 2 - The Swirls

Wrought-iron swirls are a kind of thing. Wrought-iron swirls are part of every gate out. Understand "wrought" or "iron" or "wroughtiron" or "swirl" or "piece/pieces" or "cross/crosses" as wrought-iron swirls.
The description of wrought-iron swirls is usually "They're green and metal and cold, forged into complicated swirls and crosses."

Instead of attacking or burning or cutting the wrought-iron swirls: try attacking a random present gate out.

Instead of attacking the wrought-iron swirls with something:
	if a gate out (called the portal) is in the location:
		try attacking the portal with the second noun.

Instead of consulting the wrought-iron swirls about: try examining the noun.

Instead of drinking or eating or tasting wrought-iron swirls: say "Gross. Better to refrain."
	
Instead of smelling the wrought-iron swirls: try smelling a random present gate out.
	
Instead of climbing the wrought-iron swirls: try climbing a random present gate out.
	
Instead of inserting something into the wrought-iron swirls: try inserting the noun into a random present gate out.
	
Instead of unlocking wrought-iron swirls with: try unlocking a random present gate out with the second noun.
	
Instead of opening the wrought-iron swirls: try opening a random present gate out.

Instead of closing the wrought-iron swirls: try closing a random present gate out.
	
Instead of taking the wrought-iron swirls: say "Those are part of the gate and can't be separated from it."
	
Instead of touching or rubbing the wrought-iron swirls: try touching a random present gate out.
	
Instead of tying the ball of yarn to the wrought-iron swirls: try tying the ball of yarn to a random present gate out.

Section 3 - Inscription

An inscription is a kind of thing. An inscription is part of every gate out. Understand "words/wording" or "message/writing" or "inscryption" or "inscribed" or "engraving/engraved" or "carving/carved/etching/etched" as the inscription. An inscription is always distant.
The description of an inscription is usually "Its a single sentence made of carved upper-case letters, curved to match the arch at the top of the gate below. It reads:

[fixed letter spacing]AND IN THE END, THEY FOUND THEMSELVES RETURNED TO THE BEGINNING[roman type]."

A distant stuff rule for an inscription:
	say "The inscription is high enough above the gate to be just out of your reach.";
	rule fails.
	
A distant stuff rule for an inscription while reading: rule succeeds.

Report reading an inscription: say "[fixed letter spacing]AND IN THE END, THEY FOUND THEMSELVES RETURNED TO THE BEGINNING[roman type]."

Before trying consulting an inscription about: try examining the noun instead.
	
Before trying climbing an inscription: try climbing a random present gate out instead.
	
Before trying inserting something into an inscription: try inserting the noun into a random present gate out instead.
	
Before trying unlocking an inscription with: try unlocking a random present gate out with the second noun instead.
	
A distant stuff rule for an inscription while listening:
	say "Written media is more traditionally read than listened to.";
	rule fails.

Before trying opening an inscription: try opening a random present gate out instead.

Before trying closing an inscription: try closing a random present gate out instead.
	
Before trying tying the ball of yarn to an inscription: try tying the noun to a random present gate out instead.
		
Chapter 6 - Sledgehammer

The sledgehammer is a thing. "A sledgehammer leans against one wall." Understand "sledge" or "hammer" as the sledgehammer.
The description of the sledgehammer is "The handle is long and wooden, stained with dirt or oil. The head is heavy and metal and mottled. This hammer has seen use, and it has work left to do."

Instead of attacking or burning or cutting the sledgehammer: say "It's built to destroy other things; it's far too sturdy for you to destroy it itself."
	
Instead of attacking the sledgehammer with something: try attacking the second noun with the sledgehammer.

Instead of consulting the sledgehammer about: try examining the noun.

Instead of drinking or eating or tasting the sledgehammer: say "Gross. Better to refrain."
	
Instead of smelling the sledgehammer: say "It smells of dirt, sweat, and iron. It smells of covalent and ionic bonds. It smells of power and of agency."
	
Instead of giving the sledgehammer to someone: try attacking the second noun with the sledgehammer.
	
Instead of showing the sledgehammer to something: try attacking the second noun with the sledgehammer.
	
Instead of showing something to the sledgehammer: try attacking the noun with the sledgehammer.

Instead of inserting the sledgehammer into something: try attacking the second noun with the sledgehammer.
	
Instead of listening to the sledgehammer: say "It whispers to you of dirt, sweat, and iron. It whispers of covalent and ionic bonds. It whispers of power and of agency."

Instead of throwing the sledgehammer at something: try attacking the second noun with the sledgehammer.
	
Instead of touching or rubbing the sledgehammer: say "The wooden handle fits well in your grip. Its weight and heft make your arms sing."

Instead of waving or swinging the sledgehammer: say "That's a tool. If you're going to swing it, swing it with purpose."

Part 2 - Scenery and backdrops

Chapter 1 - Walls

Section 1 - The walls themselves

The high concrete walls are a backdrop. The walls are everywhere. Understand "big/large/tall" or "barrier/barriers" or "white" or "wall" or "plaster/concrete" or "slimy/slime" or "mold/moldy" as the walls.
The description of the high concrete walls is "The walls are uniformly tall and white. They're made of plaster, which has worn away in places to show the concrete underneath. [concrete-worn]There are patches of smily mold dotted here and there."

To say concrete-worn:
	if the wall-damage of the location is 0:
		do nothing;
	otherwise if the wall-damage of the location < 3:
		say "Here, you've managed to crack the concrete and it's beginning to crumble away. ";
	otherwise if the wall-damage of the location is 3:
		say "Here, you smashed some of the concrete until it gave way, revealing the metal rebar underneath. ".

Instead of attacking or burning or cutting the high concrete walls: say "You doubt that will accomplish much more than giving you a set of bloody knuckles."

Instead of burning the high concrete walls: say "You don't think concrete burns[if rain is in the location]. Besides, the rain would just put a fire back out[end if]."
	
Instead of cutting the high concrete walls: say "You have nothing with which to cut through concrete."

Instead of consulting the high concrete walls about: try examining the noun.

Instead of drinking or eating or tasting the high concrete walls: say "Gross. Better to refrain."

Instead of inserting something into the high concrete walls when the wall-damage of the location is 3: try inserting the noun into the metal rebar.
	
Instead of putting something on the high concrete walls when the wall-damage of the location is 3: try putting the noun on the metal rebar.
	
Instead of smelling the high concrete walls: say "The walls smell musty, of mold and moss and damp that could only have dug in their roots through years of neglected maintainance."
	
Instead of climbing the high concrete walls:
	if the wall-damage of the location < 3:
		say "The wall is far too sheer and smooth. The top is out of your reach, even when you jump.";
	otherwise:
		say "Even with the damage you've done to the wall, there isn't a clear path to climb. The top is still out of your reach, even when you jump."
	
Instead of listening to the high concrete walls: say "The secrets these walls could tell, if only they trusted you."

Instead of throwing something at the high concrete walls: say "You doubt [the noun] is likely to stick. Better to refrain."

Instead of touching or rubbing the high concrete walls:
	let D be the wall-damage of the location;
	if D < 2:
		say "Despite their appearance, the walls are surprisingly smooth. Your fingers come away slimy.";
	otherwise if D is 2:
		say "The wall is cracked and crumbling. Your fingers come away dusty.";
	otherwise if D is 3:
		try touching the metal rebar.

Section 2 - Attacking them and rebar

A room has a number called the wall-damage. The wall-damage of a room is usually 0.

Check attacking the high concrete walls with the sledgehammer:
	if the wall-damage of the location is 3:
		say "You strike the rebar with the sledgehammer and it lets out a resounding clang, but you don't seem to make much progress on damaging it." instead.

Carry out attacking the high concrete walls with the sledgehammer:
	if the wall-damage of the location < 3:
		increment the wall-damage of the location;
	otherwise if the wall-damage of the location is 3 and the metal rebar is not in the location:
		now the metal rebar is in the location.
		
Report attacking the high concrete walls with the sledgehammer:
	let D be the wall-damage of the location;
	if D is 1:
		say "You strike the wall with the sledgehammer. The impact rings out and a crack appears in the smooth concrete.";
	otherwise if D is 2:
		say "You strike the wall with the sledgehammer again. The crack widens, and a few concrete chips fall to the ground with a shower of dust.";
	otherwise if D is 3:
		say "You strike the wall once more and it gives way. The facade of the wall crumbles away, revealing the metal rebar underneath."
	
The metal rebar is a backdrop. It is everywhere. Understand "steel" or "beam/beams" or "foundation" or "sturdy" or "skeleton" or "bone/bones" or "cylinder/cylindrical" or "ridge" or "spiral" or "length" or "front/half" or "embedded/embed" as the metal rebar.
The description of the metal rebar is "Through the dent you've made in the wall, a sturdy steel bar peeks through. It's part of the skeleton that keeps the entire maze in place. It seems to be cylindrical, with a ridge running in a spiral up its length. You can only see the front half of it; it's still firmly embedded in the structure.

Despite having been protected from the elements by the surrounding concrete and plaster, the rebar appears very rusty."

Instead of doing something with the metal rebar when the wall-damage of the location < 3:
	say "[text of parser error internal rule response (E)][paragraph break]".
	
Instead of burning or cutting the metal rebar: say "You doubt that will accomplish much of anything."
	
Instead of attacking the metal rebar with the sledgehammer: try attacking the high concrete walls with the sledgehammer.

Instead of consulting the metal rebar about: try examining the noun.

Instead of drinking or eating or tasting the metal rebar: say "Gross. Better to refrain."
	
Instead of smelling the metal rebar: try smelling the high concrete walls.
	
Instead of climbing the metal rebar: try climbing the high concrete walls.
	
Instead of inserting something into the metal rebar: say "There's not really enough room for [the noun] to fit in."
	
Instead of putting something on the metal rebar: say "There's not really enough room for [the noun] to fit on."

Instead of removing the metal rebar from: try taking the metal rebar.

Instead of listening to the metal rebar: try listening to the high concrete walls.

Instead of taking the metal rebar: say "The rebar is firmly embedded in the wall; it won't budge an inch."
	
Instead of throwing something at the metal rebar: try throwing the noun at the high concrete walls.
	
Instead of touching or rubbing the metal rebar: say "The metal is cool and rough. Chunks of concrete still stick to it. The rust only makes it rougher, and makes your fingers come away slightly red."
	
Instead of tying the ball of yarn to the metal rebar: say "The rebar is embedded a bit too well in the concrete of the walls for you to successfully tie the yarn around it."

Section 3 - Rust on the rebar

The rust is part of the metal rebar. Understand "rusty/rusted" or "wear/tear" or "weathered/weather" or "pox/disease/rot/infestation/infrested/infesting/parasite" as the rust. 
The description of the rust is "It mars the surface of the rebar like a pox, rotting the whole maze away from the inside."
Does the player mean doing something with the rust: it is unlikely.

Instead of doing something with the rust when the wall-damage of the location < 3:
	say "[text of parser error internal rule response (E)][paragraph break]".

Instead of attacking or burning or cutting the rust: try burning the metal rebar.

Instead of consulting the rust about: try examining the noun.
	
Instead of drinking or eating or tasting or smelling the rust: say "Gross. Better to refrain."
	
Instead of removing the rust from: try taking the rust.

Instead of taking the rust: say "The rust is firmly attached to the rebar; it almost seems like an infestation. You don't think you'll be able to separate the two."
	
Instead of throwing something at the rust: try throwing the noun at the high concrete walls.
	
Instead of touching or rubbing the rust: try touching the metal rebar.

Section 4 - Detritus

The detritus is a backdrop. It is everywhere. Understand "dust" or "concrete" or "detrius" or "chunk/chunks" or "rubble" or "fine" or "rough" or "chalk/chalky" or "small/light" or "sprinkle/sprinkling" or "snow" as the detritus. The description of the detritus is "Small chunks of concrete and a fine dust litter the ground by the wall you broke into with the sledgehammer. [if It Drizzles is happening]The rain mixes the powder in with the mud[otherwise]The powder looks like a light sprinking of snow[end if]."
Does the player mean doing something with the detritus: it is unlikely.

Instead of doing something with the detritus when the wall-damage of the location < 2:
	say "[text of parser error internal rule response (E)][paragraph break]".
	
Instead of attacking or burning or cutting the detritus: say "The detritus is the result of the damage you did to the wall[unicode 8212]you're not likely to be able to do more damage to it itself."

Instead of attacking the detritus with: say "The detritus is the result of the damage you did to the wall[unicode 8212]you're not likely to be able to do more damage to it itself."

Instead of consulting the detritus about: try examining the noun.
	
Instead of drinking or eating or tasting or smelling the detritus: say "Gross. Better to refrain."
	
Instead of taking the detritus: say "The dust is [if It Drizzles is happening]now mixed in well with the mud (and is too fine to collect anyway)[otherwise]too fine to collect[end if], and the chunks are too small to be useful."
	
Instead of touching or rubbing the detritus: say "The chunks are rough; the dust is [if It Drizzles is happening][drizzles-dust][otherwise]fine and chalky[end if]."

To say drizzles-dust: say "[one of]fine and chalky[or]quickly growing indistinguishable from the mud[stopping]".

Chapter 2 - Dirt/Mud

Section 1 - Dirt

The dirt is a backdrop. The dirt is everywhere. Understand "ground/earth" or "small/tufts/grass" or "floor" as the dirt. The dirt is diggable.
The description of the dirt is "The dirt has been packed hard by many trampling feet. Small tufts of grass sprout from it here and there."

Instead of attacking or burning or cutting the dirt: say "You don't think you're likely to get much of anywhere attacking the earth itself."

Instead of attacking the dirt with: say "You don't think you're likely to get much of anywhere attacking the earth itself."

Instead of consulting the dirt about: try examining the noun.
	
Instead of drinking or eating or tasting the dirt: say "You doubt the dirt is sanitary enough to consume. You decide against it."
	
Instead of smelling the dirt: say "The dirt smells green, even earthy."
	
Instead of putting something on the dirt:
	try dropping the noun;
	if the noun is in the location and the noun is not carried:
		now the noun is dirtied.

Instead of removing something from the dirt: try taking the noun.

Instead of listening to the dirt: say "It holds all of the secrets of all of the people that have ever trod upon it, and it refuses to tell you a single one."

Instead of taking the dirt: say "There's far too much dirt to carry, and it's too hard-packed to only take part of it."
	
Instead of touching or rubbing the dirt: say "It trickles between your fingers and falls back to the earth."

Section 2 - Mud & its appearance

The mud is a backdrop. The mud is nowhere. Understand "ground/earth" or "grass" or "floor" or "wet/damp/slip/slippery" as the mud. The mud is diggable.
The description of the mud is "The rain has softened the dirt into dark mud, its surface ranging from soft to slick to saturated."

Instead of attacking or burning or cutting the mud: say "You don't think you're likely to get much of anywhere attacking the earth itself."

Instead of attacking the mud with: say "You don't think you're likely to get much of anywhere attacking the earth itself."

Instead of consulting the mud about: try examining the noun.
	
Instead of drinking or eating or tasting the mud: say "You doubt the mud is sanitary enough to consume. You decide against it."
	
Instead of smelling the mud: say "The mud smells dark brown and wet."
	
Instead of putting something on the mud:
	try dropping the noun;
	if the noun is in the location and the noun is not carried:
		now the noun is dirtied.

Instead of removing something from the mud: try taking the noun.

Instead of listening to the mud: say "It holds all of the secrets of all of the people that have ever trod upon it. It's only barely managing to keep them from bubbling up to the surface."

Instead of taking the mud: say "There's far too much mud to carry."
	
Instead of touching or rubbing the mud: say "As soon as you tilt your hand it slides off and plops heavily back to the ground."

At 10:00 AM:
	now the dirt is nowhere;
	now the mud is everywhere.
	
Section 3 - The mudball
	
The mudball is a thing. The printed name is "mud-ball". Understand "mud-ball" or "ball" or "lump" or "healthy/healthily/sized/healthily-sized/size" as the mudball. Understand "mud" as the mudball when the mudball is carried. The maximum saturation of the mudball is 15.
The description of the mudball is "A handfull of mud you took from the earth. It is very wet and very dirty."

Check digging in the mud:
	if the player carries the mudball, say "You've already got a healthily-sized mud-ball with you." instead.

Carry out digging in the mud:
	if the mudball is nowhere:
		now the player carries the mudball.
		
Report digging in the mud: say "You dig in the mud, removing a healthily-sized mud-ball from the mass."
		
Carry out throwing the mudball at a security camera (called the lens):
	now the lens is obscured;
	now the lens is dirtied;
	now the mudball is nowhere.
	
Report throwing the mudball at a security camera: say "You hurl the mud at the camera. It splatters against the lens, successfully obscuring its view of the hallway."

Instead of attacking or burning or cutting the mudball: say "You're not sure what that would achieve."
	
Instead of attacking the mudball with: say "You're not sure what that would achieve."

Instead of consulting the mudball about: try examining the noun.
	
Instead of drinking or eating or tasting the mudball: say "That definitely wouldn't be sanitary."
	
Instead of smelling the mudball: say "It smells of rich earth."
	
Instead of giving the mudball to someone: say "You're not sure what use [the second noun] would have with the mud-ball."

Instead of dropping the mudball:
	now the mudball is nowhere;
	say "You let the mud fall from your hand and rejoin the mass on the ground."
	
Instead of putting the mudball on:
	now the second noun is dirtied;
	now the mudball is nowhere;
	say "You try to put the mud onto [the second noun], but the mud isn't really able to hold its shape and you really only manage to spread it around on [the second noun], leaving it quite dirty."

Instead of listening to the mudball: say "It says nothing, but seems content."

Before trying taking the mudball:
	if the mud is in the location:
		try digging in the mud instead.
		
Before trying taking the mud:
	if the mud is in the location:
		try digging in the mud instead.

Check throwing the mudball at something insecure:
	if the second noun is animate:
		if the second noun is John Everyman:
			say "You're not particularly interested in facing assault charges today." instead;
		otherwise:
			say "That strikes you as cruel. Better to refrain." instead.
	
Carry out throwing the mudball at something insecure:
	now the mudball is nowhere;
	now the second noun is dirtied.

Report throwing the mudball at something insecure:
	say "The ball of mud splatters against [the second noun], getting it thoroughly filthy and losing any right to be called a 'ball' in the process."
	
Instead of touching or rubbing the mudball: say "It's cold and slimy."
	
Instead of tying something to the mudball: say "That's not likely to achieve much."

Instead of washing the mudball with: say "The mud-ball is filth incarnate; to wash it would be to rob it of itself."

Chapter 3 - The sky

The sky is a distant backdrop. The sky is everywhere. The description is "It is [if It Drizzles is happening]dark and gray and roiling[otherwise]bright and blue and cold[end if]." Understand "dark/gray/grey/roiling/broiling/boiling/roil/boil" or "bright/blue/cold" or "cloud/clouds/storm" as the sky.
	
Before trying attacking the sky with: say "[The noun] is unlikely to touch the sky. It's not an elephant." instead.

Instead of consulting the sky about: try examining the noun.
	
Instead of listening to the sky: say "Even if it were to speak, it's too far away to hear."

Before trying throwing something at the sky: say "[The noun] is unlikely to touch the sky. It's not an elephant." instead.
	
Part 3 - Worn things

Chapter 1 - Jacket

The player wears the aviator jacket. Understand "heavy" or "green" or "army" or "coat" or "my" or "bomber" or "pocket/pockets" or "faux/fake" or "leather/pleather" or "fur" or "polyester/plastic" or "lining/lined" as the aviator jacket. The aviator jacket is a player's holdall. The aviator jacket is open and not openable.
The description of the aviator jacket is "It's your trusty aviator jacket. You bought it years ago at a thrift store. It's made of brown fake leather, with a soft orange faux fur collar. It has many patches and many pockets, in which you can store many things."
The aviator jacket can be fake-open or fake-closed. The aviator jacket is fake-open.
The maximum saturation of the aviator jacket is 15.

Instead of attacking or burning or cutting the aviator jacket: say "That's your jacket! You're not particularly eager to destroy it."

Instead of attacking the aviator jacket with: say "That's your jacket! You're not particularly eager to destroy it."

Instead of consulting the aviator jacket about something:
	if the second noun is in the aviator jacket:
		say "[The second noun] is indeed in one of your jacket's pockets.";
	otherwise:
		try examining the noun.
		
Instead of drinking or eating or tasting the aviator jacket: say "It's not exactly edible."
	
Instead of looking under the aviator jacket: say "You're wearing a white tee shirt underneath."
	
Instead of smelling the aviator jacket: say "You don't detect much of an odor[unicode 8212]you suspect it smells like you."
	
Instead of giving the aviator jacket to someone: say "That's your jacket! You're not particularly interested in risking losing it[if It Drizzles is happening]. Besides, it's the only thing keeping you relatively dry at the moment[end if]."
	
Instead of giving something to the aviator jacket: try inserting the noun into the aviator jacket.
	
Instead of dropping the aviator jacket: say "That's your jacket! You're not particularly interested in risking losing it[if It Drizzles is happening]. Besides, it's the only thing keeping you relatively dry at the moment[end if]."
	
Instead of putting something on the aviator jacket: try inserting the noun into the aviator jacket.

Instead of opening the aviator jacket:
	if the aviator jacket is fake-closed:
		say "You unzip your jacket and let it sit open.";
		now the aviator jacket is fake-open;
	otherwise:
		say "It's already unzipped."

Instead of closing the aviator jacket:
	if the aviator jacket is fake-open:
		say "You zip up your aviator jacket.";
		now the aviator jacket is fake-closed;
	otherwise:
		say "It's already zipped up."
	
Instead of throwing the aviator jacket at: say "That's your jacket! You're not particularly interested in risking losing it[if It Drizzles is happening]. Besides, it's the only thing keeping you relatively dry at the moment[end if]."
	
Instead of touching or rubbing the aviator jacket: say "It's made of faux leather and fur, and the inside is lined with polyester. All three materials feel soft under your fingers."
	
Instead of taking off the aviator jacket: say "That's your jacket! You're not particularly interested in risking losing it[if It Drizzles is happening]. Besides, it's the only thing keeping you relatively dry at the moment[end if]."

Some patches are part of the aviator jacket. The description of the patches is "A memory for each one." Understand "patch" or "stiff/fabric" or "embroidered/embroidery" as the patches.

Instead of attacking or burning or cutting the patches: try attacking the aviator jacket.

Instead of attacking the patches with: try attacking the aviator jacket with the second noun.

Instead of consulting the patches about: try examining the noun.
		
Instead of drinking or eating or tasting the patches: say "They're not exactly edible."
	
Instead of looking under the patches: say "They're part of your aviator jacket."
	
Instead of smelling the patches: try smelling the aviator jacket.
	
Instead of giving the patches to someone: say "They're part of your aviator jacket."
	
Instead of giving something to the patches: try inserting the noun into the aviator jacket.
	
Instead of dropping the patches: say "They're part of your aviator jacket."
	
Instead of putting something on the patches: try inserting the noun into the aviator jacket.

Instead of inserting something into the patches: try inserting the noun into the aviator jacket.
	
Instead of throwing the patches at: say "They're part of your aviator jacket."
	
Instead of touching or rubbing the patches: say "They're made of thin, stiff, embroidered fabric."
	
Instead of taking off the patches: say "They're part of your aviator jacket."

Chapter 2 - Tee shirt

The player wears the white tee shirt. Understand "plain" or "tshirt" or "teeshirt" or "t-shirt" or "my" as the white tee shirt.
The description of the white tee shirt is "You're wearing a plain white tee shirt. It's really just functional in this outfit, allowing the aviator jacket to be the focus."
The maximum saturation of the tee shirt is 15.

Instead of attacking or burning or cutting the white tee shirt: say "You're not particularly interested in destroying your shirt. It may be plain, but it does serve a function."

Instead of attacking the white tee shirt with: say "You're not particularly interested in destroying your shirt. It may be plain, but it does serve a function."

Instead of consulting the white tee shirt about: try examining the noun.

Instead of drinking or eating or tasting the white tee shirt: say "It's not exactly edible."
	
Instead of looking under the white tee shirt: say "Why, you're underneath!"
	
Instead of smelling the white tee shirt: say "You don't detect much of an odor[unicode 8212]you suspect it smells like you."
	
Instead of giving the white tee shirt to someone:
	if the location is Room2-2 and Cam1 is not busted or the location is Room3-7 and Cam2 is not busted or the location is Room7-1 and Cam3 is not busted or the location is Room9-5 and Cam4 is not busted:
		say "You're on camera, and you're not particularly interested in giving a show to whoever's watching.";
	otherwise:
		say "You're likely to be on camera at some point during your time in the maze, and you're not particularly interested in giving a show to whoever's watching."
	
Instead of dropping the white tee shirt:
	if the location is Room2-2 and Cam1 is not busted or the location is Room3-7 and Cam2 is not busted or the location is Room7-1 and Cam3 is not busted or the location is Room9-5 and Cam4 is not busted:
		say "You're on camera, and you're not particularly interested in giving a show to whoever's watching.";
	otherwise:
		say "You're likely to be on camera at some point during your time in the maze, and you're not particularly interested in giving a show to whoever's watching."
	
Instead of touching or rubbing the white tee shirt: say "The material is soft and stretchy."
	
Instead of taking off the white tee shirt:
	if the location is Room2-2 and Cam1 is not busted or the location is Room3-7 and Cam2 is not busted or the location is Room7-1 and Cam3 is not busted or the location is Room9-5 and Cam4 is not busted:
		say "You're on camera, and you're not particularly interested in giving a show to whoever's watching.";
	otherwise:
		say "You're likely to be on camera at some point during your time in the maze, and you're not particularly interested in giving a show to whoever's watching."

Chapter 3 - Shorts

The player wears the cutoff shorts. Understand "short" or "low-rise/lowrise" or "jean/denim" or "cut-off" or "my" or "pair" or "of" as the cutoff shorts. The printed name of the cutoff shorts is "pair of cutoff shorts".
The description of the cutoff shorts is "You're wearing a pair of tight jean shorts. They used to fall around your knees before you took a pair of scissors to them, and now they stop about mid-thigh."
The maximum saturation of the cutoff shorts is 15.

Instead of attacking or burning or cutting the cutoff shorts: say "You're not particularly interested in destroying your shorts. You've cut them up exactly as much as you intend to already."

Instead of attacking the cutoff shorts with: say "You're not particularly interested in destroying your shorts. You've cut them up exactly as much as you intend to already."

Instead of consulting the cutoff shorts about: try examining the noun.

Instead of drinking or eating or tasting the cutoff shorts: say "It's not exactly edible."
	
Instead of looking under the cutoff shorts: say "Why, you're underneath!"
	
Instead of smelling the cutoff shorts: say "You're not quite that flexible."
	
Instead of inserting something into the cutoff shorts:
	try inserting the noun into the aviator jacket;
	if the noun is in the aviator jacket:
		say "They're tight enough that the pockets are really only decorative. There's plenty of room in your jacket pockets, though. You decide to put [the noun] there instead.";
	otherwise:
		say "Hm. That doesn't quite seem possible."
	
Instead of opening the cutoff shorts:
	if the location is Room2-2 and Cam1 is not busted or the location is Room3-7 and Cam2 is not busted or the location is Room7-1 and Cam3 is not busted or the location is Room9-5 and Cam4 is not busted:
		say "You're on camera, and you're not particularly interested in giving a show to whoever's watching.";
	otherwise:
		say "You're likely to be on camera at some point during your time in the maze, and you're not particularly interested in giving a show to whoever's watching."

Instead of touching or rubbing the cutoff shorts: say "The shorts are soft and slightly scratchy, in that unique denim way."

Instead of taking off the cutoff shorts:
	if the location is Room2-2 and Cam1 is not busted or the location is Room3-7 and Cam2 is not busted or the location is Room7-1 and Cam3 is not busted or the location is Room9-5 and Cam4 is not busted:
		say "You're on camera, and you're not particularly interested in giving a show to whoever's watching.";
	otherwise:
		say "You're likely to be on camera at some point during your time in the maze, and you're not particularly interested in giving a show to whoever's watching."

Part 4 - Yarn mechanics

A room can be beyarned. A room is usually not beyarned.

Before going (this is the beyarning rule):
	if the ball of yarn is carried:
		now the location is beyarned;
	continue the action.
	
Carry out looking (this is the yarncrumbs rule):
	let yarned count be 0;
	let farplace be location;
	repeat with way running through directions
	begin;
		let farplace be the room way from the location;
		now direction-object is the room-or-door way from the location;
		if the direction-object is apparent and farplace is beyarned, increase yarned count by 1;
	end repeat;
	if yarned count is 0
	begin;
		do nothing;
		continue the action;
	end if;
	let Y be yarned count;
	if yarned count <= 2, say "A trail of yarn runs off to the ";
	otherwise say "Trails of yarn run off to the ";
	repeat with way running through directions
	begin;
		let farplace be the room way from the location;
		now direction-object is the room-or-door way from the location;
		if the direction-object is apparent and farplace is beyarned
		begin;
			say "[way]";     
			decrease Y by 1;
			if Y is 0, say ".";
			if Y is 1, say " [and-conjunction] ";
			if Y > 1, say ", ";       
		end if;   
	end repeat;
	continue the action.
	
Part 5 - General noun understanding

Understand "my" as something carried.

Understand "dead" or "end" or "hall/hallway" or "corner" or "fork" or "cross/crossing/crossroad/crossroads/road/roads" or "location" or "here" or "surroundings" as a room.

Understand "grave" as a grave.

Definition: a thing is animate if it is a person.
Definition: a thing is inanimate if it is not animate.

Book 4 - Verbs

Chapter 1 - Unused verbs

Understand the commands "unwrap" and "uncover" and "cover" and "set" and "adjust" as something new.

Understand nothing as waking.
Understand nothing as squeezing.
Understand nothing as buying.

Instead of pushing something to: try pushing the noun.
Instead of swinging something: try waving the noun.

Chapter 2 - New synonyms

Understand "turn [something switched off] on/--" as switching on.
Understand "turn on [something switched off]" as switching on.
Understand "switch [something] on" as switching on.
Understand "flip [something switched off]" as switching on.
Understand "play [something]" as switching on.

Understand "turn [something switched on] off/--" as switching off.
Understand "turn off [something switched on]" as switching off.
Understand "switch [something] off" as switching off.
Understand "flip [something switched on]" as switching off.
Understand "pause [something]" as switching off.

Understand "listen [something]" as listening to.

Understand "keep [something]" as taking.
Understand "catch [something]" as taking.

Chapter 3 - Unique/miscellaneous actions

Section 1 - Doing things to John

The can't take other people rule response (A) is "You suspect that might technically be kidnapping."

The kissing John rule is listed before the block kissing rule in the check kissing rules.

This is the kissing John rule:
	if the noun is John Everyman:
		say "You suspect John would get a lot more out of that than you would." instead.
		
The pushing John rule is listed before the can't push people rule in the check pushing rules.

This is the pushing John rule:
	if the noun is John Everyman:
		say "You're not particularly interested in facing assault charges today." instead.
		
Instead of waving hands when John Everyman is in the location, say "You wave. John [one of]gives a halfhearted wave back[or]gives a mock salute[or]ignores you[stopping]."

The rubbing John rule is listed before the can't rub another person rule in the check rubbing rules.

This is the rubbing John rule:
	if the noun is John Everyman:
		say "You suspect John would get a lot more out of that than you would." instead.
		
Section 2 - Doing things with nouns

The can't reach inside rooms rule response (A) is "[The noun] [are] too far away to reach from here."

The can't take yourself rule response (A) is "One would hope you already have ahold of yourself."

The can't eat unless edible rule response (A) is "You're not particularly inclined to put [regarding the noun][those] in your mouth."

The examine directions rule response (A) is "You'll have to get closer to make out any detail."

Instead of examining yourself: say "You're you. You already know well what you look like."
Instead of searching yourself: try taking inventory.
Instead of smelling yourself: say "Woof. Might be time for a shower soon."
Before trying climbing or pushing or turning or opening or entering or closing or listening to yourself: say "What in the world are you going on about?" instead.
Before trying getting off or switching on or switching off or kissing or touching or rubbing or tasting or eating yourself: say "Don't be gross." instead.
Instead of waking yourself: try waking up.
Before trying attacking or burning or cutting yourself: say "The rest of the world will try to hurt you; you aren't obligated to give it any help." instead.

Instead of searching the aviator jacket:
	prepare a list of things contained by the aviator jacket;
	if the number of filled rows in the Table of Scored Listing > 0:
		say "Stored in the pockets of the aviator jacket [is-are a prepared list].";
	otherwise:
		say "The pockets of the aviator jacket are empty."

Instead of waving or swinging or dropping the aviator jacket: try taking off the noun.

Instead of waving or swinging or dropping the white tee shirt: try taking off the noun.

Instead of searching the cutoff shorts: say "The pockets are purely ornamental. Everything you need to carry, you can store in your jacket."
Instead of waving or swinging or dropping the cutoff shorts: try taking off the noun.
		
Report waving the dirty ribbon: say "You do a brief ribbon dance."

Carry out pulling the ball of yarn:
	let R be the list of beyarned rooms;
	if the number of entries in R is 2:
		remove the location from R, if present;
		repeat with rm running through R:
			now rm is not beyarned.

Report pulling the ball of yarn:
	if the number of beyarned rooms <= 1:
		say "You yank on the yarn trailing behind you and its end skitters to meet you." instead;
	otherwise:
		say "You yank on the yarn trailing behind you. It pulls tight around a corner." instead.
		
Before trying going down when the player is on a supporter:
	unless the location is a treehouse:
		try exiting instead;
	otherwise:
		continue the action.

Section 3 - Doing things without nouns

The report jumping rule response (A) is "You jump on the spot. It's not enough to let you see over the walls."

The block sleeping rule response (A) is "You sense that the maze is a dangerous place to fall asleep. If you do, it's entirely possible you won't wake up again."

The block thinking rule response (A) is "The time for thinking has passed; now it's time to act."

Waving at is an action applying to one visible thing. Understand "wave at [something]" as waving at. Understand "wave to [something]" as waving at.
Instead of waving at: try waving hands.

The block saying yes rule is not listed in any rulebook.

Check an actor saying yes (this is the new block saying yes rule):
	if the actor is the player:
		if John Everyman is in the location:
			say "John hasn't asked you a question." (A);
		otherwise:
			say "You say the word 'yes' aloud." (B);
	stop the action.

The block saying no rule is not listed in any rulebook.

Check an actor saying no (this is the new block saying no rule):
	if the actor is the player:
		if John Everyman is in the location:
			say "John hasn't asked you a question." (A);
		otherwise:
			say "You say the word 'no' aloud." (B);
	stop the action.
	
The block saying sorry rule is not listed in any rulebook.

Check an actor saying sorry (this is the new block saying sorry rule):
	if the actor is the player:
		if John Everyman is in the location:
			say "You find it beneath your dignity to apologize to John." (A);
		otherwise:
			say "Oh, don't apologize." (B);
	stop the action.

Check waving hands:
	if a present gate out (called the portal) is in the location:
		if the portal is closed:
			say "You wave your hands, but can't see anyone on the other side of the gate to notice you.";
		otherwise:
			say "You pause for a moment, then wave goodbye to the maze."

Instead of waving hands when the location is Room2-3: say "You wave. The carved maidens, being made of stone, are unable to wave back."

Instead of waving hands when a security camera is in the location: say "You wave at the camera."

Instead of waving hands when the location is Room6-5:
	if the nice tree is in the location:
		say "You wave at the nice tree. Its branches wave back.";
	otherwise:
		say "You wave at the charred ruin. It remains entirely still."

Instead of waving hands when the small lizard is visible: say "You wave to the lizard. It [one of]stares blankly at you[or]licks its eyeball[or]cocks its head[or]seems startled[then at random]."

Instead of waving hands when the location is Room8-2: say "You give a melancholy wave. All else is still."

Check listening: if the location is jukebox-adjacent and the jukebox is switched on, say "You listen to the music." instead.

Section 4 - Legacy verbs

Magicking is an action applying to nothing. Understand "xyzzy" or "cast magic/magick/spell/--" as magicking.

Report magicking: say "[one of]You are, lamentably, untrained in the magical arts[or]Nothing happens[or]Nothing happens. You are, lamentably, untrained in the magical arts[stopping]."

Cursing is an action applying to nothing. Understand "curse" or "swear" or "say [foul language]" or "[foul language]" as cursing. Cursing is verbal behavior.
Understand "ass/asshole/assholes/arse/arsehole/arseholes/asshat/asshats/arsehead/arseheads" or "bastard/bastards" or "bitch/bitches" or "christ/jesus" or "cock/cocksucker/cocksuckers/-- sucker/suckers" or "crap" or "cunt/cunts" or "god/-- damn/goddamn/goddammit" or "dick/dicks/dickhead/dickheads" or "fuck/fucks/fucker/fuckers/motherfucker/motherfuckers" or "hell/hells" or "piss" or "prick/pricks" or "pussy/pussies" or "shit/shitty/bullshit/horseshit/shite" or "son of a bitch/--" or "twat" or "wanker" as "[foul language]".

Check cursing:
	if John Everyman is in the location:
		say "You suspect that might offend John's delicate sensibilities." instead.
		
Report cursing: say "You curse. [one of]It echoes off the walls[or]You don't feel much better[or]You're unsure what you hoped to accomplish by it[in random order]."

Praying is an action applying to nothing. Understand "pray" as praying. Praying is verbal behavior.

Report praying: say "You pray, but don't sense any kind of acknowledgement. It would appear you're on your own."

Singing is an action applying to nothing. Understand "sing" or "hum" as singing. Singing is verbal behavior.

Check singing:
	if John Everyman is in the location:
		say "You're not embarrassed of your singing voice, but you doubt John would appreciate it much." instead.

Report singing:
	if the location is jukebox-adjacent and the jukebox is switched on:
		say "You sing a snatch of the melody along with the record.";
	otherwise:
		say "You sing a fragment of a melody to yourself."

Chapter 4 - Examined/Unexamined

A thing can be examined or unexamined. A thing is usually unexamined.

Carry out examining something (called the obj) (this is the standard examined rule):
	now the obj is examined;
	continue the action.
	
To decide whether (obj - a thing) has been examined:
	if obj is examined, yes;
	no.

Chapter 5 - Reading

Understand the command "read" as something new.

Understand "read [something]" or "consult [something]" or "read in/from [something]" as reading. Reading is an action applying to one thing, requiring light.

Check reading (this is the can only read text rule):
	if the noun is not an LED ticker sign and the noun is not a tombstone and the noun is not the book of paint swatches and the noun is not an inscription:
		say "There's no text to read." instead.
		
Check reading (this is the can only read working signs rule):
	if the noun is a busted LED ticker sign:
		say "When you threw the rock at it, you rendered it unreadable." instead.
		
Carry out reading an LED ticker sign (this is the read the sign rule):
	if the message of the noun is not "":
		say "You wait for the text to tick through all the way once so that you can make out the entire message. It reads: [paragraph break][fixed letter spacing][the message of the noun][roman type][paragraph break]";
	otherwise:
		say "Hm. The sign seems to be broken. There's no text here to read at all."

Carry out reading a tombstone (this is the read the epitaph rule):
	if the message of the noun is not "":
		if the noun is not stone3:
			say "There are no names or dates listed on the tombstone, but there is an epitaph. It reads: [paragraph break][italic type][the message of the noun][roman type][paragraph break]";
		otherwise:
			say "This tomb does have a name[unicode 8212][italic type]your[roman type] name. Below it, in smaller lettering aligned to the left side of the stone, is your date of birth. The place on the right side for your date of death is currently blank. So is a large space below, presumably reserved for your own epitaph.";
	otherwise:
		say "Hm. The stone is completely blank."
		
Chapter 6 - Washing

Section 1 - Dirtiness and cleanliness

A thing can be dirtied or clean. A thing is usually clean. Understand the dirtied property as describing a thing. 
Understand "dirty" or "messy" or "muddy/muddied/mucky" or "gross/foul" or "soiled" or "grimy/grubby" or "filthy" or "unwashed" or "dusty" or "unclean" or "yucky/icky" or "unsanitary" as dirtied.
Understand "washed" or "cleaned" or "sanitary" as clean.

The mudball is dirtied.

Rule for printing inventory details of something dirtied (called the obj) (this is the dirty inv rule):
	say " (dirty[if the obj is wet],[otherwise])[end if][run paragraph on]";
	continue the activity.

Carry out dropping something (called the obj):
	now the obj is dirtied;
	continue the action.

A thing can be dry or wet. A thing is usually dry. Understand the wet property as describing a thing.
Understand "sodden" or "soaked" or "waterfilled" or "dripping" or "saturated" or "damp" or "wetted" as wet.
Understand "dried" as dry.

A thing can be cleansing. A thing is usually not cleansing.

Section 2 - Wetness

A thing has a real number called the wetness. The wetness of a thing is usually 0.00.
A thing has a real number called the maximum saturation. The maximum saturation of a thing is usually 10.00.

Carry out washing something with something (this is the washing saturates rule):
	now the wetness of the noun is the maximum saturation of the noun.
	
Every turn (this is the drying or wetting rule):
	repeat with obj running through things:
		if It Drizzles is not happening:
			if obj is not in the fountain and the wetness of obj > 0:
				decrement the wetness of obj;
		otherwise:
			if obj is not in the root-hole and obj is not in the aviator jacket and the maximum saturation of obj > the wetness of obj:
				increment the wetness of obj;
			otherwise if obj is in the aviator jacket and the maximum saturation of the aviator jacket is the wetness of the aviator jacket and the maximum saturation of obj > the wetness of obj:
				increment the wetness of obj.
				
Every turn (this is the update the dryness rule):
	repeat with obj running through things:
		if the wetness of obj > 0:
			now obj is wet;
		otherwise:
			now obj is dry.
	
Rule for printing inventory details of something wet (called the obj) (this is the inventory wetness rule):
	say " [unless the obj is dirtied]([end unless][run paragraph on]";
	let A be the wetness of the obj;
	let B be the maximum saturation of the obj;
	let C be A divided by B;
	if B > 5:
		if C is 1:
			say "dripping wet)[run paragraph on]";
		otherwise if C >= 2.00 divided by 3.00:
			say "wet)[run paragraph on]";
		otherwise if C >= 1.00 divided by 3.00:
			say "soggy)[run paragraph on]";
		otherwise if C > 0:
			say "damp)[run paragraph on]";
	otherwise:
		if C is 1:
			say "wet)[run paragraph on]";
		otherwise:
			say "damp)[run paragraph on]";
	continue the activity.

Section 3 - The washing verb

Washing it with is an action applying to two things. Understand "wash [something preferably held] in/with [something]" as washing it with. Understand "clean [something preferably held] in/with [something]" as washing it with.

Check washing it with (this is the already clean rule):
	if the noun is clean:
		say "[The noun] [are] already clean." instead.
		
Check washing it with (this is the must be cleansing rule):
	unless the second noun is cleansing:
		say "[The second noun] [aren't] able to clean [the noun], or anything for that matter." instead.

Carry out washing it with (this is the standard washing rule):
	now the noun is clean;
	now the noun is wet.
	
Report washing it with (this is the standard report washing rule):
	say "You wash [the noun] off in [the second noun], getting [regarding the noun][them] both clean and thoroughly soaked."
	
Chapter 7 - Digging

Digging is an action applying to nothing. Understand "dig" as digging.

Instead of digging:
	if dirt is in the location, try digging in the dirt;
	otherwise try digging in the mud.

Digging in is an action applying to one thing. Understand "dig in/into/-- [something]" as digging in.

Check digging in something (called the obj) (this is the can only dig if diggable rule):
	if the noun is not diggable:
		say "That's not something you can dig in." instead.
			
Chapter 8 - Attacking it with

Attacking it with is an action applying to two things.

Understand "attack [something] with [something preferably held]" as attacking it with.
Understand "break [something] with [something preferably held]" as attacking it with.
Understand "smash [something] with [something preferably held]" as attacking it with.
Understand "hit [something] with [something preferably held]" as attacking it with.
Understand "wreck [something] with [something preferably held]" as attacking it with.
Understand "crack [something] with [something preferably held]" as attacking it with.
Understand "destroy [something] with [something preferably held]" as attacking it with.
Understand "thump [something] with [something preferably held]" as attacking it with.
Understand "strike [something] with [something preferably held]" as attacking it with.
Understand "smack [something] with [something preferably held]" as attacking it with.

Understand "attack [something]" or "break [something]" or "smash [something]" or "hit [something]" or "wreck [something]" or "crack [something]" or "destroy [something]" or "thump [something]" or "strike [something]" or  "smack [something]" as attacking it with when the sledgehammer is carried.

Rule for supplying a missing second noun while attacking with:
	if the sledgehammer is carried, now the second noun is the sledgehammer;
	otherwise try attacking the noun instead.
	
Check attacking it with:
	if the second noun is not the sledgehammer, say "You think that's unlikely to do much damage." instead.
	
Instead of attacking a room with the sledgehammer: try attacking the high concrete walls with the sledgehammer.

Chapter 9 - Satisfying players' impulses

Knotting is an action applying to one thing. Understand "tie [something preferably held]" as knotting.

Check an actor knotting something (this is the block knotting rule):
	if the actor is the player:
		say "[We] [would achieve] nothing by this." (A);
	stop the action.
	
Instead of knotting the dirty ribbon: try wearing the dirty ribbon.

Instead of knotting the ball of yarn: say "You don't think there's much to be gained by tying a knot in the yarn."

Swimming is an action applying to nothing. Understand "swim" as swimming.

Before swimming:
	if the location is Room2-3 and the player is not in the fountain:
		silently try entering the fountain;
	continue the action.

Check swimming: if the player is not in the fountain, say "You can't swim on land." instead.

Report swimming: say "You [one of]splash down into the fountain. The water is very cold[or]try a few laps. It's challenging in the shallow water[or]Lay back and [if It Drizzles is happening]let the rain hit your face[otherwise]stare at the clouds overhead[end if][stopping]."

Chapter 10 - About and credits

Section 1 - About

After printing the banner text: say "[italic type]First-time players should type ABOUT (even if you've played IF before). [roman type][paragraph break]".

The help request rule is not listed in any rulebook.

Carry out asking for help:
	now the current menu is the Table of Labyrinthine Help;
	carry out the displaying activity;
	clear the screen;
	try looking;
	stop the action.
	
Table of Labyrinthine Help
title	subtable	description	toggle
"Introduction to [story title] (please read even if seasoned in IF)"	--	"[new-intro]"	--
"About Interactive Fiction"	--	"[about-if]"	--
"How to Play (go here even if seasoned in IF)"	Table of Play Instructions	--	--
"If You Get Stuck"	Table of Stuckness Advice	--	--
"Credits and Acknowledgements"	--	"[full-credits]"	--
"Found a bug?"	--	"[found-bug]"

To say new-intro:
	say "[italic type]You are one of the unlucky many chosen to walk the maze. Will you be one of the lucky few to escape?[roman type]
	
	I began writing this game on June 24, 2022, and finished version 1 of it in September of that year. Version 2 (this version) was released that October, taking into account some early suggestions from players. It takes place now and then, at a very specific time and at every time.
	
	A small request: while I encourage you to map out your maze as you play, I ask that you DO NOT post any maps of any maze from this game online. The exploration and the getting lost and the entering the unknown is part of the point.
	
	To those of you out there walking your own mazes, I stand with you."
	
To say about-if:
	say "This game is a work of Interactive Fiction[unicode 8212]a story in which you play the main character.  You type commands which determine the actions of the character and affect the flow of the plot.  This game includes no graphics: the imagery is provided courtesy of your imagination.  On the other hand, there's a wide range of action available: whereas in other games you may be restricted to shooting, movement, or searching items you can click on with a mouse, IF allows you a wide range of verbs."
	
Table of Play Instructions
title	subtable	description	toggle
"What to do with [command prompt]"	--	"[wtd-prompt]"	--
"Getting Started"	--	"[getting-started]"	--
"Moving Around"	--	"[moving-around]"	--
"Other Common Verbs"	--	"[other-verbs]"	--
"Conversation"	--	"[convo-info]"	--
"Commands Specific to This Game (read this even if seasoned in IF)"	--	"[specific-commands]"	--
"Controlling the Game"	--	"[controlling-game]"	--

To say wtd-prompt:
	say "The [command prompt] sign is where the game says, 'Okay, what do you want to do now?'  You may respond by typing an instruction -- usually an imperative verb, possibly followed by prepositions and objects.  So, for instance, LOOK, LOOK AT FISH, TAKE FISH."
	
To say getting-started:
	say "The first thing you want to do when starting any piece of IF is acquaint yourself with your surroundings and get a sense of your goal. To this end, you should read the introductory text carefully. Pay attention to where you are. Notice which directions are available to go to, and what objects are described here. If any of these seem interesting, you may want to EXAMINE them (X for short). [paragraph break]You might also want to examine yourself (X ME) to see whether the author has left you any clues about your character. TAKE INVENTORY (or INVENTORY for short, I for shorter) will tell you what you're carrying, as well.[paragraph break]Once you've gotten your bearings, you may want to explore. Move from place to place, and check out every location available."
	
To say moving-around:
	say "At any given time, you are in a specific location in the game world. When you go to a new place, the game will print a description of what you can see there. This description will contain two vital kinds of information: things in the room you can interact with or take, and a list of directions you can go from there. If you want to see the description again, you may just type LOOK (L for short). [paragraph break]When you want to leave a location and go to another one, you may communicate this to the game using compass directions: eg, GO NORTH. For simplicity's sake, you are allowed to omit the word GO, and to abbreviate the compass directions. So you may use NORTH, SOUTH, EAST, WEST, UP, and DOWN, or in short form N, S, E, W, U, and D (seasoned IF players will note that diagonal directions such as NORTHEAST have been omited from this game).[paragraph break]In some locations, IN and OUT will also be useful."
	
To say other-verbs:
	say "You've already seen that you can type LOOK/L to look around; EXAMINE/X to look closer at the things you see; INVENTORY/I to examine the things you're holding and wearing; and any cardinal direction, plus UP and DOWN (and their respective first letters), to move around in the world. You'll be delighted to know that that's far from all you're able to do. Among your other options are:
	
	Using your other four senses. Don't limit yourself to looking[unicode 8212]you can also try to LISTEN to, SMELL, TASTE, and TOUCH things. [line break]Certain things are large enough that you might try to get IN or ON them (and then OUT or OFF of them again). [line break]Sometimes you may not want to drop something directly on the ground. If that's the case, you could try to PUT it ON a surface, or INSERT it INTO a container. [line break]Speaking of, you might be able to OPEN or CLOSE certain things. [line break]You may, at some point, find a device that you can SWITCH ON and then SWITCH OFF again.
	
	There are other, less common, actions available to you. When the time is right, you could try to ATTACK things, CLIMB things, LOOK UNDER things, THROW things AT other things, or WAVE things.
	
	This list might look overwhelming, but in the moment think of what makes sense to do[unicode 8212]as a wise uncle once said, 'doors are for opening; buttons are for pushing; pie is for eating.'"
	
To say convo-info:
	say "Conversation is minimal in this game. If you're speaking with someone and a menu with numbered dialogue options appears onscreen, you'll need to enter one of the available numbers as a command in order to progress.
	
	If at a later point you want to tell or ask someone about something, you can do just that: TELL/ASK them ABOUT it. You can also SHOW something TO someone, if you're so inclined."
	
To say specific-commands:
	say "This game does use a few non-standard commands. Included in these are:
	
	Some things have words on them[unicode 8212]you may want to try to READ those things. [line break]Some other things you find might be a bit dirty. If you're so inclined and can find something to clean them in, you might try to WASH them WITH it. [line break]You can return to these menus at any time by typing ABOUT.

You may encounter some situations over the course of the game where other commands may be available or required[unicode 8212]pay attention to verbs, and especially to verbs in CAPITAL LETTERS. Seasoned players of IF may even find some easter eggs."
	
To say controlling-game:
	say "There are a few simple commands for controlling the game itself. These are: [paragraph break]SAVE saves a snapshot of the game as it is now. [line break]RESTORE puts the game back to a previous saved state. You may keep as many saved games as you like. [line break]RESTART puts the game back to the way it was at the beginning. [line break]QUIT ends the game."

To say full-credits: 
	say "[italic type]You May Not Escape![roman type] was conceptualized, written, and programmed by Charm Cochran.

	The cover art was created by Charm Cochran. It includes an edited version of a photo by Rayson Tan, which is licensed under the Unsplash License.

	'The Tramp' is from [italic type]Songs of the Workers[roman type] by Joe Hill, which is in the public domain.

	Special thanks to the people who put up with the author's incessant requests for beta testing (and who deserve a good chunk of the credit and none of the blame): Julia Byrne, Maggie Higginbotham, Nick Harvey, Tess Oberholtzer, and Tommy Sullivan-Lovett.

	Extra special thanks to Graham Nelson for Inform 7, and to Aaron Reed, Andrew Plotkin, Emily Short, Eric Eve, Jon Ingold, Juhana Leinonen, and Michael Martin for their extensions.
	
	Additional thanks to Emily Short for the original introductive text to interactive fiction as included in her Basic Help Menu extension, which has been adapted for this game's help menu."

[This story uses the following extensions: [line break]Extended Grammar v8/140501 and Numbered Disambiguation Choices v7/140501 by Aaron Reed; 
[line break]Disappearing Doors v1 by Andrew Plotkin; 
[line break]Assorted Text Generation v5/150410, Basic Help Menu v1, Basic Screen Effects v7/140425, Complex Listing v9, Glulx Text Effects v5/140516, Menus v3, Modified Exit v6, and Punctuation Removal v5 by Emily Short; 
[line break]Alternatives v3/150410, Epistemology v9, and Exit Lister v11 by Eric Eve; 
[line break]Far Away v5/160517 by Jon Ingold; 
[line break]and Reactable Quips v10 by Michael Martin.

Additionally, the following extensions were used during testing, but aren't included in the final release: [line break]Response Assistant v1 by Aaron Reed; [line break]and Object Response Tests v7 by Juhana Leinonen.]

To say found-bug:
	say "If you found a bug, or you'd just like to tell me about your experience with [italic type]You May Not Escape![roman type], you can email me at charmwritesthings@gmail.com, or find me on Twitter @Over__Thinkings (that's with two underscores)."
		
Volume 2 - The bones

Part 1 - Row 1

Room1-1 is a room.

Room1-2 is a room.

11-12passage is east of Room1-1 and west of Room1-2. 11-12passage is a door.
The absent-seeds of 11-12passage are { 8, 16 }.

Room1-3 is a room.

12-13passage is east of Room1-2 and west of Room1-3. 12-13passage is a door.
The absent-seeds of 12-13passage are { 3, 4, 5, 7, 9, 12, 13, 15 }.

Room1-4 is a room.

13-14passage is east of Room1-3 and west of Room1-4. 13-14passage is a door.
The absent-seeds of 13-14passage are { 2, 4, 10, 12, 13, 14, 16 }.

Room1-5 is a room.

14-15passage is east of Room1-4 and west of Room1-5. 14-15passage is a door.
The absent-seeds of 14-15passage are { 3, 8 }.

Room1-6 is a room.

15-16passage is east of Room1-5 and west of Room1-6. 15-16passage is a door.
The absent-seeds of 15-16passage are { 1, 11, 16 }.

Room1-7 is a room.

16-17passage is east of Room1-6 and west of Room1-7. 16-17passage is a door.
The absent-seeds of 16-17passage are { 4, 10, 12, 15 }.

Part 2 - Row 2

Room2-1 is a room.

11-21passage is south of Room1-1 and north of Room2-1. 11-21passage is a door.
The absent-seeds of 11-21passage are { 12, 13 }.

Room2-2 is a room.

12-22passage is south of Room1-2 and north of Room2-2. 12-22passage is a door.
The absent-seeds of 12-22passage are { 1, 2, 3, 6, 10, 14, 15 }.

21-22passage is east of Room2-1 and west of Room2-2. 21-22passage is a door.
The absent-seeds of 21-22passage are { 3, 4, 5, 7, 9, 11 }.

Room2-3 is a room. "The endless hallways widen slightly here into something resembling a room[walls-damaged]."

13-23passage is south of Room1-3 and north of Room2-3. 13-23passage is a door.
The absent-seeds of 13-23passage are { 1, 5, 6, 8, 9, 11, 14 }.

22-23passage is east of Room2-2 and west of Room2-3. 22-23passage is a door.
The absent-seeds of 22-23passage are { 1, 2, 5, 6, 7, 9, 10, 12, 13, 14, 15, 16 }.

Room2-4 is a room.

14-24passage is south of Room1-4 and north of Room2-4. 14-24passage is a door.
The absent-seeds of 14-24passage are { 1, 6, 7, 9, 11, 14, 15 }.

23-24passage is east of Room2-3 and west of Room2-4. 23-24passage is a door.
The absent-seeds of 23-24passage are { 3, 4, 8, 10, 11, 12, 16 }.

Room2-5 is a room.

15-25passage is south of Room1-5 and north of Room2-5. 15-25passage is a door.
The absent-seeds of 15-25passage are { 2, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15 }.

24-25passage is east of Room2-4 and west of Room2-5. 24-25passage is a door.
The absent-seeds of 24-25passage are { 1, 2, 3, 4, 6, 8, 10, 12, 16 }.

Room2-6 is a room.

16-26passage is south of Room1-6 and north of Room2-6. 16-26passage is a door.
The absent-seeds of 16-26passage are { 2, 3, 5, 6, 7, 8, 13 }.

25-26passage is east of Room2-5 and west of Room2-6. 25-26passage is a door.
The absent-seeds of 25-26passage are { 3, 4, 5, 10, 11, 12, 14, 15 }.

Room2-7 is a room.

17-27passage is south of Room1-7 and north of Room2-7. 17-27passage is a door.
The absent-seeds of 17-27passage are { 9, 11 }.

26-27passage is east of Room2-6 and west of Room2-7. 26-27passage is a door.
The absent-seeds of 26-27passage are { 1, 2, 3, 4, 7, 8, 12, 13, 14, 16 }.

Part 3 - Row 3

Room3-1 is a room.

21-31passage is south of Room2-1 and north of Room3-1. 21-31passage is a door.
The absent-seeds of 21-31passage are { 1, 2, 4, 6, 7, 9, 11, 14, 15, 16 }.

Room3-2 is a room.

22-32passage is south of Room2-2 and north of Room3-2. 22-32passage is a door.
The absent-seeds of 22-32passage are { 1, 2, 8, 11, 12, 13, 16 }.

31-32passage is east of Room3-1 and west of Room3-2. 31-32passage is a door.
The absent-seeds of 31-32passage are { 3, 5, 6, 7, 8, 10, 13, 14 }.

Room3-3 is a room.

23-33passage is south of Room2-3 and north of Room3-3. 23-33passage is a door.
The absent-seeds of 23-33passage are { 2, 3, 7, 13, 14, 15 }.

32-33passage is east of Room3-2 and west of Room3-3. 32-33passage is a door.
The absent-seeds of 32-33passage are { 3, 4, 10, 12, 15 }.

Room3-4 is a room.

24-34passage is south of Room2-4 and north of Room3-4. 24-34passage is a door.
The absent-seeds of 24-34passage are { 5, 7, 9, 13, 14 }.

33-34passage is east of Room3-3 and west of Room3-4. 33-34passage is a door.
The absent-seeds of 33-34passage are { 1, 2, 5, 6, 8, 9, 10, 11, 12, 16 }.

Room3-5 is a room.

25-35passage is south of Room2-5 and north of Room3-5. 25-35passage is a door.
The absent-seeds of 25-35passage are { 1, 7, 9, 11, 13 }.

34-35passage is east of Room3-4 and west of Room3-5. 34-35passage is a door.
The absent-seeds of 34-35passage are { 2, 3, 5, 6, 11, 13, 15, 16 }.

Room3-6 is a room.

26-36passage is south of Room2-6 and north of Room3-6. 26-36passage is a door.
The absent-seeds of 26-36passage are { 6, 9, 10, 15 }.

35-36passage is east of Room3-5 and west of Room3-6. 35-36passage is a door.
The absent-seeds of 35-36passage are { 1, 2, 3, 4, 5, 6, 8, 10, 12, 14, 16 }.

Room3-7 is a room.

27-37passage is south of Room2-7 and north of Room3-7. 27-37passage is a door.
The absent-seeds of 27-37passage are { 5, 6, 10, 15 }.

36-37passage is east of Room3-6 and west of Room3-7. 36-37passage is a door.
The absent-seeds of 36-37passage are { 1, 3, 7, 8, 9, 11, 13, 14 }.

Part 4 - Row 4

Room4-1 is a room.

31-41passage is south of Room3-1 and north of Room4-1. 31-41passage is a door.
The absent-seeds of 31-41passage are { 8, 12 }.

Room4-2 is a room.

32-42passage is south of Room3-2 and north of Room4-2. 32-42passage is a door.
The absent-seeds of 32-42passage are { 1, 2, 4, 5, 6, 9, 11, 14, 15 }.

41-42passage is east of Room4-1 and west of Room4-2. 41-42passage is a door.
The absent-seeds of 41-42passage are { 1, 2, 9, 10, 13, 14, 15, 16 }.

Room4-3 is a room.

33-43passage is south of Room3-3 and north of Room4-3. 33-43passage is a door.
The absent-seeds of 33-43passage are { 1, 4, 5, 6, 7, 8, 9, 11, 13, 14 }.

42-43passage is east of Room4-2 and west of Room4-3. 42-43passage is a door.
The absent-seeds of 42-43passage are { 3, 5, 6, 7, 8, 10, 11, 13, 16 }.

Room4-4 is a room.

34-44passage is south of Room3-4 and north of Room4-4. 34-44passage is a door.
The absent-seeds of 34-44passage are { 3, 4, 6, 7, 15, 16 }.

43-44passage is east of Room4-3 and west of Room4-4. 43-44passage is a door.
The absent-seeds of 43-44passage are { 1, 2, 3, 8, 10, 12, 13, 14, 15, 16 }.

Room4-5 is a room.

35-45passage is south of Room3-5 and north of Room4-5. 35-45passage is a door.
The absent-seeds of 35-45passage are { 4, 8, 9, 10, 11, 12, 15, 16 }.

44-45passage is east of Room4-4 and west of Room4-5. 44-45passage is a door.
The absent-seeds of 44-45passage are { 1, 2, 5, 7, 8, 9, 11, 14 }.

Room4-6 is a room.

36-46passage is south of Room3-6 and north of Room4-6. 36-46passage is a door.
The absent-seeds of 36-46passage are { 2, 4, 5, 6, 9, 12, 13, 14, 15 }.

45-46passage is east of Room4-5 and west of Room4-6. 45-46passage is a door.
The absent-seeds of 45-46passage are { 1, 3, 5, 7, 8, 10, 12, 13, 14, 15 }.

Room4-7 is a room.

37-47passage is south of Room3-7 and north of Room4-7. 37-47passage is a door.
The absent-seeds of 37-47passage are { 1, 4, 7, 10, 12, 13 }.

46-47passage is east of Room4-6 and west of Room4-7. 46-47passage is a door.
The absent-seeds of 46-47passage are { 2, 6, 11, 16 }.

Part 5 - Row 5

Room5-1 is a room. The printed name is "[if number of visited rooms > 1]Back where you began[otherwise]The beginning[end if]".
The description is "[if number of visited rooms > 1]This is the spot where you first found yourself in the maze[otherwise]You find yourself standing [ident-preface] a [ident][end if]. Dirt floor below, open sky above, high concrete walls to either side[walls-damaged]." The player is in Room5-1.

To say ident-preface:
	let room-ident be "[room-identity]";
	if room-ident matches the text "hallway", say "in";
	otherwise say "at".

To say ident:
	let room-ident be "[room-identity]";
	say "[unpunctuated word number 2 in room-ident][if the number of words in room-ident > 2] end[end if]"

41-51passage is south of Room4-1 and north of Room5-1. 41-51passage is a door.
The absent-seeds of 41-51passage are { 1, 4, 5, 6, 10, 11 }.

Room5-2 is a room.

42-52passage is south of Room4-2 and north of Room5-2. 42-52passage is a door.
The absent-seeds of 42-52passage are { 3, 7, 8, 12 }.

51-52passage is east of Room5-1 and west of Room5-2. 51-52passage is a door.
The absent-seeds of 51-52passage are { 1, 2, 3, 4, 7, 8, 11, 16 }.

Room5-3 is a room.

43-53passage is south of Room4-3 and north of Room5-3. 43-53passage is a door.
The absent-seeds of 43-53passage are { 2, 4, 9, 10, 11, 12 }.

52-53passage is east of Room5-2 and west of Room5-3. 52-53passage is a door.
The absent-seeds of 52-53passage are { 1, 2, 3, 5, 6, 10, 11, 12, 13, 14, 15, 16 }.

Room5-4 is a room.

44-54passage is south of Room4-4 and north of Room5-4. 44-54passage is a door.
The absent-seeds of 44-54passage are { 4, 6, 9, 10, 11, 12, 13, 15, 16 }.

53-54passage is east of Room5-3 and west of Room5-4. 53-54passage is a door.
The absent-seeds of 53-54passage are { 1, 3, 4, 5, 7, 8, 16 }.

Room5-5 is a room.

45-55passage is south of Room4-5 and north of Room5-5. 45-55passage is a door.
The absent-seeds of 45-55passage are { 1, 2, 3, 6, 7, 16 }.

54-55passage is east of Room5-4 and west of Room5-5. 54-55passage is a door.
The absent-seeds of 54-55passage are { 5, 6, 9, 10, 11, 12, 14 }.

Room5-6 is a room.

46-56passage is south of Room4-6 and north of Room5-6. 46-56passage is a door.
The absent-seeds of 46-56passage are { 1, 4, 5, 7, 8, 9, 11, 12 }.

55-56passage is east of Room5-5 and west of Room5-6. 55-56passage is a door.
The absent-seeds of 55-56passage are { 2, 3, 4, 13, 14, 15 }.

Room5-7 is a room.

47-57passage is south of Room4-7 and north of Room5-7. 47-57passage is a door.
The absent-seeds of 47-57passage are { 3, 5, 9, 15, 16 }.

56-57passage is east of Room5-6 and west of Room5-7. 56-57passage is a door.
The absent-seeds of 56-57passage are { 2, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 16 }.

Part 6 - Row 6

Room6-1 is a room.

51-61passage is south of Room5-1 and north of Room6-1. 51-61passage is a door.
The absent-seeds of 51-61passage are { 2, 3, 12 }.

Room6-2 is a room.

52-62passage is south of Room5-2 and north of Room6-2. 52-62passage is a door.
The absent-seeds of 52-62passage are { 4, 5, 6, 9, 10, 13, 14, 15 }.

61-62passage is east of Room6-1 and west of Room6-2. 61-62passage is a door.
The absent-seeds of 61-62passage are { 1, 3, 5, 6, 7, 9, 10, 11, 15, 16 }.

Room6-3 is a room.

53-63passage is south of Room5-3 and north of Room6-3. 53-63passage is a door.
The absent-seeds of 53-63passage are { 4, 6, 7, 8, 9, 13, 15, 16 }.

62-63passage is east of Room6-2 and west of Room6-3. 62-63passage is a door.
The absent-seeds of 62-63passage are { 1, 2, 4, 8, 11, 14 }.

Room6-4 is a room.

54-64passage is south of Room5-4 and north of Room6-4. 54-64passage is a door.
The absent-seeds of 54-64passage are { 1, 2, 5, 7, 8, 13, 14, 15 }.

63-64passage is east of Room6-3 and west of Room6-4. 63-64passage is a door.
The absent-seeds of 63-64passage are { 5, 10, 11, 12, 16 }.

Room6-5 is a room. "The endless hallways widen slightly here into something resembling a room. [tree-condition][walls-damaged]."

55-65passage is south of Room5-5 and north of Room6-5. 55-65passage is a door.
The absent-seeds of 55-65passage are { 1, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13 }.

64-65passage is east of Room6-4 and west of Room6-5. 64-65passage is a door.
The absent-seeds of 64-65passage are { 2, 3, 6, 8, 9, 13, 14, 15, 16 }.

Room6-6 is a room.

56-66passage is south of Room5-6 and north of Room6-6. 56-66passage is a door.
The absent-seeds of 56-66passage are { 1, 2, 6, 10, 11, 12, 15, 16 }.

65-66passage is east of Room6-5 and west of Room6-6. 65-66passage is a door.
The absent-seeds of 65-66passage are { 1, 4, 7, 8, 9, 10 }.

Room6-7 is a room.

57-67passage is south of Room5-7 and north of Room6-7. 57-67passage is a door.
The absent-seeds of 57-67passage are { 8, 13, 15 }.

66-67passage is east of Room6-6 and west of Room6-7. 66-67passage is a door.
The absent-seeds of 66-67passage are { 1, 3, 4, 7, 9, 13, 14, 16 }.

Part 7 - Row 7

Room7-1 is a room.

61-71passage is south of Room6-1 and north of Room7-1. 61-71passage is a door.
The absent-seeds of 61-71passage are { 4, 8, 14 }.

Room7-2 is a room.

62-72passage is south of Room6-2 and north of Room7-2. 62-72passage is a door.
The absent-seeds of 62-72passage are { 5, 7, 9, 12, 13, 14, 16 }.

71-72passage is east of Room7-1 and west of Room7-2. 71-72passage is a door.
The absent-seeds of 71-72passage are { 2, 5, 6, 8, 9, 10, 11, 13, 15 }.

Room7-3 is a room.

63-73passage is south of Room6-3 and north of Room7-3. 63-73passage is a door.
The absent-seeds of 63-73passage are { 1, 2, 3, 6, 7, 9, 10, 12, 13, 14, 15 }.

72-73passage is east of Room7-2 and west of Room7-3. 72-73passage is a door.
The absent-seeds of 72-73passage are { 1, 4, 6, 8, 10, 11, 14, 16 }.

Room7-4 is a room.

64-74passage is south of Room6-4 and north of Room7-4. 64-74passage is a door.
The absent-seeds of 64-74passage are { 3, 4, 6, 7, 10, 11, 12 }.

73-74passage is east of Room7-3 and west of Room7-4. 73-74passage is a door.
The absent-seeds of 73-74passage are { 2, 3, 5, 7, 8, 12, 13, 15 }.

Room7-5 is a room.

65-75passage is south of Room6-5 and north of Room7-5. 65-75passage is a door.
The absent-seeds of 65-75passage are { 2, 4, 5, 11, 12, 16 }.

74-75passage is east of Room7-4 and west of Room7-5. 74-75passage is a door.
The absent-seeds of 74-75passage are { 1, 3, 5, 9, 11, 13, 14, 15, 16 }.

Room7-6 is a room.

66-76passage is south of Room6-6 and north of Room7-6. 66-76passage is a door.
The absent-seeds of 66-76passage are { 2, 3, 5, 6, 7, 8, 12, 13, 14, 15 }.

75-76passage is east of Room7-5 and west of Room7-6. 75-76passage is a door.
The absent-seeds of 75-76passage are { 1, 2, 3, 4, 6, 7 }.

Room7-7 is a room.

67-77passage is south of Room6-7 and north of Room7-7. 67-77passage is a door.
The absent-seeds of 67-77passage are { 2, 3, 5, 10, 11, 12 }.

76-77passage is east of Room7-6 and west of Room7-7. 76-77passage is a door.
The absent-seeds of 76-77passage are { 1, 5, 8, 9, 11, 12, 13, 14, 15, 16 }.

Part 8 - Row 8

Room8-1 is a room.

71-81passage is south of Room7-1 and north of Room8-1. 71-81passage is a door.
The absent-seeds of 71-81passage are { 1, 3, 7, 9, 12, 16 }.

Room8-2 is a room. "The endless hallways widen slightly here into something resembling a room[walls-damaged]."

72-82passage is south of Room7-2 and north of Room8-2. 72-82passage is a door.
The absent-seeds of 72-82passage are { 1, 2, 3, 4, 7, 10, 12, 15 }.

81-82passage is east of Room8-1 and west of Room8-2. 81-82passage is a door.
The absent-seeds of 81-82passage are { 1, 2, 5, 8, 9, 14, 15 }.

Room8-3 is a room.

73-83passage is south of Room7-3 and north of Room8-3. 73-83passage is a door.
The absent-seeds of 73-83passage are { 4, 5, 6, 9, 11, 13, 15, 16 }.

82-83passage is east of Room8-2 and west of Room8-3. 82-83passage is a door.
The absent-seeds of 82-83passage are { 3, 4, 7, 8, 9, 11, 12, 13, 14, 16 }.

Room8-4 is a room.

74-84passage is south of Room7-4 and north of Room8-4. 74-84passage is a door.
The absent-seeds of 74-84passage are { 1, 2, 4, 6, 8, 9, 11, 14 }.

83-84passage is east of Room8-3 and west of Room8-4. 83-84passage is a door.
The absent-seeds of 83-84passage are { 1, 2, 6, 7, 8, 10 }.

Room8-5 is a room.

75-85passage is south of Room7-5 and north of Room8-5. 75-85passage is a door.
The absent-seeds of 75-85passage are { 6, 7, 8, 9, 10, 13, 15 }.

84-85passage is east of Room8-4 and west of Room8-5. 84-85passage is a door.
The absent-seeds of 84-85passage are { 3, 4, 5, 6, 7, 10, 12, 14, 16 }.

Room8-6 is a room.

76-86passage is south of Room7-6 and north of Room8-6. 76-86passage is a door.
The absent-seeds of 76-86passage are { 6, 8, 9, 10, 15, 16 }.

85-86passage is east of Room8-5 and west of Room8-6. 85-86passage is a door.
The absent-seeds of 85-86passage are { 2, 4, 5, 9, 11, 12, 13, 14, 15 }.

Room8-7 is a room.

77-87passage is south of Room7-7 and north of Room8-7. 77-87passage is a door.
The absent-seeds of 77-87passage are { 4, 6, 7, 14, 15 }.

86-87passage is east of Room8-6 and west of Room8-7. 86-87passage is a door.
The absent-seeds of 86-87passage are { 1, 2, 3, 4, 5, 8, 9, 11, 12, 16 }.

Part 9 - Row 9

Room9-1 is a room.

81-91passage is south of Room8-1 and north of Room9-1. 81-91passage is a door.
The absent-seeds of 81-91passage are { 4, 6, 10, 13 }.

Room9-2 is a room.

82-92passage is south of Room8-2 and north of Room9-2. 82-92passage is a door.
The absent-seeds of 82-92passage are { 5, 6, 7, 10, 11, 12, 13, 14, 16 }.

91-92passage is east of Room9-1 and west of Room9-2. 91-92passage is a door.
The absent-seeds of 91-92passage are { 2, 3 }.

Room9-3 is a room.

83-93passage is south of Room8-3 and north of Room9-3. 83-93passage is a door.
The absent-seeds of 83-93passage are { 2, 3, 4, 5, 10, 14, 15 }.

92-93passage is east of Room9-2 and west of Room9-3. 92-93passage is a door.
The absent-seeds of 92-93passage are { 1, 8, 15, 16 }.

Room9-4 is a room.

84-94passage is south of Room8-4 and north of Room9-4. 84-94passage is a door.
The absent-seeds of 84-94passage are { 3, 5, 11, 12, 13, 16 }.

93-94passage is east of Room9-3 and west of Room9-4. 93-94passage is a door.
The absent-seeds of 93-94passage are { 1, 7, 9, 11, 12 }.

Room9-5 is a room.

85-95passage is south of Room8-5 and north of Room9-5. 85-95passage is a door.
The absent-seeds of 85-95passage are { 1, 2, 3, 7, 8, 12, 13 }.

94-95passage is east of Room9-4 and west of Room9-5. 94-95passage is a door.
The absent-seeds of 94-95passage are { 9, 10, 14, 15, 16 }.

Room9-6 is a room.

86-96passage is south of Room8-6 and north of Room9-6. 86-96passage is a door.
The absent-seeds of 86-96passage are { 1, 2, 3, 6, 7, 10, 11, 13, 14, 16 }.

95-96passage is east of Room9-5 and west of Room9-6. 95-96passage is a door.
The absent-seeds of 95-96passage are { 4, 5, 6, 8, 14 }.

Room9-7 is a room.

87-97passage is south of Room8-7 and north of Room9-7. 87-97passage is a door.
The absent-seeds of 87-97passage are { 10 }.

96-97passage is east of Room9-6 and west of Room9-7. 96-97passage is a door.
The absent-seeds of 96-97passage are { 15 }.

Part 10 - Other places

Chapter 2 - Elsewhere

Elsewhere is a room. The printed name of Elsewhere is "".

The Escape0 is a gate out. It is east of Room3-7 and northwest of Elsewhere.
The absent-seeds of Escape0 are { 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16 }.

The Escape1 is east of Room4-7 and west of Elsewhere. Escape1 is a gate out.
The absent-seeds of Escape1 are { 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 16 }.

The Escape2 is east of Room5-7 and north of Elsewhere. Escape2 is a gate out.
The absent-seeds of Escape2 are { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15, 16 }.

The Escape3 is east of Room6-7 and below Elsewhere. Escape3 is a gate out.
The absent-seeds of Escape3 are { 1, 2, 3, 4, 5, 7, 8, 10, 11, 12, 14, 15, 16 }.

The Escape4 is east of Room7-7 and south of Elsewhere. Escape4 is a gate out.
The absent-seeds of Escape4 are { 1, 3, 4, 5, 6, 7, 9, 10, 11, 13, 14, 16 }.

The Escape5 is a gate out. It is east of Room8-7 and above Elsewhere.
The absent-seeds of Escape5 are { 2, 6, 7, 8, 9, 10, 11, 12, 13, 15 }.

Chapter 3 - The ends

Section 1 - Making it to Elsewhere

Every turn (this is the escape ending rule):
	if the player is in Elsewhere:
		silently try exitstopping;
		clear the screen;
		say "You [exit-desc] and find yourself outside of the maze.
		
		[italic type](Press any key to continue)[roman type][paragraph break]";
		wait for any key;
		say "[if It Drizzles has happened]The rain stops as abruptly as it began. The clouds roll away to reveal a blue sky.[paragraph break][end if]A light breeze ruffles your hair as you take a deep breath. [paragraph break]";
		wait for any key;
		say "You escaped, and you did it on your own. You survived the maze. You know there may be further mazes in the future, but for now[unicode 8230] for now, you can rest.[paragraph break]";
		wait for any key;
		end the story finally saying "You have escaped this maze."
		
To say exit-desc: say "squeeze through the hole you made in the gate";
	
Table of Final Question Options (continued)
final question wording	only if victorious	topic		final response rule		final response activity
"See your STATS"	false	"stats"		see the stats rule		--
	
This is the see the stats rule: say "STATISTICAL ANALYSIS OF THE OCCUPANT OF MAZE #[maze-num]:[line break]
Turns taken: [turn count][line break]
Artifacts found: [number of familiar artifacts]/4[line break]
Cameras broken: [number of busted security cameras]/4[line break]
Souls laid to rest: [rest-count]/4[line break]
Found the time capsule: [if the time capsule has been carried]yes[otherwise]no[end if][line break]
Found a sacred space: [if a treehouse is visited]yes[otherwise]no[end if][line break]
Escaped the maze: [if Elsewhere is visited]yes[otherwise]no[end if][line break]
Forged your own path: [if the gate out is busted]yes[otherwise]no[end if][paragraph break]".

To say digit1: say "[one of]1[or]2[or]3[or]4[or]5[or]6[or]7[or]8[or]9[sticky random]".
To say digit2: say "[one of]0[or]1[or]2[or]3[or]4[or]5[or]6[or]7[or]8[or]9[sticky random]".
To say digit3: say "[one of]0[or]1[or]2[or]3[or]4[or]5[or]6[or]7[or]8[or]9[sticky random]".
To say digit4: say "[one of]0[or]1[or]2[or]3[or]4[or]5[or]6[or]7[or]8[or]9[sticky random]".

To say maze-num: say "[digit1][digit2][digit3][digit4]-[if map-seed < 10]0[end if][map-seed]".

Section 2 - Make your own end
	
Requesting an ending is an action out of world. Understand "end" as requesting an ending.

Carry out requesting an ending (this is the standard request an end rule):
	say "Is this the end? > [run paragraph on]";
	if the player consents:
		clear the screen;
		say "It's all too much. You've done enough.
		
		[italic type](Press any key to continue)[roman type][paragraph break]";
		wait for any key;
		say "You're tired[unicode 8212]bone weary. [unless the aviator jacket is dry]Your clothes are soaked through and heavy. [end unless]You just need to lie down. [paragraph break]";
		wait for any key;
		say "And so you do. You lie down right in the [ident]. And there you stay. [paragraph break]";
		end the story saying "You succumbed to the maze.";
	otherwise:
		if the gate out is familiar and the sledgehammer is nowhere:
			now the sledgehammer is in Room5-1;
		say "No. It's not time yet. Perhaps there's still a way out of this. [paragraph break]If you decide there isn't, though, you can type END at any time."

Volume 3 - The Flesh

Book 1 - Things

[-	-	-	-	-	-	-
-	-	-	-	25	26	-
-	-	33	34	-	-	-
41	42	-	-	-	46	-
-	-	53	-	55	-	57
-	62	-	64	-	-	-
-	-	73	-	75	-	77
-	-	-	84	-	86	-
-	92	93	-	-	-	-
NOTE: Looking at it in 2024, I'm not 100% certain what the numbers that are left here represent, but I suspect they're the rooms that don't contain any special features at the start of the game.]

Part 1 - John Everyman

Chapter 1 - The man

John Everyman is a man in Room5-1. "A well-dressed man who looks to be in his seventies stands idly near a wall[first time]. He seems to be drowsing[only]." Understand "John" or "Everyman" or "politician/politic/politics" or "helper" or "your" or "designated" or "every" or "Johnny/Joe" as "[John]". Understand "[John]" or "hair" or "well/groomed/well-groomed" or " shaved/shaven" or "march" or "assistant/assistive" or "complulsor" or "rep/representative" or "man" as John Everyman.
The description of John Everyman is "He's tall, white, and getting on in years. He's well-dressed, in a suit jacket, dress slacks, and a starched white shirt. His hair is well-groomed and his face is shaved. He has an air of someone who [italic type]always[roman type] knows better."

Instead of attacking or burning or cutting John Everyman: say "You're not particularly interested in facing assault charges today."

Instead of attacking John Everyman with the sledgehammer: say "You're not particularly interested in facing assault charges today."
	
Instead of smelling John Everyman: say "You think that might be uncouth."
	
Instead of giving or showing something to John Everyman:
	if the noun is dirtied:
		say "He looks vaguely disgusted.";
	otherwise if the noun is the aviator jacket:
		say "That's your jacket! You're not particularly interested in risking losing it.";
	otherwise if the noun is either the white tee shirt or the cutoff shorts:
		say "You're likely to be on camera at some point during your time in the maze, and you're not particularly interested in giving a show to whoever's watching. Besides, it seems inappropriate to take [the noun] off in front of Everyman in person, regardless.";
	otherwise if the noun is an artifact:
		say "You have a feeling deep in your gut that that would be a very, very bad idea.";
	otherwise if the noun is the sledgehammer:
		say "You fear he'd take that as a threat.";
	otherwise:
		say "He seems entirely uninterested."

Instead of listening to John Everyman: say "He doesn't seem inclined to initiate conversation[unicode 8212]you'll need to ASK or TELL him about something."

Instead of throwing something at John Everyman: say "You're not particularly interested in facing assault charges today."
	
Instead of touching or rubbing John Everyman: say "You're not particularly interested in facing assault charges today. You're not interested, anyway."
	
Instead of tying something to John Everyman: say "You're not particularly interested in facing assault charges today."

Chapter 2 - His clothing and possessions

Section 1 - Suit jacket

John Everyman wears a suit jacket. Understand "blazer" or "coat" or "grey/gray/blue" or "subtle" or "glen/glens" or "check" or "pattern/patterning" or "thread" or "plaid/gingham/criss/cross/crisscross" or "expensive" or "looking" or "exceprional/exceptionally" or "well/tailored/welltailored/well-tailored" as the suit jacket.
The description of the suit jacket is "[if the pair of slacks has been examined]Like the slacks, it's expensive-looking and gray,[otherwise]It's an expensive-looking gray suit jacket[end if] with subtle glen check patterning in blue thread. It is exceptionally well-tailored."
The maximum saturation of the suit jacket is 15.

Instead of attacking or burning or cutting the suit jacket: say "You're not particularly interested in facing assault charges today."

Instead of attacking the suit jacket with the sledgehammer: say "You're not particularly interested in facing assault charges today."

Instead of consulting the suit jacket about: try examining the noun.
	
Instead of looking under or opening or taking or wearing or taking off the suit jacket: say "You think that might be uncouth. You're not particularly interested in what's underneath, anyway."
	
Instead of smelling the suit jacket: say "You think that might be uncouth."
	
Instead of removing the suit jacket from: say "You think that might be uncouth. You're not particularly interested in what's underneath, anyway."

Instead of throwing something at the suit jacket: say "You're not particularly interested in facing assault charges today."
	
Instead of touching or rubbing the suit jacket: say "You think that might be uncouth. It looks well-made and heavy."

Section 2 - Slacks

John Everyman wears a pair of slacks. Understand "pants" or "grey/gray/blue" or "bottoms" or "subtle" or "glen/glens" or "check" or "pattern/patterning" or "thread" or "plaid/gingham/criss/cross/crisscross" or "expensive" or "looking" or "exceprional/exceptionally" or "well/tailored/welltailored/well-tailored" as the pair of slacks.
The description of the pair of slacks is "[if the suit jacket has been examined]Like the suit jacket, they're expensive looking and gray,[otherwise]They're expensive-looking gray formal slacks[end if] with subtle glen check patterning in blue thread. They are exceptionally well-tailored."
The maximum saturation of the slacks is 15.

Instead of attacking or burning or cutting the pair of slacks: say "You're not particularly interested in facing assault charges today."

Instead of attacking the pair of slacks with the sledgehammer: say "You're not particularly interested in facing assault charges today."

Instead of consulting the pair of slacks about: try examining the noun.
	
Instead of looking under or opening or taking or wearing or taking off the pair of slacks: say "You think that might be uncouth. You're not particularly interested in what's underneath, anyway."
	
Instead of smelling the pair of slacks: say "You think that might be uncouth."
	
Instead of removing the pair of slacks from: say "You think that might be uncouth. You're not particularly interested in what's underneath, anyway."
	
Instead of throwing something at the pair of slacks: say "You're not particularly interested in facing assault charges today."
	
Instead of touching or rubbing the pair of slacks: say "You think that might be uncouth. They look stiff and well-pressed."

Section 3 - Starched shirt

John Everyman wears a starched shirt. Understand "stiff" or "white" or "starch" or "top" or "extreme/extremely" or "formal" or "uncomfortable" or "dress" or "bright" as the starched shirt.
The description of the starched shirt is "It's a starched white dress shirt. It looks extremely stiff, extremely formal, and extremely uncomfortable."
The maximum saturation of the starched shirt is 15.

Instead of attacking or burning or cutting the starched shirt: say "You're not particularly interested in facing assault charges today."

Instead of attacking the starched shirt with the sledgehammer: say "You're not particularly interested in facing assault charges today."

Instead of consulting the starched shirt about: try examining the noun.
	
Instead of looking under or opening or taking or wearing or taking off the starched shirt: say "You think that might be uncouth. You're not particularly interested in what's underneath, anyway."
	
Instead of smelling the starched shirt: say "You think that might be uncouth."
	
Instead of removing the starched shirt from: say "You think that might be uncouth. You're not particularly interested in what's underneath, anyway."
	
Instead of throwing something at the starched shirt: say "You're not particularly interested in facing assault charges today."
	
Instead of touching or rubbing the starched shirt: say "You think that might be uncouth. It looks stiff and uncomfortable."

Section 4 - Cell phone

John Everyman carries a cell phone. Understand "cellular" or "state/of/the/art" or "smartphone/smart" or "cellphone" or "thin" or "rectangle/rectangular" or "touch" or "screen" or "black" or "case/casing" or "home" or "background" or "screen" or "family" or "photo" as the cell phone.
The description of the cell phone is "It's a state-of-the-art smart phone, very thin and very rectangular, with a touch screen and a black case. The home screen looks to be an Everyman family photo."
The maximum saturation of the cell phone is 3.

Instead of attacking or burning or cutting the cell phone: say "You're not particularly interested in facing assault charges today."

Instead of attacking the cell phone with the sledgehammer: say "You're not particularly interested in facing assault charges today."

Instead of consulting the cell phone about: try examining the noun.
	
Instead of listening to the cell phone:
	if the time of day < 9:48 AM:
		say "It's not in the process of making a call, so there's not much to hear.";
	otherwise:
		say "It's impolite to listen in on others' conversations. And given Everyman's standing, you doubt you'd get away with it."

Instead of taking the cell phone: say "It's not yours, and you're not particularly interested in facing theft charges today."
	
Instead of touching or rubbing the cell phone: say "You think that might be uncouth. Besides, you're not particularly interested in facing assault charges today[unicode 8212]and you just never know."

Rule for deciding the concealed possessions of John Everyman:
	if the particular possession is the cell phone:
		if the time of day < 9:48 AM:
			yes;
	otherwise:
		no.

Chapter 3 - John's Speil

Section 1 - Scene

Speil-complete is a truth state that varies. Speil-complete is false.

John's Speil is a scene. John's Speil begins when play begins. John's Speil ends when speil-complete is true.

Answering something that is verbal behavior. Asking something about is verbal behavior. Asking something for is verbal behavior. Consulting something about is verbal behavior. Saying no is verbal behavior. Saying sorry is verbal behavior. Saying yes is verbal behavior. Showing something to is verbal behavior. Telling something about is verbal behavior. Responding with is verbal behavior.
	
After doing something other than verbal behavior during John's Speil:
	if the location is Room5-1 and the pertinent quip is quip_null:
		if the turn count > 1, say "John Everyman waits patiently for you to ask him for help.";
	otherwise:
		continue the action.
		
Instead of going during John's Speil: say "The man in the suit suddenly springs to life with surprising alacrity."
		
When John's Speil begins: now the RQ reaction demand is "[if the current action is going]John doesn't seem inclined to let you escape until you've let him say his piece[otherwise]John Everyman waits patiently for you to ask him for help[end if]. [paragraph break][bracket]I need some kind of reaction from you to continue the scene.  Enter a number, or say REPEAT to reacquaint yourself with your options.[close bracket]".

When John's Speil ends: now the RQ reaction demand is "[bracket]I need some kind of reaction from you to continue the scene.  Enter a number, or say REPEAT to reacquaint yourself with your options.[close bracket]".
		
Section 2 - Quips and tables
		
A quip can be familiar or unfamiliar. A quip is usually unfamiliar.

For quipping:
	now the current quip is familiar;
	continue the activity.

At 9:00 AM: deliver the Hello Hello quip.

To say end speil: now speil-complete is true.
	
Table of Quip Texts (continued)
quip	quiptext
Hello Hello	"[hello-hello]"
What Be	"[what-is-this]"
What Be Two	"[what-is-this]"
Who You	"[who-you]"
Who You Two	"[who-you]"
Where We	"[where-we]"
Where We Two	"[where-we]"
Why This	"[why-happening]"
Why Me	"[why-me]"
What Do	"[what-do]"
How Many	"[how-many]"
Way Out	"[way-out]"
Did You Put	"[did-you-put]"
Can Help	"[can-help]"
So Alone	"[so-alone]"
Know Layout	"[know-layout]"
Why Won't	"[end speil][why-wont-you]"

Table of Quip Followups (continued)
quip	option	result
Hello Hello	"What is this?"	What Be
Hello Hello	"Who are you?"	Who You
Hello Hello	"Where are we?"	Where We
What Be	"Who are you?"	Who You Two
Where We	"Who are you?"	Who You Two
Who You	"What is this?"	What Be Two
Who You	"Where are we?"	Where We Two
Who You Two	"Why is this happening?"	Why This
Where We Two	"Why is this happening?"	Why This
What Be Two	"Why is this happening?"	Why This
Why This	"Why me?"	Why Me
Why This	"What do I do?"	What Do
Why Me	"How many have there been before me?"	How Many
What Do	"Is there a way out?"	Way Out
How Many	"Is there a way out?"	Way Out
How Many	"Did you put me here?"	Did You Put
Did You Put	"Can you help me?"	Can Help
Way Out	"Can you help me?"	Can Help
Can Help	"So I'm alone in this?"	So Alone
Can Help	"Do you know the layout of the maze?"	Know Layout
So Alone	"Then why won't you help me?"	Why Won't
Know Layout	"Then why won't you help me?"	Why Won't

Section 3 - Text

To say hello-hello:
	say "'Hello, hello!' The man booms. 'My name is John Everyman. Welcome to the maze! I understand you must have a lot of questions, so I'm here to answer them as best I can.'
	
	[italic type](Choose what to say from the options below by typing the associated number.)[roman type] "

To say what-is-this:
	say "'What is this?' You ask, looking around at the high walls.
	
	'This is The Maze,' Everyman replies. 'Or rather, [italic type]a[roman type] maze. It's maze number [maze-num], to be precise. There are many, many of them, don't you know,' he chuckles good-naturedly, then sobers. 'And I regret to inform you that you are one of the unlucky many chosen to walk it.' "
	
To say who-you:
	say "'Who are you?' You ask. His face seems vaguely familiar, but you can't quite place it.
	
	He seems just slightly miffed. 'Well, as I said, my name is John Everyman. I'm the current Maze Assistive Representative, Compulsor, and Helper. Don't you remember my campaign?' He strikes a heroic pose. 'My slogan was [']MARCHing Into the Future.['] No? Well, regardless, I won. It's my job to give you the information you need inside of the maze, and to advocate for you to those outside of it.' "
	
To say where-we:
	say "'Where[unicode 8230] are we?' You ask, looking around at the high walls.
	
	'This is The Maze,' Everyman replies. 'Or rather, [italic type]a[roman type] maze. It's maze number [maze-num], to be precise. There are many, many of them, don't you know,' he chuckles good-naturedly, then sobers. 'And I regret to inform you that you are one of the unlucky many chosen to walk it.' "
	
To say why-happening:
	say "'Why is this hapening?' You ask. You feel a tightness in your chest, a shortness of breath.
	
	John scoffs. 'Why does [italic type]anything[roman type] happen?' He counters. 'It's all the luck of the draw, isn't it? You know, you should actually consider yourself pretty fortunate. Back in my day, the floors of the mazes were covered in broken glass.' "
	
To say why-me:
	say "'But why [italic type]me[roman type]?' You press. 'How was I selected? What kind of process is this?'
	
	John looks uncomfortable. 'Well,' he hesitates. 'It could be based on any number of factors. Your body, your mind, your home, your clothes[unicode 8230] any of these could make you eligible.' He pauses again. 'I don't think I'm really the best person to explain it to you.' "
	
To say what-do:
	say "'So I'm in a maze. Now what do I do?' You ask.
	
	He chuckles. 'Why, what does one do in any maze? You walk it.' Then, at your expression, he raises his hands defensively. 'Hey, you asked the question. I thought the answer would have been obvious.' "
	
To say how-many:
	say "'How[unicode 8230]' You almost don't want to ask. 'How many have there been before me?'
	
	John scoffs. 'Oh, billions.' He says it with such casualness. 'And there are hundreds of thousands of others walking mazes right now. But this maze is special: this maze is yours.' "
	
To say way-out:
	say "'Is there a way out?' You ask dubiously. 'Do you know?'
	
	He nods. 'Yes. Well, usually,' he corrects himself. 'Sometimes the gate out is locked. But usually it's not. And even when it is, some people have found ways of getting out anyway. So don't lose hope!' "
	
To say did-you-put:
	say "A horrible thought races through you. 'Did [italic type]you[roman type] put me in here?' You choke out.
	
	'No, no, no!' John waves his hands quickly, as if to dispel the accusation. 'The decision is out of my hands! Out of anyone's individual hands, really. It's not the fault of any one person or entity when someone end up in a maze. It's just[unicode 8230] something that happens.' "
	
To say can-help:
	say "'Can you help me?' You ask hopefully.
	
	'I already am!' John protests. 'I'm your M.A.R.C.H., remember? I'm your advocate to the people outside.' "
	
To say so-alone:
	say "'So, I'm alone in this?' You ask. This man is starting to get to you.
	
	'Hey, don't say that,' John protests, his voice softening in a way that comes off more condescending than comforting. 'Rest assured that I'm doing everything I can to convince my colleagues[unicode 8212]that's the people outside the maze[unicode 8212]to make things easier. I'm [italic type]advocating[roman type] for you, but these things take time. And patience.
	
	'I know I'm not exactly what you were hoping for. But just be glad it's not the other guy here; Jerry[unicode 8212]that's Jerry Mander, the guy I beat in the campaign[unicode 8212]could make this a lot worse for you.' "
	
To say know-layout:
	say "'Do you know the layout of the maze?' You demand.
	
	'I[unicode 8230]' he seems taken aback. 'Well, I've never walked one myself, but I have a general idea. I've been told stories, and there are maps that can be accessed. But it's a [italic type]lot[roman type] of paperwork.' "

To say why-wont-you:
	say "'Then why won't you [italic type]help[roman type] me?' You cry, your voice echoing off the walls.
	
	His face grows cold. 'I promise you everything is being done,' he says icily. 'And I will be here to answer any questions you have about things you may encounter in the maze.' He pauses, then says 'a word of advice: in the future, you may find it productive [italic type]not[roman type] to alienate your potential allies.'
	
	He turns away, and you get the sense that the conversation is over. "
	
Chapter 4 - Other dialogue

Section 1 - Tables

Table of Ask Results (continued)
NPC	topic	result
John Everyman	"[bench]"	a_bench
John Everyman	"[cam]"	a_camera
John Everyman	"[flower]"	a_flower
John Everyman	"[fountain]" or "[maidens]" or "water"	a_fountain
John Everyman	"[graveyard]" or "[grave]" or "[tomb]"	a_graveyard
John Everyman	"[John]"	a_john
John Everyman	"[jukebox]"	a_jukebox
John Everyman	"[lighter]"	a_lighter
John Everyman	"small" or "lizard" or "animal"	a_lizard
John Everyman	"maze"	a_maze
John Everyman	"rain"	a_rain
John Everyman	"[ribbon]"	a_ribbon
John Everyman	"rock/rocks" or "stone/stones"	a_rock
John Everyman	"[signs]"	a_sign
John Everyman	 "[swatches]"	a_swatches
John Everyman	"nice" or "tree"	a_tree
John Everyman	"charred" or "ruin"	a_ruin
John Everyman	"time/capsule" or "[capsule]"	a_capsule
John Everyman	"[yarn]"	a_yarn


Table of Quip Texts (continued)
quip	quiptext
a_bench	"[park-bench-ask]"
a_camera	"[security-cam-ask]"
a_capsule	"[time-capsule-ask]"
a_flower	"[flower-ask]"
a_graveyard	"[graveyard-ask]"
a_john	"[john-ask]"
a_jukebox	"[jukebox-ask]"
a_lighter	"[lighter-ask]"
a_lizard 	"[lizard-ask]"
a_maze	"[maze-ask]"
a_fountain	"[fountain-ask]"
a_rain	"[rain-ask]"
a_ribbon	"[ribbon-ask]"
a_rock	"[rock-ask]"
a_ruin	"[charred-ruin-ask]"
a_sign	"[sign-ask]"
a_swatches	"[swatches-ask]"
a_tree	"[tree-ask]"
a_yarn	"[yarn-ask]"

Section 2 - Text

To say ask-preface: say "[one of]What can you tell me about[or]What can you tell me about[or]Can you tell me about[or]Can you tell me about[or]What's the deal with[or]What do you know about[or]What's up with[or]Do you know about[at random]".

To say ask-sub: say "[one of]ask[or]ask[or]ask[or]ask John[or]ask him[or]inquire[or]demand[as decreasingly likely outcomes]".

To say dunno: say "'The [one of]what[or]which[or]who[then at random]?' John asks. 'I wasn't aware that was in the maze. I'll make a note of it.'"

To say charred-ruin-ask:
	say "'[ask-preface] the charred ruin?' You [ask-sub].
	
	'The what?' John asks. 'I'm not sure what you're talking about.' "
	
To say flower-ask:
	say "'[ask-preface] the wilted flower?' You [ask-sub].
	
	[dunno] ".
	
To say fountain-ask:
	say "'[ask-preface] the fountain?' You [ask-sub].
	
	'Ah, yes,' John seems pleased. 'Pretty, isn't it? The people outside thought it would be good to give you something nice to look at when you walked. The carving was my idea.' "
	
To say graveyard-ask:
	say "'[ask-preface] the graveyard?' You [ask-sub].
	
	'Ah, yes,' John says, with a sense of overblown gravity. 'A while back, it was decided that it was too upsetting to move the walkers who failed to escape the maze out through public avenues, so a resting place was built for them inside. It's better for everyone this way.' "
	
To say john-ask:
	say "'Tell me about yourself,' you say.
	
	John seems miffed. 'I already told you who I am,' he says defensively. 'And frankly, I find it insulting that you insist on continuing to interrogate me. Don't you trust me?' "
	
To say jukebox-ask:
	say "'[ask-preface] the jukebox?' You [ask-sub].
	
	[dunno] ".
	
To say lighter-ask:
	say "'[ask-preface] the lighter?' You [ask-sub].
	
	[dunno] ".
	
To say lizard-ask:
	say "'[ask-preface] the small lizard?' You [ask-sub].
	
	'A lizard?' John seems genuinely surprised. 'There definitely shouldn't be a lizard in here. I'll have to ask someone to contact pest control.' "

To say maze-ask:
	say "'What else can you tell me about the maze?' You [ask-sub].
	
	'I've really already told you everything there is to know,' John says. 'It was built by the people outside of it. The walls are strong concrete. Your task is to try and find yout way out.' "
	
To say park-bench-ask:
	say "'[ask-preface] the park [if the number of familiar park benches > 1]benches scattered around the maze[otherwise]bench[end if]?' You [ask-sub].
	
	'Oh, [if the number of familiar park benches < 2]there's more than one, you know,' John informs you. [otherwise]those?' John seems as if he'd forgotten they were there. [end if]'They were added by some youth group. A community service kind of thing. They're meant to give you a place to sit and rest while you're walking.' "
	
To say rain-ask:
	say "'[ask-preface] [if It Drizzles is happening]this[otherwise]the[end if] rain?' You [ask-sub].
	
	'[if It Drizzles is happening]Terrible isn't it?' John shouts, though the rain isn't nearly loud enough for him to need to raise his voice. 'Do try to stay dry[otherwise]The what?' John asks, looking puzzled. 'It hasn't rained here in weeks[end if].' "
	
To say ribbon-ask:
	say "'[ask-preface] the [if the dirty ribbon is dirtied]dirty [end if]ribbon?' You [ask-sub].
	
	[dunno] ".
	
To say rock-ask:
	say "'[ask-preface] the river rocks?' You [ask-sub].
	
	John shrugs. 'Ambiance?' He suggests. 'The fountain didn't seem complete without them.' "
	
To say security-cam-ask:
	say "'[ask-preface] the security [if the number of familiar security cameras > 1]cameras[otherwise]camera I saw[end if]?' You [ask-sub].
	
	'Oh, those?' John waves a hand. 'Those are for your safety and ours. It's a closed circuit[unicode 8212]no need to worry.' "
	
To say sign-ask:
	say "'[ask-preface] the LED ticker [if the number of familiar LED ticker signs > 1]signs scattered around the maze[otherwise]sign I saw[end if]?' You [ask-sub].
	
	'Oh, those?' John sounds pleased. 'A new innovation. They allow the people outside the maze[unicode 8212]or, I guess, outside [italic type]this[roman type] maze[unicode 8212]to communicate with you. Tell you their thoughts on your progress, suggestions, directions[unicode 8230] all in the service of free communication. We haven't figured out a way to let you respond yet, but that will happen eventually, I'm sure.' "
	
To say swatches-ask:
	say "'[ask-preface] the book of paint swatches?' You [ask-sub].
	
	[dunno] ".
	
To say time-capsule-ask:
	say "'[ask-preface] the time capsule?' You [ask-sub].
	
	'The what?' John asks. 'I'm not sure what you're talking about.' "
	
To say tree-ask:
	say "'[ask-preface] the tree?' You [ask-sub].
	
	'Oh, that?' John asks. 'Grew there all by itself. Can't get anyone in to take care of it without making them walk the maze themselves, you understand. I'm sure you can just squeeze around it.' "
	
To say yarn-ask:
	say "'[ask-preface] the ball of yarn?' You [ask-sub].
	
	[dunno]
	
	He pauses, then shrugs. 'Maybe it was left by someone before you, who knows.' "
	
The generic ask quip is "[if John Everyman is in the location]You ask, but John just [stares-at-you] and doesn't reply[otherwise]There's no one around to hear you[end if].[conditional paragraph break]".

The generic tell quip is "[if John Everyman is in the location]You tell John, but he just [stares-at-you] and doesn't reply[otherwise]There's no one around to hear you[end if].[conditional paragraph break]".

To say stares-at-you: say "[one of]stares at you[or]pretends not to hear you[or]stares steadfastly into the middle distance[or]stares at you[or]snorts[or]pretends not to hear you[or]stares at you[or]sighs[or]pretends not to hear you[or]stares at you[or]pretends not to hear you[or]rolls his eyes[cycling][run paragraph on]".

Part 2 - Location-specific things

Chapter 1 - Signs

[Seed	Sign1	Sign2	Sign3	Sign4
1	1	1	1	1
2	1	2	3	4
3	1	3	4	2
4	2	2	2	2
5	2	3	4	1
6	2	4	1	3
7	3	3	3	3
8	3	4	1	2
9	3	1	2	4
10	4	4	4	4
11	4	1	2	3
12	4	2	3	1
13	1	4	1	2
14	2	1	3	4
15	3	2	4	1
16	4	3	2	3
NOTE: The message each sign displays depends on the seed. The pattern above applies only to the bad advice, good advice, and cruel comment signs—the signs that give directions must, of course, react to the layout of the hallways surrounding them.]

Section 1 - Unhelpful signs with bad directions

The UnhelpfulSign1 is an LED ticker sign in Room1-1. The message of UnhelpfulSign1 is "[fixed letter spacing][unh1][roman type]".

To say unh1:
	if the map-seed is either 1 or 2 or 4 or 6 or 9 or 11:
		say "Go south from here! ";
	otherwise if the map-seed is either 3 or 5 or 10 or 14 or 15:
		say "Go east from here! ";
	otherwise if the map-seed is either 7 or 8 or 12 or 13 or 16:
		say "Congratulations! You've made it! Go north or west! ";

The UnhelpfulSign2 is an LED ticker sign in Room1-7. The message of UnhelpfulSign2 is "[fixed letter spacing][unh2][roman type]".

To say unh2:
	if the map-seed is either 1 or 2 or 5 or 13:
		say "Go south from here! ";
	otherwise if the map-seed is either 3 or 6 or 8 or 14 or 16:
		say "Go west from here! ";
	otherwise if the map-seed is either 4 or 9 or 10 or 11 or 12 or 15:
		say "Congratulations! You've made it! Go north or east! ";
	otherwise if the map-seed is 7:
		say "Go west from here! You're almost there! ";

The UnhelpfulSign3 is an LED ticker sign in Room9-1. The message of UnhelpfulSign3 is "[fixed letter spacing][unh3][roman type]".

To say unh3:
	if the map-seed is either 1 or 5 or 9 or 11 or 12:
		say "Go north from here! ";
	otherwise if the map-seed is either 2 or 3 or 4 or 6 or 10 or 13:
		say "Congratulations! You've made it! Go south or west! ";
	otherwise if the map-seed is either 7 or 8 or 14:
		say "Go north from here! ";
	otherwise if the map-seed is either 15 or 16:
		say "Go east from here! ";

The UnhelpfulSign4 is an LED ticker sign in Room9-7. The message of UnhelpfulSign4 is "[fixed letter spacing][unh4][roman type]".

To say unh4:
	if the map-seed is either 1 or 2 or 3 or 4 or 5 or 8:
		say "Go west from here! You're almost there! ";
	otherwise if the map-seed is either 12 or 13 or 16:
		say "Go west from here! You're almost there! ";
	otherwise if the map-seed is either 6 or 7 or 9 or 14:
		say "Go west from here! ";
	otherwise if the map-seed is either 10 or 15:
		say "Congratulations! You've made it! Go south or east! ";
	otherwise if the map-seed is 11:
		say "Go north from here! ";

Section 2 - Helpful signs with good directions

[Note: There is a way to tell the unhelpful signs from the helpful ones. The unhelpful signs tell you to "go" a direction, while the helpful ones tell you to "head" there. No one has figured that out on their own yet, so maybe it's too subtle. Ah well.]

The HelpfulSign1 is an LED ticker sign in Room3-2. The message of HelpfulSign1 is "[fixed letter spacing][h1][roman type]".

To say h1:
	if the map-seed is 1:
		say "Head back east from here. ";
	otherwise if the map-seed is 2:
		say "Keep heading east from here. ";
	otherwise if the map-seed is 3:
		say "Keep heading north from here. ";
	otherwise if the map-seed is either 4 or 9 or 11 or 15:
		say "Wrong way. Head west and get back on track. ";
	otherwise if the map-seed is 5:
		say "Wrong way. Head north and get back on track. ";
	otherwise if the map-seed is 6:
		say "You've ended up somewhere very wrong. Head north and get back on track. ";
	otherwise if the map-seed is 7:
		say "You're on the right track! Keep heading east from here. ";
	otherwise if the map-seed is 8:
		say "You're on the right track! Head east from here. ";
	otherwise if the map-seed is either 10 or 12 or 13:
		say "Wrong way. Head south and get back on track. ";
	otherwise if the map-seed is 14:
		say "Wrong way. Head east and get back on track. ";
	otherwise if the map-seed is 16:
		say "Head south from here. ";

The HelpfulSign2 is an LED ticker sign in Room3-6. The message of HelpfulSign2 is "[fixed letter spacing][h2][roman type]".

To say h2:
	if the map-seed is 1:
		say "Head back south from here. ";
	otherwise if the map-seed is 2:
		say "Wrong way. Head back east. ";
	otherwise if the map-seed is either 3 or 16:
		say "Wrong way. Head back south. ";
	otherwise if the map-seed is either 4 or 5 or 12:
		say "You've ended up somewhere very wrong. Head north and get back on track. ";
	otherwise if the map-seed is 6:
		say "You passed it! Head back east. ";
	otherwise if the map-seed is 7:
		say "You're on the right track! Head north from here. ";
	otherwise if the map-seed is either 8 or 11 or 14:
		say "Wrong way. Head back north. ";
	otherwise if the map-seed is 9:
		say "Wrong way. Head back west. ";
	otherwise if the map-seed is 10:
		say "You passed it! Head back south. ";
	otherwise if the map-seed is either 13 or 15:
		say "You've ended up somewhere very wrong. Head west and get back on track. ";

The HelpfulSign3 is an LED ticker sign in Room7-2. The message of HelpfulSign3 is "[fixed letter spacing][h3][roman type]".

To say h3:
	if the map-seed is either 1 or 6:
		say "You're on the right track! Head north from here to reach the exit. ";
	otherwise if the map-seed is either 2 or 12:
		say "Head east from here towards the exit. ";
	otherwise if the map-seed is either 3 or 10 or 15:
		say "You've ended up somewhere very wrong. Head north and get back on track. ";
	otherwise if the map-seed is either 4 or 14 or 16:
		say "Wrong way. Head back west. ";
	otherwise if the map-seed is 5:
		say "You've ended up somewhere very wrong. Head south and get back on track. ";
	otherwise if the map-seed is either 7 or 8:
		say "Wrong way. Head back north. ";
	otherwise if the map-seed is 9:
		say "You're on the right track! Head south from here. ";
	otherwise if the map-seed is either 11 or 13:
		say "Wrong way. Head back south. ";

The HelpfulSign4 is an LED ticker sign in Room7-6. The message of HelpfulSign4 is "[fixed letter spacing][h4][roman type]".

To say h4:
	if the map-seed is either 1 or 13:
		say "Wrong way. Head back south. ";
	otherwise if the map-seed is 2:
		say "Wrong way. Head back east. ";
	otherwise if the map-seed is 3:
		say "You're close! Head east from here to reach the exit! ";
	otherwise if the map-seed is either 4 or 5 or 12:
		say "You're close! Head south from here to reach the exit! ";
	otherwise if the map-seed is 6:
		say "You passed it! Head back east. ";
	otherwise if the map-seed is 7:
		say "You've ended up somewhere very wrong. Head east and get back on track. ";
	otherwise if the map-seed is either 8 or 14 or 15:
		say "You passed it! Head back west. ";
	otherwise if the map-seed is 9:
		say "You've ended up somewhere very wrong. Head north and get back on track. ";
	otherwise if the map-seed is either 10 or 11:
		say "You're close! Head north from here to reach the exit! ";
	otherwise if the map-seed is 16:
		say "You're close! Head west from here to reach the exit! ";

Section 3 - Bad advice from those who haven't walked the maze

The BadAdvice1 is an LED ticker sign in Room1-2. The message of BadAdvice1 is "[fixed letter spacing][ba1][roman type]".

To say ba1:
	if the map-seed is either 1 or 2 or 3 or 13:
		say "Perhaps you ought to see this as an opportunity. How can this help you grow? ";
	otherwise if the map-seed is either 4 or 5 or 6 or 14:
		say "Look on the bright side! There's always a silver lining. ";
	otherwise if the map-seed is either 7 or 8 or 9 or 15:
		say "There's no point complaining[unicode 8212]it never made anything better. ";
	otherwise:
		say "Keep moving forward. There are people who have it much harder. "

The BadAdvice2 is an LED ticker sign in Room3-5. The message of BadAdvice2 is "[fixed letter spacing][ba2][roman type]".

To say ba2:
	if the map-seed is either 1 or 9 or 11 or 14:
		say "Have you considered meditation? If you raise your vibrational level, maybe the maze won't bother you so much. ";
	otherwise if the map-seed is either 2 or 4 or 12 or 15:
		say "Have you spoken to your family? Maybe if you ask their help, they can get you out of the maze. ";
	otherwise if the map-seed is either 3 or 5 or 7 or 16:
		say "Have you considered going somewhere else? I mean, why choose to live in the maze? ";
	otherwise:
		say "Have you considered voting? If we get more of a majority in six months, maybe we can demolish a few of the hallways. "

The BadAdvice3 is an LED ticker sign in Room6-6. The message of BadAdvice3 is "[fixed letter spacing][ba3][roman type]".

To say ba3:
	if the map-seed is either 1 or 6 or 8 or 13:
		say "I want you to know I sympathize, I really do. I'm sending my thoughts and prayers. ";
	otherwise if the map-seed is either 4 or 9 or 11 or 16:
		say "I've never even heard of the maze before. Can you take the time to tell me exactly what's happening to you, in a way that educates me well on a more universal experience without threatening my own worldview? ";
	otherwise if the map-seed is either 2 or 7 or 12 or 14:
		say "You should know that I donated to CAM two years ago[unicode 8212]that's the Council Against Mazes. They've got a lot of big things coming up. ";
	otherwise:
		say "I don't understand. Why do you stay in the maze? Why don't you just[unicode 8230] leave? "

The BadAdvice4 is an LED ticker sign in Room8-3. The message of BadAdvice4 is "[fixed letter spacing][ba4][roman type]".

To say ba4:
	if the map-seed is either 1 or 5 or 12 or 15:
		say "Are you sure it's a maze you're in? You know, it's possible it's just a bunch of hallways. ";
	otherwise if the map-seed is either 3 or 4 or 8 or 13:
		say "Oh, come on. Everyone's seen a maze. You're not special. ";
	otherwise if the map-seed is either 6 or 7 or 11 or 16:
		say "I think it's so hot when someone's been in a maze. If you make it out, give me a call. ";
	otherwise:
		say "I don't even know how to talk to you. Do people still say [']hall-crawler[']? It's so hard to keep up with the terminology. "

Section 4 - Good advice from those who've walked the maze

The GoodAdvice1 is an LED ticker sign in Room2-1. The message of GoodAdvice1 is "[fixed letter spacing][ga1][roman type]".

To say ga1:
	if the map-seed is either 1 or 2 or 3 or 13:
		say "It is trying to get into your head. Breathe. You can keep it out. ";
	otherwise if the map-seed is either 4 or 5 or 6 or 14:
		say "You know yourself, and you know yourself much better than they do. Hold fast to that[unicode 8212]it just may save you. ";
	otherwise if the map-seed is either 7 or 8 or 9 or 15:
		say "Even if you lose your way, you mustn't lose yourself. One foot in front of the other. ";
	otherwise:
		say "It is unjust, that's true. It's okay to sit with that for a moment, but you can't afford to stay still for too long. "

The GoodAdvice2 is an LED ticker sign in Room5-6. The message of GoodAdvice2 is "[fixed letter spacing][ga2][roman type]".

To say ga2:
	if the map-seed is either 1 or 9 or 11 or 14:
		say "You have survived situations equally dangerous. You can survive this. ";
	otherwise if the map-seed is either 2 or 4 or 12 or 15:
		say "You are your own[unicode 8212]never let them convince you otherwise. ";
	otherwise if the map-seed is either 3 or 5 or 7 or 16:
		say "There are others walking the maze at this very moment[unicode 8212]perhaps not this maze, but the maze nonetheless. If you feel you cannot walk it for yourself, walk it for them. ";
	otherwise:
		say "Consider what you'll return to once you've left the maze. Keep it close to your heart and let it guide you. "

The GoodAdvice3 is an LED ticker sign in Room6-3. The message of GoodAdvice3 is "[fixed letter spacing][ga3][roman type]".

To say ga3:
	if the map-seed is either 1 or 6 or 8 or 13:
		say "There are others walking the maze at this very moment[unicode 8212]perhaps not this maze, but the maze nonetheless. If you feel you cannot walk it for yourself, walk it for them. ";
	otherwise if the map-seed is either 4 or 9 or 11 or 16:
		say "You do not deserve this. This is not your fault. Remember that. ";
	otherwise if the map-seed is either 2 or 7 or 12 or 14:
		say "You know yourself, and you know yourself much better than they do. Hold fast to that[unicode 8212]it just may save you. ";
	otherwise:
		say "Do what it takes to survive. The world needs you. We need you. "

The GoodAdvice4 is an LED ticker sign in Room4-7. The message of GoodAdvice4 is "[fixed letter spacing][ga4][roman type]".

To say ga4:
	if the map-seed is either 1 or 5 or 12 or 15:
		say "You do not deserve this. This is not your fault. Remember that. ";
	otherwise if the map-seed is either 3 or 4 or 8 or 13:
		say "It is unjust, that's true. It's okay to sit with that for a moment, but you can't afford to stay still for too long. ";
	otherwise if the map-seed is either 6 or 7 or 11 or 16:
		say "You are your own[unicode 8212]never let them convince you otherwise. ";
	otherwise:
		say "I've been where you are now. I have. It took everything inside of me to make it out of there and to where I now am. I thought it had hollowed me out, and that I would never be the same. That may well be true, but now I am something else[unicode 8212]something new. Just because you won't be what you were, doesn't mean you won't be you on the other side of this. "

Section 5 - Cruel comments

The CruelComment1 is an LED ticker sign in Room2-4. The message of CruelComment1 is "[fixed letter spacing][cc1][roman type]".

To say cc1:
	if the map-seed is either 1 or 2 or 3 or 13:
		say "I think people like you deserve the maze. Have you considered laying down and dying? ";
	otherwise if the map-seed is either 4 or 5 or 6 or 14:
		say "You are the scum of the earth. You're the worst among us. ";
	otherwise if the map-seed is either 7 or 8 or 9 or 15:
		say "You should have known better. You brought this on yourself. ";
	otherwise:
		say "You're upset because you're in a maze? Are you serious? People literally go to mazes for fun. How pathetic are you? "

The CruelComment2 is an LED ticker sign in Room4-3. The message of CruelComment2 is "[fixed letter spacing][cc2][roman type]".

To say cc2:
	if the map-seed is either 1 or 9 or 11 or 14:
		say "All I ever hear are the hall-crawlers whining. Why don't we ever hear from people outside of mazes? We're being silenced. ";
	otherwise if the map-seed is either 2 or 4 or 12 or 15:
		say "Drop your location, coward. I'll come in there and hunt you down. ";
	otherwise if the map-seed is either 3 or 5 or 7 or 16:
		say "You do understand that you brought this on yourself, right? Maybe if you had lived a more moral life, you could have been happy. This serves you right. ";
	otherwise:
		say "We can't talk about every maze at once, you know. You talking about your maze is detracting from the conversation about mine, and I've been fighting for years. Can you just shut up for a minute and wait your turn? "

The CruelComment3 is an LED ticker sign in Room7-4. The message of CruelComment3 is "[fixed letter spacing][cc3][roman type]".

To say cc3:
	if the map-seed is either 1 or 6 or 8 or 13:
		say "HALL-CRAWLER! HALL-CRAWLER! HALL-CRAWLER! HALL-CRAWLER! HALL-CRAWLER! HALL-CRAWLER! HALL-CRAWLER! HALL-CRAWLER! HALL-CRAWLER! ";
	otherwise if the map-seed is either 4 or 9 or 11 or 16:
		say "Your poor, poor mother. I dread to think what she must be going through. ";
	otherwise if the map-seed is either 2 or 7 or 12 or 14:
		say "If I see you even look at my child, trust and believe I will kill you where you stand. ";
	otherwise:
		say "I'm tired of having my legitimate questions shut down. I think YOU'RE prejudiced against non-hall-crawlers. What do you say to that, you crawling freak? "

The CruelComment4 is an LED ticker sign in Room8-5. The message of CruelComment4 is "[fixed letter spacing][cc4][roman type]".

To say cc4:
	if the map-seed is either 1 or 5 or 12 or 15:
		say "You're a stupid fucking bitch. I'll laugh when you die. ";
	otherwise if the map-seed is either 3 or 4 or 8 or 13:
		say "You're a rotten piece of shit. I want to watch you die. ";
	otherwise if the map-seed is either 6 or 7 or 11 or 16:
		say "You're a fucking animal. I hope you die. ";
	otherwise:
		say "You're worthless. I've taken shits with more value than you, asswipe. "

[Note: Having the corpses of recent walkers littered around the maze was an early idea, and would have been implimented alongside of (not in place of) the graveyard. I realized it might be a bit too blunt, ESPECIALLY alongside the more subtle graveyard puzzle, and more likely retraumatizing than anything else. Since the corpses served no narrative or puzzle function, I removed them.]

[Chapter 2 - Corpses

Section 1 - Corpse 1 - Recent

Corpse1 is a skeleton in Room1-3. The description of Corpse1 is "[if you've seen a skeleton]This corpse is more[unicode 8230] recent than the skeletons you've seen[otherwise]A corpse lies here[end if]. It seems to be only a few weeks old[unicode 8212]the flesh has a reddish hue, and the nails and hair are still intact. The chest and the eye sockets are sunken. The lips have dried out and curled in, revealing grinning yellowed teeth. The corpse wears a graphic tee and a pair of cargo shorts, both damp and infested with mildew but still intact."

To decide whether you've seen a skeleton:
	if Corpse2 is familiar, yes;
	if Corpse3 is familiar, yes;
	if Corpse4 is familiar, yes;
	if Corpse5 is familiar, yes;
	no.
	
The graphic tee is part of Corpse1. Understand "t-shirt/tshirt/t/shirt" or "print/printed" or "design/logo" or "clothing/clothes" or "deep/blue/yellow" as the graphic tee.
The description of the graphic tee is "The shirt is a deep blue. In the center is a logo: a square made up of four smaller yellow squares."

Instead of attacking or burning or cutting the graphic tee: say "That feels too close to corpse desecration for your liking."

Instead of consulting the graphic tee about: try examining the noun.
	
Instead of looking under or touching or rubbing the graphic tee: say "You don;t want to risk touching the corpse."
	
Instead of smelling the graphic tee: try smelling the mildew.
	
Instead of removing the graphic tee from: try taking the noun.

Instead of taking the graphic tee: say "You'd have to move the corpse to take it, and that's not something you're exactly eager to do."

The cargo shorts are part of Corpse1. Understand "short" or "pair" or "of" or "pocket/pockets" or "clothing/clothes" as the cargo shorts.
The description of the cargo shorts is "CARGO SHORTS DESC PLACEHOLDER."

[NOTE: Here in the code was originally a copy of all the potential "Instead" rules for an individual object. I didn't get around to writing those responses for the cargo shorts before deciding against including the corpses altogether, so that list has been elided for the sake of readability.]

The mildew is part of the graphic tee. Understand "mold" or "damp" or "rot" or "fungus" as the mildew.
The description of the mildew is "It's a green-brown color. It looks slimy."

Instead of attacking or burning or cutting the mildew: say "That feels too close to corpse desecration for your liking."

Instead of consulting the mildew about: try examining the noun.
	
Instead of removing the mildew from: say "It's firmly attached to the corpse's clothing."

Instead of taking or touching or rubbing or drinking or eating or tasting or smelling the mildew: say "Gross. Better to refrain."
	
Section 2 - Corpse 2 - Shattered

Corpse2 is a skeleton in Room1-6. The description of Corpse2 is "SECOND CORPSE DESC PLACEHOLDER - SHATTERED."

Section 3 - Corpse 3 - Ancient

Corpse3 is a skeleton in Room3-1. The description of Corpse3 is "THIRD CORPSE DESC PLACEHOLDER - ANCIENT."

Section 4 - Corpse 4 - Neutral

Corpse4 is a skeleton in Room5-2. The description of Corpse4 is "It's a skeleton. If it were standing, it would be about as tall as you are. It's splayed out on its back, most of its flesh worn away by exposure. Only the ligaments remain to loosely hold the bones together. It stares up at the sky with unseeing eye sockets."

Section 5 - Corpse 5 - Child

Corpse5 is a skeleton in Room9-4. The description of Corpse5 is "It[unicode 8230] oh, god. It’s a small skeleton, splayed out on its back. Most of the flesh is gone, worn away by exposure, so only the ligaments holding the individual bones together remain. The fibulas and ulnas, too soft to support their own weight, bow in the middle to touch the ground.

Whoever this was[unicode 8230] they never even had a chance."]

Chapter 2 - Park benches

The Bench1 is a park bench in Room1-5.

After looking when the location is Room1-4:
	if 14-15passage is present, say "[unless Room1-5 is visited]There's something[otherwise]A park bench sits[end unless] to the east."
	
After looking when the location is Room1-6:
	if 15-16passage is present, say "[unless Room1-5 is visited]There's something[otherwise]A park bench sits[end unless] to the west."
	
After looking when the location is Room2-5:
	if 15-25passage is present, say "[unless Room1-5 is visited]There's something[otherwise]A park bench sits[end unless] to the north."

The Bench2 is a park bench in Room4-4.

After looking when the location is Room4-3:
	if 43-44passage is present, say "[unless Room4-4 is visited]There's something[otherwise]A park bench sits[end unless] to the east."
	
After looking when the location is Room4-5:
	if 44-45passage is present, say "[unless Room4-4 is visited]There's something[otherwise]A park bench sits[end unless] to the west."
	
After looking when the location is Room5-4:
	if 44-54passage is present, say "[unless Room4-4 is visited]There's something[otherwise]A park bench sits[end unless] to the north."
	
After looking when the location is Room3-4:
	if 34-44passage is present, say "[unless Room4-4 is visited]There's something[otherwise]A park bench sits[end unless] to the south."

The Bench3 is a park bench in Room6-1.

After looking when the location is Room6-2:
	if 61-62passage is present, say "[unless Room6-1 is visited]There's something[otherwise]A park bench sits[end unless] to the west."
	
After looking when the location is Room5-1:
	if 51-61passage is present, say "[unless Room6-1 is visited]There's something[otherwise]A park bench sits[end unless] to the south."
	
After looking when the location is Room7-1:
	if 61-71passage is present, say "[unless Room6-1 is visited]There's something[otherwise]A park bench sits[end unless] to the north."

The Bench4 is a park bench in Room6-7.

After looking when the location is Room6-6:
	if 66-67passage is present, say "[unless Room6-7 is visited]There's something[otherwise]A park bench sits[end unless] to the east."
	
After looking when the location is Room5-7:
	if 57-67passage is present, say "[unless Room6-7 is visited]There's something[otherwise]A park bench sits[end unless] to the south."
	
After looking when the location is Room7-7:
	if 67-77passage is present, say "[unless Room6-7 is visited]There's something[otherwise]A park bench sits[end unless] to the north."

Chapter 3 - Security cameras

The Cam1 is a security camera in Room2-2. "[if busted][busted-camera][otherwise]A security camera observes you disinterestedly[end if]."

The Cam2 is a security camera in Room3-7. "[if busted][busted-camera][otherwise]A security camera eyes you watchfully[end if]."

The Cam3 is a security camera in Room7-1. "[if busted][busted-camera][otherwise]A security camera watches you intensely[end if]."

The Cam4 is a security camera in Room9-5. "[if busted][busted-camera][otherwise]A security camera surveys you attentively[end if]."

To say busted-camera: say "You've broken the security camera that once watched over this hallway; now its single eye stares off at an angle, lens cracked and unseeing".

Chapter 4 - The nice tree

Section 1 - The nice tree itself

A nice tree is scenery in Room6-5. Understand "sapling" or "fruit" or "root/roots" as the nice tree.
The description of the nice tree is "It's a tall tree, with a majestic trunk. Dark green leaves interspersed with small white flowers flutter gently in the wind. It had grown above the walls of the maze and reaches towards the sky.[paragraph break]A rickety ladder is attached to the trunk."

Before trying doing something with the nice tree when the location is a treehouse: say "You can't reach the tree from inside the treehouse." instead.

Instead of attacking or burning or cutting the nice tree: say "The tree is one of the few pretty things in the maze. Why would you want to harm it?"

Instead of attacking the nice tree with: say "The tree is one of the few pretty things in the maze. Why would you want to harm it?"

Instead of consulting the nice tree about: try examining the noun.
	
Instead of looking under the nice tree: say "Its trunk goes right down to the ground."
	
Instead of smelling the nice tree: say "It smells green and sweet."
	
[Instead of climbing the nice tree: say "You never were very athletic[unicode 8212]better to save your energy for walking."]

Instead of climbing the nice tree when the location is Room6-5: try going up.

Instead of climbing the nice tree when the location is a treehouse: try going down.
	
Instead of inserting something into the nice tree: say "There's nowhere to set it inside."

Instead of listening to the nice tree: say "Its leaves rustle quietly in a gentle wind."

Instead of throwing something at the nice tree: say "The tree is one of the few pretty things in the maze. Why would you want to harm it?"
	
Instead of touching or rubbing the nice tree: say "The bark is rough under your fingers."
	
Instead of tying the ball of yarn to the nice tree: say "The yarn will do just as good a job guiding you back here laid on the ground as it will tied to the tree."

Section 2 - Trunk and bark

The trunk is part of the nice tree. Understand "stem" as the trunk.
The description of the trunk is "It's thick, sturdy, and majestic. It serves the branches well."

Instead of attacking or burning or cutting the trunk: try burning the nice tree.

Instead of attacking the trunk with: try attacking the nice tree with the second noun.

Instead of consulting the trunk about: try examining the noun.
	
Instead of looking under the trunk: try looking under the nice tree.
	
Instead of smelling the trunk: try smelling the nice tree.
	
Instead of climbing the trunk: try climbing the nice tree.
	
Instead of inserting something into the trunk: try inserting the noun into the nice tree.

Instead of listening to the trunk: say "It stands stoic and silent."
	
Instead of throwing something at the trunk: try throwing the noun at the nice tree.
	
Instead of touching or rubbing the trunk: try touching the bark.
	
Instead of tying the ball of yarn to the trunk: try tying the ball of yarn to the nice tree.

The bark is part of the nice tree.
The description of the bark is "It's rough, hale, and healthy. It protects the trunk well."

Instead of attacking or burning or cutting the bark: try burning the nice tree.

Instead of attacking the bark with: try attacking the nice tree with the second noun.

Instead of consulting the bark about: try examining the noun.
	
Instead of looking under the bark: try looking under the nice tree.
	
Instead of smelling the bark: try smelling the nice tree.
	
Instead of climbing the bark: try climbing the nice tree.
	
Instead of putting something on the bark: try inserting the noun into the nice tree.

Instead of removing the bark from: say "That seems likely to hurt the tree. Better to refrain."

Instead of listening to the bark: try listening to the trunk.

Instead of taking the bark: say "That seems likely to hurt the tree. Better to refrain."
	
Instead of throwing something at the bark: try throwing the noun at the nice tree.
	
Instead of touching or rubbing the bark: say "It's rough and flaky under your fingers."
	
Instead of tying the ball of yarn to the bark: try tying the ball of yarn to the nice tree.

Section 3 - Branches

Some branches are part of the nice tree. Understand "branch" or "twig" or "twigs" as the branches. The branches are distant and plural-named.
The description of the branches is "They sway gently in a light breeze."

Instead of attacking or burning or cutting the branches: try burning the nice tree.

Instead of attacking the branches with: try attacking the nice tree with the second noun.

Instead of consulting the branches about: try examining the noun.
	
Instead of smelling the branches: try smelling the nice tree.
	
Instead of removing the branches from: say "That seems likely to hurt the tree. Better to refrain."

Instead of listening to the branches: try listening to the nice tree.

Instead of taking the branches: say "That seems likely to hurt the tree. Better to refrain."
	
Instead of throwing something at the branches: try throwing the noun at the nice tree.

Section 4 - Leaves

Some leaves are part of the nice tree. Understand "leaf" as the leaves. The leaves are distant and plural-named.
The description of the leaves is "They rustle gently together."

Instead of attacking or burning or cutting the leaves: try burning the nice tree.

Instead of attacking the leaves with: try attacking the nice tree with the second noun.

Instead of consulting the leaves about: try examining the noun.
	
Instead of smelling the leaves: say "They smell green and sweet."
	
Instead of removing the leaves from: say "That seems likely to hurt the tree. Better to refrain."

Instead of listening to the leaves: say "The leaves rustle quietly in a gentle wind."

Instead of taking the leaves: say "That seems likely to hurt the tree. Better to refrain."
	
Instead of throwing something at the leaves: try throwing the noun at the nice tree.

Section 5 - Ladder

The rickety ladder is part of the nice three. Understand "plank/planks" or "step/steps" or "series" or "rusted/rusty" or "two/by/four/fours" or "twobyfour/twobyfours" or "two-by-four/two-by-fours" or "nail/nails/nailed" or "precarious" as the rickety ladder.
The description of the rickety ladder is "To call it a ladder might be overselling it. It's a series of two-by-fours nailed horizontally to the trunk, creating [unless a treehouse is visited]what you imagine must be [end unless]a precarious climbing experience."

Instead of attacking or burning or cutting the rickety ladder: say "That seems likely to hurt the tree."
	
Instead of attacking the rickety ladder with: say "That seems likely to hurt the tree."

Instead of consulting the rickety ladder about: try examining the noun.
	
Instead of smelling the rickety ladder: say "All you can smell is the tree. It smells green and sweet."
	
Instead of climbing the rickety ladder: try going up.

Instead of taking the rickety ladder: say "It's thoroughly attached to the tree."
	
Instead of throwing something at the rickety ladder: try throwing the noun at the nice tree.
	
Instead of touching or rubbing the rickety ladder: say "The planks are soft, but they should hold."
	
Instead of tying something to the rickety ladder: try tying the noun to the nice tree.

Section 6 - Lightning strike

A room can be tree-adjacent. A room is usually not tree-adjacent. A treehouse, Room5-4, Room5-5, Room5-6, Room6-4, Room6-5, Room6-6, Room7-4, Room7-5, and Room7-6 are tree-adjacent.

At 10:09 AM: if the location is tree-adjacent, say "You smell ozone."
		
At 10:10 AM:
	if the location is Room6-5:
		say "Suddenly, there's a bright flash, followed by an enormously loud booming noise. You instinctively throw up your arms to shield your eyes. When you lower them, you see before you what once was once a small tree is now a charred ruin.";
	otherwise if the location is a treehouse:
		say "A bright flash of light. A deafening boom. You are hurled to the ground as the tree is struck by lightning.";
	otherwise if the location is tree-adjacent and the location is not a treehouse:
		say "Suddenly, lightning strikes! It doesn't hit you, but it's close enough that you throw your hands over your eyes even as the thunder booms impossibly loud, incredibly close in your ears. After a moment, you lower your hands and find yourself unharmed.";
	otherwise:
		say "You see a bright flash of lightning strike somewhere else in the maze, followed almost immediately by an ear-splitting clap of thunder.";
	now the nice tree is nowhere;
	now the charred ruin is in Room6-5.
	
Chapter 5 - The charred ruin

Section 1 - The charred ruin itself

A charred ruin is scenery. It is nowhere. Understand "nice" or "tree" or "char" or "ruined" or "sapling" or "leaf/leaves" or "fruit" as the charred ruin.
The description of the charred ruin is "It still holds the general shape of the tree, though most of the auxiliary branches are gone. A charred black crack has appeared near its base, revealing a space underneath." 

Instead of attacking or burning or cutting the charred ruin: say "You're not likely to be able to do much more damage to it than has already been done at this point."

Instead of attacking the charred ruin with: say "You strike the charred ruin with the hammer. This accomplishes nothing."

Instead of consulting the charred ruin about: try examining the noun.
	
Instead of looking under the charred ruin: try examining the root-hole.
	
Instead of smelling the charred ruin: say "As expected, it smells of smoke."
	
Instead of climbing the charred ruin: say "You're afraid it won't hold your weight."
	
Instead of inserting something into the charred ruin: try inserting the noun into the root-hole.
	
Instead of listening to the charred ruin: say "It groans quietly."
	
Instead of throwing something at the charred ruin: say "You're not likely to be able to do much more damage to it than has already been done at this point."
	
Instead of touching or rubbing the charred ruin: say "Your fingers come away stained with soot."
	
Instead of tying the ball of yarn to the charred ruin: say "The yarn will do just as good a job guiding you back here laid on the ground as it will tied to the ruin."

To say tree-condition:
	if the nice tree is in the location:
		say "In its center stands a nice tree, [unless It Drizzles is happening]its branches waving gently in a breeze you can't quite feel[otherwise]its leaves weighed down and dripping with the rain[end unless]";
	otherwise:
		say "[if the nice tree is familiar]What was once a nice tree[otherwise]What was probably once a tree[end if] appears to have been struck by lightning, and is now just a charred ruin".
		
After looking when the location is Room6-4:
	if 64-65passage is present, say "[unless Room6-5 is visited]There's something[otherwise][tree-ruin][end unless] to the east."
	
After looking when the location is Room6-6:
	if 65-66passage is present, say "[unless Room6-5 is visited]There's something[otherwise][tree-ruin][end unless] to the west."
	
After looking when the location is Room7-5:
	if 65-75passage is present, say "[unless Room6-5 is visited]There's something[otherwise][tree-ruin][end unless] to the north."
	
After looking when the location is Room5-5:
	if 55-65passage is present, say "[unless Room6-5 is visited]There's something[otherwise][tree-ruin][end unless] to the south."
	
To say tree-ruin:
	if the nice tree is in Room6-5:
		say "The nice tree stands";
	otherwise if the charred ruin is in Room6-5 and the charred ruin is unfamiliar:
		say "What remains of the nice tree sits";
	otherwise:
		say "The charred ruin lies".
		
Section 2 - The root-hole and the time capsule
	
The root-hole is a container. It is part of the charred ruin. The printed name of the root-hole is "crack". The root-hole is fixed in place, open, and not openable. Understand "root/roots" or "earth" or "woody/wood/soft" or "hole" or "chamber" or "gap" or "crack/gap/space/chamber" or "under/underneath" as the root-hole.
The description of the root-hole is "When the tree was struck by lighting, it cracked in such a way that this space underneath was revealed."

Instead of attacking or burning or cutting the root-hole: try attacking the charred ruin.

Instead of attacking the root-hole with something: try attacking the charred ruin with the second noun.

Instead of consulting the root-hole about: try examining the noun.
	
Instead of looking under the root-hole: try examining the noun.
	
Instead of smelling the root-hole: say "As expected, it smells of smoke and earth."
	
Instead of giving something to the root-hole: try inserting the noun into the root-hole.
	
Instead of putting something on the root-hole: try inserting the noun into the root-hole.

Instead of listening to the root-hole: try listening to the charred ruin.
	
Instead of touching or rubbing the root-hole: say "The roots are woody; the earth is soft."

In the root-hole is a container called a time capsule. The time capsule is dirtied, closed, and openable. Understand "box" or "memory" or "hinged" or "promise/promises" or "empty" or "purple" or "hinged" or "lid" or "flowery" or "script" or "red" or "permanent" or "marker" or "ink" or "scribble/scribbles/scribbled" as "[capsule]". Understand "[capsule]" as the time capsule.
The description of the time capsule is "It's a purple plastic box with a hinged lid. Originally printed on the lid was the word 'PROMISES' in a flowery script, but that has been scribbled out with what looks to be red permanent marker, and 'TIME CAPSULE' has been written in its stead."
The maximum saturation of the time capsule is 1.

Does the player mean doing something to the time capsule: it is likely.
Does the player mean inserting something into the time capsule: it is likely.
After opening the time capsule: try searching the time capsule.

Rule for printing the name of the time capsule while listing contents of the root-hole: say "[if examined]time capsule[otherwise]purple box".

Instead of attacking or burning or cutting the time capsule: say "The time capsule isn't yours to destroy."

Instead of attacking the time capsule with: say "The time capsule isn't yours to destroy."

Instead of consulting the time capsule about: try examining the noun.
	
Instead of smelling the time capsule: say "It smells of the mildewy underground."
	
Instead of giving the time capsule to someone: say "The time capsule isn't yours to give away."
	
Instead of giving something to the time capsule: say "The time capsule's contents aren't yours to alter."
	
Instead of listening to the time capsule: say "It doesn't even try to make excuses."

Instead of touching or rubbing the time capsule: say "The plastic feels rough and cheap."

[NOTE: The time capsule is empty.]

Section 3 - Charred-trunk

The charred-trunk is part of the charred-ruin. Understand "charred" or "trunk/stem" or "bark" or "branch/branches" or "twig/twigs" as the charred-trunk. The printed name of the charred-trunk is "trunk".
The description of the charred-trunk is "Every bit of the tree has been left as nothing but a charred husk. Trunk, branches, bark, leaves[unicode 8230] all are now one indistinguishable mass."
Does the player mean doing something with the charred-trunk: it is unlikely.

Instead of attacking or burning or cutting the charred-trunk: try cutting the charred ruin.

Instead of attacking the charred-trunk with: try attacking the charred ruin with the second noun.

Instead of consulting the charred-trunk about: try examining the charred ruin.
	
Instead of looking under the charred-trunk: try examining the root-hole.
	
Instead of smelling the charred-trunk: try smelling the charred ruin.
	
Instead of climbing the charred-trunk: try climbing the charred ruin.
	
Instead of inserting something into the charred-trunk: try inserting the noun into the root-hole.
	
Instead of listening to the charred-trunk: try listening to the charred ruin.
	
Instead of throwing something at the charred-trunk: try throwing the noun at the charred ruin.
	
Instead of touching or rubbing the charred-trunk: try touching the charred ruin.
	
Instead of tying the ball of yarn to the charred-trunk: try tying the ball of yarn to the charred ruin.

Chapter 6 - The treehouse

Section 1 - The room

A treehouse is a room. "Here among the leaves, someone has built a small wooden platform." A treehouse is up from Room6-5. The printed name of a treehouse is "A treehouse".

At 10:10 AM:
	change the up exit of Room6-5 to nowhere;
	change the down exit of a treehouse to nowhere;
	if the player is in a treehouse:
		move the player to Room6-5.

Every turn:
	if a treehouse is beyarned:
		now a treehouse is not beyarned.
		
Section 2 - Wood planks
		
The wood planks are scenery in a treehouse. Understand "wooden" or "plank" or "platform" or "floor" or "knot/knots" or "dark/darker" as the wood planks. The description of the wood planks is "Wood that was once new is now worn smooth. What must have been thousands of paces have thoroughly broken it in. It is darker than the tree itself, and dotted with knots." The wood planks are plural-named.

Instead of attacking or burning or cutting the wood planks: say "This is a sacred space. You must not desecrate it."
	
Instead of attacking the wood planks with: say "This is a sacred space. You must not desecrate it."

Instead of consulting the wood planks about: try examining the noun.
	
Instead of climbing the wood planks: say "The planks make a flat surface[unicode 8212]there's nothing there to climb."
	
Instead of putting something on the wood planks: try dropping the noun.

Instead of removing something from the wood planks: try taking the noun.

Instead of listening to the wood planks: say "The planks creak plaintively under your feet."

Instead of opening the wood planks: say "There's no hatch[unicode 8212]just a hole leading down."

Instead of closing the wood planks: say "There's no hatch[unicode 8212]just a hole leading down."
	
Instead of taking the wood planks: say "The planks are firmly nailed in place."
	
Instead of throwing something at the wood planks: try dropping the noun.
	
Instead of touching or rubbing the wood planks: say "They have been worn smooth and shiny."
	
Instead of tying the ball of yarn to the wood planks: say "You don't want to risk the yarn getting tangled in the tree."

Section 3 - The roof, the light, its absence

The roof is scenery in a treehouse. Understand "rooftop" or "ceiling" or "aged/age" or "crack/cracks/cracked" or "rough/roughness" or "soft/softness" as the roof. The description of the roof is "Wood that was once new is now weather-aged[unless It Drizzles is happening]. Cracks between the planks let in blades of light[end unless]."

Instead of attacking or burning or cutting the roof: say "This is a sacred space. You must not desecrate it."
	
Instead of attacking the roof with: say "This is a sacred space. You must not desecrate it."

Instead of consulting the roof about: try examining the noun.
	
Instead of listening to the roof: say "The roof is stoic and silent."

Instead of taking the roof: say "The planks are firmly nailed in place."
	
Instead of throwing something at the roof:
	say "You throw [the noun] upwards. It lands at your feet.";
	silently try dropping the noun.
	
Instead of touching or rubbing the roof: say "The wood is rough, yet soft."
	
Instead of tying the ball of yarn to the roof: say "You don't want to risk the yarn getting tangled in the tree."

The blades of light are scenery in a treehouse. Understand "blade/shaft" or "sunlight" as the blades of light. The description is "They stream through the cracks in the roof."

Instead of attacking or burning or cutting the blades of light: say "The light is incorporeal, and can't be injured."

Instead of consulting the blades of light about: try examining the noun.
	
Instead of looking under the blades of light: say "The light is incapable of hiding anything; in fact, it does the opposite."
	
Instead of drinking or eating or tasting or touching or rubbing or wearing the blades of light: say "The light is incorporeal, but warm."
	
Instead of smelling the blades of light: say "The light has no scent."
	
Instead of climbing the blades of light: say "The light is incorporeal, and cannot be climbed."
	
Instead of inserting something into the blades of light: say "The light is incorporeal, and can contain nothing."
	
Instead of putting something on the blades of light: say "The light is incorporeal, and can support nothing."

Instead of listening to the blades of light: say "The light has nothing to say to you."

Instead of taking the blades of light: say "The light is incorporeal, and cannot be taken."
	
Instead of throwing something at the blades of light: say "That's unlikely to damage the light much."
	
Instead of tying something to the blades of light: say "The light is incorporeal."

The absence of light is privately-named scenery in a treehouse. The description is "The light has faded."

Instead of doing something to the blades of light during It Drizzles: try examining the absence of light.

Section 4 - Tree-leaves

The tree-leaves are scenery in a treehouse. The printed name of the tree-leaves is "leaves". Understand "leaf/leaves" as the tree-leaves. The description of the tree-leaves is "They rustle gently together." The tree-leaves are plural-named.

Instead of attacking or burning or cutting the tree-leaves: say "This is a sacred space. You must not desecrate it."
	
Instead of attacking the tree-leaves with: say "This is a sacred space. You must not desecrate it."

Instead of consulting the tree-leaves about: try examining the noun.
	
Instead of smelling the tree-leaves: say "The leaves smell green and sweet."
	
Instead of inserting something into the tree-leaves:
	move the noun to Room6-5;
	say "[The noun] crashes through the leaves to the ground below."
	
Instead of putting something on the tree-leaves:
	move the noun to Room6-5;
	say "[The noun] crashes through the leaves to the ground below."

Instead of listening to the tree-leaves: say "The leaves rustle quietly in a gentle wind."

Instead of taking the tree-leaves: say "That seems likely to hurt the tree. Better to refrain."
	
Instead of throwing something at the tree-leaves:
	move the noun to Room6-5;
	say "[The noun] crashes through the leaves to the ground below."
	
Instead of touching or rubbing the tree-leaves: say "The leaves are smooth and [if It Drizzles is happening]dripping[otherwise]damp[end if]."
	
Instead of tying the ball of yarn to the tree-leaves: say "You don't want to risk the yarn getting tangled in the tree."

Section 5 - Tree-branches

The tree-branches are scenery in a treehouse. The printed name of the tree-branches is "branches". Understand "branch/branches" or "twig/twigs" or "bark" as the tree-branches. The description of the tree-branches is "They sway gently in a light breeze." The tree-branches are plural-named.

Instead of attacking or burning or cutting the tree-branches: say "This is a sacred space. You must not desecrate it."
	
Instead of attacking the tree-branches with: say "This is a sacred space. You must not desecrate it."

Instead of consulting the tree-branches about: try examining the noun.
	
Instead of smelling the tree-branches: say "The branches smell green and sweet."
	
Instead of climbing the tree-branches: say "They seem unlikely to hold your weight[unicode 8212]better not to stray from the platform."
	
Instead of inserting something into the tree-branches:
	move the noun to Room6-5;
	say "[The noun] crashes through the branches to the ground below."
	
Instead of putting something on the tree-branches:
	move the noun to Room6-5;
	say "[The noun] crashes through the branches to the ground below."

Instead of listening to the tree-branches: say "The leaves rustle quietly in a gentle wind."

Instead of taking the tree-branches: say "That seems likely to hurt the tree. Better to refrain."
	
Instead of throwing something at the tree-branches:
	move the noun to Room6-5;
	say "[The noun] crashes through the branches to the ground below."
	
Instead of touching or rubbing the tree-branches: say "The bark is rough and flaky under your fingers."
	
Instead of tying the ball of yarn to the tree-branches: say "You don't want to risk the yarn getting tangled in the tree."

Section 6 - Bookcase

The bookcase is in a treehouse. "Against one wall is a stuffed, sagging bookcase." It is fixed in place. Understand "bookshelf/shelf/shelves" or "case" or "stuffed/stuff/stuffing" or "sag/sags/sagging" as the bookcase. The maximum saturation of the bookcase is 0.
The description of the bookcase is "The bookcase is old enough do be designated as [']old,['] but not quite old enough to be antique. Every shelf sags towards the middle under the weight of far too many books[unicode 8212]there are enough stuffed in that atop the ones lined up vertically, there are several layers more stacked horizontally, such that there is absolutely no open space."

Instead of attacking or burning or cutting the bookcase: say "This is a sacred space. You must not desecrate it."

Instead of attacking the bookcase with: say "This is a sacred space. You must not desecrate it."

Instead of consulting the bookcase about: try examining the noun.
	
Instead of searching the bookcase: say "Dozens and dozens of books."
	
Instead of looking under the bookcase: say "The bottom is flush with the floor."
	
Instead of smelling the bookcase: say "It smells like it's been damp for a very long time."
	
Instead of climbing the bookcase: say "The bookcase seems unlinkely to be able to hold much more weight. Better to refrain."
	
Instead of inserting something into the bookcase: say "The bookcase is stuffed too full of books to accomodate [the noun]."
	
Instead of putting something on the bookcase: say "The bookcase is stuffed too full of books to accomodate [the noun]."

Instead of removing something from the bookcase: say "These books are not yours to take. You don't see any that would be of much use to you, anyway."

Instead of listening to the bookcase: say "It creaks plaintively."

Instead of taking the bookcase: say "It's far too heavy to move."
	
Instead of pushing the bookcase: say "It's far too heavy to move."
	
Instead of throwing something at the bookcase: say "This is a sacred space. You must not desecrate it."
	
Instead of touching or rubbing the bookcase: say "The wood is soft and damp."
	
Instead of tying something to the bookcase: say "The books are stuffed in far too tight to leave any space to loop around."

The books are part of the bookcase. Understand "book" as the books. The maximum saturation of the books is 0. The books are plural-named.
The description of the books is "There must be hundreds of books here, on hundreds of subjects: sociology, history, music theory, techniques of environmental storytelling[unicode 8230] none of them particularly catch your eye."

Instead of attacking or burning or cutting the books: say "This is a sacred space. You must not desecrate it."

Instead of attacking the books with: say "This is a sacred space. You must not desecrate it."

Instead of consulting the books about: try examining the noun.
	
Instead of searching the books: say "You peruse the spines. [one of]There's one here[or]You see one[or]One's[at random] [one of]titled[or]called[or]named[cycling] '[book-title],' but you decide not to take the time to read it."

To say book-title: say "[one of]A World Without Borders: Steps Towards Utopia[or]Dead Girls, No Mothers[or]Environmental Storytelling 101: Volumes Without Words[or]Francis Bacon: Painting the Town Red[or]Kiss of Beth[or]Please Fear Wagner[or]To Serve the Hive[or]We, the Remainder[in random order]".
	
Instead of smelling the books: say "The musty smell of old paper and mildew."
	
Instead of removing the books from: try taking the books.

Instead of listening to the books: say "Books are, traditionally, a silent medium."

Instead of opening the books: try searching the books.

Instead of closing the books: say "They're too tightly packed to be opened in the first place."
	
Instead of taking the books: say "They're not yours to take[unicode 8212]you're not sure you'd know how to utilize them to escape the maze."
	
Instead of throwing something at the books: try throwing the noun at the bookcase.
	
Instead of touching or rubbing the books: say "They're ratty but universally well-bound[unicode 8212]you find yourself thinking that they don't make them like this anymore."
	
Instead of tying something to the books: try tying the noun to the bookcase.

Section 7 - Throw rug

The throw rug is in a treehouse. "A circular throw rug covers the center of the floor." It is fixed in place. Understand "carpet" or "ratty" or "circle/circular" as the throw rug. The maximum saturation of the throw rug is 0.
The description of the throw rug is "The rug is in a simple circular crocheted pattern. It looks handmade, out of red yarn[if the ball of yarn is carried][unicode 8212]red yarn very similar to the ball you yourself are carrying[end if]."

Instead of attacking or burning or cutting the throw rug: say "This is a sacred space. You must not desecrate it."

Instead of attacking the throw rug with: say "This is a sacred space. You must not desecrate it."

Instead of consulting the throw rug about: try examining the noun.
	
Instead of looking under the throw rug: say "There's nothing underneath."
	
Instead of smelling the throw rug: say "Mildew and memories."
	
Instead of inserting something into the throw rug: try dropping the noun.
	
Instead of putting something on the throw rug: try dropping the noun.

Instead of taking the throw rug: say "It's not yours to take. You can't think of any use for it, anyway."
	
Instead of throwing something at the throw rug: try dropping the noun.
	
Instead of touching or rubbing the throw rug: say "The woven strands are rough and worn."

Section 8 - Easy chair

The easy chair is an enterable supporter in a treehouse. "A worn easy chair sits in one corner; a pile of calendars dominates another." It is fixed in place. It has carrying capacity 1. Understand "lazy/boy/la-z-boy" or "recline/reclining/recliner" or "soft" or "seat" or "arm/armchair" or "plush" or "frame" or "threadbare/scratchy" or "cover" or "faded" or "smelly" as the easy chair. The maximum saturation of the easy chair is 0.
The description of the easy chair is "This is a chair that's seen years of use. The once-plush seat now sinks down into the frame. The arms are threadbare and scratchy. The cover is faded and smelly."

Instead of attacking or burning or cutting the easy chair: say "This is a sacred space. You must not desecrate it."

Instead of attacking the easy chair with: say "This is a sacred space. You must not desecrate it."

Instead of consulting the easy chair about: try examining the noun.
	
Instead of looking under the easy chair: say "Nothing of interest underneath."
	
Instead of smelling the easy chair: say "It smells like mildew and stale sweat."
	
Instead of climbing the easy chair: try entering the easy chair.
	
Instead of inserting something into the easy chair: try putting the noun on the easy chair.
	
Instead of removing something from the easy chair: try taking the noun.	

Instead of taking the easy chair: say "It's too large to carry around with you."
	
Instead of throwing something at the easy chair: say "This is a sacred space. You must not desecrate it."
	
Instead of touching or rubbing the easy chair: say "It was probably once soft, but now it's old and scratchy."
	
Instead of tying something to the easy chair: say "You're not sure what good that would do."

Section 9 - Pile of calendars

The pile of calendars is scenery in the treehouse. Understand "calendar" or "stack" or "disorganized" or "dozen/dozens" or "year/years" as the pile of calendars. The maximum saturation of the pile of calendars is 0.
The description of the pile of calendars is "Taking up an entire corner of the room is a disorganized pile of dozens of calendars, each one from a different year."
The pile of calendars can be fake-open or fake-closed. The pile of calendars is fake-closed.

After reading a command:
	let C be "[the player's command]";
	replace the regular expression "\d\d\d\d" in C with "calendar";
	change the text of the player's command to C.

Instead of attacking or burning or cutting the pile of calendars: say "This is a sacred space. You must not desecrate it."

Instead of attacking the pile of calendars with: say "This is a sacred space. You must not desecrate it."

Instead of consulting the pile of calendars about: try examining the noun.
	
Instead of looking under the pile of calendars: say "You don't dare; you fear the pile will collapse atop you and bury you."
	
Instead of smelling the pile of calendars: say "Like the rest of the treehouse, they smell mostly of mold."
	
Instead of climbing the pile of calendars: say "You don't dare; you fear the pile will collapse atop you and bury you."
	
Instead of inserting something into the pile of calendars: say "You don't dare; you fear [the noun] might be buried and lost forever."
	
Instead of putting something on the pile of calendars: say "You don't dare; you fear [the noun] might be buried and lost forever."

Instead of removing something from the pile of calendars: say "You don't dare; you fear the pile will collapse atop you and bury you."

Instead of listening to the pile of calendars: say "They hold their secrets close."

Before trying opening the pile of calendars: try searching the noun instead.

Before trying closing the pile of calendars:
	if the pile of calendars is fake-open:
		now the pile of calendars is fake-closed;
		say “You flip the open calendars closed.”;
	otherwise:
		say “The calendars are all closed already.”;
	rule fails.
	
Instead of searching the pile of calendars:
	now the pile of calendars is fake-open;
	say "You flip open one of the calendars. It's dated to [one of]last year[or]two years ago[or]around a decade ago[or]almost fifty years ago[in random order]. Every date is crossed off in varying colors of pen. Accompanying each month is [one of]a schematic or map of a maze, though you're quite certain none of them are the maze you're currently in.[or]a different photo of a cat hanging from a tree branch, each and every one captioned [']hang in there!['][conditional paragraph break][or]a photograph of John Everyman in a different pinup-style pose, though he's wearing a full business suit in each one.[or]an in memoriam for someone who died in a maze.[in random order]".
	
Instead of taking the pile of calendars: say "You don't dare; you fear the pile will collapse atop you and bury you."
	
Instead of pushing the pile of calendars: say "You don't dare; you fear the pile will collapse atop you and bury you."
	
Instead of throwing something at the pile of calendars: say "You don't dare; you fear [the noun] might be buried and lost forever."
	
Instead of touching or rubbing the pile of calendars: say "The paper is soft and damp."
	
Instead of tying something to the pile of calendars: say "You're not sure what good that would do."

Chapter 7 - The fountain

Section 1 - The fountain itself

The fountain is a container in Room2-3. "A great grand fountain stands at the room's center, its circular basin filled with moving water." Understand "fountain" or "spring" or "stone" or "basin" or "pillar" or "pool" as "[fountain]". Understand "[fountain]" as the fountain.
The fountain is fixed in place, enterable, open, transparent, and not openable. The fountain is cleansing and wet.
The fountain can be busted. The fountain is not busted.
The description of the fountain is "The basin is very wide, and the water in it is about knee-deep. The central pillar is carved to look like three Renaissance-era maidens, their wet dresses sticking to their skin, vomiting the water into the pool below."

Instead of attacking or burning or cutting the fountain: say "That's unlikely to be productive."

Instead of consulting the fountain about: try examining the noun.
	
Instead of looking under the fountain: try looking under the fountain-water.
	
Instead of drinking or eating or tasting the fountain: try drinking the fountain-water.
	
Instead of smelling the fountain: say "It doesn't smell like much more than water."
	
Instead of climbing the fountain: say "It's slick with water[unicode 8212]you'd be liable to fall."
	
Instead of giving something to the fountain:
	try washing the noun with the fountain-water;
	try inserting the noun into the fountain.
	
Before inserting something into the fountain:
	try washing the noun with the fountain-water;
	continue the action.
	
Instead of listening to the fountain: say "The sound of falling water is almost musical."

Instead of throwing something at the fountain:
	try washing the noun with the fountain-water;
	try inserting the noun into the fountain.
	
Instead of touching or rubbing the fountain: say "The stone is rough and damp."
	
Instead of tying the ball of yarn to the fountain: say "The yarn will do just as good a job guiding you back here laid on the ground as it will tied to the fountain."

After looking when the location is Room1-3:
	if 13-23passage is present, say "[unless Room2-3 is visited]There's something[otherwise]The fountain sits[end unless] to the south."
	
After looking when the location is Room2-2:
	if 22-23passage is present, say "[unless Room2-3 is visited]There's something[otherwise]The fountain sits[end unless] to the east."
	
After looking when the location is Room2-4:
	if 23-24passage is present, say "[unless Room2-3 is visited]There's something[otherwise]The fountain sits[end unless] to the west."
	
After looking when the location is Room3-3:
	if 23-33passage is present, say "[unless Room2-3 is visited]There's something[otherwise]The fountain sits[end unless] to the north."
	
Section 2 - Damaging the fountain

The fountain has a number called the damage. The damage of the fountain is 0.

Check attacking the fountain with the sledgehammer:
	if the damage of the fountain is 2:
		say "You don't have the heart to damage it any more." instead.

Carry out attacking the fountain with the sledgehammer:
	increment the damage of the fountain;
	if the damage of the fountain is 2:
		now the groundwater is in the location;
		now the fountain is not cleansing;
		now the fountain-water is not cleansing.
		
Report attacking the fountain with the sledgehammer:
	if the damage of the fountain is 1:
		say "You strike the side of the fountain's basin with the sledgehammer. A large crack appears and water begins dripping out.";
	otherwise if the damage of the fountain is 2:
		say "You strike the basin again. The side crumbles and water begins to spill out. It mixes with the [dirt-mud] and grows filthy."

Section 3 - The carved maidens

The carved maidens are part of the fountain. The carved maidens are fixed in place and wet.
Understand "maiden/maidens/woman/women/girl/girls" or "carved/carving" or "sculpture/sculpted" or "slip/dress/dresses" or "translucent/transparent" or "breasts/breast/bust/tit/tits/boob/boobs" or "loving/love" or "detail/shape/shaping" or "face/faces/expression/expressions" or "twisted/twist/discomfort/discomforted/uncomfortable" or "vomiting/vomit" or "crude/cruder" or "Renaissance" as "[maidens]". Understand "[maidens]" as the carved maidens.
The description of the carved maidens is "They have been carved as if their slip dresses have been rendered translucent by the water. The breasts are rendered in loving detail, as are the faces, twisted in discomfort from continuously vomiting water. Below the bust the shaping is much cruder, as if the sculptor lost interest as he went further down."

Instead of attacking or burning or cutting the carved maidens: say "That seems unnecessary and cruel."

Instead of attacking the carved maidens with: say "You know they're just carved stone, but the thought still repulses you."

Instead of consulting the carved maidens about: say "The maidens are too busy vomiting water to reply. Besides, they're made of stone."
	
Instead of climbing the carved maidens: try climbing the fountain.

Instead of listening to the carved maidens: say "The maidens are too busy vomiting water to speak. Besides, they're made of stone."
	
Instead of throwing something at the carved maidens: try attacking the carved maidens.
	
Instead of touching or rubbing or smelling the carved maidens:
	unless the player is in the fountain:
		say "You can't reach the central pillar from the edge of the fountain.";
	otherwise:
		say "That feels vaguely creepy. Better to refrain."
	
Instead of tying the ball of yarn to the carved maidens: try tying the noun to the fountain.

Section 4 - The fountain water

The fountain-water is part of the fountain. The printed name of the fountain-water is "the water". The fountain-water is fixed in place, cleansing and wet.
Understand "water" or "liquid" or "cleaning/clean/cleansing/cleanse" or "flow/trickle/torrent/pressure/current" as the fountain-water.
The description of the fountain-water is "It's crystal clear, but probably not potable."

Instead of attacking or burning or cutting the fountain-water: say "That's unlikely to be productive."

Instead of attacking fountain-water with: say "That's unlikely to be productive."

Instead of consulting the fountain-water about: try examining the noun.

Instead of looking under the fountain-water:
	let F be the number of things in the fountain;
	if F > 0:
		say "Submerged in the water [is-are a list of things in the fountain].";
	otherwise:
		say "There's only water in the basin."
	
Instead of drinking or eating or tasting the fountain-water: say "You doubt it's potable."
	
Instead of smelling the fountain-water: say "It smells faintly of copper."
	
Instead of giving something to the fountain-water:
	try washing the noun with the fountain-water;
	try inserting the noun into the fountain.
	
Instead of showing something to the fountain-water: try washing the noun with the fountain-water.

Instead of inserting something into the fountain-water:
	try washing the noun with the fountain-water;
	try inserting the noun into the fountain.
	
Instead of putting something on the fountain-water:
	try washing the noun with the fountain-water;
	try inserting the noun into the fountain.

Instead of removing something from the fountain-water: try taking the noun.

Instead of listening to the fountain-water: say "It flows and burbles quietly over itself."

Instead of taking the fountain-water: say "There's far too much of it to carry with you, and you're not sure it will be of much use anywhere else."
	
Instead of throwing something at the fountain-water:
	try washing the noun with the fountain-water;
	try inserting the noun into the fountain.
	
Instead of touching or rubbing the fountain-water: say "Your hands come away wet."

Section 5 - Groundwater

The groundwater is scenery. Understand "ground" or "water" or "filthy" or "spill/spilled" as the groundwater. The groundwater is dirtied.

Instead of attacking or burning or cutting the groundwater: say "That's unlikely to be productive."

Instead of attacking groundwater with: say "That's unlikely to be productive."

Instead of consulting the groundwater about: try examining the noun.

Definition: a thing is movable if it is not fixed in place and it is not scenery and it is not a backdrop.

[Instead of looking under the groundwater:
	let L be a list of things;
	repeat with obj running through other movable things in the location:
		add obj to L;
	repeat with obj2 running through carried things:
		remove obj2 from L, if present;
	let M be the number of entries in L;
	if M > 1:
		say "Slowly soaking in the groundwater are [L].";
	otherwise if M is 1:
		say "Slowly soaking in the groundwater is [L].";
	otherwise:
		say "The only thing under the water is the ground itself."]
		
Instead of looking under the groundwater:
	prepare a list of other movable things in the location;
	if the number of filled rows in the Table of Scored Listing > 0:
		say "Slowly soaking in the groundwater [is-are a prepared list].";
	otherwise:
		say "The only thing under the water is the ground itself."
	
Instead of drinking or eating or tasting the groundwater: say "That's definitely not potable."
	
Instead of smelling the groundwater: say "It smells faintly of copper and strongly of dirt."
	
Instead of giving something to the groundwater:
	try dropping the noun;
	if the noun is in the location and the noun is not carried:
		now the noun is dirtied.
	
Instead of showing something to the groundwater:
	try dropping the noun;
	if the noun is in the location and the noun is not carried:
		now the noun is dirtied.

Instead of inserting something into the groundwater:
	try dropping the noun;
	if the noun is in the location and the noun is not carried:
		now the noun is dirtied.
	
Instead of putting something on the groundwater:
	try dropping the noun;
	if the noun is in the location and the noun is not carried:
		now the noun is dirtied.

Instead of removing something from the groundwater: try taking the noun.

Instead of listening to the groundwater: say "It splashes quietly as it spreads."

Instead of taking the groundwater: say "There's far too much of it to carry with you, and you're not sure it will be of much use anyway."
	
Instead of throwing something at the groundwater:
	try dropping the noun;
	if the noun is in the location and the noun is not carried:
		now the noun is dirtied.
	
Instead of touching or rubbing the groundwater: say "Your hands come away wet and filthy."

Section 6 - River rocks

A river rock is a kind of thing. A river rock is usually wet. Four river rocks are in the fountain.
Understand "rocks" or "smooth" or "stone/stones" as a river rock.
The description of a river rock is usually "It's a smooth, porous rock."

Instead of attacking or burning or cutting a river rock: say "That's unlikely to be productive."

Instead of attacking a river rock with: say "That's unlikely to be productive."

Instead of consulting a river rock about: try examining the noun.
	
Instead of smelling a river rock: say "It doesn't have a smell."
	
Instead of listening to a river rock: say "It doesn't seem inclined to talk to you."

Instead of throwing something at a river rock: try throwing the second noun at the noun.
	
Instead of touching or rubbing a river rock: say "Its surface is cool and rough."

Check dropping a river rock (called the stone):
	if a security camera (called the lens) is in the location:
		try throwing the stone at the lens instead.
		
Does the player mean throwing something carried at: it is very likely.

Carry out throwing a river rock at a security camera:
	now the second noun is busted;
	now the noun is in the location;
	continue the action.
	
After throwing a river rock at a security camera:
	say "You hurl the rock as hard as you can at the camera. It [one of]strikes[or]hits[or]glances off[or]nails[cycling] the [one of]lens[or]glass[or]side[or]mount[in random order], causing [one of]a shower of sparks[or]it to crack[or]a harsh electrical noise[or]what surely must be thousands of dollars of damage[in random order]. You've broken the camera[unicode 8212]it won't be watching you anymore.";
	continue the action.
	
Carry out throwing a river rock at an LED ticker sign:
	now the second noun is busted;
	now the noun is in the location.
	
After throwing a river rock at an LED ticker sign:
	say "You hurl the rock as hard as you can at the sign. It [one of]strikes[or]hits[or]glances off[or]nails[cycling] the [one of]glass[or]box[or]display[in random order], causing [one of]a shower of sparks[or]it to crack[or]a harsh electrical noise[or]what surely must be thousands of dollars of damage[in random order]. You've broken the sign[unicode 8212]it can't communicate anything anymore.";
	continue the action.
	
The futile to throw things at inanimate objects rule is not listed in the check throwing it at rulebook.
The block throwing at rule is not listed in the check throwing it at rulebook.

Report throwing a river rock at something (this is the standard report throwing it at rule):
	if the second noun is not an LED ticker sign and the second noun is not a security camera:
		say "You throw the rock at [the noun]. This achieves nothing."

Chapter 8 - The graveyard

Section 1 - The yard

The graveyard is in Room8-2. "In the middle of the room is what appears to be a small graveyard." The graveyard is fixed in place. Understand "graveyard" or "yard" as "[graveyard]". Understand "[graveyard]" as the graveyard.
The description of the graveyard is "It's made up of four graves, each with a tombstone with a different epitaph."
The maximum saturation of the graveyard is 15.

Definition: a supporter is empty if the number of things on it is 0.

Report examining the graveyard:
	repeat with spot running through graves:
		if spot is not empty:
			let X be a random thing on spot;
			say "On the [spot] lies [an X]."

Instead of attacking or burning or cutting or looking under the graveyard: say "That strikes you as rather disrespectful. Better to refrain."

Instead of attacking the graveyard with: say "That strikes you as rather disrespectful. Better to refrain."

Instead of consulting the graveyard about:
	if the second noun is a grave:
		try examining the second noun;
	otherwise:
		try examining the noun.
		
Instead of searching the graveyard: try examining the noun.
	
Instead of smelling the graveyard: say "It smells of decay."
	
Instead of giving something to the graveyard: say "You'll have to specify which grave you'd like to put [the noun] on."

Instead of inserting something into the graveyard: say "You'll have to specify which grave you'd like to put [the noun] on."
	
Instead of putting something on the graveyard: say "You'll have to specify which grave you'd like to put [the noun] on."

Instead of removing something from the graveyard: try taking the noun.

Instead of listening to the graveyard: say "Quiet as death."

Instead of taking the graveyard: say "You can't take it with you; it's simply too big."
	
Instead of touching or rubbing the graveyard: say "The earth is cold and still."

Instead of pulling or pushing or turning the graveyard: say "It's not going anywhere."

Instead of pulling or pushing or turning a grave: try pulling the graveyard.

Instead of pulling or pushing or turning a tombstone: try pulling the graveyard.

After looking when the location is Room8-1:
	if 81-82passage is present, say "[unless Room8-2 is visited]There's something[otherwise]The graveyard lies[end unless] to the east."
	
After looking when the location is Room8-3:
	if 82-83passage is present, say "[unless Room8-2 is visited]There's something[otherwise]The graveyard lies[end unless] to the west."
	
After looking when the location is Room9-2:
	if 82-92passage is present, say "[unless Room8-2 is visited]There's something[otherwise]The graveyard lies[end unless] to the north."
	
After looking when the location is Room7-2:
	if 72-82passage is present, say "[unless Room8-2 is visited]There's something[otherwise]The graveyard lies[end unless] to the south."

Section 3 - Grave 1

A grave called grave1 is part of the graveyard. The printed name is "the first grave". The relic of grave1 is the dirty ribbon.
Understand "1/one" or "1st/first" as grave1.

A tombstone called stone1 is part of the graveyard. The printed name is "first tombstone". Stone1 marks grave1.
Understand "1/one" or "1st/first" as stone1.
The message of stone1 is "She told them who she was, and was disbelieved. Now she lies here under the wrong name."

Section 4 - Grave 2

A grave called grave2 is part of the graveyard. The printed name is "the second grave". The relic of grave2 is the book of paint swatches.
Understand "2/two" or "2nd/second" as grave2.

A tombstone called stone2 is part of the graveyard. The printed name is "second tombstone". Stone2 marks grave2.
Understand "2/two" or "2nd/second" as stone2.
The message of stone2 is "It wasn't viable, but she was disallowed from saving herself. Now the both of them lie here."

Section 5 - Grave 3

A grave called grave3 is part of the graveyard. The printed name is "the third grave". The relic of grave3 is the wilted flower. Understand "space" as the grave3.
The description of grave3 is "The earth is, as of yet, untouched. The grass overtop of it is still intact."
Understand "3/three" or "3rd/third" as grave3.

A tombstone called stone3 is part of the graveyard. The printed name is "third tombstone". Stone3 marks grave3.
Understand "3/three" or "3rd/third" as stone3.
The message of stone3 is "This one's[unicode 8230] for you. They just assumed you'd need one."

Instead of burning or cutting stone3: try attacking the noun.

Check attacking stone3:
	if the sledgehammer is not carried:
		say "If you're going to destroy your own tombstone, you want to make sure you have the kind of weapon to do it properly." instead;
	otherwise:
		try attacking grave3 with the sledgehammer instead.
		
Report attacking stone3 with the sledgehammer: say "You smash the tombstone to smithereens with the sledgehammer. The rubble falls over the grave."

Instead of digging in or looking under grave3: say "That strikes you as rather morbid. You're not in any hurry to lie in it."
		
Instead of throwing something at grave3: try putting the noun on the second noun.

Carry out attacking stone3 with the sledgehammer:
	now stone3 is nowhere;
	now the rubble is in Room8-2;
	now the rubble is part of the graveyard.
	
The rubble is a thing. Understand "tomb" or "stone" or "tombstone" or "three/3/3rd/third" or "remain/remains" or "smithereen/smithereens" as the rubble.
The description of the rubble is "It's the remains of the tombstone that was made for you."

Instead of attacking or burning or cutting the rubble: say "You don't feel much of a need to destroy it any more than you already have."

Instead of attacking the rubble with: say "You don't feel much of a need to destroy it any more than you already have."

Instead of consulting the rubble about: try examining the noun.
	
Instead of drinking or eating or tasting the rubble: say "Gross. Better to refrain."
	
Instead of smelling the rubble: say "It smells of cold earth."

Instead of listening to the rubble: say "It is cold and still and silent."

Instead of touching or rubbing the rubble: say "The stone is rough[if It Drizzles is happening], cold, and damp[otherwise] and cold[end if]."
	
Instead of tying the ball of yarn to the rubble: say "The yarn will guide you back here just as well laid on the ground as it will tied to the rubble."

Instead of looking under the rubble: say "It's scattered over the third grave."
	
Instead of giving something to the rubble: try putting the noun on grave3.
	
Instead of showing something to the rubble: try putting the noun on grave3.

Instead of inserting something into the rubble: try putting the noun on grave3.
	
Instead of putting something on the rubble: try putting the noun on grave3.

Instead of taking the rubble: say "You don't really want to take it with you. You feel it belongs here."
	
Instead of throwing something at the rubble: say "You can't bring yourself to follow through."

Section 6 - Grave 4

A grave called grave4 is part of the graveyard. The printed name is "the fourth grave". The relic of grave4 is the triangle lighter.
Understand "4/four" or "4th/fourth" as grave4.

A tombstone called stone4 is part of the graveyard. The printed name is "fourth tombstone". Stone4 marks grave4.
Understand "4/four" or "4th/fourth" as stone4.
The message of stone4 is "When it began, they crowded aroun the doors. But no one outside cared enough to let them out before their skin began to peel."

[NOTE: This grave (and the lighter associated with it) was meant to reference the Triangle Shirtwaist Factory Fire, and workers' rights more broadly. Perhaps it was too subtle, because I don't think I've seen anyone pick up on it.]

Section 7 - Rest-count

The rest-count is a number that varies. Rest-count is 0.

Carry out putting the dirty ribbon on grave1 for the first time (this is the first rest rule): increment the rest-count.
Carry out putting the book of paint swatches on grave2 for the first time (this is the second rest rule): increment the rest-count.
Carry out putting the wilted flower on grave3 for the first time (this is the third rest rule): increment the rest-count.
Carry out putting the triangle lighter on grave4 for the first time (this is the fourth rest rule): increment the rest-count.

Part 3 - Things that can affect multiple rooms

Chapter 1 - The yarn

The ball of yarn is in Room5-4. "On the ground sits a big ball of red wool yarn." 
Understand "ball" or "of" or "yarn" or "big/large/bright/red" or "wool/woolen/cotton" or "tight/tightly/weight/gauge" or "wound/ply/plied" or "frayed/pilling/pill/pills" or "end" or "sphere/ballband/ball/band/skein" or "double knit/--" or "dk/knit/knitting/worsted" or "cord/string/cable/hank/lace" as "[yarn]". Understand "[yarn]" as the ball of yarn.
The description of the ball of yarn is "It's a [yarn-size] sphere of tightly-wound red yarn. [if the location is Room5-4]The end is slightly frayed[otherwise]Its end trails off behind you[end if]."
The maximum saturation of the ball of yarn is 20.

To say yarn-size:
	if the number of beyarned rooms < 20:
		say "large";
	otherwise if the number of beyarned rooms < 40:
		say "medium-sized";
	otherwise:
		say "smallish".

Instead of attacking or burning or cutting the ball of yarn: say "Don't destroy your only lifeline!"

Instead of attacking the ball of yarn with: say "You doubt that's likely to accomplish much."

Instead of consulting the ball of yarn about: try examining the noun.
	
Instead of smelling the ball of yarn: say "It smells like dirt and hope."
	
Instead of giving the ball of yarn to John Everyman: say "Don't give away your only lifeline! Everyman doesn't need it, anyway."
	
Instead of showing the ball of yarn to John Everyman: say "Don't give away your only lifeline! Everyman isn't someone you think you ought to show your hand to."
	
Instead of listening to the ball of yarn: say "It can show you where to go, not tell you."

Instead of throwing the ball of yarn at something: say "You'd rather keep ahold of it."
	
Instead of touching or rubbing the ball of yarn: say "The yarn is soft, if [if dirtied]dirty[otherwise if wet]soggy[otherwise]worn[end if]."
	
Instead of tying the ball of yarn to something: say "The yarn can lead you back here laid on the ground as well as it can tied to [the second noun]."
	
Instead of tying something to the ball of yarn: say "The yarn can lead you back here laid on the ground as well as it can tied to [the noun]."

Chapter 2 - The jukebox

A jukebox is a switched off device in Room4-5. "A jukebox stands against one wall, moving colored lights catching your eye [if switched on]even as the music it plays catches your ear[otherwise]though it's currently making no noise[end if]." The jukebox is fixed in place.
Understand "juke" or "box" or "record/records" or "player" or "song/music" or "tune/tunes" as "[jukebox]". Understand "[jukebox]" or "slippery" or "play/plays/playing" or "property" or "silent/silence" or "multicolored/multi/color/colored/colors" or "tube/tubes" or "glass/plastic/warm/light/lights" or "smooth/uniform" or "on/off" or "button" or "side/sides" or "array" as the jukebox.
The description of the jukebox is "It's a 1950s-style console with a rounded top and multicolored tubes of light running up the side. Glass on the front allows you to see an array of records inside.

There doesn't seem to be a way to select which song it plays; you can only choose whether to turn it [if switched on]off[otherwise]on[end if] or not."
The maximum saturation of the jukebox is 1.
Does the player mean switching on the switched off jukebox: it is likely.
Does the player mean switching on the switched on jukebox: it is unlikely.
Does the player mean switching off the switched on jukebox: it is likely.
Does the player mean switching off the switched off jukebox: it is unlikely.

Instead of attacking or burning or cutting the jukebox: say "You're not particulalry interested in being arrested for destruction of property today."

Instead of attacking the jukebox with: say "You're not particulalry interested in being arrested for destruction of property today."

Instead of consulting the jukebox about: try examining the noun.

Instead of searching the jukebox: try examining the noun.
	
Instead of climbing the jukebox: say "The sides are too slippery for you to get a good grip."
	
Instead of inserting something into the jukebox: say "[The noun] doesn't seem likely to fit anywhere."

Instead of looking under the jukebox: say "It's flush to the ground."
	
Instead of putting something on the jukebox:
	silently try dropping the noun;
	now the noun is dirtied;
	say "You set [the noun] on the rounded top of the jukebox and it immediately slides off onto the ground."

Instead of removing something from the jukebox: say "You don't see anywhere that the jukebox opens."

Instead of listening to the jukebox:
	if the jukebox is switched off:
		say "It's not playing anything at the moment.";
	otherwise:
		silently try waiting.

Instead of opening the jukebox: say "You don't see anywhere that it opens."

Instead of throwing something at the jukebox: say "You're not particulalry interested in being arrested for destruction of property today."
	
Instead of touching or rubbing the jukebox: say "The plastic and glass are both smooth and uniform, slightly warm from the lights inside."
	
Instead of tying the ball of yarn to the jukebox: say "The yarn will do just as good a job guiding you back here laid on the ground as it will tied to the jukebox."

Instead of pulling or pushing or turning the jukebox: say "The jukebox is far too heavy for you to move."

Instead of pushing the jukebox to: try pushing the noun.

A room can be jukebox-adjacent. A room is usually not jukebox-adjacent. Room2-4, Room2-5, Room2-6, Room3-3, Room3-4, Room3-5, Room3-6, Room3-7, Room4-3, Room4-4, Room4-5, Room4-6, Room4-7, Room5-3, Room5-4, Room5-5, Room5-6, Room5-7, Room6-4, Room6-5, and Room6-6 are jukebox-adjacent.

The list of lyrics is a list of texts that varies.
The list of lyrics is { "If you all will shut your trap, I will tell you [']bout a chap / that was broke and up againt it too, for fair", "He was not the kind to shirk; he was looking hard for work / but he heard the same old story ev'rywhere", "[tramp-ch1]", "[tramp-ch2]", "He walked up and down the street [']til the shoes fell off his feet / In a house he spied a lady cooking stew", "And he said 'How do you do? May I chop some wood for you?' / What the lady told him made him feel so blue", "[tramp-ch1]", "[tramp-ch2]", "[']Cross the street a sign he read; 'Work For Jesus' so it said / and he said 'Here is my chance, I'll surely try", "And he kneeled upon the floor [']til his knees got rather sore / but at eating time he heard the preacher cry", "[tramp-ch1]", "[tramp-ch2]", "Down the street he met a cop, and the copper made him stop / and he asked him 'When did you blow into town?'", "'Come with me up to the judge,' but the judge, he said 'Oh fudge, / bums that have no money needn't come around'", "[tramp-ch1]", "[tramp-ch2]", "Fin'ly came that happy day when his life did pass away / He was sure he'd go to heaven when he died", "When he reached the pearly Gate, Santa Peter, mean old skate, / slammed the gate right in his face and loudly cried", "[tramp-ch1]", "[tramp-ch2]" }.

To say tramp-ch1: say "Tramp, tramp, tramp, keep on a-tramping / Nothing doing here for you".

To say tramp-ch2: say "If I catch you [']round again, you will wear the ball and chain / Keep on tramping, that's the best thing you can do".

The lyric-number is a number that varies. The lyric-number is 1.

Last every turn (this is the play that music rule):
	if the jukebox is switched on:
		if the location is jukebox-adjacent:
			let n be the lyric-number;
			if the number of entries in the list of lyrics >= n:
				say "[first time]Old-timey music starts up from the record player. After a short intro, a man begins to sing:[paragraph break][only][italic type][entry n in the list of lyrics][unicode 8230][roman type][paragraph break]";
			otherwise:
				now the lyric-number is 0;
				say "The record in the jukebox halts. There's a clicking and a whirring, then the song begins again.";
		increment the lyric-number;
	continue the action.
	
After looking when the location is Room4-6:
	if 45-46passage is present, say "[unless Room4-5 is visited]There's something[otherwise]The jukebox sits[end unless] to the west."
	
After looking when the location is Room4-4:
	if 44-45passage is present, say "[unless Room4-5 is visited]There's something[otherwise]The jukebox sits[end unless] to the east."
	
After looking when the location is Room5-5:
	if 45-55passage is present, say "[unless Room4-5 is visited]There's something[otherwise]The jukebox sits[end unless] to the north."
	
After looking when the location is Room3-5:
	if 35-45passage is present, say "[unless Room4-5 is visited]There's something[otherwise]The jukebox sits[end unless] to the south."

Chapter 3 - The lizard

A small lizard is a distant animal in Room4-1. Understand "tiny/little" or "green" or "agile" or "eye/eyes" or "bulge/bulging" or "startle/startled" as the small lizard.
The description of the small lizard is "It's tiny, green, and agile. Its eyes bulge out of its head, as if perpetually startled."

Before listing contents of a room:
	if the small lizard is marked for listing:
		now the small lizard is not marked for listing.
		
Before listing nondescript items:
	if the small lizard is marked for listing:
		now the small lizard is not marked for listing.

Last carry out looking: follow the leaping lizard rule.

This is the leaping lizard rule:
	let L be a list of objects;
	if the small lizard is in the location:
		repeat with way running through directions:
			let farplace be the room way from the location;
			now direction-object is the room-or-door way from the location;
			if the direction-object is apparent, add farplace to L;
		if the number of entries in L > 1:
			remove Elsewhere from L, if present;
			if the number of entries in L > 1:
				remove the previous location from L, if present;
		let M be a random number between 1 and the number of entries in L;
		if entry M in L is a room:
			let escape be entry M in L;
			let dir be the best route from the location to escape, using doors;
			move the small lizard to escape;									
			say "[one of]A[or]The[stopping] small lizard darts [if escape is the previous location]past you[otherwise]off[end if] to the [dir]!";
	continue the action.
	
Before trying taking or attacking or cutting or burning or smelling or touching or rubbing the small lizard: say "It seems to have skittered out of your reach from here." instead.

Before trying taking or attacking the small lizard with: say "It seems to have skittered out of your reach from here." instead.

Instead of consulting the small lizard about: try examining the noun.
	
Instead of showing something to the small lizard: say "The lizard seems unimpressed."

Instead of listening to the small lizard: say "The small lizard flicks its tongue at you."

Instead of throwing something at the small lizard:
	now the noun is in the location of the small lizard;
	follow the leaping lizard rule.

Part 4 - Takeable things

Chapter 1 - Ribbon

The dirty ribbon is a dirtied artifact in Room8-1. "A pink ribbon lies abandoned on the ground, trampled and covered in [dirt-mud]." Understand "muddy" or "abandoned/trampled/covered" or "hair" or "tie" or "pink" or "ribbon" as "[ribbon]". Understand "[ribbon]" as the dirty ribbon. The printed name of the dirty ribbon is "[if dirtied]dirty [end if]ribbon".
The description of the dirty ribbon is "It's a pink ribbon, meant for tying back hair[if dirtied]. It looks like it's been outside for a long time[end if]."

Rule for printing the name of the dirty ribbon while taking inventory: say "ribbon".

Instead of attacking or burning the dirty ribbon: say "It's not yours to destroy."

Instead of cutting the dirty ribbon: say "You don't have any way to cut it. Besides, it's not yours to destroy."

Instead of attacking the dirty ribbon with: say "It's not yours to destroy."

Instead of consulting the dirty ribbon about: try examining the noun.
	
Instead of smelling the dirty ribbon: say "It smells [if dirtied]like earth[otherwise]fresh and clean[end if]."
	
Instead of listening to the dirty ribbon: say "There's no one left for whom it can speak."

Instead of touching or rubbing the dirty ribbon: say "The cloth is soft and worn."
	
Instead of tying the dirty ribbon to something:
	if the second noun is grave1:
		try putting the  noun on the second noun;
	otherwise:
		say "You get the sense that [the second noun] isn't the proper place for the ribbon."
	
Instead of tying something to the dirty ribbon: try tying the second noun to the noun.

Instead of wearing the dirty ribbon: say "It doesn't belong to you. Better to refrain."

To say dirt-mud:
	if It Drizzles is happening, say "mud";
	otherwise say "dirt".
	
Chapter 2 - Swatches

The book of paint swatches is a dirtied artifact in Room2-7. "What looks to be a book of paint swatches lies abandoned on the ground." Understand "color" or "guide" or "chip/chips" or "swatch/swatches" or "book" or "of" or "paint" as "[swatches]". Understand "[swatches]" as the book of paint swatches.
The book of paint swatches can be open. The book of paint swatches is closed.
The description of the book of paint swatches is "It's a book of paint swatches, meant to help people decide on paint colors for a room. Each page has a different colored chip."
The maximum saturation of the book of paint swatches is 15.

Instead of attacking or burning or cutting the book of paint swatches: say "It's not yours to destroy."

Instead of attacking the book of paint swatches with: say "It's not yours to destroy."

Instead of consulting the book of paint swatches about: try examining the noun.
	
Instead of smelling the book of paint swatches: say "It smells like [if dirtied]dirty [end if]paper."
	
Instead of listening to the book of paint swatches: say "There's no one left for whom it can speak."

Before doing something other than reading or smelling or opening or closing or listening to or touching or rubbing the book of paint swatches when the book of paint swatches is carried (this is the implicitly close the swatches rule):
	if the book of paint swatches is open, now the book of paint swatches is closed.

Instead of touching or rubbing the book of paint swatches: say "The thick, stiff paper is smooth under your fingers."

Before reading the book of paint swatches (this is the only readable if open rule):
	if the book of paint swatches is closed, now the book of paint swatches is open.
	
Carry out reading the book of paint swatches:
	say "You flip to a random chip. It's a [color-quality] [color-tone] [color-desc]."
	
To say color-quality: say "[one of]light[or]light-ish[or]dark[or]dark-ish[or]neutral[or]bright[or]dull[or]bold[or]saturated[or]faint[or]deep[or]medium[or]drab[or]sort of[or]misty[or]intense[or]faded[or]pale[at random]".

To say color-tone: say "[one of]pink[or]pinkish[or]red[or]reddish[or]crimson[or]red-orange[or]orange[or]orange-ish[or]yellow[or]yellow-orange[or]yellowish[or]gold[or]khaki[or]brown[or]brownish[or]yellow-brown[or]maroon[or]tan[or]tan-ish[or]green[or]greenish[or]olive[or]lime[or]yellow-green[or]brown-green[or]cyan[or]teal[or]turquoise[or]blue[or]blue-ish[or]green-blue[or]purple[or]indigo[or]blue-purple[or]magenta[or]violet[or]fuchsia[or]plum[or]lavender[or]white[or]beige[or]ivory[or]gray[or]black[or]silver[at random]".

To say color-desc: say "[one of]color[or]tone[or]shade[or]hue[or]tint[at random]".

Chapter 3 - Flower

The wilted flower is a dirtied artifact in Room9-6. "A wilted flower leans abandoned against one wall." Understand "hyacinth" or "dead" or "plant" or "petal/petals/stem/bulb" or "soft/brittle" or "vibrant/purple/violet/fading/faded/gray/grey" or "wilt/wilting" as "[flower]". Understand "[flower]" as the wilted flower.
The description of the wilted flower is "It's a hyacinth flower. Its petals were once a vibrant violet, but now they're wilted and fading towards gray."

Instead of attacking or burning or cutting the wilted flower: say "You doubt that's likely to accomplish much."

Instead of attacking the book of paint swatches with: say "You doubt that's likely to accomplish much."

Instead of consulting the wilted flower about: try examining the noun.
	
Instead of drinking or eating or tasting the wilted flower: say "You remember reading somewhere that hyacinths are poisonous. Better to refrain."
	
Instead of smelling the wilted flower: say "It smells very green and slightly spicy."
	
Instead of listening to the wilted flower: say "There's no one left for whom it can speak."

Instead of touching or rubbing the wilted flower: say "The petals are soft and brittle."

Instead of wearing the wilted flower: say "It doesn't belong to you. Better to refrain."

Chapter 4 - Lighter

The triangle lighter is a dirtied artifact in Room8-7. "A lighter with a triangle engraved on it sits half-buried in the [dirt-mud]." Understand "triangular" or "engraved/embossed" or "gold/silver/copper" or "fire/flame/spark/fuel" or "light" or "spark" or "wheel" or "small" or "lid" or "carved" or "word" or "waste" as "[lighter]". Understand "open/shut" or "[lighter]" as the triangle lighter. The printed name of the triangle lighter is "lighter".
The triangle lighter can be open. The triangle lighter can be openable. The triangle lighter is openable and closed.
The description of the triangle lighter is "It's a small, metal spark wheel lighter with its lid [if open]open[otherwise]shut[end if]. One side of the body is engraved a triangle. On the other side is the word 'WASTE!'"
The maximum saturation of the triangle lighter is 2.

Before doing something other than burning or smelling or opening or closing or listening to or switching on or rubbing or touching or examining the triangle lighter when the triangle lighter is carried (this is the implicitly close the lighter rule):
	if the triangle lighter is open, now the triangle lighter is closed.
	
Instead of attacking or cutting the triangle lighter: say "It's not yours to destroy."

Instead of attacking triangle lighter with: say "It's not yours to destroy."

Instead of burning the triangle lighter: say "It's meant to burn other things, not to be burned itself."

Instead of consulting the triangle lighter about: try examining the noun.
	
Instead of smelling the triangle lighter: say "It smells faintly of overheated machinery."
	
Instead of listening to the triangle lighter: say "There's no one left for whom it can speak."
	
Before trying switching on the triangle lighter:
	if the triangle lighter is closed:
		say "(first opening the lighter)[command clarification break]";
		silently try opening the triangle lighter;
	continue the action.
	
Instead of switching on the triangle lighter: say "You flick it a couple of times, but don't get anything more than a spark. It may be out of fuel[if It Drizzles is happening], or it may simply be too wet to light[end if]."

Instead of touching or rubbing the triangle lighter: say "The metal is cool against your fingers."

Book 3 - Rain

It Drizzles is a scene. "You [unless the location is a treehouse]feel the first drops of a drizzle begin to shock your skin[otherwise]hear the first telltale taps of a drizzle hitting the roof above you. The light streaming through the cracks in the roof fades[end unless]." It Drizzles begins when the time of day is 9:40 AM. It Drizzles ends when the player is in Elsewhere.

Rain is a backdrop. "It's a light summer drizzle." Understand "light/dark" or "summer" or "drizzle/drizzles/drizzling" or "raindrop/raindrops/drop/drops/drip/drips" or "rains/raining" or "wet/chill/damp/wet" or "weather/thunderclouds/cloud/clouds" or "pinprick/pin/prick prick/--" or "streak/streaks" as Rain. It is nowhere.

A room can be indoors or outdoors. A room is usually outdoors. A treehouse is indoors.

When It Drizzles begins: move the Rain backdrop to all outdoors rooms.

Instead of attacking or burning or cutting rain: say "You doubt that will accomplish much[unicode 8212]there's simply too much of it."

Instead of attacking rain with: say "You swing the hammer around, but it doesn't accomplish much[unicode 8212]there's simply too much rain."

Instead of consulting rain about: try examining the noun.
	
Instead of drinking or eating or tasting rain: say "You doubt it's potable."
	
Instead of smelling rain: say "You breathe in the wet smell."
	
Instead of listening to rain:
	if the time since It Drizzles began is at least 30 minutes:
		say "It roars.";
	otherwise if the time since It Drizzles began is at least 20 minutes:
		say "It hisses.";
	otherwise if the time since It Drizzles began is at least 10 minutes:
		say "It whispers.";
	otherwise:
		say "It plips and plops."

Instead of taking rain: say "There's already far too much to carry, and more of it all the time."
	
Instead of touching or rubbing rain: say "Your skin is wet enough now that you cant differentiate between the new rain and the rain that was already there."

Before trying washing something with the rain:
	unless the noun is clean:
		say "The rain isn't sufficient to clean [the noun], and only manages to smear the dirt on [regarding the noun][them] around." instead.

Every turn during It Drizzles (this is the mention the rain rule): say "[if the location is a treehouse]The rain [one of]impacts against[or]plips and plops on[or]whispers through[at random] the leaves of the tree[otherwise][rain-report][end if]."

To say rain-report: say "Rain continues to fall[if the current action is going][dampness description][end if]".

To say dampness description:
	if the time since It Drizzles began is at least 30 minutes:
		say ". [one of]It taunts you with its pinprick impacts[or]Your clothes are weighed down and sodden. They chafe at your groin and armpits[or]Your hair, dripping wet, gets in your eyes[or]Your clothes weigh you down[or]You slog through the muddy ground[or]You shiver, but cannot rid yourself of the bone-deep chill[in random order]";
	otherwise if the time since It Drizzles began is at least 20 minutes:
		say ". [one of]It has by this point lost its novelty[or]Your clothes grow heavier[or]Its chill reaches your scalp as it drips off the ends of your hair[or]You slip in a muddy patch, but catch yourself before falling completely[or]You wring out one of your sleeves onto the ground[or]It doesn't seem like it will let up any time soon[or]Your clothes, now soaked through, begin to drip[in random order]";
	otherwise if the time since It Drizzles began is at least 10 minutes:
		say ". [one of]It impacts softly on your hair and shoulders[or]Dark, damp spots slowly begin to spread on your clothes[or]The ground grows softer under your feet[or]You breathe in the wet smell[or]You hope it won't begin to thunder[or]It leaves streaks on the concrete walls[in random order]";
	otherwise if the time since It Drizzles began is at least 1 minute:
		say ". The rain kisses your skin";
	otherwise:
		do nothing.
		
Cell-observed is a truth state that varies. Cell-observed is false.

To say cell observed: now cell-observed is true.

To say speak-desc: say "[if cell-observed is true]continues to speak[otherwise]appears to be speaking[cell observed][end if]".
		
At 9:41 AM: if the location is Room5-1, say "John Everyman holds out his hand, palm up, and squints at the sky. "

At 9:48 AM: if the location is Room5-1, say "John Everyman pulls a cell phone out of his pocket and speaks quietly into it[cell observed]. [paragraph break]"

At 9:49 AM: if the location is Room5-1, say "John [speak-desc] quietly into [if cell-observed is true]his[otherwise]a[end if] cell phone. [paragraph break]"

At 9:50 AM: if the location is Room5-1, say "John [speak-desc] quietly into [if cell-observed is true]his[otherwise]a[end if] cell phone. [paragraph break]"

At 9:51 AM: if the location is Room5-1, say "John [speak-desc] quietly into [if cell-observed is true]his[otherwise]a[end if] cell phone. [paragraph break]"

At 9:52 AM: if the location is Room5-1, say "John slips [if cell-observed is true]his[otherwise]a[end if] cell phone [if cell-observed is true]back[end if] into his pocket. [paragraph break]"

At 9:55 AM:
	if the location is Room5-1:
		say "A doorway opens in one of the walls. John Everyman steps through and out of the maze. You get only a brief glimpse of the outside before the door shuts behind him. ";
	now John Everyman is nowhere.
	
After looking when the location is Room5-1 and John Everyman is not in the location:
	say "John Everyman is nowhere to be found.";
	continue the action.
