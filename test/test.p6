use Assinatura;
use FormaPagamento;

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
