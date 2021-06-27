Config = {}

-- Language du menu
-- Menu language
Config.Locale = 'de'

-- Location du spawn joueur après la création du personnage
-- Rental of player spawn after character creation
Config.PlayerSpawn = {x = -1042.635, y =-2745.828, z = 21.359, h = -30.0}

-- Name of parents for inheritance (Do not add / remove character, you can just replace them)
-- Nom des parents pour l'héritage (Ne pas ajouter / supprimer de personnage, vous pouvez juste les remplacés)
Config.MotherList = { "Hannah", "Aubrey", "Jasmine", "Gisele", "Amelia", "Isabella", "Zoe", "Ava", "Camila", "Violet", "Sophia", "Evelyn", "Nicole", "Ashley", "Gracie", "Brianna", "Natalie", "Olivia", "Elizabeth", "Charlotte", "Emma" }
Config.FatherList = { "Benjamin", "Daniel", "Joshua", "Noah", "Andrew", "Juan", "Alex", "Isaac", "Evan", "Ethan", "Vincent", "Angel", "Diego", "Adrian", "Gabriel", "Michael", "Santiago", "Kevin", "Louis", "Samuel", "Anthony",  "Claude", "Niko" }

-- List of outfit
-- Liste des tenues
Config.Outfit = {
	{
		label = 'Underwear',
		id = {
			male = {
				tshirt = {15, 0},
				torso = {15, 0},
				decals = {0, 0},
				arms = {15, 0},
				pants = {61, 4},
				shoes = {34, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}
			},
			female = {
				tshirt = {15, 0},
				torso = {5, 0},
				decals = {0, 0},
				arms = {15, 0},
				pants = {57, 0},
				shoes = {35, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}
			}
		}
	},
	{
		label = 'Casual',
		id = {
			male = {
				tshirt = {168, 5},
				torso = {118, 8},
				decals = {0, 0},
				arms = {1, 0},
				pants = {1, 5},
				shoes = {3, 1},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}
			},
			female = {
				tshirt = {3, 0},
				torso = {0, 1},
				decals = {0, 0},
				arms = {15, 0},
				pants = {0, 1},
				shoes = {3, 12},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}	
			}
		}
	},
	{
		label = 'Vagos',
		id = {
			male = {
				tshirt = {15, 0},
				torso = {14, 1},
				decals = {0, 0},
				arms = {1, 0},
				pants = {42, 5},
				shoes = {8, 6},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}
			},
			female = {
				tshirt = {60, 0},
				torso = {35, 0},
				decals = {0, 0},
				arms = {5, 0},
				pants = {3, 8},
				shoes = {50, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}	
			}
		}
	},
	{
		label = 'Ballas',
		id = {
			male = {
				tshirt = {1, 6},
				torso = {127, 6},
				decals = {0, 0},
				arms = {1, 0},
				pants = {26, 1},
				shoes = {9, 5},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}
			},
			female = {
				tshirt = {3, 0},
				torso = {2, 14},
				decals = {0, 0},
				arms = {2, 0},
				pants = {78, 0},
				shoes = {30, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}	
			}
		}
	},
	{
		label = 'Families',
		id = {
			male = {
				tshirt = {15, 0},
				torso = {128, 0},
				decals = {0, 0},
				arms = {0, 0},
				pants = {42, 6},
				shoes = {6, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}
			},
			female = {
				tshirt = {60, 0},
				torso = {31, 1},
				decals = {0, 0},
				arms = {5, 0},
				pants = {45, 0},
				shoes = {1, 8},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}	
			}
		}
	},
	{
		label = 'Mara-Bunta',
		id = {
			male = {
				tshirt = {30, 0},
				torso = {14, 0},
				decals = {0, 0},
				arms = {4, 0},
				pants = {9, 3},
				shoes = {12, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}
			},
			female = {
				tshirt = {3, 0},
				torso = {13, 10},
				decals = {0, 0},
				arms = {4, 0},
				pants = {8, 3},
				shoes = {22, 7},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}	
			}
		}
	},
	{
		label = 'Aztecas',
		id = {
			male = {
				tshirt = {15, 0},
				torso = {202, 1},
				decals = {0, 0},
				arms = {5, 0},
				pants = {103, 2},
				shoes = {9, 9},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}
			},
			female = {
				tshirt = {19, 3},
				torso = {181, 0},
				decals = {0, 0},
				arms = {15, 0},
				pants = {43, 3},
				shoes = {22, 2},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}	
			}
		}
	},
	{
		label = 'Biker',
		id = {
			male = {
				tshirt = {168, 11},
				torso = {181, 3},
				decals = {0, 0},
				arms = {1, 0},
				pants = {72, 3},
				shoes = {50, 3},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}
			},
			female = {
				tshirt = {3, 0},
				torso = {13, 15},
				decals = {0, 0},
				arms = {15, 0},
				pants = {27, 9},
				shoes = {20, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {-1, 0}	
			}
		}
	}
}