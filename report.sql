/*|**********************************************************************;
* Project           : State Of Maryland Budget Analysis
*
* Program name      : report.sql
*
* Author            : Jessie Ann Owens
*
* Date created      : 12/14/20
*
* Purpose           : Support analysis of the Maryland Budget Data
*					This document holds the tables in the model
*
|**********************************************************************;*/

-- Agency Dimension
with d1 as (SELECT DISTINCT
CONCAT(Agency_Code,Agency_Subobject_Code,Unit_Code,Program_Code,Subprogram_Code,Object_Code) [budgetCode],
Agency_Code,
Agency_Name,
Agency_Subobject_Code,
Agency_Subobject_Name,
Category,
Category_Title,
--Comptroller_Subobject_Code,
--Comptroller_Subobject_Name,
--Description,
Fund_Type_Name,
Object_Code,
Object_Name,
Program_Code,
Program_Name,
Subprogram_Code,
Subprogram_Name,
Type,
Unit_Code,
Unit_Name
FROM
[dbo].[Maryland_Operating_Budget] )

select * from d1

-- Budget Fact
 with f1 as ( 
select
CONCAT(Agency_Code,Agency_Subobject_Code,Unit_Code,Program_Code,Subprogram_Code,Object_Code) [budgetCode],
CONCAT('1/1/',Fiscal_Year) [Fiscal_Year],
Budget,
[Total Budget],
([Budget] / [Total Budget]) [Percent]
from Maryland_Operating_Budget as MOB
LEFT JOIN  (
select Fiscal_Year [fy], sum(Budget) [Total Budget]
from Maryland_Operating_Budget
group by Fiscal_Year ) p on p.fy = MOB.Fiscal_Year
) select * from f1


--Bridge
with b1 as (
SELECT DISTINCT
CONCAT(Agency_Code,Agency_Subobject_Code,Unit_Code,Program_Code,Subprogram_Code,Object_Code) [budgetCode]
from Maryland_Operating_Budget ) select * from b1