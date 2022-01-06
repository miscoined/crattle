// Both named Santos
VAR homesteader = "Amaro"  // Male PC name
VAR merchant = "Amara"     // Female PC name

// Object pronouns
VAR merchant_them = ""
VAR homesteader_them = ""
~ homesteader_them = "him"
~ merchant_them = "her"

// Possessive pronouns
VAR merchant_their = ""
VAR homesteader_their = ""
~ homesteader_their = "his"
~ merchant_their = "her"

EXTERNAL var_from_input(prompt, default)
=== function var_from_input(prompt, default) ===
~ return 1

EXTERNAL force_map()
=== function force_map() ===
~ return "TODO map here"

=== intro ===
# location: santos_ranch_porch
# characters: Homesteader

{homesteader}: You sure you’ve got everything? # face_skeptical

{merchant}: Unless you’ve changed your mind about letting me strap the couch and the patio umbrella to the front of the caravan, yes. # face_smiling

{homesteader} smacks your arm lightly.

{homesteader}: I’m the oldest, it’s my couch. # face_neutral # pose_arms_crossed

{merchant}: By fifteen minutes! # face_offended

{homesteader}: Pft. # face_eyeroll

{homesteader}: # face_concern

{homesteader} hesitates a moment, an uncharacteristic moment of genuine concern crossing {homesteader_their} face.

{homesteader}: Are you sure you’re going to be okay?

{merchant}: # face_concern

You can’t really blame {homesteader_them} for being worried. You’ve left before, sure, but not since Nana passed.

You’re both a little lost without her.

{merchant}: I can’t die, {homesteader}, what’s the worst that can happen? # face_grin

{homesteader}: Well, first of all, you [i]can[/i] die— # face_unimpressed

{merchant}: Doesn’t stick, same thing. # face_dismissive

{homesteader}: If you spill a glass of water and then fill it up again that doesn’t mean it never got spilled. # face_annoyed

{merchant}: But if all the water in the glass magically goes back inside of it post spillage, much like my blood and organs and what have you—

{homesteader}: I’m not having this conversation with you again. Anyway, [i]second[/i] of all, the worst thing that can happen is you get robbed and some raiders make off with our poor girl. # face_disgusted

-> intro_caravan

=== intro_caravan ===
# location: santos_ranch_caravan
# characters: Homesteader Lula

You both look at the crattle hitched to the front of your caravan. She’s peacefully chewing hay, one last little pre-road snack.

VAR lula = "Lula"
~ var_from_input("you named her…", "lula")

Nana’s old crattle lost her undercoat to a bout of the Lumps just before she laid her clutch. She couldn’t keep her clutch warm without it, so Nana had you and {homesteader} pick an egg each. You carried it around in a big backpack full of blankets for a week, and when she hatched, you named her…

You hand reared her after her mother passed. You’re a little worried she’ll be lonely without her clutchmates, but {lula} always seemed to prefer your company.

One time she walked through the kitchen wall to come get pats.

{merchant}: Okay, I know this means less from me than it would anyone else, but I would literally die before I let anything happen to {lula}. And, besides, even if crattle [i]weren't[/i] basically walking rocks, you'd fix her up again. # face_serious

Your gift is life. Your twin's is to take life from one, and give to another. It’s gotten you out of so much shit with Nana over the years; no scraped knees, no evidence.

{homesteader}: Like when she walked through the kitchen wall? # face_smile_eyebrow

{merchant}: Like when she walked through the kitchen wall. # face_smile

You open your arms for a hug. {homesteader} rolls {homesteader_their} eyes, but hugs you tightly. # face_exasperated:homesteader

{homesteader}: I’m gonna miss you. # face: sad

{merchant}: I know. I’ll come back as soon as I can. # face_sad

{homesteader} lets you go, pushing you towards the wagon.

{homesteader}: You better. # face_smile

You climb on top of the wagon and take hold of {lula}'s antenna. One advantage of crattle over other livestock is they came with their own reigns. {homesteader} waves as you steer {lula} out the front gate of your family ranch.

# location: deep_gleam
# characters:
// Forested mountain path encased in crystals

You haven’t had the time to maintain the road properly, not since Nana got sick. The path is jagged with overhanging branches and ferns, encased in Gleam. # face_worried
Every year, the crystals grow further and deeper. There used to be forests around your ranch, game to hunt and forage to find and fresh water in the rivers. Now, it’s all encased in crystal, too thick to clear yourselves and too dangerous for anyone else to touch. With that and Nana passing…you two can’t live on your own anymore.
You haven’t been outside the Gleam since before Nana’s illness. You’ve always wanted to travel; the world out there is dangerous, and your gift means you’re uniquely advantaged to thrive in it. Granted, you thought it’d be more in a ‘sightseeing vacation’ sort of way, and less of a ‘traveling merchant trying to feed your starving family’, sort of way, but whatever.

-> tutorial

=== tutorial ===
# location: outer_gleam
# characters:
// Path along an open crystal mountain range

The path opens up into the open mountainside. {lula} remembers this path; you hook her antennas on her saddle and let her plod along stalwartly, digging your map out of your bag.

~ force_map()

-> END
