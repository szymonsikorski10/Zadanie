--Sprawdzenie jednostek
SELECT id_wiersza, kod_oddzialu, okres, zuzycie, jednostka 
FROM dostawca_a 
WHERE jednostka <> 'kWh';

--Sprawdzenie ukrytych spacji w kodach oddziałów
SELECT id_wiersza, kod_oddzialu 
FROM dostawca_a 
WHERE kod_oddzialu <> TRIM(kod_oddzialu);

--Znalezienie duplikatów i wielu wersji tego samego odczytu
SELECT id_odczytu, COUNT(*) AS liczba_wystapien
FROM dostawca_a
GROUP BY id_odczytu
HAVING COUNT(*) > 1;

--Sprawdzenie oddziałów ze starego raportu, których nie ma w tabeli lokalizacji
SELECT DISTINCT r.kod_lok
FROM raport_poprzedni r
LEFT JOIN lokalizacje l ON r.kod_lok = l.kod_lok
WHERE l.kod_lok IS NULL;

--Analogiczne kroki zostały przyprowadzone dla dostawcy b, zmieniły się nazwy kolumn z racji tego, że zostały zapisane po angielsku, na przykład:
SELECT row_id, branch_code, period, energy_value, energy_unit
FROM dostawca_b
WHERE energy_unit <> 'kWh';