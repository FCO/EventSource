use EventSource;
use AssinaturaEventStorage;
use AssinaturaEvent;
use CreateAssinaturaEvent;
use AssinaturaAtivadaEvent;
use AssinaturaCanceladaEvent;
use AtualizaAniversárioEvent;
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

proto method apply(AssinaturaEvent --> ::?CLASS) {*}

multi method apply(CreateAssinaturaEvent $ev) {
    self.clone: |$ev.Hash
}

multi method apply(AssinaturaAtivadaEvent $ev) {
    self.clone: |$ev.Hash, :status(ativo)
}

multi method apply(AssinaturaCanceladaEvent $ev) {
    self.clone: |$ev.Hash, :status(cancelado)
}

multi method apply(AtualizaAniversárioEvent $ev) {
    self.clone: |$ev.Hash, :aniversário($ev.novo-aniversário)
}

method ativar is command{ AssinaturaAtivadaEvent.new:
    :id-assinatura(.id-assinatura),
    :id-serviço(.id-serviço),
    :número-assinante(.número-assinante),
    :aniversário(DateTime.now.day)
} {
    $!status !~~ ativo
}

method cancelar is command{ AssinaturaCanceladaEvent.new:
    :id-assinatura(.id-assinatura),
    :id-serviço(.id-serviço),
    :número-assinante(.número-assinante),
    :metadata(.metadata),
} {
    $!status !~~ cancelado
}

method atualiza-aniversário($novo-aniversário) is command{ AtualizaAniversárioEvent.new:
    :id-assinatura(.id-assinatura),
    :id-serviço(.id-serviço),
    :número-assinante(.número-assinante),
    :$novo-aniversário,
    :aniversário-antigo(.aniversário)
} {
    die "Não e possivel atualizar uma assinatura não ativa" unless $!status ~~ ativo;
    True
}
