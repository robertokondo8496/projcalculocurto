function [ saida ] = pu_corrente( entrada, tipo )

IbaseAlta = (260000/(1.73*23100));
IbaseBaixa = (260000/(1.73*380));

if tipo == 1 % alta
    saida = IbaseAlta * entrada;
end
if tipo == 0 % baixa
    saida = IbaseBaixa * entrada;
end
    
    
end

