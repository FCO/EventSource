unit class Event;

my atomicint $counter = 0;
has UInt    $.counter = $counter⚛++;
method id { ... }
multi method Hash(--> Hash()) {
    self.^attributes.map: {.name.substr(2) => .get_value: self}
}

multi method Hash(*%pairs where *.elems > 0, --> Hash()) {
    {
        |self.^attributes.map({.name.substr(2) => .get_value: self}),
        |%pairs
    }
}

