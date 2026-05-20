# Sistema de Facturación Telefónica
Solución a la prueba técnica de Mercap en Pharo Smalltalk: sistema de facturación mensual de llamadas telefónicas.

## Qué hace
Un Customer tiene un abono mensual y un historial de llamadas. Existen tres tipos de Call: locales, nacionales e internacionales, cada una con su propia forma de calcular el costo. Una PhoneBill se genera para un cliente y un período (mes/año), filtra las llamadas correspondientes y suma el abono más el costo total de las llamadas.

## Estructura
Call (abstracta)
• LocalCall          -> costo según franja horaria y día
• NationalCall       -> costo según City destino
• InternationalCall  -> costo según Country destino

Customer  -> abono mensual + collection de llamadas
PhoneBill -> factura del período para todas las llamadas de un customer

## Patrón Strategy
El cálculo del costo varía según el tipo de llamada y su contexto. La jerarquía Call con su método abstracto cost y las tres implementaciones concretas resuelve esto vía polimorfismo, que es la forma natural del patrón Strategy en la POO.
PhoneBill hace que las llamadas calculen su propio costo sin conocer los tipos concretos:
callsTotal
    | total |
    total := 0.
    billedCalls do: [ :call | total := total + call cost ].
    ^ total
## Principios SOLID aplicados

Single responsability: cada clase tiene una única responsabilidad. Call calcula su costo, Customer gestiona sus llamadas, PhoneBill calcula el total y hace la factura.
Open-closed: agregar un nuevo tipo de llamada (ej. satelital) requiere solo crear una subclase de Call. No se modifica ninguna clase existente.
Liskov substitution: toda subclase de Call es intercambiable, responde a la misma interfaz.
