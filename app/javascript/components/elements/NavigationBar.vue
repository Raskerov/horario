<template>
  <div class="navigation-bar__wrapper">
    <div class="navigation-bar__wrapper__left-side">
      <div class="navigation-bar__nav-item">
        Strona główna
      </div>
      <div class="navigation-bar__nav-item">
        Grafik pracy
      </div>
      <div class="navigation-bar__nav-item">
        Wiadomości
      </div>
    </div>

    <div class="navigation-bar__wrapper__right-side">
      <div class="navigation-bar__nav-item">
        Mój profil
      </div>
      <div class="navigation-bar__nav-item">
        Wyloguj
      </div>
    </div>
  </div>
</template>

<script>
export default {

}
</script>

<style lang="scss" scoped>
  .navigation-bar__wrapper {
    width: 100%;
    height: 50px;
    display: flex;
    border-bottom: #730E15 2px solid;
    justify-content: space-between;
  }

  .navigation-bar__wrapper__left-side, .navigation-bar__wrapper__right-side {
    display: flex;
  }

  .navigation-bar__nav-item {
    font-size: 16px;
    font-weight: bold;
    line-height: 50px;
    padding: 0 10px;
  }
</style>
