-- Mes Enveloppes : une seule ligne par compte, lisible et modifiable uniquement par ce compte.
create table if not exists public.budget_data (
  user_id uuid primary key default auth.uid() references auth.users (id) on delete cascade,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.budget_data enable row level security;

create policy "lire mes données" on public.budget_data
  for select using (auth.uid() = user_id);
create policy "créer mes données" on public.budget_data
  for insert with check (auth.uid() = user_id);
create policy "modifier mes données" on public.budget_data
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
