import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind, execAsync } from "astal"
import Hyprland from "gi://AstalHyprland"
import Mpris from "gi://AstalMpris"
//import Cava from "gi://AstalCava"

export const musicWidgetOpen = Variable(false)

const iconcss = "font-family: 'Material Symbols Rounded'; font-weight: 700; font-style: normal;"

const workspacesCount = 6;

const timeHours = Variable("").poll(1000, "date +'%H'")
const timeMins = Variable("").poll(1000, "date +'%M'")

function Workspaces() {
  const hypr = Hyprland.get_default()
  
  return <box className="WorkspacesBox"
    setup={(self) => {
      let iconarray = ["Web", "Forum", "Terminal", "Category", "Deployed_Code", "Add"]
      for (let wsid = 1; wsid <= workspacesCount; wsid++) {
        self.add(
          <button
            css={iconcss}
            setup={(self) => {
              self.toggleClassName("workspace ws" + wsid, true)
            }}
            onClicked={() =>
              execAsync("hyprctl dispatch workspace " + wsid)
            }
            className={
              bind(hypr, "focusedWorkspace").as(fw => 
                wsid == fw.id ? "workspace focused ws" + wsid : "workspace ws" + wsid)
            }
          >
            {iconarray[wsid-1]}
          </button>
        )
      }
    }}
  >
  </box>
}

function Music() {
  const mpris = Mpris.get_default()

  return <box>
    {bind(mpris, "players").as(ps => ps[0] ? (
      <box>
        <button className={"musicDropdown"}
          onClicked={() => {
            musicWidgetOpen.set(!musicWidgetOpen.get())
          }}
        >
          <box>
            <label className={"musicTitle"}
              label={bind(ps[0], "metadata").as(() =>
                `${ps[0].title}`
              )}
              maxWidthChars={25}
              ellipsize={3}
            />
            <label className={"musicArtist"}
              label={bind(ps[0], "metadata").as(() =>
                ` - ${ps[0].artist}`
              )}
              maxWidthChars={20}
              ellipsize={3}
            />
          </box>
        </button>
            <button className={"musicPlayingButton"}
            onClicked={() => {
              ps[0].play_pause()
            }}
          >
            <label
              label={
                bind(ps[0], "playbackStatus").as(pb =>
                  pb === Mpris.PlaybackStatus.PLAYING
                  ? "Pause"
                  : "Play_Arrow"
                )
              }
              className="musicPlayingIcon"
              css={iconcss}
            />
          </button>
        </box>
      ) : (
        <label label="Nothing Playing" />
      ))}
    </box>
}

function Time() {
  return <button
    className="timeButton"
  >
    <box
      valign={Gtk.Align.CENTER}
    >
      <label
        label="schedule"
        className="timeIcon"
        css={iconcss}
      />
      <label label={timeHours()} className={"timeHours"} />
      <label label={timeMins()} className={"timeMins"} />
    </box>
  </button>
}

function Record() { // Not finished because i dont understand wf-recorder's file naming.
  let recording = false;
  return <button
    onClick={() => {
      if (!recording) {
        exec("wf-recorder")
      }
    }}
  >

  </button>
}

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  return <window
    className="Bar"
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={TOP | LEFT | RIGHT}
    application={App}>
    <centerbox>
      <box
        halign={Gtk.Align.START}
      >
        <Workspaces/>
      </box>
      <box>
        <Music/>
      </box>
      <box   
        halign={Gtk.Align.END}
      >
        <Time/>
      </box>
    </centerbox>
  </window>
}
