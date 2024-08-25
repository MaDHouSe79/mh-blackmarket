<p align="center">
    <img width="140" src="https://icons.iconarchive.com/icons/iconarchive/red-orb-alphabet/128/Letter-M-icon.png" />  
    <h1 align="center">Hi 👋, I'm MaDHouSe</h1>
    <h3 align="center">A passionate allround developer </h3>    
</p>

<p align="center">
  <a href="https://github.com/MaDHouSe79/mh-blackmarket/issues">
    <img src="https://img.shields.io/github/issues/MaDHouSe79/mh-blackmarket"/> 
  </a>
  <a href="https://github.com/MaDHouSe79/mh-blackmarket/watchers">
    <img src="https://img.shields.io/github/watchers/MaDHouSe79/mh-blackmarket"/> 
  </a> 
  <a href="https://github.com/MaDHouSe79/mh-blackmarket/network/members">
    <img src="https://img.shields.io/github/forks/MaDHouSe79/mh-blackmarket"/> 
  </a>  
  <a href="https://github.com/MaDHouSe79/mh-blackmarket/stargazers">
    <img src="https://img.shields.io/github/stars/MaDHouSe79/mh-blackmarket?color=white"/> 
  </a>
  <a href="https://github.com/MaDHouSe79/mh-blackmarket/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/MaDHouSe79/mh-blackmarket?color=black"/> 
  </a>      
</p>

# mh-blackmarket
- just an easy blackmarket ;)

# Dependencies:
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-target](https://github.com/qbcore-framework/qb-target) 
- [qb-shops](https://github.com/qbcore-framework/qb-shops)
- [qb-inventory](https://github.com/qbcore-framework/qb-inventory)
- [mh-cashasitem](https://github.com/MaDHouSe79/mh-cashasitem)

## Install:
- Step 1: Create a folder `[mh]` in `resources`. 
- Step 2: Put `mh-blackmarket` in to `resources/[mh]`.
- Step 3: Add in sever.cfg after `ensure [standalone]` add -> `ensure [mh]`
- Step 4: Restart the server.

# NOTE FOR Blackmoney in qb-core
- You need to edit `qb-core/config.lua` to this below and add `black_money` to this tables.
```lua
QBConfig.Money.MoneyTypes = { cash = 500, bank = 5000, crypto = 0, black_money = 0 }
QBConfig.Money.DontAllowMinus = { 'cash', 'crypto', 'black_money' }
```

# 🙈 Youtube
- [Youtube](https://www.youtube.com/c/MaDHouSe79)

# Contributers
<a href="https://github.com/MaDHouSe79/mh-carlift/graphs/contributors">
  <img src="https://contributors-img.web.app/image?repo=MaDHouSe79/mh-carlift" />
</a>

# LICENSE
[GPL LICENSE](./LICENSE)<br />
&copy; [MaDHouSe79](https://www.youtube.com/@MaDHouSe79)
