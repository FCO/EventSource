use EventSource;
use AssinaturaEventStorage;
use CreateAssinaturaEvent;
use AssinaturaAtivadaEvent;
use FormaPagamento;
use Status;

unit class Assinatura does EventSource[AssinaturaEventStorage.new];
has Str             $.id-assinatura;
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

method id { $!id-assinatura }

multi method apply(CreateAssinaturaEvent $ev --> ::?CLASS) {
    self.clone: |$ev.Hash
}

multi method apply(AssinaturaAtivadaEvent $ev --> ::?CLASS) {
    self.clone: |$ev.Hash, :status(ativo)
}

method ativar is command{AssinaturaAtivadaEvent.new: :id-assinatura(.id-assinatura), :aniversário(DateTime.now.day)} {
    $!status !~~ ativo
}

