# SCP in GITHUB's Action

## USAGE

```yml
- name: Update Server Repo
  uses: alinz/actions/ssh@master
  env:
    PRIVATE_KEY: ${{ secrets.PRIVATE_KEY }}
    HOST: example.com
  with:
    args: |
      '~/local1.txt user@example.com:~/remove1.txt'
      '~/local2.txt user@example.com:~/remove2.txt'
      'user@example.com:~/remove3.txt ~/local3.txt'
```
