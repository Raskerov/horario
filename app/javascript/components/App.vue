<template>
  <div>
    <NavigationBar />
    <RouterView />
  </div>
</template>

<script>
import NavigationBar from "./elements/NavigationBar";

export default {
  components: { NavigationBar }
}
</script>

<style lang="scss" scoped>

</style>
