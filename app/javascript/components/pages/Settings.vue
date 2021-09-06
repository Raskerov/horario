<template>
  <div class="settings">
    <div class="settings__nav-bar">
      <RouterLink
          v-for="type in settingsTabs"
          :key="type"
          :to="{ name: `settings_${type}` }"
          class="settings__tab"
      >
        {{ $t(`settings.${type}`) }}
      </RouterLink>
    </div>
    <div class="settings__content">
      <div class="settings__item">
        <div class="settings__content__title">
          {{ $t('settings.title') }}
        </div>
        <div class="settings__content__text">
          {{ $t('settings.text') }}
        </div>
      </div>
      <RouterView class="settings__item" />
    </div>
  </div>
</template>

<script>
export default {
  computed: {
    settingsTabs() {
      const tabs = ['profile', 'password'];
      if (this.$hasRole('owner')) {
        tabs.push('company');
      }
      if (this.$hasRole('owner') || this.$hasRole('manager')) {
        tabs.push('invitations');
      }

      return tabs;
    },
  },
}
</script>

<style lang="scss" scoped>
  .settings {
    display: flex;
    margin: -30px;
    height: calc(100% + 60px);
  }

  .settings__nav-bar {
    background-color: #FFFFFF;
    height: 100%;
  }

  .settings__tab {
    display: block;
    height: 50px;
    border-bottom: #730E15 2px solid;
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

  .router-link-exact-active {
    background-color: #730E15;
    color: #FFFFFF !important;
  }

  .settings__content {
    padding: 30px 60px;
    flex: 1;
  }

  .settings__item {
    padding: 25px;
    background-color: #FFFFFF;
    border-radius: 12px;
    margin-bottom: 20px;
  }

  .settings__content__title {
    font-size: 36px;
    font-weight: bold;
    color: #000000;
  }

  .settings__content__text {
    font-size: 18px;
    color: #000000;
  }
</style>
