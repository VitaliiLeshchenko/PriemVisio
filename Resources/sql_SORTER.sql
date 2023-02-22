       SELECT lh.lvl                                                                             AS lane,
              COUNT(DISTINCT lh.posn)                                                            AS all_cell_count,
              COUNT(DISTINCT CASE WHEN caseh.case_nbr    IS NOT NULL THEN lh.posn ELSE NULL END) AS lpn_cell_count,
              COUNT(DISTINCT CASE WHEN carton.carton_nbr IS NOT NULL THEN lh.posn ELSE NULL END) AS okt_cell_count
         FROM locn_hdr lh
    LEFT JOIN Case_Hdr caseh ON caseh.locn_id = lh.locn_id
    LEFT JOIN carton_hdr carton ON carton.curr_locn_id = lh.locn_id
        WHERE lh.area IN ('REP', 'PAH') AND
              lh.locn_class IN ('R', 'P') AND
              lh.lvl IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H')
     GROUP BY lh.lvl
UNION ALL
       SELECT 'Итого:', NULL, NULL, NULL FROM dual
UNION ALL
       SELECT lh.area,
              NULL,
              COUNT(DISTINCT caseh.case_nbr),
              COUNT(DISTINCT carton.carton_nbr)
         FROM locn_hdr lh
    LEFT JOIN Case_Hdr caseh ON caseh.locn_id = lh.locn_id
    LEFT JOIN carton_hdr carton ON carton.curr_locn_id = lh.locn_id
        WHERE lh.area IN ('SRT', 'SCN')
     GROUP BY lh.area