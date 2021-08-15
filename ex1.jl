using JuMP
using GLPK

m = Model();
set_optimizer(m, GLPK.Optimizer);

@variable(m, quantiSoja >=0);
@variable(m, quantiMilho >=0);
@variable(m, quantiCana >=0);

@variable(m, quantiProte >=0);
@variable(m, quantiCarbo >=0);
@variable(m, quantiCalcio >=0);

@objective(m, Min, sum(quantiSoja*15 + quantiMilho*20 + quantiCana*8))

@constraint(m,quantiMilho+quantiSoja+quantiCana == 1000);
@constraint(m,quantiCalcio <= 1.2*1000);
@constraint(m,quantiCalcio >= 0.8*1000);
@constraint(m,quantiCarbo <= 20*1000);
@constraint(m,quantiProte >= 22*1000);
@constraint(m,quantiCalcio == quantiSoja*0.2 + quantiMilho*1 +quantiCana*3);
@constraint(m,quantiProte == quantiSoja*50 + quantiMilho*9 +quantiCana*0);
@constraint(m,quantiCarbo == quantiSoja*0.8 + quantiMilho*2 +quantiCana*2);

optimize!(m);

print("$(value(quantiSoja))Kg de soja");
println("$(value(quantiMilho))Kg de milho");
println("$(value(quantiCana))Kg de cana");
println("Totalizando: $(objective_value(m)) reais\n");