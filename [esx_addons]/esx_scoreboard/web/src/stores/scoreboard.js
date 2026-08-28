import { writable, derived } from "svelte/store"

/**
 * @typedef {Object} PlayerData
 * @property {number} serverId
 * @property {string} name
 * @property {string} job
 * @property {string} jobGrade
 * @property {string} group
 * @property {number} ping
 * @property {string|null} activity
 */

/**
 * @typedef {Object} JobCount
 * @property {string} name
 * @property {string} label
 * @property {number} count
 * @property {string} color
 */

/**
 * @typedef {Object} ActivityData
 * @property {string} type
 * @property {string} label
 * @property {string} location
 * @property {number} startTime
 */

/**
 * @typedef {Object} ScoreboardState
 * @property {boolean} visible
 * @property {PlayerData[]} players
 * @property {JobCount[]} jobs
 * @property {ActivityData[]} activities
 * @property {string} searchQuery
 * @property {string} sortBy
 * @property {boolean} sortAsc
 * @property {string} serverName
 * @property {number} maxPlayers
 * @property {number} uptime
 * @property {string} logoUrl
 */

/** @type {ScoreboardState} */
const initialState = {
  visible: false,
  players: [],
  jobs: [],
  activities: [],
  searchQuery: "",
  sortBy: "serverId",
  sortAsc: true,
  serverName: "ESX Server",
  maxPlayers: 128,
  uptime: 0,
  logoUrl: ""
}

export const scoreboardStore = writable(initialState)

export const filteredPlayers = derived(scoreboardStore, ($state) => {
  let players = [...$state.players]

  if ($state.searchQuery) {
    const query = $state.searchQuery.toLowerCase()
    players = players.filter((p) =>
      p.name.toLowerCase().includes(query) ||
      p.job.toLowerCase().includes(query) ||
      String(p.serverId).includes(query)
    )
  }

  players.sort((a, b) => {
    let valA = a[$state.sortBy]
    let valB = b[$state.sortBy]

    if (typeof valA === "string") {
      valA = valA.toLowerCase()
      valB = valB.toLowerCase()
    }

    if (valA < valB) return $state.sortAsc ? -1 : 1
    if (valA > valB) return $state.sortAsc ? 1 : -1
    return 0
  })

  return players
})

export const totalPlayers = derived(scoreboardStore, ($state) => $state.players.length)

export const activeActivities = derived(scoreboardStore, ($state) => $state.activities.length)

/**
 * Update scoreboard visibility
 * @param {boolean} visible
 */
export function setVisible(visible) {
  scoreboardStore.update((s) => ({ ...s, visible }))
}

/**
 * Update players list
 * @param {PlayerData[]} players
 */
export function setPlayers(players) {
  scoreboardStore.update((s) => ({ ...s, players }))
}

/**
 * Update jobs list
 * @param {JobCount[]} jobs
 */
export function setJobs(jobs) {
  scoreboardStore.update((s) => ({ ...s, jobs }))
}

/**
 * Update activities
 * @param {ActivityData[]} activities
 */
export function setActivities(activities) {
  scoreboardStore.update((s) => ({ ...s, activities }))
}

/**
 * Set search query
 * @param {string} query
 */
export function setSearchQuery(query) {
  scoreboardStore.update((s) => ({ ...s, searchQuery: query }))
}

/**
 * Set sort column
 * @param {string} column
 */
export function setSortBy(column) {
  scoreboardStore.update((s) => ({
    ...s,
    sortBy: column,
    sortAsc: s.sortBy === column ? !s.sortAsc : true
  }))
}

/**
 * Update server info
 * @param {Object} info
 * @param {string} info.serverName
 * @param {number} info.maxPlayers
 * @param {number} info.uptime
 * @param {string} info.logoUrl
 */
export function setServerInfo(info) {
  scoreboardStore.update((s) => ({ ...s, ...info }))
}
