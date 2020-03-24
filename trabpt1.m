%***** Cálculo de Curto-Circuito Subtransitório a 1/3 da barra 4 *****
%*********************************************************************
%*****  Roberto Kondo, Victor S. Sismotto ****************************
%*********************************************************************
format long

linhas = 4; %transformador foi contabilizado nas linhas
barras = 5; % são 4 barras + 1 devido à análise ser a 1/3 da barra 11
de = [1 2 3 5]';
para = [2 3 5 4]';

% impedâncias das linhas

r1 = [0.007762      0           2/3*0.002866    1/3*0.002866]';
x1 = [0.005499      0.05893     2/3*0.000987    1/3*0.000987]';
r2 = [0.007762      0           2/3*0.002866    1/3*0.002866]';
x2 = [0.005499      0.05893     2/3*0.000987    1/3*0.000987]';
r0 = [0.012098      0           2/3*0.019071    1/3*0.019071]';
x0 = [0.014672      0.05893     2/3*0.02312     1/3*0.02312]';

% gerador - curto subtransitório

xg1 = 0.1204;
xg2 = 0.1423;
xg0 = 0.087579;

% su

rsu1 = 0.0000737;
xsu1 = 0.00712;
rsu2 = 0.0000737;
xsu2 = 0.00712;
rsu0 = 0.000016;
xsu0 = 0.00012;

A = [1 1 1; 1 -0.5-j*0.8666 -0.5+j*0.8666; 1 -0.5+j*0.8666 -0.5-j*0.8666];

% montagem da matriz Y

% seq. positiva

Y = zeros(barras,barras);

for linha=1:linhas %linha 1 é 1-2, linha 2 é 2-3, linha 3 é 3-5 e linha 4 é 5-4.
        a1 = de(linha);
        a2 = para(linha);
        % esse algoritmo vai montar os elementos Y11, Y12, Y21, Y22, Y33, Y35, Y53, Y55, Y44, Y45 e
        % Y54. a1 assume os valores 1,3,5 e a2 2,5,4.
        
        Y(a1,a1) = Y(a1,a1)+1/(r1(linha)+1j*x1(linha));
        Y(a1,a2) = Y(a1,a2)-1/(r1(linha)+1j*x1(linha));
        Y(a2,a1) = Y(a2,a1)-1/(r1(linha)+1j*x1(linha));
        Y(a2,a2) = Y(a2,a2)+1/(r1(linha)+1j*x1(linha));

end
    Y(1,1) = Y(1,1)+1/(rsu1+1j*xsu1);
    Y(5,5) = Y(5,5)+1/(1j*xg1); 
        Y1 = Y;
        Z1 = inv(Y1);
      
        
% seq. negativa

linhas = 4; %transformador foi contabilizado nas linhas
barras = 5; % são 4 barras + 1 devido à análise ser a 1/3 da barra 11


Y = zeros(barras,barras);

for linha=1:linhas
        a1 = de(linha);
        a2 = para(linha);
 
        Y(a1,a1) = Y(a1,a1)+1/(r2(linha)+1j*x2(linha));
        Y(a1,a2) = Y(a1,a2)-1/(r2(linha)+1j*x2(linha));
        Y(a2,a1) = Y(a2,a1)-1/(r2(linha)+1j*x2(linha));
        Y(a2,a2) = Y(a2,a2)+1/(r2(linha)+1j*x2(linha));

end
        Y(1,1) = Y(1,1)+1/(rsu2+1j*xsu2);
        Y(5,5) = Y(5,5)+1/(1j*xg2); 
        Y2 = Y;
        Z2 = inv(Y2);
        
% seq. zero

linhas = 4; %transformador foi contabilizado nas linhas
barras = 5; % são 4 barras + 1 devido à análise ser a 1/3 da barra 11

