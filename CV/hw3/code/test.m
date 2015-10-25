
nx = 30;
ny = 30;

jac_x = kron([0:nx - 1],ones(ny, 1));
jac_y = kron([0:ny - 1]',ones(1, nx));
jac_zero = zeros(ny, nx);
jac_one = ones(ny, nx);

dW_dp = [jac_x, jac_zero, jac_y, jac_zero, jac_one, jac_zero;
         jac_zero, jac_x, jac_zero, jac_y, jac_zero, jac_one];