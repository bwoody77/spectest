// One-shot: flat v1 { "English": "Spanish" } → v2 common catalog { "English": { "value": "Spanish" } }.
import { readFileSync, writeFileSync } from 'node:fs';
const flat = JSON.parse(readFileSync('i18n/es.json', 'utf8'));
const out = Object.fromEntries(Object.keys(flat).sort().map((k) => [k, { value: flat[k] }]));
writeFileSync('i18n/common.es.json', JSON.stringify(out, null, 2) + '\n');
console.log(`${Object.keys(out).length} entries`);
