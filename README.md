# Adunare in limbaj de asamblare

Programul este scris in x86-64 GNU Assembly (sintaxa AT&T) pentru Linux. Citeste doua numere intregi cu semn pe 64 de biti de la intrarea standard si afiseaza suma. Raporteaza intrarea invalida si depasirea intervalului reprezentabil.

## Rulare

Necesita GCC, Make si Python 3.

```sh
make
printf '12 30\n' | ./build/add
```

Rezultatul este `42`.

## Teste

```sh
make test
```

GitHub Actions ruleaza aceeasi comanda la fiecare push si pull request.
