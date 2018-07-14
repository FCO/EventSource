use EventSource;
use AssinaturaEventStorage;
use CreateAssinaturaEvent;
use AssinaturaAtivadaEvent;
use FormaPagamento;
use Status;

class Assinatura does EventSource[AssinaturaEventStorage.new] {
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

    method ativar is applier{AssinaturaAtivadaEvent.new: :id-assinatura(.id-assinatura), :aniversário(DateTime.now.day)} {
        $!status !~~ ativo
    }
}

my Assinatura $a .= new:
    :id-assinatura<12345>,
    :id-serviço<3000>,
    :id-adesão<123>,
    :número-assinante<2199999999>,
    :forma-pagamento(boleto),
    :dados-pagamento{},
    :dados-beneficio{},
    :id-oferta-principal<abc>,
    :metadata{:bla<ble>},
    :31aniversário,
;
my $b = Assinatura.load: "12345";
$b.ativar;
say $b.load
