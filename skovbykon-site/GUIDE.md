# SkovByKon.dk — Opsætning af ny hjemmeside

Denne guide tager dig fra den fil-pakke du har nu, til en live hjemmeside med et CMS hvor du kan redigere indhold.

Du behøver ingen kodningserfaring. Alt foregår i browseren.

---

## Hvad er i pakken?

```
skovbykon-site/
├── index.html          ← Selve hjemmesiden
├── netlify.toml        ← Konfiguration til Netlify hosting
├── admin/
│   ├── index.html      ← CMS login-side
│   └── config.yml      ← CMS konfiguration (hvilke felter du kan redigere)
└── data/               ← Indholdsdata i JSON-format
    ├── artikler/
    ├── boeger/
    ├── metoder/
    ├── standarder/
    ├── team/
    ├── projekter/
    └── sider/
```

---

## Trin 1: Opret en GitHub-konto

GitHub er hvor dine filer bor. CMS'et gemmer ændringer her automatisk.

1. Gå til **github.com** og opret en gratis konto
2. Klik **"New repository"** (grøn knap)
3. Navngiv det `skovbykon-site`
4. Vælg **Public**
5. Klik **"Create repository"**
6. Upload alle filer fra pakken (drag-and-drop hele mappen ind i browseren)
7. Klik **"Commit changes"**

---

## Trin 2: Opret Netlify-konto og forbind

Netlify er den gratis hosting der kører din hjemmeside.

1. Gå til **app.netlify.com** og opret konto (brug "Sign up with GitHub")
2. Klik **"Add new site"** → **"Import an existing project"**
3. Vælg **GitHub** og find dit `skovbykon-site` repository
4. Lad alle indstillinger stå som standard
5. Klik **"Deploy site"**
6. Vent 30 sekunder — din side er nu live på en midlertidig URL (fx `random-name-123.netlify.app`)

---

## Trin 3: Slå Identity til (kræves til CMS-login)

1. I Netlify: gå til **Site settings** → **Identity**
2. Klik **"Enable Identity"**
3. Under **Registration preferences**: vælg **"Invite only"**
4. Under **External providers**: tilføj evt. **Google** (så du kan logge ind med Google)
5. Gå til **Identity** → **Invite users** og inviter din egen e-mail
6. Tjek din mail og klik på invitationslinket
7. Vælg et password

---

## Trin 4: Aktiver Git Gateway (kræves til at CMS kan gemme)

1. I Netlify: gå til **Site settings** → **Identity** → **Services**
2. Under **Git Gateway**: klik **"Enable Git Gateway"**

---

## Trin 5: Test CMS'et

1. Gå til `din-side.netlify.app/admin/`
2. Log ind med den e-mail du inviterede i trin 3
3. Du ser nu alle indholdskategorier: Artikler, Bøger, Metoder, Team osv.
4. Prøv at redigere et teammedlem eller tilføje en artikel
5. Når du klikker **"Publish"**, gemmes ændringen i GitHub

**Bemærk:** I denne version skal du stadig opdatere `index.html` manuelt for at vise de nye data fra CMS'et. Det er næste skridt (se "Videreudvikling" nedenfor).

---

## Trin 6: Peg skovbykon.dk til Netlify

Når siden ser rigtig ud:

1. I Netlify: gå til **Domain settings** → **Add custom domain**
2. Skriv `skovbykon.dk`
3. Netlify fortæller dig hvilke DNS-records du skal ændre
4. Log ind hos jeres domæneregistrar (sandsynligvis via jeres nuværende hosting-udbyder)
5. Ændr DNS-records som Netlify angiver (typisk en CNAME- eller A-record)
6. Vent op til 24 timer på DNS-propagering
7. Netlify opretter automatisk et SSL-certifikat (HTTPS)

**Vigtigt:** Ændr ikke DNS før I er tilfredse med den nye side. I kan teste alt på den midlertidige Netlify-URL først.

---

## Hvad kan du redigere i CMS'et?

| Indhold | Hvad du kan | Hvor |
|---------|-------------|------|
| **Artikler** | Tilføj/rediger/slet fagartikler med titel, kategori, PDF-link | Artikler |
| **Bøger** | Tilføj/rediger bøger med forside, beskrivelse, link | Bøger |
| **Metoder** | Tilføj/rediger målemetoder med link og kategori | Metoder |
| **Standarder** | Tilføj/rediger standarder og retningslinjer | Standarder & retningslinjer |
| **Team** | Tilføj/rediger teammedlemmer med portræt og beskrivelse | Teammedlemmer |
| **Projekter** | Tilføj/rediger cases med billede og beskrivelse | Projekter / Cases |
| **Forside** | Rediger hero-overskrift, tagline, stats og intro-tekst | Sideindhold → Forside |
| **Tilgang** | Rediger "Sådan arbejder vi"-afsnittet | Sideindhold → Tilgang |
| **Kontakt** | Rediger kontaktinfo, overskrift, e-mail, telefon | Sideindhold → Kontakt |

---

## Videreudvikling

Lige nu virker CMS'et som en struktureret database — det gemmer data, men viser dem ikke automatisk på forsiden. For at koble det hele sammen skal der tilføjes et lille JavaScript der henter JSON-filerne fra `/data/` og renderer dem i HTML'en.

Det er en opgave Claude kan løse for dig i en senere samtale. Resultatet er at du kan tilføje en ny artikel i CMS'et, klikke "Publish", og den dukker op på hjemmesiden inden for et minut — uden at røre koden.

---

## Ofte stillede spørgsmål

**Koster det noget?**
Nej. GitHub (gratis), Netlify (gratis tier dækker rigeligt), og Decap CMS (open source). Det eneste I betaler for er domænet, som I allerede har.

**Hvad sker der med den gamle Joomla-side?**
Den kører videre på den nuværende hosting indtil I peger DNS'en til Netlify. Så kan I opsige Joomla-hostingen.

**Kan andre redigere?**
Ja — inviter dem via Netlify Identity (trin 3). De får deres eget login.

**Hvad hvis noget går galt?**
Alle ændringer gemmes i GitHub med fuld historik. Du kan altid rulle tilbage til en tidligere version.
