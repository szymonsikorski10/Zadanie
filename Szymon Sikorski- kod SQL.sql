--Utworzenie tabel
CREATE TABLE IF NOT EXISTS dostawca_a (
  id_wiersza TEXT, 
	id_odczytu TEXT, 
	kod_oddzialu TEXT, 
	okres TEXT, 
  zuzycie TEXT, 
	jednostka TEXT, 
	wersja TEXT, 
	data_otrzymania TEXT
);

CREATE TABLE IF NOT EXISTS dostawca_b (
  row_id TEXT, 
	reading_id TEXT, 
	branch_code TEXT, 
	period TEXT, 
  energy_value TEXT, 
	energy_unit TEXT, 
	revision_no TEXT, 
	recieved_at TEXT
);

CREATE TABLE IF NOT EXISTS lokalizacje (
  kod_lok TEXT, 
	nazwa TEXT, 
	aktywny_od TEXT, 
	aktywny_do TEXT
);

CREATE TABLE IF NOT EXISTS historia_zmian (
  id_zmiany TEXT, 
	kod_lok TEXT, 
	miesiac TEXT, 
	typ TEXT, 
  wartosc_kwh TEXT, 
	data_zmiany TEXT, 
	opis TEXT
);

CREATE TABLE IF NOT EXISTS raport_poprzedni (
  kod_lok TEXT, 
	miesiac TEXT, 
	zuzycie_kwh TEXT
);


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
FROM raport_poprzedni AS r
LEFT JOIN lokalizacje l ON r.kod_lok = l.kod_lok
WHERE l.kod_lok IS NULL;

--Analogiczne kroki zostały przyprowadzone dla dostawcy b, zmieniły się nazwy kolumn z racji tego, że zostały zapisane po angielsku, na przykład:
SELECT row_id, branch_code, period, energy_value, energy_unit
FROM dostawca_b
WHERE energy_unit <> 'kWh';
