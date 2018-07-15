use Event;
use EventStorage;
no precompilation;

multi trait_mod:<is>(Routine $r, :&command!) is export {
    $r.wrap: method (|) {
        my \rest = callsame;
        if ?rest {
            self.save: command self
        }
        rest
    }
}

unit role EventSource[EventStorage $ev-stg];

has UInt $.counter;

method id { ... }

method TWEAK(|c) {
    if +c.hash {
        $ev-stg.save: $ev-stg.create-event-class.new: |c
    }
}

multi method load(::?CLASS:D:) {
    my ::?CLASS $domain = self;
    for $ev-stg.load: self.id, self.counter -> $ev {
        my \val = $domain.apply: $ev;
        if val !~~ ::?CLASS {
            $domain = $domain.clone: |%(val ~~ Hash ?? val !! val.Hash)
        } else {
            $domain = val
        }
    }
    $domain
}

multi method load(::?CLASS:U: $id) {
    my ::?CLASS $domain .= new;
    for $ev-stg.load: $id -> $ev {
        my \val = $domain.apply: $ev;
        if val !~~ ::?CLASS {
            $domain = $domain.clone: |%(val ~~ Hash ?? val !! val.Hash)
        } else {
            $domain = val
        }
    }
    $domain
}

method save(Event $ev) {
    $ev-stg.save: $ev
}
