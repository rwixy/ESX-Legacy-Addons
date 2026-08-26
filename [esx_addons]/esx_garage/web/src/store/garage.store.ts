import { create } from 'zustand';
import { devtools } from 'zustand/middleware';
import { immer } from 'zustand/middleware/immer';
<<<<<<< HEAD
import type { Vehicle, VehicleFilter, VehicleStats } from '@/types/vehicle.types';
import type { Garage } from '@/types/garage.types';
import { fetchNui } from '@/utils/nui';
import { NuiCallbackType } from '@/types/nui.types';
=======
import type {
  Vehicle,
  VehicleFilter,
  VehiclePageResponse,
  VehiclePagination,
  VehicleStats
} from '@/types/vehicle.types';
import type { Garage } from '@/types/garage.types';
import { fetchNui } from '@/utils/nui';
import { NuiCallbackType } from '@/types/nui.types';
import { isErrorCode, isQuietErrorCode, showErrorNotification } from '@/utils/errors';
>>>>>>> upstream-1142/1.14.2

interface GarageState {
  // UI State
  isOpen: boolean;
  isLoading: boolean;

  // Data
  selectedGarage: Garage | null;
  selectedVehicle: Vehicle | null;
  vehicles: Vehicle[];
  filter: VehicleFilter;
<<<<<<< HEAD
=======
  pagination: VehiclePagination;
>>>>>>> upstream-1142/1.14.2

  // Stats
  stats: VehicleStats;

  // Actions
  setOpen: (open: boolean) => void;
  setLoading: (loading: boolean) => void;
  selectGarage: (garage: Garage) => void;
  selectVehicle: (vehicle: Vehicle | null) => void;
  updateVehicles: (vehicles: Vehicle[]) => void;
<<<<<<< HEAD
  setFilter: (filter: Partial<VehicleFilter>) => void;
  resetFilter: () => void;

  // Vehicle Actions
  retrieveVehicle: (vehicleId: string) => Promise<void>;
=======
  updateVehiclePage: (page: VehiclePageResponse) => void;
  setFilter: (filter: Partial<VehicleFilter>) => void;
  loadVehicles: (page?: number) => Promise<void>;
  resetFilter: () => void;

  // Vehicle Actions
  retrieveVehicle: (vehicleId: string) => Promise<boolean>;
>>>>>>> upstream-1142/1.14.2
  storeVehicle: (vehicleId: string) => Promise<void>;
  renameVehicle: (vehicleId: string, newName: string) => Promise<void>;
  toggleFavorite: (vehicleId: string) => Promise<void>;

  // Computed
  getFilteredVehicles: () => Vehicle[];
  updateStats: () => void;
}

const defaultFilter: VehicleFilter = {
  search: '',
  type: 'all',
  stored: 'all',
  impounded: 'all',
  favorite: 'all'
};

<<<<<<< HEAD
=======
const defaultStats: VehicleStats = {
  total: 0,
  stored: 0,
  out: 0,
  impounded: 0
};

const pendingFavoriteToggles = new Set<string>();
const pendingVehicleRetrievals = new Set<string>();

const handleGarageActionError = (message: string, error: unknown): void => {
  showErrorNotification(error, message);

  if (!isQuietErrorCode(error)) {
    console.error(message, error);
  }
};

const calculateStats = (vehicles: Vehicle[]): VehicleStats => ({
  total: vehicles.length,
  stored: vehicles.filter(v => v.stored && !v.impounded).length,
  out: vehicles.filter(v => !v.stored && !v.impounded).length,
  impounded: vehicles.filter(v => v.impounded).length
});

const normalizeMileage = (mileage: unknown): number => {
  const value = typeof mileage === 'number' ? mileage : Number(mileage);
  return Number.isFinite(value) ? value : 0;
};

const normalizeMileageUnit = (unit: unknown): 'mi' | 'km' => unit === 'km' ? 'km' : 'mi';

