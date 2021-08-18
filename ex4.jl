using JuMP
using GLPK

m = Model();
set_optimizer(m, GLPK.Optimizer);
producao1 = 100
producao2 = 120

capacidade1 = 200
capacidade2 = 300


custoDeProducao1 = 1
custoDeProducao2 = 1.2
custoDeArmazenamento = 1
custoEnvio = 1
@variable(m, enviado1para2 <= 0)
@variable(m, enviado2para1 <= 0)

@variable(m, qProduzida1 <= producao1)
@variable(m, qArmazenada1 <= qProduzida1 - enviada1para2)

@variable(m, qProduzida2 <= producao2)
@variable(m, qArmazenada2 <= qProduzida2 - enviada2para1)



@variable(m, qProduzidaSegundo1 <= producao1 + qProduzida1)
@variable(m, qProduzidaSegundo1 <= producao1 + qProduzida1)
@variable(m, qArmazenadasegundo1 <= qProduzidaSegundo1 + qArmazenada1)
@variable(m, qArmazenadasegundo2 <= qProduzidaSegundo2 + qArmazenada2)

@objective(Max, (qArmazenadasegundo1) + (qArmazenadasegundo2) - custoDeArmazenamento*(qArmazenada1 + qArmazenada2) - custoEnvio*(enviada1para2+enviada2para1) - (custoDeProducao1*(qProduzida1+qProduzidaSegundo1)+custoDeProducao2*(qProduzida2+qProduzidaSegundo2)))

@constraint(qProduzida1+enviada2para1 - enviada1para2 < qArmazenada1);
@constraint(qProduzida2+enviada1para2 - enviada2para1 < qArmazenada2);

@constraint(qProduzida1+qProduzidaSegundo1 <= 0.85*(qProduzida2+qProduzidaSegundo2))
optimize!(m);

println("Total da Produção Fabrica 1:$(value(qArmazenadasegundo1))");
println("Total da Produção Fabrica 2:$(value(qArmazenadasegundo2))");

