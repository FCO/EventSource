use FormaPagamento;
use Status;
use AssinaturaEvent;

unit class CreateAssinaturaEvent is AssinaturaEvent;

has Str             $.id-serviço;
has Str             $.id-adesão;
has Str             $.número-assinante;
has FormaPagamento  $.forma-pagamento;
has                 %.dados-pagamento;
has                 %.dados-beneficio;
has Str             $.id-oferta-principal;
has                 %.metadata;
has UInt            $.aniversário;
has Status          $.status                = pendente;

