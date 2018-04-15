/*Table creation start*/
CREATE TABLE tbl_user_login_control (
                                     user_login_id VARCHAR(10) NOT NULL,
                                     app_modified_datetime DATETIME NOT NULL,
                                     PRIMARY KEY(user_login_id)
                                    );
/*Table creation end*/

/*Event creation start*/
CREATE EVENT event_chk_inactive_usr_lgn
SCHEDULE event_chk_inactive_usr_lgn BETWEEN '00:00' AND '23:59' EVERY 60 SECONDS
HANDLER
BEGIN
    DELETE 
    FROM tbl_user_login_control
    WHERE DateDiff(ss, app_modified_datetime, CURRENT_TIMESTAMP) > 300;
    
    COMMIT;

END;

COMMENT ON EVENT event_chk_inactive_usr_lgn IS 'This event checks and deletes user record from tbl_user_login_control, if any user found inactive';

/*Event creation end*/

COMMIT;