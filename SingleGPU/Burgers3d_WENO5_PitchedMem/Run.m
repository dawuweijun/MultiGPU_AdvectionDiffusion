% Produce Run

% ===========================Burgers-3D GPU-WENO5=======================
% Optimization                                 :  Pitched Memory
% Kernel time ex. data transfers               :  549.940000 seconds
% Data transfer(s) HtD                         :  0.280000 seconds
% Data transfer(s) DtH                         :  35.350000 seconds
% ===================================================================
% Total effective GFLOPs                       :  2.572744
% ===================================================================
% 3D Grid Size                                 :  1601 x 986 x 35
% Iterations                                   :  1067 x 3 RK steps
% ===================================================================

% ===========================Burgers-3D GPU-WENO5=======================
% Optimization                                 :  Pitched Memory
% Kernel time ex. data transfers               :  33.520000 seconds
% Data transfer(s) HtD                         :  0.330000 seconds
% Data transfer(s) DtH                         :  97.830000 seconds
% ===================================================================
% Total effective GFLOPs                       :  8.264481
% ===================================================================
% 3D Grid Size                                 :  512 x 512 x 512
% Iterations                                   :  86 x 3 RK steps
% ===================================================================

% ===========================Burgers-3D GPU-WENO5=======================
% Optimization                                 :  Pitched Memory
% Kernel time ex. data transfers               :  240.110000 seconds
% Data transfer(s) HtD                         :  1.000000 seconds
% Data transfer(s) DtH                         :  150.170000 seconds
% ===================================================================
% Total effective GFLOPs                       :  3.338470
% ===================================================================
% 3D Grid Size                                 :  1000 x 1000 x 200
% Iterations                                   :  167 x 3 RK steps
% ===================================================================

% Set run parameters
tEnd=0.10;
CFL= 0.30;
L = 2.0;
W = 2.0;
H = 2.0;
nx = 1000;
ny = 1000;
nz = 200;
block_X = 8;
block_Y = 8;
block_Z = 8;

%% Write sh.run
fID = fopen('run.sh','wt');
fprintf(fID,'make\n');
args = sprintf('%1.2f %1.2f %1.2f %1.2f %1.2f %d %d %d %d %d %d %d',tEnd,CFL,L,W,H,nx,ny,nz,block_X,block_Y,block_Z);
fprintf(fID,'./burgers3d.run %s\n',args);
fclose(fID);

% Execute sh.run
! sh run.sh

% %% Load & plot data
% fID = fopen('result.bin');
% output = fread(fID,[1,nx*ny*nz],'float')';
% u = reshape(output,nx,ny,nz);
% 
% %myplot(output,nx,ny,nz,L,W,H);
% 
% %% Build discrete domain
% dx=L/(nx-1); xc=-L/2:dx:L/2;
% dy=W/(ny-1); yc=-W/2:dy:W/2;
% dz=H/(nz-1); zc=-H/2:dz:H/2;
% [x,y,z]=meshgrid(yc,xc,zc);
% 
% % Set plot region
% region = [-L/2,L/2,-W/2,W/2,-H/2,H/2]; 
% 
% q=slice(x,y,z,u,1/3,1/3,1/3); axis(region);
% title('Burgers Equation, WENO5$_Z$-RK3-GPU','interpreter','latex','FontSize',16);
% q(1).EdgeColor = 'none';
% q(2).EdgeColor = 'none';
% q(3).EdgeColor = 'none';
% xlabel('$\it{x}$','interpreter','latex','FontSize',14);
% ylabel('$\it{y}$','interpreter','latex','FontSize',14);
% zlabel('$\it{z}$','interpreter','latex','FontSize',14);
% colorbar; view(-45,-45);
% print('Burgers_WENO5_3d','-dpng');

% Clean up
! rm -rf *.bin
