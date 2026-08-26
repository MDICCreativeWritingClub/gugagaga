-- ============================================================
-- Award History table
-- Run in: Supabase → SQL Editor → New Query
-- Safe to run on your existing project. Does not touch other tables.
-- ============================================================

create table if not exists award_history (
  id uuid primary key default gen_random_uuid(),
  award_type text not null check (award_type in ('wom', 'editors_choice')),
  student_code text,
  writer_name text not null,
  grade text,
  article_id text,
  article_title text,
  votes integer,
  month_label text not null,
  year integer not null,
  created_at timestamptz default now()
);

alter table award_history enable row level security;

create policy "public read award_history" on award_history for select using (true);
create policy "public write award_history" on award_history for all using (true);

-- Speeds up "how many times has this student won" lookups on the author page.
create index if not exists award_history_student_code_idx on award_history (student_code);
