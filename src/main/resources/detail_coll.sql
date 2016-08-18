select
    m.PID                      PID,
    m.PTYPE                    ITEM_TYPE,
    m.ITEM_DATE                ITEM_TICKS_TIME, -- long
    m.ITEM_DATE                ITEM_TICKS_DATE, -- long
    m.ITEM_ID                  ITEM_ID,
    m.ITEM_ID                  ITEM_ID_13,
    ''                         ITEM_ID_STD,
    m.ITEM_ID                  ITEM_CLASS_SMALLEST,
    m.ITEM_NAME                ITEM_NAME,
    m.NUMBERS                  NUMBERS,
    m.PRICE                    PRICE,
    m.COSTS                    COSTS,
    m.DEPT_ID                  DEPT_ID,
    m.DEPTNAME                 DEPTNAME,
    m.PACKAGE_UNIT             USAGE_UNIT,
    m.DRUG_SPEC                Specification,
    m.DAYS_OF_SUPPLY           USAGE_DAYS,
    m.USAGE                    USAGE,
    m.FREQUENCY_INTERVAL       FREQUENCY_INTERVAL,
    m.USE_METHOD               USE_METHOD,
    0                          TheUseType,
    0.0d                       SELF_AMOUNT,
    m.ELIGIBLE_AMOUNT          ELIGIBLE_AMOUNT,
    0.0d                       UsageAmount,
    m.ITEM_DATE                ITEM_TICKS_TIME_Next, -- long
    1                          theFirstClinicalType,
    21                         theSecondType,
  --'RD_DiseaseCode'           RD_DiseaseCode,
    '330799-8002'              RD_HospitalID,
    '1'                        RD_HospitalType,
    -1                         RD_FIRST_DATE,   -- long
    ''                         PhysicianLevel,
    m.PHYSICIAN_ID             PHYSICIAN_ID,
    m.PHYSICIAN_NAME           PHYSICIAN_NAME,
    m.REAL_NUM                 REAL_NUM,
    m.REAL_MONEY               REAL_MONEY,
    m.PHYSICIAN_ID             ETL_Patient_IDStr,
    1                          ALLOW_HISTORY,
    ''                         ApprovalNumber,
    '330799-98670086'          ETL_ClaimID,
    ''                         PhysicianAP,
    m.CostCategory             CostCategory,
    1                          AKF003,
    '1'                        BKA609,
    1                          ZZZ_Flag,
    '3700808191'               PrescriptionNo,
    0.0d                       COSTS_REAL_MONEY,
    m.ITEM_DATE                ITEM_DATE
--from dw_billdetail m where PHYSICIAN_ID is not null and pid is not null and pid = 'H0001201312240053' and PHYSICIAN_ID='7799'
--from dw_billdetail m where PHYSICIAN_ID is not null and pid is not null
from dw_billdetail m where PHYSICIAN_ID is not null and pid is not null order by pid, PHYSICIAN_ID
--from dw_billdetail m where PHYSICIAN_ID = '0411' and pid = 'H0083201312300004' and rownum = 1
--from dw_billdetail m where PHYSICIAN_ID = '0411' and pid = 'H0083201312300004'