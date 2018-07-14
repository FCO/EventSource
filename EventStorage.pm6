use Event;

unit role EventStorage;

method save(Event)                      { ... }
method load($id --> Positional[Event])  { ... }
method create-event-class               { ... }

