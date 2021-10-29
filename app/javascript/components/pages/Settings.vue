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
      <div class="item">
        <div class="section-title">
          {{ $t('settings.title') }}
        </div>
        <div class="section-text">
          {{ $t('settings.text') }}
        </div>
      </div>
      <RouterView class="item" />
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
</style>
