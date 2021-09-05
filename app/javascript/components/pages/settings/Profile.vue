<template>
  <div>
    <div class="profile">
      <UserSettingsForm />
    </div>
  </div>
</template>

<script>
import UserSettingsForm from "../../elements/forms/UserSettingsForm";

export default {
  components: { UserSettingsForm }
}
</script>

<style lang="scss" scoped>
  .profile {
    max-width: 400px;
  }
</style>
