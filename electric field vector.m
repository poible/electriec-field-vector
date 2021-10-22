clc %clear command
clear %clear variables

Q = 5e-9; %magnitude of point charge at (2, 2, 8)

%range
x = 0:0.1:4;
y = 0:0.1:4;
z = 0:0.1:4;
eps = 8.854e-12;


[X,Y,Z] = meshgrid(x, y, z);

R = ((X-2).^2 + (Y-2).^2 + (Z-8).^2).^0.5;

Ex = Q./(4*pi*eps*R.^3).*(X-2);
Ey = Q./(4*pi*eps*R.^3).*(Y-2);
Ez = Q./(4*pi*eps*R.^3).*(Z-8);
U = Ex;
V = Ey;
W = Ez;

q = quiver3(X,Y,Z,U,V,W,2);

%// Compute the magnitude of the vectors
mags = sqrt(q.UData(:).^2 + q.VData(:).^2 + q.WData(:).^2);
%mags = sqrt(sum(cat(2, q.UData(:), q.VData(:), ...
            %reshape(q.WData, numel(q.UData), [])).^2, 2));

%// Get the current colormap
currentColormap = colormap(gca);

%// Now determine the color to make each arrow using a colormap
[~, ~, ind] = histcounts(mags, size(currentColormap, 1));

%// Now map this to a colormap to get RGB
cmap = uint8(ind2rgb(ind(:), currentColormap) * 255);
cmap(:,:,4) = 255;
cmap = permute(repmat(cmap, [1 3 1]), [2 1 3]);

%// We repeat each color 3 times (using 1:3 below) because each arrow has 3 vertices
set(q.Head, ...
    'ColorBinding', 'interpolated', ...
    'ColorData', reshape(cmap(1:3,:,:), [], 4).');   %'

%// We repeat each color 2 times (using 1:2 below) because each tail has 2 vertices
set(q.Tail, ...
    'ColorBinding', 'interpolated', ...
    'ColorData', reshape(cmap(1:2,:,:), [], 4).');

xlabel ('X')
ylabel ('Y')
zlabel ('Z')
