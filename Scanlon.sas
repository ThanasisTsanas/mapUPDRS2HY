/*******************************************************************/
/* Scanlon.sas                                                      */
/* Uses formulas in Tsanas et. al. for mapping UPDRS to H&Y scale  */
/* Code supplied by Andrew A. Kramer, Ph.D.  on 3/21/2012          */
/*******************************************************************/

* Refined Scanlon's formula;

data map1; input item18 item19 item_neck22 item20L item21L item22L item23L item24L item25L item26L 
                 item20R item21R item22R item23R item24R item25R item26R item27 item29 item30 item31;
cards;
* Data should go here;
;
run;

data map2a; set map1;
   label HY = "Scanlon's formula";
   label HYm = "Modified Scanlon's formula";

   sum_L = sum(item20L, item21L, item22L, item23L, item24L,item25L, item26L);
   sum_R = sum(item20R, item21R, item22R, item23R, item24R, item25R, item26R);

   HY = 0;
   if sum(item18, item19) = 0 then do; if sum_L = 0 OR sum_R = 0 then HY = 1.0; end;
   if sum(item18, item19) > 0 then do; if sum_L = 0 OR sum_R = 0 then HY = 1.5; end;
   if item30 = 0 & sum_L > 0 & sum_R > 0 then HY = 2.0;
   if item30 = 1 & sum_L > 0 & sum_R > 0 then HY = 2.5;
   if (1 < item30 < 4) & sum_L > 0 & sum_R > 0 then HY = 3.0;
   if (1 < item29 < 4) & (item27 < 4) & (2 < item31 <= 4) then HY = 4.0;
   if item29 = 4 or item30 = 4 then HY = 5.0;
   

   HYm = 0;
   if sum(item18, item19, item_neck22) = 0 then do; if sum_L = 0 OR sum_R = 0 then HYm = 1.0; end;
   if sum(item18, item19, item_neck22) > 0 then do; if sum_L = 0 OR sum_R = 0 then HYm = 1.5; end;
   if item30 = 0 & sum_L > 0 & sum_R > 0 then HYm = 2.0;
   if item30 = 1 & sum_L > 0 & sum_R > 0 then HYm = 2.5;
   if (1 < item30 < 4) & sum_L > 0 & sum_R > 0 then HYm = 3.0;
   if (1 < item29 < 4) & (item27 < 4) & (2 < item31 le 4)then HYm = 4.0;
   if item29 = 4 or item30 = 4 then HYm = 5.0;
run;