Y = sparse(barras,barras);

 
for linha=1:linhas
    
        a1 = de(linha);
        a2 = para(linha);
        
        if ((a1==2) && (a2==3))
        Y(a1,a1) = Y(a1,a1);
        Y(a1,a2) = 0 + 1j*0;
        Y(a2,a1) = 0 + 1j*0;
        Y(a2,a2) = Y(a2,a2)+1/(r0(linha)+1j*x0(linha));
        end
        
        if ((a1~=2) && (a2~=3))
        Y(a1,a1) = Y(a1,a1)+1/(r0(linha)+1j*x0(linha));
        Y(a1,a2) = Y(a1,a2)-1/(r0(linha)+1j*x0(linha));
        Y(a2,a1) = Y(a2,a1)-1/(r0(linha)+1j*x0(linha));
        Y(a2,a2) = Y(a2,a2)+1/(r0(linha)+1j*x0(linha));
        end
end
        Y(1,1) = Y(1,1)+1/(rsu0+1j*xsu0);
        Y(5,5) = Y(5,5)+1/(1j*xg0); 
        Y0 = Y
        Z0 = inv(Y0);
          
% Trifásico

Icc_trifasico1 = 1/Z1(5,5);
Icc_trifasico = convcartpol(Icc_trifasico1);
Icc_trifasicoAmp = pu_corrente(Icc_trifasico, 0)

V_trifasico = sparse(barras,1);
V_trifasicoPolar = sparse(barras,2);
V_trifasicoPolarVolt = sparse(barras,2)

for barra=1:barras
    
        V_trifasico(barra) = 1 - 1*(Z1(barra,5)/Z1(5,5));
        variavel = V_trifasico(barra);
        variavel = convcartpol(variavel);
    
        V_trifasicoPolar(barra,2) = variavel(1,2);
        V_trifasicoPolar(barra,1) = variavel(1,1);
        
        if barra <= 2
            V_trifasicoPolarVolt(barra,1) = pu_tensao(V_trifasicoPolar(barra,1),1);
            V_trifasicoPolarVolt(barra,2) = V_trifasicoPolar(barra,2);
        end
        if barra > 2
            V_trifasicoPolarVolt(barra,1) = pu_tensao(V_trifasicoPolar(barra,1),0);
            V_trifasicoPolarVolt(barra,2) = V_trifasicoPolar(barra,2);
        end
end

I_sistema = Y1(3,5)*(V_trifasico(3) - V_trifasico(5));
I_sistemaDef = defasagempositiva(I_sistema);                                    % defasa pro lado de alta
I_sistemaDef = convcartpol(I_sistemaDef);                                          % passa para polar;
I_sistemaAmp(1,1) = pu_corrente(I_sistemaDef(1,1), 1);
I_sistemaAmp(1,2) = I_sistemaDef(1,2);

I_gerador1 = Icc_trifasico1 - I_sistema;
I_gerador1 = convcartpol(I_gerador1);

I_geradorAmp(1,1) = pu_corrente(I_gerador1(1,1), 0);
I_geradorAmp(1,2) = I_gerador1(1,2);


%fase-terra

Icc_a1_faseterra1 = 1/(Z1(5,5)+ Z2(5,5)+ Z0(5,5));
Icc_a2_faseterra1 = Icc_a1_faseterra1;
Icc_a0_faseterra1 = Icc_a1_faseterra1;

Icc_falta_faseterraA = 3*Icc_a1_faseterra1;
Icc_falta_faseterraA_polar = convcartpol(Icc_falta_faseterraA);                       % mostra a corrente da fase A do ponto de curto em pu                                                                                
Icc_falta_faseterraA_polar_Amp = pu_corrente(Icc_falta_faseterraA_polar, 0);                % mostra a corrente da fase A do ponto de curto em A

Icc_falta_faseterraB = 0;
Icc_falta_faseterraB_polar = convcartpol(Icc_falta_faseterraB);                       % mostra a corrente da fase B do ponto de curto em pu
Icc_falta_faseterraB_polar_Amp = pu_corrente(Icc_falta_faseterraB_polar, 0);                % mostra a corrente da fase B do ponto de curto em A

