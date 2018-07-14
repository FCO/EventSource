use Event;
use  EventStorage;

unit role EventSource[EventStorage $ev-stg];

has UInt $.counter;

method id                   { ... }

method TWEAK(|c) {
    if +c.hash {
        $ev-stg.save: $ev-stg.create-event-class.new: |c
    }
}

multi method load(::?CLASS:D:) {
    my ::?CLASS $domain = self;
    for $ev-stg.load: self.id, self.counter -> $ev {
        $domain .= apply: $ev
    }
    $domain
}

multi method load(::?CLASS:U: $id) {
    my ::?CLASS $domain .= new;
    for $ev-stg.load: $id -> $ev {
        $domain .= apply: $ev
    }
    $domain
}

method save(Event $ev) {
    $ev-stg.save: $ev
}
