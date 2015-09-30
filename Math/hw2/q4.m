fx = @(x)(x - tan(x));
ffx = @(x)(sec(x).^2 - 1);



disp(bisectionMethod(199.49,199,fx,0.0001));


disp(newtonMethod(199.4861,fx,ffx));

disp(fx(199));

