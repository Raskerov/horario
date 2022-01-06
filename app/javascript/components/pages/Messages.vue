<template>
  <div class="messages">
    <div class="section-title item">
      {{ $t('messages.title') }}
    </div>
    <div class="messages__content">
      <div class="item messages__inbox">
        <div
          v-for="user in inboxUsers"
          :key="user.id"
          class="messages__inbox__box"
          :class="activeConversation(user.id) ? 'messages__inbox__box--active' : null"
          @click="switchConversation(user)"
        >
          {{ user.fullName }}
        </div>
      </div>
      <div class="item messages__conversation">
        <div ref="conversation" v-if="conversation" class="messages__conversation__content">
          <div
            v-for="message in conversation"
            :key="message.id"
          >
            <div class="message__row">
              <div :class="messageAlign(message.sender)">
                {{ message.sender.fullName }}
                {{ message.createdAt }}
                <div class="message__text">
                  {{ message.text }}
                </div>
              </div>
            </div>
          </div>
        </div>
        <textarea
          v-if="conversation"
          class="messages__conversation__input"
          :placeholder="$t('messages.input_placeholder')"
          v-on:keyup.enter="submitMessage"
        />
      </div>
    </div>
  </div>
</template>

<script>
import _ from 'lodash';
import { mapState } from "vuex";
import messages_repository from "../../repositories/messages_repository";
import Vue from "vue";

export default {
  data() {
    return {
      conversation: null,
      activeConversationUser: null,
    };
  },
  computed: {
    ...mapState({
      users: state => state.company.users,
    }),
    inboxUsers() {
      return _.filter(this.users, (user) => this.$auth.user.id !== user.id)
    }
  },
  async created() {
    await this.$store.dispatch('company/getCompanyUsers');
  },
  methods: {
    async switchConversation(user) {
      this.conversation = await messages_repository.getConversation(user.id);
      this.$nextTick(() => {
        this.scrollToBottom();
      })
      this.activeConversationUser = user;
    },
    activeConversation(userId) {
      return this.activeConversationUser?.id === userId;
    },
    messageAlign(user) {
      return this.$auth.user.id === user.id ? 'message--right' : 'message--left';
    },
    async submitMessage(event) {
      await messages_repository.create(event.target.value, this.activeConversationUser.id)
      this.conversation = await messages_repository.getConversation(this.activeConversationUser.id);
      this.scrollToBottom();
      event.target.value = ''
    },
    scrollToBottom() {
      let container = this.$refs.conversation;
      container.scrollTop = container.scrollHeight;
    }
  }
}
</script>

<style lang="scss" scoped>
  .messages {
    height: calc(100vh - 130px);
    box-sizing: border-box;
  }

  .messages__content {
    display: flex;
    flex-direction: row;
  }

  .messages__inbox {
    width: 20%;
    height: calc(100vh - 274px);
    margin-right: 30px;

    &__box {
      padding: 10px;
      border: 2px solid #730E15;
      margin: 2px 0;
      border-radius: 12px;

      &:hover {
        cursor: pointer;
        background-color: #9a222b;
      }

      &:active {
        background-color: #6c0a0b;
        outline: 0;
        transform: translateY(1px);
      }

      &--active {
        background-color: #e5afb1;
      }
    }
  }

  .messages__conversation {
    width: calc(80% - 30px);
    height: calc(100vh - 275px);

    &__content {
      display: block;
      overflow-y: auto;
      width: 100%;
      height: calc(100% - 50px);
      box-sizing: border-box;
      -ms-overflow-style: none;
      scrollbar-width: none;

      &::-webkit-scrollbar {
        display: none;
      }
    }

    &__input {
      width: 100%;
      border-radius: 12px;
      padding: 10px;
      border: 2px solid #730E15;
      outline: none;
      resize: none;
      box-sizing: border-box;

      &:focus {
        border: 2px solid #730E15;
        background-color: #e5afb1;

        &::placeholder {
          color: #000;
        }
      }
    }
  }

  .message {
    &--right {
      margin-left: auto;
      flex-direction: column;
      display: flex;
      align-items: flex-end;
    }

    &--left {
      margin-right: auto;
      flex-direction: column;
      display: flex;
      align-items: flex-start;
    }

    &__row {
      width: 100%;
      height: auto;
      font-size: 12px;
      color: #878787;
      display: flex;
    }

    &__text {
      display: block;
      width: fit-content;
      max-width: 50%;
      border-radius: 12px;
      margin: 2px 0 20px 0;
      padding: 10px;
      color: #000;
      font-size: 16px;
      background-color: #666666;
    }
  }

</style>
