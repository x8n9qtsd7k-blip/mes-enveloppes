# Mes Enveloppes : installation pas à pas

Ce dossier contient deux choses fabriquées à partir du même code :

- **un logiciel Windows** à installer sur ton PC, pour saisir et importer tes dépenses ;
- **une version web** à ouvrir sur ton iPhone, avec une icône sur l'écran d'accueil, pour consulter tes chiffres.

Les deux restent synchronisés grâce à **Supabase**, une petite base de données en ligne gratuite. Tu n'as rien à installer pour développer : c'est GitHub qui fabrique le logiciel sur ses serveurs.

Compte environ **45 minutes** la première fois. Tout est gratuit.

---

## Étape 1 : créer ta base de données (Supabase), environ 10 min

1. Va sur **supabase.com**, clique sur **Start your project** et crée un compte (avec GitHub ou ton e-mail).
2. Clique sur **New project**.
   - Nom : `mes-enveloppes`
   - Mot de passe de la base : génère-le et garde-le dans un coin, il ne te servira presque jamais.
   - Région : **West EU (Paris)** ou **Central EU (Frankfurt)**.
3. Attends une à deux minutes que le projet soit prêt.
4. Dans le menu de gauche, ouvre **SQL Editor**. Colle tout le contenu du fichier `supabase/schema.sql` de ce dossier, puis clique sur **Run**. Le message « Success » doit s'afficher.
5. Va dans **Project Settings → Data API** (ou **API Keys** selon la version) et note deux informations :
   - **Project URL**, qui ressemble à `https://abcdxyz.supabase.co` ;
   - la clé **anon / public** (qui commence par `eyJ…`) ou **publishable** (qui commence par `sb_publishable_…`).

   Ces deux codes ne sont pas secrets : ils ne donnent accès à rien sans ton e-mail et ton mot de passe. **N'utilise jamais la clé `service_role` ou `secret`.**

## Étape 2 : mettre le code sur GitHub, environ 10 min

1. Crée un compte sur **github.com** si tu n'en as pas.
2. En haut à droite, clique sur **+ → New repository**.
   - Nom : `mes-enveloppes`
   - Visibilité : **Public** (obligatoire pour la version téléphone gratuite). Le code ne contient aucune donnée personnelle : tes chiffres restent dans Supabase, derrière ton mot de passe.
   - Clique sur **Create repository**.
3. Sur la page qui s'affiche, clique sur **uploading an existing file**.
4. Ouvre ce dossier `mes-enveloppes` sur ton PC, sélectionne **tout son contenu**, y compris le dossier `.github`, et fais-le glisser dans la page. Utilise Chrome ou Edge : ils acceptent les dossiers.
5. Vérifie que tu vois bien `.github`, `src-tauri`, `supabase`, `web`, `app-icon.png` et `package.json`, puis clique sur **Commit changes**.

## Étape 3 : fabriquer le logiciel Windows, environ 15 min (surtout de l'attente)

1. Dans ton dépôt GitHub, ouvre l'onglet **Actions**. Si GitHub te le demande, clique sur le bouton vert pour activer les workflows.
2. À gauche, clique sur **Construire le logiciel Windows**, puis sur **Run workflow → Run workflow**.
3. Attends que la pastille devienne verte (10 à 15 minutes la première fois).
4. Clique sur cette exécution. En bas de la page, dans **Artifacts**, télécharge **Mes-Enveloppes-Windows**.
5. Décompresse le fichier .zip, puis lance le fichier qui finit par **`-setup.exe`**.
6. Windows affichera sans doute « Windows a protégé votre ordinateur » : c'est normal pour un logiciel qui n'est pas signé par un éditeur payant. Clique sur **Informations complémentaires → Exécuter quand même**.

Mes Enveloppes apparaît ensuite dans ton menu Démarrer.

## Étape 4 : publier la version téléphone, environ 5 min

1. Dans ton dépôt GitHub : **Settings → Pages**. Sous **Source**, choisis **GitHub Actions**.
2. Onglet **Actions → Publier la version téléphone → Run workflow**.
3. Quand c'est vert, ton adresse est : `https://TON-PSEUDO.github.io/mes-enveloppes/`
4. Retourne dans Supabase : **Authentication → URL Configuration → Site URL**, colle cette adresse et enregistre. C'est là que mènera le lien de l'e-mail de confirmation.

## Étape 5 : te connecter et récupérer tes données

**Sur le PC, dans le logiciel :**

1. Ouvre **Réglages → Synchroniser avec le téléphone**.
2. Colle la **Project URL** et la **clé publique** de l'étape 1.
3. Saisis ton e-mail et un mot de passe, puis clique sur **Créer mon compte**.
4. Ouvre l'e-mail de confirmation de Supabase et clique sur le lien.
5. Reviens dans le logiciel et clique sur **Se connecter**. L'indicateur sous le titre affiche « Synchronisé ».

**Récupérer ce que tu as déjà saisi dans l'outil sur Claude :**

1. Dans l'outil sur Claude : **Réglages → Copier mes données**.
2. Dans le logiciel : **Réglages → Sauvegarde de secours**, colle la copie, puis clique sur **Restaurer cette copie**.
3. Toujours dans Réglages, indique ton nom tel qu'il apparaît sur tes virements, puis clique sur **Enregistrer**. Il sert à écarter les virements entre tes propres comptes lors d'un import.

**Sur l'iPhone :**

1. Ouvre ton adresse `https://TON-PSEUDO.github.io/mes-enveloppes/` dans **Safari**.
2. Touche **Partager → Sur l'écran d'accueil → Ajouter**.
3. Ouvre l'appli depuis l'icône, va dans **Réglages**, colle les deux mêmes codes et connecte-toi avec **le même e-mail et le même mot de passe**.

**Dernière précaution :** dans Supabase, va dans **Authentication → Sign In / Providers** et désactive **Allow new users to sign up**. Personne d'autre ne pourra alors créer de compte sur ta base.

---

## Au quotidien

- Les données se synchronisent à chaque modification et chaque fois que tu rouvres l'appli. Si tu modifies sur les deux appareils en même temps, c'est **la modification la plus récente** qui l'emporte.
- Hors connexion, tout fonctionne sur l'appareil, et la synchronisation reprend au retour du réseau.
- **Supabase met en pause les projets gratuits inutilisés pendant une semaine.** Si ça arrive, connecte-toi sur supabase.com et clique sur **Restore project**. Tes données ne sont pas perdues.
- Pense à faire de temps en temps **Réglages → Copier mes données** et à garder la copie dans un fichier, par sécurité.

## Modifier l'appli plus tard

Toute l'appli tient dans `web/index.html`. Pour la mettre à jour :

1. Dans GitHub, ouvre le dossier `web`, clique sur **Add file → Upload files**, dépose le nouveau `index.html` et valide avec **Commit changes**.
2. Les deux workflows se relancent automatiquement : la version téléphone se met à jour toute seule. Pour le PC, télécharge et installe le nouveau `-setup.exe` (tes données sont conservées).

## Contenu du dossier

| Élément | Rôle |
|---|---|
| `web/` | L'appli elle-même (page, icônes, fonctionnement hors connexion) |
| `src-tauri/` | L'enveloppe qui transforme la page en logiciel Windows (Tauri) |
| `.github/workflows/` | Les recettes que GitHub suit pour fabriquer le logiciel et publier la version téléphone |
| `supabase/schema.sql` | La table où sont rangées tes données, accessible à ton compte seulement |
| `app-icon.png` | L'icône du logiciel |
