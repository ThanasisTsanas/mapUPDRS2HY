function [HY] = UPDRS2HY(Xin, gender)
%
% General call: [HY] = UPDRS2HY(Xin, gender)
%
%% Function to get the Hoehn & Yahr stage from UPDRS
%
% Aim: obtain Parkinson's disease severity stage from the detailed UPDRS
% metric
%
% Inputs:  Xin     -> 1 by 27 vector, the 27 motor-UPDRS entries (each entry is a scalar between 0 and 4)
%                     It is also possible to obtain H&Y for multiple subjects:
%                     simply insert an Nx27 matrix
%__________________________________________________________________________
% optional inputs:  
%          gender  -> '0' for males, '1' for females
% =========================================================================
% Output:  HY       -> The Hoehn and Yahr stage
% =========================================================================
% -----------------------------------------------------------------------
% Useful references:
% 
% 1) A. Tsanas, M.A. Little, P.E. McSharry, B.K. Scanlon,
%    S. Papapetropoulos: “Statistical analysis and mapping of the Unified 
%    Parkinson’s Disease Rating Scale to Hoehn and Yahr staging”, 
%    Parkinsonism and Related Disorders, Vol. 18 (5), pp. 697-699, 2012 
% 2) B.K. Scanlon, H.L. Katzen, B.E. Levin, C. Singer, S. Papapetropoulos,
%    "A revised formula for the conversion of UPDRS-III scores to Hoehn and
%    Yahr stage", Parkinsonism & Related Disorders 2010, 16(2), 151-152
% -----------------------------------------------------------------------
%
% Last modified on 9 May 2012
%
% (c) Athanasios Tsanas
%
% ********************************************************************
% If you use this program please cite:
%
%    A. Tsanas, M.A. Little, P.E. McSharry, B.K. Scanlon,
%    S. Papapetropoulos: “Statistical analysis and mapping of the Unified 
%    Parkinson’s Disease Rating Scale to Hoehn and Yahr staging”, 
%    Parkinsonism and Related Disorders, Vol. 18 (5), pp. 697-699, 2012 
% ********************************************************************
%
% For any question, to report bugs, or just to say this was useful, email
% tsanasthanasis@gmail.com

%% Set initial defaults

if (nargin<2) % general equation
    w = [0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 4 0 0 1 4 4 2 4 4 4]; % modified Scanlon's optimal parameters
elseif (gender ==0) % Male subject
    w = [0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 4 0 0 1 4 4 3 4 4 4]; % modified Scanlon's optimal parameters for MALES
elseif (gender ==1) % Female subject
    w = [0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 4 0 0 2 4 4 1 4 4 4]; % modified Scanlon's optimal parameters for FEMALES
end

HY = Scanlon_mapping_optimized(Xin, w);

end

%% Additional functions to the program

function [modifiedScanlon_HY] = Scanlon_mapping_optimized(Xin, w)

% function to map the motor-UPDRS to H&Y stage according to Scanlon, and
% according to Fernandez
% rows are for patients, columns are for the motor components (27)


X(:,18:44) = Xin; % just for compatibility I map the normal design matrix X consisting of 27 sections to X with 44 sections

[N, M] = size(X);

motor_UPDRS_names = {'18.Q18 Speech',...
    '19.Q19 Face',...
    '20.Q20a Tremor face',...
    '21.Q20b Tremor RH',...
    '22.Q20c Tremor LH',...
    '23.Q20d Tremor RF',...
    '24.Q20e Tremor LF',...
    '25.Q21a Postr RH',...
    '26.Q21b Postr LH',...
    '27.Q22a Rigid neck',...
    '28.Q22b Rigid RUE',...
    '29.Q22c Rigid LUE',...
    '30.Q22d Rigid RLE',...
    '31.Q22e Rigid LLE',...
    '32.Q23a Tap RH',...
    '33.Q23b Tap LH',...
    '34.Q24a Hand RH',...
    '35.Q24b Hand LH',...
    '36.Q25a RAM RH',...
    '37.Q25b RAM LH',...
    '38.Q26a Leg RL',...
    '39.Q26b Leg LL',...
    '40.Q27 Arise',...
    '41.Q28 Post',...
    '42.Q29 Gait',...
    '43.Q30 Stable',...
    '44.Q31 Brady'};

%% Define items

for i = 1:N 
    clear item*
    
    item18 = X(i,18);
    item19 = X(i,19);
    item20R = X(i,21) + X(i,23);
    item20L = X(i,22) + X(i,24);

    item21R = X(i,25);
    item21L = X(i,26);

    item22R = X(i,28) + X(i,30);
    item22L = X(i,29) + X(i,31);
    item22_neck = X(i,27);
    
    item23R = X(i,32);
    item23L = X(i,33);

    item24R = X(i,34);
    item24L = X(i,35);

    item25R = X(i,36);
    item25L = X(i,37);

    item26R = X(i,38);
    item26L = X(i,39);

    item27 = X(i,40);
    item28 = X(i,41);
    item29 = X(i,42);
    item30 = X(i,43);
    item31 = X(i,44);

%% Now, determine the H&Y stage using the optimized modified Scanlon formula

% %         CASE 1
    if ((item18 == w(1) && item19 == w(2) && item22_neck == w(3)) && ...
            ((item20L + item21L + item22L + item23L + item24L + item25L + item26L == w(4)) || ...
             (item20R + item21R + item22R + item23R + item24R + item25R + item26R == w(5))))
         modifiedScanlon_HY(i,1) = 1.0;
    end

% %         CASE 1.5
    if ((item18 > w(6) || item19 > w(7) || item22_neck > w(8)) && ...
            ((item20L + item21L + item22L + item23L + item24L + item25L + item26L == w(9)) || ...
             (item20R + item21R + item22R + item23R + item24R + item25R + item26R == w(10))))
         modifiedScanlon_HY(i,1) = 1.5;
    end

% %         CASE 2
    if (item30 == w(11) && ...
            ((item20L + item21L + item22L + item23L + item24L + item25L + item26L > w(12)) && ...
             (item20R + item21R + item22R + item23R + item24R + item25R + item26R > w(13))))
         modifiedScanlon_HY(i,1) = 2.0;
    end

% %         CASE 2.5
    if ((item30 == w(14)) && ...
            ((item20L + item21L + item22L + item23L + item24L + item25L + item26L > w(15)) && ...
             (item20R + item21R + item22R + item23R + item24R + item25R + item26R > w(16))))
         modifiedScanlon_HY(i,1) = 2.5;
    end

% %         CASE 3
    if ((item30 > w(17) && item30 < w(18)) && ...
            ((item20L + item21L + item22L + item23L + item24L + item25L + item26L > w(19)) && ...
             (item20R + item21R + item22R + item23R + item24R + item25R + item26R > w(20))))
         modifiedScanlon_HY(i,1) = 3.0;
    end

% %         CASE 4
    if (((item29 > w(21) && item29 < w(22)) && (item27 < w(23)) && (item31 > w(24) && item31 <= w(25))))
         modifiedScanlon_HY(i,1) = 4.0;
    end

% %         CASE 5
    if (((item29 == w(26)) || (item30 == w(27))))
        modifiedScanlon_HY(i,1) = 5.0;
    end

% %         CASE 0 -- for now just use this if all entries are zero!
    if (all(Xin(i,:)==0))
        modifiedScanlon_HY(i,1) = 0;
    end
end % end of main loop

end
