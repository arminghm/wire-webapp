#
# Wire
# Copyright (C) 2016 Wire Swiss GmbH
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see http://www.gnu.org/licenses/.
#

window.z ?= {}
z.ViewModel ?= {}
z.ViewModel.content ?= {}

# Parent: z.ViewModel.ContentViewModel
class z.ViewModel.content.CollectionViewModel
  constructor: (element_id, @conversation_repository) ->
    @logger = new z.util.Logger 'z.ViewModel.CollectionViewModel', z.config.LOGGER.OPTIONS

    @message_ets = ko.observableArray()
    @conversation_et = null

  set_conversation: (conversation_et) =>
    @conversation_et = conversation_et
    @conversation_repository.get_events_for_category @conversation_et
    .then (message_ets) => @message_ets message_ets

  added_to_view: =>
    console.debug 'added_to_view'

  removed_from_view: =>
    @conversation_et = null
    @message_ets.removeAll()

  click_on_back_button: =>
    amplify.publish z.event.WebApp.CONVERSATION.SWITCH, @conversation_et
