# SSH in GITHUB's Action

## USAGE

```yml
- name: Update Server Repo
        uses: alinz/actions/ssh@master
        env:
          PRIVATE_KEY: ${{ secrets.PRIVATE_KEY }}
          HOST: ${{ secrets.HOST }}
          USER: ${{ secrets.USER }}
        with:
          args: ls -lath
```

## Forked from

`https://github.com/maddox/actions/tree/master/ssh`
