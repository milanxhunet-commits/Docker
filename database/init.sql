-- ================================================
-- SHLINK DATABASE INITIALIZATION
-- Ky file ekzekutohet automatikisht kur krijohet
-- database-i per here te pare
-- ================================================

-- Krijon extension per UUID (opsionale)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Log mesazh fillestar
DO $$
BEGIN
    RAISE NOTICE 'Shlink database initialized successfully!';
END $$;
