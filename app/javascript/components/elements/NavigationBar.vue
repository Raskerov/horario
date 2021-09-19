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
      <a
          href="/admin"
          class="navigation-bar__nav-item"
      >
        {{ $t('navigation.admin') }}
      </a>
      <RouterLink
          :to="{ name: `settings_profile` }"
          class="navigation-bar__nav-item"
      >
        {{ $t('navigation.settings') }}
      </RouterLink>
      <div class="navigation-bar__nav-item" @click="logout">
        {{ $t('navigation.logout') }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    async logout() {
      await this.$auth.logout();
      window.location = '/auth/login';
    },
  },
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
    color: #000000;
    padding: 0 10px;
    text-decoration: none;
    text-transform: uppercase;

    &:visited {
      color: #000000;
    }

    &:hover {
      background-color: #730e15;
      color: #FFFFFF;
      cursor: pointer;
    }

    &:active {
      transform: translateY(2px);
    }
  }
</style>
