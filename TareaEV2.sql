
/*3.A*/
CREATE OR REPLACE PROCEDURE reg_attencion (
    p_ate_id IN NUMBER,
    p_fecha IN DATE,
    p_hr_atencion IN VARCHAR2,
    p_costo IN NUMBER,
    p_med_run IN NUMBER,
    p_esp_id IN NUMBER,
    p_pac_run IN VARCHAR2
) IS

BEGIN
    INSERT INTO atencion (ate_id, fecha_atencion, hr_atencion, costo, med_run, esp_id, pac_run)
    VALUES (p_ate_id, p_fecha, p_hr_atencion, p_costo, p_med_run, p_esp_id, p_pac_run);

END;

/*3.B*/
CREATE OR REPLACE FUNCTION cons_attencion (
    f_fecha_in DATE,
    f_fecha_fin DATE
) RETURN SYS_REFCURSOR IS 
    v_cursor SYS_REFCURSOR;

BEGIN 
    OPEN v_cursor FOR
    SELECT att.fecha_atencion AS "Fecha Attencion", med.pnombre || ' ' || med.apaterno AS "Nombre Medico", pac.pnombre || ' ' || pac.apaterno AS " Nombre Paciente" 
    FROM atencion att
    JOIN medico med ON att.med_run = med.med_run
    JOIN paciente pac ON att.med_run = pac.pac_run
    JOIN especialidad esp ON att.esp_id = esp.esp_id
    WHERE att.fecha_atencion BETWEEN f_fecha_in AND f_fecha_fin;
    
END;    
    

/*3.C*/
CREATE OR REPLACE PROCEDURE upd_sueldo (
    p_med_rut VARCHAR2,
    p_sueldo_base NUMBER
) IS

BEGIN 
    UPDATE medico SET sueldo_base = p_sueldo_base
    WHERE p_med_rut = med_run || '-' || dv_run;

END;   

BEGIN
    upd_sueldo('9827836-2', '9999990');
END;


/*3.D*/
CREATE OR REPLACE FUNCTION calc_age (
    f_rut_pac VARCHAR2
) RETURN NUMBER IS 
    v_edad NUMBER;
    v_fecha_nacimiento DATE;

BEGIN
    SELECT fecha_nacimiento
    INTO v_fecha_nacimiento
    FROM paciente
    WHERE f_rut_pac = pac_run || '-' || dv_run;
    
    v_edad := FLOOR(MONTHS_BETWEEN(SYSDATE, v_fecha_nacimiento) / 12);
    
    RETURN v_edad;
END;


SELECT calc_age('6215470-5') AS EDAD
FROM dual;


/*3.E*/
CREATE OR REPLACE FUNCTION existe (
    f_rut_pac VARCHAR2
) RETURN VARCHAR2 IS 
    v_exist VARCHAR2(50);
BEGIN
    SELECT CASE WHEN COUNT(*) > 0 THEN 'El Paciente Exists' ELSE 'No Se Encuentra'END
    INTO v_exist
    FROM paciente
    WHERE f_rut_pac = pac_run || '-' || dv_run;
    
    RETURN v_exist;
END;


SELECT existe('6675981-4')
FROM dual;

/*fin*/







