using JuMP
using GLPK

m = Model();
set_optimizer(m, GLPK.Optimizer);

@variable(m, V1 >= 0);
@variable(m, V2 >= 0);
@variable(m, NV1 >= 0);
@variable(m, NV2 >= 0);
@variable(m, NV3 >= 0);


@constraint(m,NV1 + NV2 + NV3 <= 250);
@constraint(m,V1 + V2 <= 200);

total = 450;

@constraint(m,(V1*8.8 + V2*6.1 + NV1*2 + NV2*4.2 + NV3*5) <= 6*total);
@constraint(m,(V1*8.8 + V2*6.1 + NV1*2 + NV2*4.2 + NV3*5) >= 3*total);

@objective(m, Max, (V1 + V2 + NV1 + NV2 + NV3)*150 - (V1*110 + V2*120 + NV1*130 + NV2*110 + NV3*115));

optimize!(m);

println("A mistura é composta de:")
println("$(value(V1)) Toneladas de V1");
println("$(value(V2)) Toneladas de V2");
println("$(value(NV1)) Toneladas de NV1");
println("$(value(NV2)) Toneladas de NV2");
println("$(value(NV3)) Toneladas de NV3");
println("Resultando em: $(objective_value(m)) reais de faturamento");
println("O PH da mistura eh de: $(value(V1*8.8 + V2*6.1 + NV1*2 + NV2*4.2 + NV3*5)/450)")