unit class Event;

my atomicint $counter = 0;
has UInt    $.counter = $counter⚛++;
method id               { ... }
method Hash(--> Hash()) {
    self.^attributes.map: {.name.substr(2) => .get_value: self}
}