Icc_falta_faseterraC = 0;
Icc_falta_faseterraC_polar = convcartpol(Icc_falta_faseterraC);                       % mostra a corrente da fase C do ponto de curto em pu
Icc_falta_faseterraC_polar_Amp = pu_corrente(Icc_falta_faseterraC_polar, 0);                % mostra a corrente da fase C do ponto de curto em A

Vcc_a1_faseterra1 = 1*(Z2(5,5)+Z0(5,5))/(Z1(5,5)+Z2(5,5)+Z0(5,5));
Vcc_a2_faseterra1 = 1*(Z2(5,5))/(Z1(5,5)+Z2(5,5)+Z0(5,5));
Vcc_a0_faseterra1 = 1*(Z0(5,5))/(Z1(5,5)+Z2(5,5)+Z0(5,5));

%tensões de sequência
Vcc_falta_faseterraA = zeros(3,1);
Vcc_falta_faseterraA(1,1) = Vcc_a0_faseterra1;
Vcc_falta_faseterraA(2,1) = Vcc_a1_faseterra1;
Vcc_falta_faseterraA(3,1) = Vcc_a2_faseterra1;

Vcc_falta_faseterra = A * Vcc_falta_faseterraA;                                 % mostra as tensões de fase no ponto de curto

V_faseterraPolar = sparse(barras,2);
V_faseterraPolarVolt = sparse(barras,2);

for fase=1:3
    
        variavel = Vcc_falta_faseterra(fase,1);
        variavel = convcartpol(variavel);
    
        V_faseterraPolar(fase,2) = variavel(1,2);
        V_faseterraPolar(fase,1) = variavel(1,1);
        
        V_faseterraPolarVolt(barra,1) = pu_tensao(V_faseterraPolar(fase,1),0);
        V_faseterraPolarVolt(barra,2) = V_faseterraPolar(fase,2);
end

Vcc_a1 = sparse(barras,1);
Vcc_a2 = sparse(barras,1);
Vcc_a0 = sparse(barras,1);

for(n = 1:barras)
    Vcc_a1(n,1) = 1 - (Z1(n,5)/(Z1(n,5)+Z2(n,5)+Z0(n,5)));
    Vcc_a2(n,1) = - (Z2(n,5)/(Z1(n,5)+Z2(n,5)+Z0(n,5)));
    Vcc_a0(n,1) = - (Z0(n,5)/(Z1(n,5)+Z2(n,5)+Z0(n,5)));
end

% para a primeira Barra:
Vcc_falta_barra1_sq = sparse(3,1);
Vcc_falta_barra2_sq = sparse(3,1);
Vcc_falta_barra3_sq = sparse(3,1);
Vcc_falta_barra4_sq = sparse(3,1);

Vcc_falta_barra1 = sparse(3,1);
Vcc_falta_barra2 = sparse(3,1);
Vcc_falta_barra3 = sparse(3,1);
Vcc_falta_barra4 = sparse(3,1);

Vcc_falta_barra1_sq = [Vcc_a0(1,1) Vcc_a1(1,1) Vcc_a2(1,1)]';
Vcc_falta_barra2_sq = [Vcc_a0(2,1) Vcc_a1(2,1) Vcc_a2(2,1)]';
Vcc_falta_barra3_sq = [Vcc_a0(3,1) Vcc_a1(3,1) Vcc_a2(3,1)]';
Vcc_falta_barra4_sq = [Vcc_a0(4,1) Vcc_a1(4,1) Vcc_a2(4,1)]';
    
Vcc_falta_barra1 = A* Vcc_falta_barra1_sq;
Vcc_falta_barra2 = A* Vcc_falta_barra2_sq;
Vcc_falta_barra3 = A* Vcc_falta_barra3_sq;
Vcc_falta_barra4 = A* Vcc_falta_barra4_sq;

V_falta_barra1_Polar = sparse(3,2);
V_falta_barra1_PolarVolt = sparse(3,2);

