pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
  id: root

  property list<NotificationInfo> shownNotifs: []

  NotificationServer {
    id: server

    keepOnReload: false
    //actionsSupported: true
    bodyHyperlinksSupported: true
    bodyImagesSupported: false
    bodyMarkupSupported: true
    //imageSupported: true

    onNotification: notification => {
      notification.tracked = true;

      root.shownNotifs.push(notifComponent.createObject(root, {
        notification: notification,
        timeLeft: notification.expireTimeout == -1 ? 10 : notification.expireTimeout,
        totalTime: notification.expireTimeout == -1 ? 10 : notification.expireTimeout,
      }));
    }
  }
  function remove(id) {
    const i = shownNotifs.findIndex(n => n.notification.id == id);
    if (i >= 0) {
      shownNotifs.splice(i, 1);
    }
  }
  
  component NotificationInfo: QtObject {
    required property Notification notification
    required property double timeLeft
    required property double totalTime 
    property bool pinned: false
  }

  Component {
    id: notifComponent

    NotificationInfo {}
  }
}

