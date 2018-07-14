use EventStorage;
use AssinaturaEvent;
use CreateAssinaturaEvent;

unit class AssinaturaEventStorage does EventStorage;

has @!events;

method save(AssinaturaEvent $ev) { @!events.push: $ev }
method load(Str $id, Int $i = -1) { @!events.grep: { .id-assinatura ~~ $id and .counter > $i } }
method create-event-class { CreateAssinaturaEvent }

