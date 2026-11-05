const CACHE='ilvora-workforce-v2';
const BASE=new URL('./', self.registration.scope);
const FILES=['','index.html','styles.css','app.js','manifest.webmanifest','assets/icon-192.png','assets/icon-512.png','assets/ilvora-logo.jpeg'];
const URLS=FILES.map(path=>new URL(path,BASE).toString());
self.addEventListener('install',e=>e.waitUntil(caches.open(CACHE).then(c=>c.addAll(URLS)).then(()=>self.skipWaiting())));
self.addEventListener('activate',e=>e.waitUntil(caches.keys().then(ks=>Promise.all(ks.filter(k=>k!==CACHE).map(k=>caches.delete(k)))).then(()=>self.clients.claim())));
self.addEventListener('fetch',e=>{
 if(e.request.method!=='GET') return;
 const u=new URL(e.request.url);
 if(u.origin!==self.location.origin || u.pathname.includes('/api/')) return;
 e.respondWith(fetch(e.request).then(r=>{if(r.ok){const copy=r.clone();caches.open(CACHE).then(c=>c.put(e.request,copy));}return r;}).catch(()=>caches.match(e.request)));
});
