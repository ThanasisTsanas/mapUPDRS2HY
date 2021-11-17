# mapUPDRS2HY
Function to compute the Hoehn and Yahr (H&Y) scale from the UPDRS scale

This is a specialized function for Parkinson's. There are different clinically established scales to assess symptom severity in Parkinson's. 
Two of the most popular are (1) UPDRS and (2) Hoehn and Yahr (H&Y). The former is an elaborate detailed scale, whereas the latter provides 
an overall estimate of symptom severity at discrete levels.

This function provides a convenient approach to infer H&Y from UPDRS.

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
