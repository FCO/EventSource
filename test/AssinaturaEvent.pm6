use Event;

unit class AssinaturaEvent is Event;

has Str $.id-assinatura     is required;
has Str $.id-serviço        is required;
has Str $.número-assinante  is required;
