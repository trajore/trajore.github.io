---
layout: about
title: about
permalink: /
subtitle: <a href='https://www.microsoft.com/en-us/research/'>Microsoft Research</a>. Bangalore, India.

profile:
  align: right
  image: profile.jpg
  image_circular: false # crops the image to make it circular

news: false # includes a list of news items
selected_papers: false # includes a list of papers marked as "selected={true}"
social: true # includes social icons at the bottom of the page
---

I am a Research Fellow in the [EzPC](https://www.microsoft.com/en-us/research/project/ezpc-easy-secure-multi-party-computation/) team at Microsoft Research, and work with [Dr.Rahul Sharma](https://www.microsoft.com/en-us/research/people/rahsha/), [Dr. Divya Gupta](https://www.microsoft.com/en-us/research/people/digup/) and [Dr.Nishanth Chandran](https://www.microsoft.com/en-us/research/people/nichandr/) on Secure Multi-party Computation. My interests broadly include System security and AI safety & security.

Previously I completed my Bachelors (B.Tech) in Computer Science from IIIT Delhi in 2023 where I worked under [Dr.Mukulika Maity](https://iiitd.ac.in/mukulika) and [Dr.Arani Bhattacharya](https://iiitd.ac.in/arani) in the Network Research Lab on my thesis project titled NATIVE: Network Aggregation based Tiled Live Video Streaming. Further I have also extensively worked with [Dr.Sambuddho Chakravarty](https://iiitd.ac.in/sambuddho) on VPNs (Virtual Private Network) fingerprintability and security in the Cryptography & Network Security Lab. In addition, in the Computer Architecture domain, I have worked on projects for Designing a Network on chip (NOC) simulator and FPGA based 100 Gigabits/sec Network cards.

## PGP / GPG Key

<details class="gpg-key" markdown="1">
<summary class="gpg-summary">
  <span class="gpg-lock" aria-hidden="true"><i class="fa-solid fa-lock"></i></span>
  <strong class="gpg-label">Fingerprint:</strong>
  <code id="gpg-fpr" class="gpg-fpr-chip" title="Primary public key fingerprint">FA1D 73F7 FF19 68B0 156F  492B FE59 FAD0 D3CF CD9B</code>
  <button id="copy-gpg-fpr" class="copy-btn" type="button" aria-label="Copy fingerprint" title="Copy fingerprint">
    <i class="fa-regular fa-copy" aria-hidden="true"></i><span class="copy-text">Copy</span>
  </button>
  <span class="hint" aria-hidden="true">(click to expand)</span>
</summary>

**Download**  
[ASCII‑armored key](/assets/keys/tanmay.asc)

**Keybase Proof**  
<a href="/.well-known/keybase.txt" class="gpg-proof-link" rel="noopener" title="View Keybase site ownership proof">keybase.txt</a>

**Import & Verify**

```bash
curl -s {{ site.url }}/assets/keys/tanmay.asc | gpg --import
gpg --fingerprint tanmayrajore@gmail.com
```

Expected fingerprint:

```
FA1D 73F7 FF19 68B0 156F  492B FE59 FAD0 D3CF CD9B
```

**Usage Examples**
Encrypt a file for me:

```bash
gpg --encrypt --recipient tanmayrajore@gmail.com secret.pdf
```

Sign a message (you to me):

```bash
gpg --clear-sign message.txt
```

Verify a signature I made:

```bash
gpg --verify signed.txt
```

</details>

<style>
  /* PGP section modern styling (scoped to this page) */
  .gpg-summary { display:flex; flex-wrap:wrap; align-items:center; gap:.65rem; line-height:1.3; }
  .gpg-lock { display:inline-flex; align-items:center; justify-content:center; width:34px; height:34px; border-radius:50%; background:#2e7d32; color:#fff; font-size:14px; box-shadow:0 2px 4px rgba(0,0,0,.18); }
  .dark-mode .gpg-lock { background:#388e3c; }
  .gpg-lock i { line-height:1; }
  .gpg-fpr-chip { font-family:var(--code-font,monospace); background:#424242; color:#fff; padding:.55rem .75rem; border-radius:12px; font-size:.82rem; letter-spacing:.6px; box-shadow:0 2px 4px rgba(0,0,0,.3), inset 0 0 0 1px rgba(255,255,255,.05); }
  .dark-mode .gpg-fpr-chip { background:#1e1e1e; color:#fafafa; box-shadow:0 2px 6px rgba(0,0,0,.55), inset 0 0 0 1px rgba(255,255,255,.07); }
  .copy-btn { position:relative; display:inline-flex; align-items:center; gap:.4rem; cursor:pointer; border:none; background:linear-gradient(135deg,#4a5568,#2d3748); color:#fff; padding:.45rem .75rem; font-size:.7rem; font-weight:600; letter-spacing:.5px; border-radius:9px; box-shadow:0 2px 4px rgba(0,0,0,.18); transition:background .25s, transform .15s, box-shadow .25s; }
  .copy-btn:hover { background:linear-gradient(135deg,#2d3748,#1a202c); transform:translateY(-1px); }
  .copy-btn:active { transform:translateY(0); box-shadow:0 1px 2px rgba(0,0,0,.25); }
  .copy-btn.success { background:linear-gradient(135deg,#1b5e20,#2e7d32); }
  .copy-btn.error { background:linear-gradient(135deg,#b71c1c,#d32f2f); }
  .copy-btn i { font-size:.85rem; }
  .hint { color:var(--text-muted,#6c757d); font-size:.75rem; }
  details.gpg-key { margin-top:.75rem; }
  details.gpg-key[open] .gpg-fpr-chip { box-shadow:0 0 0 2px rgba(67,160,71,.35), inset 0 0 0 1px rgba(0,0,0,.08); }
  .gpg-proof-link { font-size:.65rem; text-transform:uppercase; background:#1a73e8; color:#fff !important; padding:.3rem .55rem; border-radius:6px; display:inline-block; letter-spacing:.6px; font-weight:600; box-shadow:0 2px 4px rgba(0,0,0,.15); transition:background .25s, transform .15s; }
  .gpg-proof-link:hover { background:#1558b5; text-decoration:none; transform:translateY(-1px); }
  .dark-mode .gpg-proof-link { background:#2962ff; }
  .dark-mode .gpg-proof-link:hover { background:#1e46b3; }
  @media (max-width:600px){ .gpg-summary { gap:.5rem; } .copy-btn { font-size:.65rem; padding:.4rem .6rem; } }
</style>
<script>
document.addEventListener('DOMContentLoaded', () => {
  const btn = document.getElementById('copy-gpg-fpr');
  const fprEl = document.getElementById('gpg-fpr');
  if(!btn || !fprEl) return;
  const originalHTML = btn.innerHTML;
  btn.addEventListener('click', (e) => {
    e.preventDefault();
    e.stopPropagation();
    const text = fprEl.textContent.replace(/\s+/g,' ').trim();
    navigator.clipboard.writeText(text).then(() => {
      btn.classList.remove('error');
      btn.classList.add('success');
      btn.innerHTML = '<i class="fa-solid fa-check" aria-hidden="true"></i><span class="copy-text">Copied</span>';
      setTimeout(() => { btn.classList.remove('success'); btn.innerHTML = originalHTML; }, 1700);
    }).catch(() => {
      btn.classList.remove('success');
      btn.classList.add('error');
      btn.innerHTML = '<i class="fa-solid fa-triangle-exclamation" aria-hidden="true"></i><span class="copy-text">Failed</span>';
      setTimeout(() => { btn.classList.remove('error'); btn.innerHTML = originalHTML; }, 2000);
    });
  });
});
</script>

# Publications

<div class="publications">

{% bibliography %}

</div>
