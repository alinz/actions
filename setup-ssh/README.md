# SETUP-SSH ENVIRONMENT in GITHUB's Action

## USAGE

```yml
- name: Setup SSH environment for SSH and SCP
  uses: alinz/actions/setup-ssh@master
  env:
    PRIVATE_KEY: ${{ secrets.PRIVATE_KEY }}
    HOST: ${{ secrets.HOST }}
- run: ssh ls -lath
```
