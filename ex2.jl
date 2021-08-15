m = Model();
set_optimizer(m, GLPK.Optimizer);

@variable(m, nQuartoP >=20);
@variable(m, nQuartoM >=35);
@variable(m, nQuartoG >=10);

tamanhoP = 10;
tamanhoM = 18;
tamanhoG = 25;

disponivel = 950;

pessoas = 100;

@objective(m, Max, sum(nQuartoP*42000 + nQuartoM*76000 + nQuartoG*138000));

@constraint(m,nQuartoP*1 + nQuartoM*2 + nQuartoG*4 <= 100);
@constraint(m,nQuartoP*10 + nQuartoM*18 + nQuartoG*25 <= 950);

optimize!(m);


println("$(value(nQuartoP)) Quartos Simples");
println("$(value(nQuartoM)) Quartos Duplos");
println("$(value(nQuartoG)) Quartos Suites");
println("$(objective_value(m)) Total de Faturamento");