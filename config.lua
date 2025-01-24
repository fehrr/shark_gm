Cfg = {}

Cfg.CommandOpenNUI = "painel" -- Comando para abrir o painel
Cfg.OpenNUIWithKey = true -- Abrir painel por tecla
Cfg.KeyOpenNUI = "F11" -- Tecla para abrir painel caso a função acima esteja habilitada

-- Alem do tablet normal para lideres, a staff tb pode manipular as orgs, utilizando o mesmo comando do Cfg.CommandOpenNUI e apos ele implementando
-- A ORG o qual deseja visualizar, EX: /groupsystem vermelhos, assim podendo acessar o tablet sem necessaciamente ser o lider
Cfg.UseStaffTablet = { -- Permissões para poder utilizar o tablet de staff
    "Staff"
}

Cfg.CommandForAddNewLider = "addLider" -- Comando utilizado para adicionar um novo lider a uma org
Cfg.UseCommandAddNewLider = { -- Permissões para poder utilizar o comando acima
    "Staff"
}

Cfg.CommandForRemMember = "remMember" -- Comando utilizado para remover alguem de uma org(utilizado principalmente para remover o lider de uma org)
Cfg.UseCommandRemMember = { -- Permissões para poder utilizar o comando acima
    "Staff"
}

Cfg.AttListOfOrgsInDB = "AttDB" -- Comando para atualizar o DB com as orgs cadastradas
Cfg.UseCommandAttListOfOrgs = { -- Permissões para poder utilizar o comando acima
    "Staff"
}

Cfg.Blacklist = {
    ["System"] = true, -- Ativar ou desativar o sistema de blacklist o qual coloca um CD entre sair de um grupo e entrar em outro
    ["Type"] = "days", -- "days" para contar o valor em dias e "hours" para contar o valor em horas
    ["Time"] = 3
}

Cfg.ListOfOrgs = { -- Nome da organização e quantidade maxima de membros
    ["Police"] = {
        ["MaxMembers"] = 100,
        ["PermLider"] = "Coronel",
        ["PermSubLider"] = "Tenente-Coronel",
        ["PermGerente"] = "Corregedoria",
        ["PermInservice"] = "Police",
        ["Hierarquia"] = {
            "Coronel",
            "Tenente-Coronel",
            "Corregedoria",
            "Major",
            "Capitão",
            "1°-Tenente",
            "2°-Tenente",
            "Aspirante-A-Oficial",
            "SubTenente",
            "1°-Sargento",
            "2°-Sargento",
            "3°-Sargento",
            "Cabo",
            "Soldado",
            "Recruta"
        }
    },
    ["Federal"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "Delegado",
        ["PermSubLider"] = "Investigador",
        ["PermGerente"] = "Corregedoria",
        ["PermInservice"] = "Federal",
        ["Hierarquia"] = {
            "Delegado",
			"Investigador",
			"Corregedoria",
			"Perito",
			"Agente 1º Classe",
			"Agente 2º Classe",
			"Agente 3º Classe",
			"Agente 4º Classe"
        }
    },
    ["Paramedic"] = {
        ["MaxMembers"] = 100,
        ["PermLider"] = "Diretor",
        ["PermSubLider"] = "Vice Diretor",
        ["PermGerente"] = "Diretoria",
        ["PermInservice"] = "Paramedic",
        ["Hierarquia"] = {
            "Diretor",
            "Vice Diretor",
            "Diretoria",
            "Cirurgião",
            "Socorrista Chefe",
            "Socorrista 2°Classe",
            "Socorrista",
            "Paramedico",
            "Interno",
            "Estagiario"
        }
    },
    ["Favela1"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderFavela1",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderFavela1",
            "Favela1"
        }
    },
    ["Favela2"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderFavela2",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderFavela2",
            "Favela2"
        }
    },
    ["Favela3"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderFavela3",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderFavela3",
            "Favela3"
        }
    },
    ["Favela4"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderFavela4",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderFavela4",
            "Favela4"
        }
    },
    ["Favela5"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderFavela5",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderFavela5",
            "Favela5"
        }
    },
    ["Favela6"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderFavela6",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderFavela6",
            "Favela6"
        }
    },
    ["Favela7"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderFavela7",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderFavela7",
            "Favela7"
        }
    },
    ["Favela8"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderFavela8",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderFavela8",
            "Favela8"
        }
    },
    ["Favela9"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderFavela9",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderFavela9",
            "Favela9"
        }
    },
    ["Favela10"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderFavela10",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderFavela10",
            "Favela10"
        }
    },
    ["Mafia1"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderMafia1",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderMafia1",
            "Mafia1"
        }
    },
    ["Mafia2"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderMafia2",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderMafia2",
            "Mafia2"
        }
    },
    ["Mafia3"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderMafia3",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderMafia3",
            "Mafia3"
        }
    },
    ["Mafia4"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderMafia4",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderMafia4",
            "Mafia4"
        }
    },
    ["Mafia5"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderMafia5",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderMafia5",
            "Mafia5"
        }
    },
    ["Mechanic"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderMechanic",
        ["PermInservice"] = "Mechanic",
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderMechanic",
            "Mechanic"
        }
    },
    ["Mechanic2"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderMechanic2",
        ["PermInservice"] = "Mechanic2",
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderMechanic2",
            "Mechanic2"
        }
    },
    ["Lavagem1"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderLavagem1",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderLavagem1",
            "Lavagem1"
        }
    },
    ["Lavagem2"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "LiderLavagem2",
        ["PermInservice"] = nil,
        ["PermOutservice"] = "",
        ["Hierarquia"] = {
            "LiderLavagem2",
            "Lavagem2"
        }
    },
    ["Judiciario"] = {
        ["MaxMembers"] = 30,
        ["PermLider"] = "Juiz",
        ["PermInservice"] = "Judiciario",
        ["Hierarquia"] = {
            "Juiz",
            "JuizAdjunto",
            "Promotor",
            "Advogado"
        }
    },
    ["Jornal"] = {
        ["MaxMembers"] = 5,
        ["PermLider"] = "Dono",
        ["PermInservice"] = "Jornal",
        ["Hierarquia"] = {
            "Dono",
            "Ajudante"
        }
    }
}