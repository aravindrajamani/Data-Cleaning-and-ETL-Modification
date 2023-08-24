CREATE PROCEDURE [dbo].[InsertDataWithTransaction]
AS
BEGIN
    SET XACT_ABORT ON;
   
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO XXXX_table (DEALER_ID,BRANCH_ID,ENQUIRY_DATE,ENQUIRY_TYPE,SALE_MODE,OLD_VEHICLE,EXIST_MODEL_ID,DO_FOLLOWUP,NXT_FOLWUP_DT,NXT_FOLWUP_TM,PROS_CAT_ID,
STATUS,CREATED_ON,CREATED_BY,MODIFIED_ON,INTERNET_ENQUIRY_ID,BOOK_AMT,BUYDATE_RANGE,IS_EMS,IS_BOOKED,ENQUIRY_MODE,CUSTOMER_NAME,GENDER,MARRIED,EMAIL_ID,CUST_TY_ID,ADDRESS_LINE1,STATE_ID,MOBILE_NUMBER,PART_ID,MODEL_ID,AREA,AREA_ID)
        SELECT Distinct a.DEALER_ID,a.BRANCH_ID,a.ENQUIRY_DATE,a.ENQUIRY_TYPE,a.SALE_MODE,a.OLD_VEHICLE,a.EXIST_MODEL_ID,a.DO_FOLLOWUP,a.NXT_FOLWUP_DT,a.NXT_FOLWUP_TM,a.PROS_CAT_ID,
a.STATUS,a.CREATED_ON,a.CREATED_BY,a.MODIFIED_ON,a.INTERNET_ENQUIRY_ID,a.BOOK_AMT,a.BUYDATE_RANGE,a.IS_EMS,a.IS_BOOKED,a.ENQUIRY_MODE_ID, c.CUST_NAME,c.GENDER,c.MARRIED,c.EMAIL_ADDRESS,c.CUST_TY_ID,d.ADDRESS_LINE_1,d.STATE_ID,e.CONTACT_NO,f.PART_ID,f.MODEL_ID,g.AREA_NAME,g.AREA_ID
        FROM YYYY_table a
left join ZZZZ_Table c on a.CUSTOMER_ID=c.CUSTOMER_ID
left join AAAA_Table d on a.CUSTOMER_ID=d.CUSTOMER_ID
left join BBBB_Table e on a.CUSTOMER_ID=e.CUSTOMER_ID
left join CCCC_Table f on a.DEALER_ID=f.DEALER_ID and a.BRANCH_ID=f.BRANCH_ID and a.ENQUIRY_ID=f.ENQUIRY_ID
left join DDDD_Table g on a.dealer_ID=g.DEALER_ID and d.AREA_ID=g.AREA_ID
        WHERE a.CREATED_ON >= DATEADD(month, -3, GETDATE()) and e.PHONE_TYPE in(6)
        AND NOT EXISTS (
            SELECT 1
            FROM XXXX_Table b
            WHERE b.CREATED_ON = a.CREATED_ON
        )
AND NOT EXISTS (
            SELECT 1
            FROM XXXX_Table h
            WHERE h.DEALER_ID=a.DEALER_ID and
h.BRANCH_ID=a.BRANCH_ID and
h.INTERNET_ENQUIRY_ID=a.INTERNET_ENQUIRY_ID and
h.dealer_id!=100 and
a.DEALER_ID!=100
        )
and a.INTERNET_ENQUIRY_ID is not null;
       
        COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;
       
        -- Additional error handling logic can be added here
        THROW;
    END CATCH;
END;
GO