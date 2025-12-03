function par = parset_DDTF_textureimg(sigma, img_size)
if sigma == 50
    par.lambda = 50;
    par.rho = 0.5;
elseif sigma == 40
    par.lambda = 45;
    par.rho = 0.6;
elseif sigma == 30
    par.lambda = 37;
    par.rho = 0.7;
elseif sigma == 20
    par.lambda = 27;
    par.rho = 0.8;
elseif sigma == 10
    par.lambda = 20;
    par.rho = 2.5;
else
    error('sigma must be in 10,20,30,40,50');
end
par.a = 1e-6;
par.b = 1e-6;
if img_size == 256
    par.dilate = 2;
else
    par.dilate = 4;
end
end