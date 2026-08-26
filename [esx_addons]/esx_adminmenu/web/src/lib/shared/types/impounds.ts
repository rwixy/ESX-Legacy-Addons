export interface Vector3 {
	x: number;
	y: number;
	z: number;
}

export interface SpawnPoint extends Vector3 {
<<<<<<< HEAD
	heading: number;
}

export interface Impound {
	getOutPoint: Vector3;
	spawnPoint: SpawnPoint;
=======
	heading?: number;
	w?: number;
}

export interface Impound {
	id?: string;
	label?: string;
	getOutPoint?: Vector3;
	spawnPoint?: SpawnPoint;
	spawns?: SpawnPoint[];
>>>>>>> upstream-1142/1.14.2
	sprite?: number;
	scale?: number;
	colour?: number;
	cost?: number;
}
