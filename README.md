# crattle
godot trading crab cattle game

## Dialog

Dialog is written using [ink](https://www.inklestudios.com/ink/). Some project-specific usages are listed below.
In general, `merchant` and `homesteader` are special identifiers that refer to the  player character and the player character's twin, respectively.

### Speaker
```
Speaker: A name before a : indicates who is speaking and will be indicated in the UI
A line of dialogue without a speaker will have the speaker name omitted
```

### Scene changes
Indicated by a `# location: ` tag followed by the name of the location resource. e.g. the following will load the `location/location_name.tres` resource:
```
# location: location_name
```

### Dialogue participants
Indicated by a `# characters:` tag followed by a space-separated list of character names corresponding to Character resources in `characters/`:
```
# characters: UndyingVagabond DisgruntledCrattler
```

### Expression tags
A tag beginning with `# face_` will load the `img/characters/<charactername>-face-<expression>.png` resource. Likewise for `# pose_` tags. e.g. this will load `img/characters/lula-face-surprised.png` and `img/chacter/lula-pose-arms-raised.png`
```
Lula: skitter skitter moo!  # face_surprised # pose_arms_raised
```

You can apply an expression tag to a non-speaking character by suffixing it with `:characteridentifier`. For example, this will make the player look angry when Lula is hurt:
```
Lula: meep whimper  # face_hurt  # face_angry:merchant
```

## Art Assets

### Characters
Character portraits are displayed by layering the pose asset over the face asset. Each portrait for the same character should be the same dimensions (different character portraits can
 have different dimensions though). The face and pose assets should both be the same dimensions.
