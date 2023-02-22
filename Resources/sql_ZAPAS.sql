WITH carton_type_location AS
(
SELECT 'APL' AS carton_type, 'APL' AS item_location FROM dual UNION ALL
SELECT 'IVE',                '��'                   FROM dual UNION ALL
SELECT 'IVS',                '��'                   FROM dual UNION ALL
SELECT 'MAZ',                '�������'              FROM dual UNION ALL
SELECT 'MHE',                '�������'              FROM dual UNION ALL
SELECT 'ORB',                '�������'              FROM dual UNION ALL
SELECT 'OTH',                '�������'              FROM dual UNION ALL
SELECT 'PPM',                '�������'              FROM dual UNION ALL
SELECT 'PPR',                '�������'              FROM dual UNION ALL
SELECT 'RST',                '��'                   FROM dual UNION ALL
SELECT 'SCS',                '��������'             FROM dual UNION ALL
SELECT 'SML',                '�������'              FROM dual UNION ALL
SELECT 'UNT',                '��'                   FROM dual
)
SELECT to_char(ch.mod_date_time, 'YYYY-MM-DD')    AS create_date,
       a.name                                     AS NAME,
       COUNT(*)                                   AS LPN_count,
       carton_type_location.item_location
  FROM carton_type_location, case_hdr ch
  JOIN case_dtl cd ON cd.case_nbr = ch.case_nbr AND cd.case_seq_nbr = 1
  JOIN item_master im ON im.sku_id = cd.sku_id
  JOIN wcd_master wm ON im.cd_master_id = wm.cd_master_id
  JOIN address a ON wm.pkt_addr_id = a.addr_id
       AND a.addr_type IN ('01')
 WHERE ch.stat_code = 10 AND carton_type_location.carton_type = im.carton_type
 GROUP BY to_char(ch.mod_date_time, 'YYYY-MM-DD'),
          carton_type_location.item_location,
          a.name
ORDER BY 1