for fase=1:3
    
        variavel = V_falta_barra1_Polar(fase);
        variavel = convcartpol(variavel);
    
        V_falta_barra1_Polar(fase,2) = variavel(1,2);
        V_falta_barra1_Polar(fase,1) = variavel(1,1);
        
        V_falta_barra1_PolarVolt(fase,1) = pu_tensao(V_falta_barra1_Polar(fase,1),1);
        V_falta_barra1_PolarVolt(fase,2) = V_falta_barra1_Polar(fase,2);
        
end

I_sistema_ft_s0 = 0;
I_sistema_ft_sp = Y1(3,5)*(Vcc_a1(3,1) - Vcc_a1(5,1));
I_sistema_ft_sn = Y2(3,5)*(Vcc_a2(3,1) - Vcc_a2(5,1));
I_sistema_ft_sp_def = defasagempositiva(I_sistema_ft_sp);                                    % defasa pro lado de alta
I_sistema_ft_sn_def = defasagemnegativa(I_sistema_ft_sn);                                    % defasa pro lado de alt
I_sistema_ft = I_sistema_ft_sp_def + I_sistema_ft_sn_def + I_sistema_ft_s0;
I_sistema_ft_polar = convcartpol(I_sistema_ft);                                              % passa para polar;
I_sistema_ft_Amp(1,1) = pu_corrente(I_sistema_ft_polar(1,1), 1);
I_sistema_ft_Amp(1,2) = I_sistema_ft_polar(1,2);

I_transf_ft_neutro = 3* Y0(3,5)*(Vcc_a0(3,1) - Vcc_a0(5,1));
I_transf_ft_neutro_polar = convcartpol(I_transf_ft_neutro);                                              % passa para polar;
I_transf_ft_neutro_Amp(1,1) = pu_corrente(I_transf_ft_neutro_polar(1,1), 1);
I_transf_ft_neutro_Amp(1,2) = I_transf_ft_neutro_polar(1,2);
I_transf_ft_neutro_polar = convcartpol(I_transf_ft_neutro);                                              % passa para polar;
I_transf_ft_neutro_Amp(1,1) = pu_corrente(I_transf_ft_neutro_polar(1,1), 1);
I_transf_ft_neutro_Amp(1,2) = I_transf_ft_neutro_polar(1,2);

I_gerador_ft = Icc_falta_faseterraA - I_sistema_ft;
I_gerador_ft_polar = convcartpol(I_gerador_ft);
I_gerador_ft_polar_Amp(1,1) = pu_corrente(I_gerador_ft_polar(1,1), 0);
I_gerador_ft_polar_Amp(1,2) = I_gerador_ft_polar(1,2);
I_gerador_ft_neutro = 3*(Icc_a0_faseterra1- (Y0(3,5)*(Vcc_a0(3,1) - Vcc_a0(5,1))));
I_gerador_ft_neutro_polar = convcartpol(I_gerador_ft_neutro);                                              % passa para polar;
I_gerador_ft_neutro_Amp(1,1) = pu_corrente(I_gerador_ft_neutro_polar(1,1), 1);
I_gerador_ft_neutro_Amp(1,2) = I_gerador_ft_neutro_polar(1,2);

%bifasico

Icc_a1_bifasico1 = 1/(Z1(5,5)+ Z2(5,5));
Icc_a2_bifasico1 = -Icc_a1_bifasico1;
Icc_a0_bifasico1 = 0;

Icc_bifasico_sq_ptcurto = [Icc_a0_bifasico1 Icc_a1_bifasico1 Icc_a2_bifasico1]';
Icc_bifasico_ptcurto = A * Icc_bifasico_sq_ptcurto;

Vcc_a1_faseterra1 = 1*(Z2(5,5)+Z0(5,5))/(Z1(5,5)+Z2(5,5)+Z0(5,5));
Vcc_a2_faseterra1 = 1*(Z2(5,5))/(Z1(5,5)+Z2(5,5)+Z0(5,5));
Vcc_a0_faseterra1 = 1*(Z0(5,5))/(Z1(5,5)+Z2(5,5)+Z0(5,5));








