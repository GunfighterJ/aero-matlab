
% CHECK THIS FOR COPYRIGHT 
function jf = umJACOBI1d(z, n, alpha, beta)

  jf  = 0;
one = 1.0;
two = 2.0;

if(n == 0)
  jf = one;
elseif (n == 1)
    jf = 0.5*(alpha - beta + (alpha + beta + two)*z);
else
    two = 2.0;
    apb = alpha + beta;
    
    poly   = 0;
    polyn2 = 1;
    polyn1 = 0.5*(alpha - beta + (alpha + beta + two)*z);
    
    for k = 2:n
        a1 =  two*k*(k + apb)*(two*k + apb - two);
        a2 = (two*k + apb - one)*(alpha*alpha - beta*beta);
        a3 = (two*k + apb - two)*(two*k + apb - one)*(two*k + apb);
        a4 =  two*(k + alpha - one)*(k + beta - one)*(two*k + apb);
        
        a2 = a2/a1;
        a3 = a3/a1;
        a4 = a4/a1;
        
        poly   = (a2 + a3*z).*polyn1 - a4*polyn2;
        polyn2 = polyn1;
        polyn1 = poly;
    end
    jf = poly;
end
