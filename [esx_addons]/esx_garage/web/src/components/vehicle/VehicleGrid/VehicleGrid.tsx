import React from 'react';
import styled from 'styled-components';
<<<<<<< HEAD
=======
import { MdChevronLeft, MdChevronRight } from 'react-icons/md';
>>>>>>> upstream-1142/1.14.2
import type { Vehicle } from '@/types/vehicle.types';
import { VehicleCard } from '../VehicleCard';
import { useGarageStore } from '@/store/garage.store';

const GridContainer = styled.div`
  width: 100%;
<<<<<<< HEAD
  height: calc(100% - 3.875rem - 1.25rem); /* header + bottom spacing */
  display: flex;
  padding-top: 1.25rem;
=======
  height: calc(100% - 4.625rem - 1.25rem); /* header + bottom spacing */
  display: flex;
  flex-direction: column;
>>>>>>> upstream-1142/1.14.2
`;

const VehiclesWrapper = styled.div`
  flex: 1;
<<<<<<< HEAD
  overflow-y: auto;
  overflow-x: hidden;
=======
  min-height: 0;
  overflow-y: auto;
  overflow-x: hidden;
  padding-top: 1.25rem;
>>>>>>> upstream-1142/1.14.2
  padding-left: 1.25rem;
  padding-right: 0.625rem;
  margin-right: 1.25rem;

  /* Custom Scrollbar - Clean & Simple */
  &::-webkit-scrollbar {
    width: 0.25rem;
  }

  &::-webkit-scrollbar-button {
    display: none;
  }

  &::-webkit-scrollbar-track {
    background: rgba(251, 155, 4, 0.20);
    border-radius: 0.125rem;
  }

  &::-webkit-scrollbar-thumb {
    background: ${props => props.theme.colors.primary};
    border-radius: 0.125rem;

    &:hover {
      background: ${props => props.theme.colors.button.primaryHover};
    }
  }
`;

const VehiclesGrid = styled.div`
  display: grid;
  grid-template-columns: repeat(3, 20.625rem);
  gap: 0.625rem;
  width: 100%;
  padding-bottom: 0.625rem;
  padding-right: 0.625rem;
  justify-content: start;
`;

const EmptyState = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
  color: ${props => props.theme.colors.text.secondary};
  font-size: 1.125rem;
  text-align: center;
  gap: 1.25rem;
`;

<<<<<<< HEAD
=======
const PaginationBar = styled.div`
  height: 3rem;
  margin-top: 0.75rem;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.75rem;
  padding: 0 1.25rem 0.75rem;
  flex-shrink: 0;
`;

const PageButton = styled.button`
  width: 2rem;
  height: 2rem;
  border-radius: ${props => props.theme.sizes.borderRadius.sm};
  background: ${props => props.theme.colors.backgroundSecondary};
  display: flex;
  align-items: center;
  justify-content: center;
  transition: ${props => props.theme.transitions.fast};

  svg {
    width: 1.25rem;
    height: 1.25rem;
    color: ${props => props.theme.colors.text.primary};
  }

  &:hover:not(:disabled) {
    background: ${props => props.theme.colors.primary};
  }

  &:disabled {
    cursor: not-allowed;
    opacity: 0.35;
  }
`;

const PageText = styled.div`
  min-width: 5rem;
  text-align: center;
  color: ${props => props.theme.colors.text.secondary};
  font-size: 0.875rem;
  font-weight: ${props => props.theme.fonts.weights.medium};
`;

>>>>>>> upstream-1142/1.14.2
interface VehicleGridProps {
  onVehicleClick?: (vehicle: Vehicle) => void;
}

export const VehicleGrid: React.FC<VehicleGridProps> = ({ onVehicleClick }) => {
<<<<<<< HEAD
  const { getFilteredVehicles } = useGarageStore();
=======
  const { getFilteredVehicles, pagination, loadVehicles, isLoading } = useGarageStore();
>>>>>>> upstream-1142/1.14.2
  const vehicles = getFilteredVehicles();

  const handleVehicleClick = (vehicle: Vehicle) => {
    onVehicleClick?.(vehicle);
  };

<<<<<<< HEAD
=======
  const handlePrevious = () => {
    if (pagination.hasPrevious && !isLoading) {
      void loadVehicles(pagination.page - 1);
    }
  };

  const handleNext = () => {
    if (pagination.hasNext && !isLoading) {
      void loadVehicles(pagination.page + 1);
    }
  };

  const paginationControls = (
    <PaginationBar>
      <PageButton
        aria-label="Previous page"
        disabled={!pagination.hasPrevious || isLoading}
        onClick={handlePrevious}
      >
        <MdChevronLeft />
      </PageButton>
      <PageText>Page {pagination.page}</PageText>
      <PageButton
        aria-label="Next page"
        disabled={!pagination.hasNext || isLoading}
        onClick={handleNext}
      >
        <MdChevronRight />
      </PageButton>
    </PaginationBar>
  );

>>>>>>> upstream-1142/1.14.2
  if (vehicles.length === 0) {
    return (
      <GridContainer>
        <VehiclesWrapper>
          <EmptyState>
            <div>No vehicles found</div>
            <div style={{ fontSize: '0.875rem', opacity: 0.7 }}>
              Try adjusting your search or filters
            </div>
          </EmptyState>
        </VehiclesWrapper>
<<<<<<< HEAD
=======
        {paginationControls}
>>>>>>> upstream-1142/1.14.2
      </GridContainer>
    );
  }

  return (
    <GridContainer>
      <VehiclesWrapper>
        <VehiclesGrid>
          {vehicles.map((vehicle) => (
            <VehicleCard
              key={vehicle.id}
              vehicle={vehicle}
              onClick={() => handleVehicleClick(vehicle)}
            />
          ))}
        </VehiclesGrid>
      </VehiclesWrapper>
<<<<<<< HEAD
=======
      {paginationControls}
>>>>>>> upstream-1142/1.14.2
    </GridContainer>
  );
};
