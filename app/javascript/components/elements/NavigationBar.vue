<template>
  <div class="navigation-bar__wrapper">
    <div class="navigation-bar__wrapper__left-side">
      <RouterLink
        :to="{ name: `dashboard` }"
        class="navigation-bar__nav-item"
      >
        {{ $t('navigation.dashboard') }}
      </RouterLink>
      <RouterLink
          :to="{ name: `work_schedule` }"
          class="navigation-bar__nav-item"
      >
        {{ $t('navigation.work_schedule') }}
      </RouterLink>
      <RouterLink
          :to="{ name: `messages` }"
          class="navigation-bar__nav-item"
      >
        {{ $t('navigation.messages') }}
      </RouterLink>
    </div>

    <div class="navigation-bar__wrapper__right-side">
      <RouterLink
          :to="{ name: `admin` }"
          class="navigation-bar__nav-item"
      >
        {{ $t('navigation.admin') }}
      </RouterLink>
      <RouterLink
          :to="{ name: `profile` }"
          class="navigation-bar__nav-item"
      >
        {{ $t('navigation.profile') }}
      </RouterLink>
      <div class="navigation-bar__nav-item">
        {{ $t('navigation.logout') }}
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
    box-sizing: border-box;
    max-width: 100%;
    height: 50px;
    display: flex;
    border-bottom: #730E15 2px solid;
    justify-content: space-between;
  }

  .navigation-bar__wrapper__left-side {
    margin-left: 15px;
    display: flex;
  }

  .navigation-bar__wrapper__right-side {
    margin-right: 15px;
    display: flex;
  }

  .navigation-bar__nav-item {
    font-size: 16px;
    font-weight: bold;
    line-height: 50px;
    padding: 0 10px;
    text-decoration: none;
    text-transform: uppercase;

    &:hover {
      background-color: #730e15;
      color: #FFFFFF;
    }
  }
</style>
