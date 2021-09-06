<template>
  <div>
    <div class="wrapper">
      <InvitationsForm />
    </div>
  </div>
</template>

<script>
import InvitationsForm from "../../elements/forms/InvitationsForm";

export default {
  components: { InvitationsForm }
}
</script>

<style lang="scss" scoped>
  .wrapper {
    max-width: 400px;
  }
</style>
