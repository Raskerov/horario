<template>
  <div>
    <div class="item schedule__title">
      <div class="section-title">
        {{ $t('schedule.title') }}
      </div>
      <div class="schedule__navbar">
        <RouterLink
            v-for="tab in tabs"
            :key="tab"
            :to="{ name: `schedule_${tab}` }"
            class="schedule__navbar__item">
          {{ $t(`schedule.navigation.${tab}`) }}
        </RouterLink>
      </div>
    </div>
    <RouterView class="item" />
  </div>
</template>

<script>
import UsersList from "../elements/UsersList";

export default {
  components: { UsersList },
  computed: {
    tabs() {
      return ['overview', 'create', 'edit', 'freedays'];
    }
  }
}
</script>

<style lang="scss" scoped>
  .schedule__title {
    padding-bottom: 0;
  }

  .section-title {
    margin-bottom: 20px;
  }

  .schedule__navbar {
    display: flex;
    flex-direction: row;

    &__item {
      font-size: 14px;
      font-weight: bold;
      line-height: 50px;
      color: #000000;
      padding: 0 10px;
      text-align: center;
      text-decoration: none;
      text-transform: uppercase;

      &:hover {
        background-color: #730e15;
        color: #FFFFFF;
        cursor: pointer;
      }

      &:active {
        transform: translateY(2px);
      }

      &--current {
        background-color: #730e15;
        color: #FFFFFF;
      }
    }

    .router-link-exact-active {
      background-color: #730E15;
      color: #FFFFFF !important;
    }
  }
</style>
