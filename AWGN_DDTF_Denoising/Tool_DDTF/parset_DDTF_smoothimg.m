function par = parset_DDTF_smoothimg(sigma, img_size)
if sigma == 50
    par.lambda = 50;
    par.rho = 0.5;
    if img_size == 256
        par.dilate = 2;
    else
        par.dilate = 4;
    end
elseif sigma == 40
    par.lambda = 45;
    par.rho = 0.6;
    if img_size == 256
        par.dilate = 2;
    else
        par.dilate = 4;
    end
elseif sigma == 30
    par.lambda = 37;
    par.rho = 0.7;
    if img_size ==256
        par.dilate = 3;
    else
        par.dilate = 6;
    end
elseif sigma == 20
    par.lambda = 27;
    par.rho = 0.8;
    if img_size == 256
        par.dilate = 8;
    else
        par.dilate = 16;
    end
elseif sigma == 10
    par.lambda = 20;
    par.rho = 2.5;
    if img_size == 256
        par.dilate = 8;
    else
        par.dilate = 16;
    end
else
    error('sigma must be in 10,20,30,40,50');
end
par.a = 1e-6;
par.b = 1e-6;
end