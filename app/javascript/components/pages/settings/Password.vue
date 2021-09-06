<template>
  <div>
    <div class="wrapper">
      <UserPasswordForm />
    </div>
  </div>
</template>

<script>
import UserPasswordForm from "../../elements/forms/UserPasswordForm";

export default {
  components: { UserPasswordForm }
}
</script>

<style lang="scss" scoped>
  .wrapper {
    max-width: 400px;
  }
</style>
