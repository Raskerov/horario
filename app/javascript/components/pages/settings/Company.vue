<template>
  <div>
    <div class="wrapper">
      <CompanyForm />
    </div>
  </div>
</template>

<script>
import CompanyForm from "../../elements/forms/CompanyForm";

export default {
  components: { CompanyForm }
}
</script>

<style lang="scss" scoped>
  .wrapper {
    max-width: 400px;
  }
</style>
