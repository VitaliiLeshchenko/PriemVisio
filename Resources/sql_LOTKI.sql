    SELECT to_char(TRUNC(ch.mod_date_time), 'YYYY-MM-DD')    AS "Дата создания",
           a.name                                            AS "name",
           COUNT(ch.plt_id)                                  AS "Allocated",
           COUNT(ptt.plt_id)                                 AS "Размещены"
      FROM case_hdr ch
 LEFT JOIN prod_trkg_tran ptt ON ch.case_nbr = ptt.cntr_nbr AND ptt.tran_type = '300'
      JOIN wcd_master wm ON ch.cd_master_id = wm.cd_master_id
      JOIN address a ON wm.pkt_addr_id = a.addr_id
     WHERE ch.stat_code IN (50, 96) AND (SUBSTR(ch.plt_id,0, 2) = '00' OR SUBSTR(ptt.plt_id,0, 2) = '00')
  GROUP BY TRUNC(ch.mod_date_time), a.name
  HAVING COUNT(ch.plt_id) > 0
  ORDER BY 1