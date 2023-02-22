SELECT to_char(ah.create_date_time, 'YYYY-MM-DD') AS create_date,
       a.name                                     AS departament_name,
       ah.shpmt_nbr                               AS shpmt_nbr,
       CASE
         WHEN ah.asn_shpmt_type = 'L'   THEN 'LOCAL'
         ELSE SUBSTR(im.sku_desc, 0, 3)
           END                                    AS brand,
       nvl(ah.ref_field_1, ' ')                    AS ref_field_1,
       CASE
         WHEN ah.stat_code = 10 THEN 'В транзите'
         WHEN ah.stat_code = 30 THEN 'В приеме'
         WHEN ah.stat_code = 60 THEN 'Приход закрыт'
         WHEN ah.stat_code = 85 THEN 'Попытка проверить'
         WHEN ah.stat_code = 90 THEN 'Приход подтвержден'
         ELSE sc.code_desc
           END                                    AS stat_code,
       ah.units_shpd                              AS units_shpd,
       ah.units_rcvd                              AS units_rcvd,
       ah.units_shpd - ah.units_rcvd              AS units
  FROM asn_hdr ah
  JOIN asn_dtl ad ON ad.shpmt_nbr = ah.shpmt_nbr AND ad.shpmt_seq_nbr = 1
  JOIN item_master im ON im.sku_id = ad.sku_id
  JOIN wcd_master wm ON im.cd_master_id = wm.cd_master_id
  JOIN address a ON wm.pkt_addr_id = a.addr_id
       AND a.addr_type IN ('01')
  JOIN sys_code sc ON sc.code_type = '564' AND sc.code_id = ah.stat_code
 WHERE (ah.asn_shpmt_type IS NULL OR ah.asn_shpmt_type IN ('DR', 'IMP', 'L', 'P', 'SV')) AND ah.stat_code < 90
       AND NOT (ah.stat_code = 90 AND ah.mod_date_time < SYSDATE - 1)
 ORDER BY ah.stat_code,
          ah.create_date_time