# SCP in GITHUB's Action

## USAGE

```yml
- name: Update Server Repo
        uses: alinz/actions/ssh@master
        env:
          PRIVATE_KEY: ${{ secrets.PRIVATE_KEY }}
          HOST: ${{ secrets.HOST }}
          USER: ${{ secrets.USER }}
          DOWNLOAD: YES # if set to YES, it downloads the content, default value is UPLOAD
          SRC: ~/remote/web
          DEST: ~/local/web
```
