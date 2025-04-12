import { App, Astal, Gdk, Gtk } from "astal/gtk3"
import Mpris from "gi://AstalMpris"
import { bind } from "astal"
import { musicWidgetOpen } from "../bar/Bar"

function lengthStr(length: number) {
    const min = Math.floor(length / 60)
    const sec = Math.floor(length % 60)
    const sec0 = sec < 10 ? "0" : ""
    return `${min}:${sec0}${sec}`
}

const iconcss = "font-family: 'Material Symbols Rounded'; font-weight: 700; font-style: normal;"

function MediaPlayer({ player }: { player: Mpris.Player }) {
  const { START, END } = Gtk.Align

  const title = bind(player, "title").as(t =>
    t || "Unknown Track")

  const artist = bind(player, "artist").as(a =>
    a || "Unknown Artist")

  const coverArt = bind(player, "coverArt").as(c =>
    `background-image: url('${c}')`)

  const position = bind(player, "position").as(p => player.length > 0
    ? p / player.length : 0)

  const playIcon = bind(player, "playbackStatus").as(s =>
    s === Mpris.PlaybackStatus.PLAYING
      ? "media-playback-pause-symbolic"
      : "media-playback-start-symbolic"
    )

  return <box className="MediaPlayer">
    <box className="cover-art" css={coverArt} />
    <box vertical>
      <box className="title">
        <label truncate hexpand halign={START} label={title} />
      </box>
        <label halign={START} valign={START} vexpand wrap label={artist} />
      <slider
        visible={bind(player, "length").as(l => l > 0)}
        //onDragged={({ value }) => player.position = value * player.length}
        value={position}
      />
      <centerbox className="actions">
        <label
          hexpand
          className="position"
          halign={START}
          visible={bind(player, "length").as(l => l > 0)}
          label={bind(player, "position").as(lengthStr)}
        />
        <box>
          <button
            className={"dropdownskipprevious"}
            onClicked={() => player.previous()}
            visible={bind(player, "canGoPrevious")}>
            <label label="Skip_Previous" css={iconcss} />
          </button>
          <button
            className={"dropdownplaybackstatus"}
            onClicked={() => player.play_pause()}
            visible={bind(player, "canControl")}>
            <label
              label={
                bind(player, "playbackStatus").as(pb =>
                  pb === Mpris.PlaybackStatus.PLAYING
                  ? "Pause"
                  : "Play_Arrow"
                )
              }
              css={iconcss}
            />
          </button>
          <button 
            className={"dropdownskipnext"}
            onClicked={() => player.next()}
            visible={bind(player, "canGoNext")}>
            <label label="Skip_Next" css={iconcss} />
          </button>
        </box>
        <label
          className="length"
          hexpand
          halign={END}
          visible={bind(player, "length").as(l => l > 0)}
          label={bind(player, "length").as(l => l > 0 ? lengthStr(l) : "0:00")}
        />
      </centerbox>
    </box>
  </box>
}

export default function MprisPlayers(monitor: Gdk.Monitor) {
  const mpris = Mpris.get_default()
  return <window  
    gdkmonitor={monitor}
    className="MUSIC_DROPDOWN"
    namespace="musicdropdown"
    application={App}
    layer={Astal.Layer.OVERLAY}
    keymode={Astal.Keymode.ON_DEMAND}
    anchor={Astal.WindowAnchor.TOP}
  >
    <revealer
      revealChild={musicWidgetOpen()}
    >
      <box vertical
        className={"musicDropdown"}
      >
        {bind(mpris, "players").as(arr => arr.map(player => (
          <MediaPlayer player={player} />
        )))}
      </box>
    </revealer>
  </window>
}
