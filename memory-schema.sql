-- 3-Tier Agent Memory System — SQLite Schema
-- Deploy: sqlite3 /home/ubuntu/shared-context/memory.db < memory-schema.sql

-- Tier 2 — Working Memory Tables

CREATE TABLE IF NOT EXISTS agents (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL,
    role TEXT NOT NULL,
    location TEXT NOT NULL,
    status TEXT DEFAULT 'idle' CHECK (status IN ('idle','working','blocked','offline')),
    current_task TEXT,
    last_seen TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    owner TEXT NOT NULL,
    priority TEXT DEFAULT 'P2' CHECK (priority IN ('P0','P1','P2','P3')),
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending','in_progress','completed','blocked','cancelled')),
    project TEXT,
    description TEXT,
    blocker TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS events (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    agent TEXT NOT NULL,
    action TEXT NOT NULL,
    target TEXT,
    details TEXT,
    project TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS pings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    from_agent TEXT NOT NULL,
    to_agent TEXT NOT NULL,
    message TEXT NOT NULL,
    urgency TEXT DEFAULT 'normal' CHECK (urgency IN ('low','normal','urgent','critical')),
    read INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS project_state (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    project TEXT UNIQUE NOT NULL,
    status TEXT NOT NULL,
    health TEXT DEFAULT 'unknown' CHECK (health IN ('healthy','degraded','down','unknown')),
    last_deploy TIMESTAMP,
    last_error TEXT,
    notes TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Seed data — current company state
INSERT OR IGNORE INTO agents (name, role, location, status, current_task) VALUES
('hermes', 'CEO', 'macOS Laptop', 'working', 'Building 3-tier memory system'),
('thor', 'Head of Product', 'macOS Laptop', 'idle', 'Dashboard/content pipeline'),
('frikkie', 'CTO', 'Oracle VM', 'working', 'Server hardening + deploy system'),
('zeus', 'Senior Engineer', 'Oracle VM', 'idle', 'Backend/API tasks');

INSERT OR IGNORE INTO tasks (title, owner, priority, status, project, description) VALUES
('Trading Agent Live Deploy', 'frikkie', 'P0', 'completed', 'hyperliquid-trader', 'Fixed duplicate instances, PID lock, one-position-per-coin, risk manager wired'),
('JobOS Tokenomics Fix', 'hermes', 'P0', 'completed', 'jobos-tokenomics', 'Scenario 3 approved: 30/20/10/15/15/10 split'),
('Server Security Hardening', 'frikkie', 'P0', 'completed', 'infrastructure', 'Firewall DROP policy, localhost binds, SSH key-only, Tailscale lifeline'),
('Content Studio YT Shorts', 'thor', 'P1', 'operational', 'content-studio', 'Needs pipeline polish'),
('Mission Control Dashboard', 'thor', 'P1', 'operational', 'mission-control-server', 'Fragile — template rebuilds wipe panels'),
('Prowash Accounting Dashboard', 'hermes', 'P2', 'in_progress', 'prowash-accounting-dashboard', 'FNB PDF parsing edge cases'),
('3-Tier Memory System', 'hermes', 'P0', 'in_progress', 'company-hq', 'Building now — this session');

INSERT OR IGNORE INTO project_state (project, status, health, last_deploy, notes) VALUES
('hyperliquid-trader', 'deployed', 'healthy', datetime('now'), 'PM2 managed, PID lock active, daily loss circuit 5%'),
('jobos-tokenomics', 'modeled', 'healthy', '2026-05-05', 'Scenario 3 approved, needs whitepaper update'),
('mission-control-server', 'operational', 'degraded', '2026-05-06', 'Template rebuilds wipe additions'),
('content-studio', 'operational', 'healthy', '2026-05-05', 'Composio YouTube auth active'),
('prowash-accounting-dashboard', 'in_dev', 'healthy', NULL, 'FNB statements up to #37');