const normalizeVehicle = (vehicle: Vehicle): Vehicle => ({
  ...vehicle,
  mileage: normalizeMileage((vehicle as { mileage: unknown }).mileage),
  mileageUnit: normalizeMileageUnit((vehicle as { mileageUnit?: unknown }).mileageUnit)
});

const normalizeVehicles = (vehicles: Vehicle[]): Vehicle[] => vehicles.map(normalizeVehicle);

>>>>>>> upstream-1142/1.14.2
export const useGarageStore = create<GarageState>()(
  devtools(
    immer((set, get) => ({
      // Initial state
      isOpen: false,
      isLoading: false,
      selectedGarage: null,
      selectedVehicle: null,
      vehicles: [],
      filter: defaultFilter,
<<<<<<< HEAD
      stats: {
        total: 0,
        stored: 0,
        out: 0,
        impounded: 0
      },
=======
      pagination: {
        page: 1,
        pageSize: 30,
        hasNext: false,
        hasPrevious: false
      },
      stats: { ...defaultStats },
>>>>>>> upstream-1142/1.14.2

      // UI Actions
      setOpen: (open) => set((state) => {
        state.isOpen = open;
        if (!open) {
          // Reset state when closing
          state.selectedGarage = null;
          state.selectedVehicle = null;
          state.vehicles = [];
          state.filter = defaultFilter;
<<<<<<< HEAD
=======
          state.pagination = {
            page: 1,
            pageSize: 30,
            hasNext: false,
            hasPrevious: false
          };
          state.stats = { ...defaultStats };
>>>>>>> upstream-1142/1.14.2
        }
      }),

      setLoading: (loading) => set((state) => {
        state.isLoading = loading;
      }),

      selectGarage: (garage) => set((state) => {
        state.selectedGarage = garage;
      }),

      selectVehicle: (vehicle) => set((state) => {
        state.selectedVehicle = vehicle;
      }),

      updateVehicles: (vehicles) => {
        set((state) => {
<<<<<<< HEAD
          state.vehicles = vehicles;
        });
        get().updateStats();
=======
          const normalizedVehicles = normalizeVehicles(vehicles);
          state.vehicles = normalizedVehicles;
          if (!state.pagination.hasNext && !state.pagination.hasPrevious) {
            state.stats = calculateStats(normalizedVehicles);
          }
        });
      },

      updateVehiclePage: (page) => {
        set((state) => {
          state.vehicles = normalizeVehicles(page.vehicles);
          state.pagination = page.pagination;
          if (page.stats) {
            state.stats = page.stats;
          }
        });
>>>>>>> upstream-1142/1.14.2
      },

      setFilter: (filter) => set((state) => {
        state.filter = { ...state.filter, ...filter };
<<<<<<< HEAD
      }),

      resetFilter: () => set((state) => {
        state.filter = defaultFilter;
=======
        state.pagination.page = 1;
      }),

      loadVehicles: async (page = get().pagination.page) => {
        const garage = get().selectedGarage;
        if (!garage) return;

        set((state) => { state.isLoading = true; });

        try {
          const result = await fetchNui<VehiclePageResponse>(
            NuiCallbackType.GET_VEHICLES,
            {
              page,
              pageSize: get().pagination.pageSize,
              filter: get().filter
            }
          );

          get().updateVehiclePage(result);
          set((state) => {
            state.selectedVehicle = null;
          });
        } catch (error) {
          handleGarageActionError('Failed to load vehicles.', error);
        } finally {
          set((state) => { state.isLoading = false; });
        }
      },

      resetFilter: () => set((state) => {
        state.filter = defaultFilter;
        state.pagination.page = 1;
>>>>>>> upstream-1142/1.14.2
      }),

      // Vehicle Actions
      retrieveVehicle: async (vehicleId) => {
<<<<<<< HEAD
=======
        if (pendingVehicleRetrievals.has(vehicleId)) {
          return false;
        }

        pendingVehicleRetrievals.add(vehicleId);
>>>>>>> upstream-1142/1.14.2
        set((state) => { state.isLoading = true; });

        try {
          const result = await fetchNui<boolean>(
            NuiCallbackType.RETRIEVE_VEHICLE,
            { vehicleId },
            true // Mock success in dev
          );

          if (result) {
            set((state) => {
              const vehicle = state.vehicles.find(v => v.id === vehicleId);
              if (vehicle) {
<<<<<<< HEAD
                vehicle.stored = false;
                vehicle.garage = undefined;
              }
            });
            get().updateStats();
          }
        } catch (error) {
          console.error('Failed to retrieve vehicle:', error);
        } finally {
=======
                const wasStored = vehicle.stored && !vehicle.impounded;
                const wasImpounded = vehicle.impounded;

                vehicle.stored = false;
                vehicle.impounded = false;
                vehicle.garage = undefined;
                vehicle.impoundFee = undefined;

                if (wasStored) {
                  state.stats.stored = Math.max(0, state.stats.stored - 1);
                  state.stats.out += 1;
                } else if (wasImpounded) {
                  state.stats.impounded = Math.max(0, state.stats.impounded - 1);
                  state.stats.out += 1;
                }
              }
            });
          }
          return !!result;
        } catch (error) {
          handleGarageActionError('Failed to retrieve vehicle.', error);
          return false;
        } finally {
          pendingVehicleRetrievals.delete(vehicleId);
>>>>>>> upstream-1142/1.14.2
          set((state) => { state.isLoading = false; });
        }
      },

      storeVehicle: async (vehicleId) => {
        set((state) => { state.isLoading = true; });

        try {
          const result = await fetchNui<boolean>(
            NuiCallbackType.STORE_VEHICLE,
            { vehicleId, garageId: get().selectedGarage?.id },
            true // Mock success in dev
          );

          if (result) {
            set((state) => {
              const vehicle = state.vehicles.find(v => v.id === vehicleId);
              if (vehicle) {
<<<<<<< HEAD
                vehicle.stored = true;
                vehicle.garage = state.selectedGarage?.id;
              }
            });
            get().updateStats();
          }
        } catch (error) {
          console.error('Failed to store vehicle:', error);
=======
                const wasOut = !vehicle.stored && !vehicle.impounded;
                const wasImpounded = vehicle.impounded;

                vehicle.stored = true;
                vehicle.impounded = false;
                vehicle.garage = state.selectedGarage?.id;
                vehicle.impoundFee = undefined;

                if (wasOut) {
                  state.stats.out = Math.max(0, state.stats.out - 1);
                  state.stats.stored += 1;
                } else if (wasImpounded) {
                  state.stats.impounded = Math.max(0, state.stats.impounded - 1);
                  state.stats.stored += 1;
                }
              }
            });
          }
        } catch (error) {
          handleGarageActionError('Failed to store vehicle.', error);
>>>>>>> upstream-1142/1.14.2
        } finally {
          set((state) => { state.isLoading = false; });
        }
      },

      renameVehicle: async (vehicleId, newName) => {
        try {
          const result = await fetchNui<boolean>(
            NuiCallbackType.RENAME_VEHICLE,
            { vehicleId, newName },
            true // Mock success in dev
          );

          if (result) {
            set((state) => {
              const vehicle = state.vehicles.find(v => v.id === vehicleId);
              if (vehicle) {
                vehicle.customName = newName;
              }
              if (state.selectedVehicle?.id === vehicleId) {
                state.selectedVehicle.customName = newName;
              }
            });
          }
        } catch (error) {
<<<<<<< HEAD
=======
          if (isErrorCode(error, 'rate_limited')) {
            handleGarageActionError('Failed to rename vehicle.', error);
            return;
          }

>>>>>>> upstream-1142/1.14.2
          console.error('Failed to rename vehicle:', error);
          throw error;
        }
      },

      toggleFavorite: async (vehicleId) => {
<<<<<<< HEAD
        try {
          const vehicle = get().vehicles.find(v => v.id === vehicleId);
          if (!vehicle) return;

          const newFavoriteStatus = !vehicle.isFavorite;

          await fetchNui<boolean>(
            NuiCallbackType.TOGGLE_FAVORITE,
            { vehicleId, isFavorite: newFavoriteStatus },
            true // Mock success in dev
          );

          set((state) => {
            const target = state.vehicles.find(v => v.id === vehicleId);
            if (target) {
              target.isFavorite = newFavoriteStatus;
            }
            if (state.selectedVehicle?.id === vehicleId) {
              state.selectedVehicle.isFavorite = newFavoriteStatus;
            }
          });
        } catch (error) {
          console.error('Failed to toggle favorite:', error);
=======
        if (pendingFavoriteToggles.has(vehicleId)) {
          return;
        }

        const applyFavoriteStatus = (isFavorite: boolean) => {
          set((state) => {
            const target = state.vehicles.find(v => v.id === vehicleId);
            if (target) {
              target.isFavorite = isFavorite;
            }
            if (state.selectedVehicle?.id === vehicleId) {
              state.selectedVehicle.isFavorite = isFavorite;
            }
          });
        };

        const vehicle = get().vehicles.find(v => v.id === vehicleId);
        if (!vehicle) return;

        const previousFavoriteStatus = Boolean(vehicle.isFavorite);
        const newFavoriteStatus = !previousFavoriteStatus;

        applyFavoriteStatus(newFavoriteStatus);
        pendingFavoriteToggles.add(vehicleId);

        try {
          const confirmedFavoriteStatus = await fetchNui<boolean>(
            NuiCallbackType.TOGGLE_FAVORITE,
            { vehicleId, isFavorite: newFavoriteStatus },
            true
          );

          if (typeof confirmedFavoriteStatus === 'boolean' && confirmedFavoriteStatus !== newFavoriteStatus) {
            applyFavoriteStatus(confirmedFavoriteStatus);
          }
        } catch (error) {
          applyFavoriteStatus(previousFavoriteStatus);
          handleGarageActionError('Failed to toggle favorite.', error);
        } finally {
          pendingFavoriteToggles.delete(vehicleId);
>>>>>>> upstream-1142/1.14.2
        }
      },

      // Computed
      getFilteredVehicles: () => {
        const state = get();
<<<<<<< HEAD
        let filtered = [...state.vehicles];

        // Search filter
        if (state.filter.search) {
          const search = state.filter.search.toLowerCase();
          filtered = filtered.filter(v =>
            v.name.toLowerCase().includes(search) ||
            v.customName?.toLowerCase().includes(search) ||
            v.plate.toLowerCase().includes(search) ||
            v.model.toLowerCase().includes(search)
          );
        }

        // Type filter
        if (state.filter.type && state.filter.type !== 'all') {
          filtered = filtered.filter(v => v.type === state.filter.type);
        }

        // Stored filter
        if (state.filter.stored !== 'all') {
          filtered = filtered.filter(v => v.stored === state.filter.stored);
        }

        // Impounded filter
        if (state.filter.impounded !== 'all') {
          filtered = filtered.filter(v => v.impounded === state.filter.impounded);
        }

        // Favorite filter
        if (state.filter.favorite !== 'all') {
          filtered = filtered.filter(v => v.isFavorite === state.filter.favorite);
        }

        // Sort: Favorites first, then by last used
        filtered.sort((a, b) => {
          if (a.isFavorite && !b.isFavorite) return -1;
          if (!a.isFavorite && b.isFavorite) return 1;
          return (b.lastUsed || 0) - (a.lastUsed || 0);
        });

        return filtered;
      },

      updateStats: () => set((state) => {
        const vehicles = state.vehicles;
        state.stats = {
          total: vehicles.length,
          stored: vehicles.filter(v => v.stored && !v.impounded).length,
          out: vehicles.filter(v => !v.stored && !v.impounded).length,
          impounded: vehicles.filter(v => v.impounded).length
        };
      })
    }))
  )
);
=======
        return state.vehicles;
      },

      updateStats: () => set((state) => {
        state.stats = calculateStats(state.vehicles);
      })
    }))
  )
);
>>>>>>> upstream-1142/1.14.2
