var groupInContext = "";
var benSearch = "cargo";
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function(){

	window.addEventListener("message",function(event){
		switch (event["data"]["action"]){
			case "openSystem":
				$("body").css("display","block");
				groupInContext = event["data"]["group"]
				gerente = event["data"]["gerente"]
				requestMembers()
				requestinfos()
				requestMembersOn()
				requestMembersMax()
				groupMenssage()
				header()
				btncontrato()
				edit()
			break;

			case "closeSystem":
				$("body").css("display","none");
			break;

			case "updateData":
				requestMembers()
				requestinfos()
				requestMembersOn()
				requestMembersMax()
				groupMenssage()
				header()
				btncontrato()
				edit()
			break;
		
		};
	});

	document.onkeyup = function(data){
		if (data["which"] == 27){
			$.post("http://shark_gm/closeSystem");
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
/* ----------Contratar----------- */
$(document).on("click","#contratar",function(){
	$("#wrapper").addClass("active");
	$.post("http://shark_gm/requestcargos",JSON.stringify({group: groupInContext}),(data) => {

		var nameList = data["result"]

		$("#wrapper").html(`
		<div class="close"></div> 
		<h2>EDITAR CARGO</h2>
		<div id="seterContent">
			<center><input type="number" class="form-control" name="Passaport" id="userId" style="width:95%">
			
			<select name="Grupos" id="setTag" class="form-control" style="margin-top:10px; width:95%">
			${nameList.map((item) => (`
			<option ${item["cargo"] == 'Recruta' ?  'selected':''}>${item["cargo"]}</option>
			`)).join('')}
			</select></center>
			</div>
			<center><button type="submit" id="enviarContratar" class="btn btn-success" style="width:95%; margin-top:10px;">Alterar</button></center>
			`);
			const input = document.querySelector("#userId")
			document.getElementById('userId').value = id
			input.disabled=true;
		});	
});



$(document).on("click","#enviarContratar",function(e){
	const id = document.getElementById("userId").value
	const group = document.getElementById("setTag").value
	$.post("http://shark_gm/requestSetGroup",JSON.stringify({ id: id , set: group,group: groupInContext}));
	$("#wrapper").removeClass("active");
});
$(document).on("click",".close",function(){
	$("#wrapper").removeClass("active");
});
/* ---------------------------------------------------------------------------------------------------------------- */
const searchTypePage = (mode) => {
	benSearch = mode;
	requestMembers();
}
var ativo = false;
/* ----------***********----------- */
const requestMembers = () => {
	$.post("http://shark_gm/requestMembers",JSON.stringify({group: groupInContext}),(data) => {

		/*var nameList = data["result"]*/
		if (benSearch == "status"){
			if (ativo){
				var nameList = data["result"].sort((a,b) => (a["status"] > b["status"]) ? 1: -1);
				ativo = false
			} else {
				var nameList = data["result"].sort((a,b) => (a["status"] < b["status"]) ? 1: -1);
				
				ativo = true
			}
		} else if (benSearch == "id") {
			if (ativo){
				var nameList = data["result"].sort((a,b) => (a["id"] > b["id"]) ? 1: -1);
				ativo = false
			} else {
				var nameList = data["result"].sort((a,b) => (a["id"] < b["id"]) ? 1: -1);
				ativo = true
			}
		} else if (benSearch == "cargo") {	
			if (ativo){
				var nameList = data["result"].sort((a,b) => (a["pesocargo"] < b["pesocargo"]) ? 1: -1);
				ativo = false
			} else {
				var nameList = data["result"].sort((a,b) => (a["pesocargo"] > b["pesocargo"]) ? 1: -1);
				ativo = true
			}
		}


	$("#box_direita_quadrado1").html(`
	
		${nameList.map((item) =>
			 (`
			<div class="pessoa">
			<div class="container">
			<div class="row">
				<div class="col" align="center">PASSAPORTE<br><b>#${item["id"]}</b></div>
				<div class="col" align="center">CARGO<br><b>${item["cargo"]}</b></div>
				<div class="col" align="center">NOME<br><b>${item["name"]}</b></div>
				<div class="col" align="center">STATUS<br>${item["status"] == "on" ? '<div class="circulo pulse"></div>':'<div class="circulo2 pulse"></div>'}</div>
				${item["Nuiservico"] ? item["servico"] ? '<div class="col" align="center">EM SERVIÇO<br><div class="circulo pulse"></div></div>':'<div class="col" align="center">EM SERVIÇO<br><div class="circulo2 pulse"></div></div>':''}
				${gerente ? '<i class="fa-solid fa-pen-to-square"onclick="updateMember('+item["id"]+')" style="font-size: 15px; margin-left: 5px; cursor: pointer;"></i>':''}
				${gerente ? '<i class="fa-solid fa-trash" onclick="deleteMember('+item["id"]+',\'${groupInContext}\')" style="font-size: 15px; margin-left: 5px; margin-right: 10px;cursor: pointer;"></i>':''}
			</div>
			</div>
		</div>
		</div>
		`)).join('')}
		`);
	});	
}

const requestinfos = () => {
	$.post("https://shark_gm/requestinfos",JSON.stringify({group: groupInContext}),(data) => {
		$('#box_esquerda_quadrado5').html(`

		<h2>INFORMAÇÕES ÚTEIS</h2>
				<div class="container">
				  <div class="row">
					<div class="col">Nome:<br><b>${data[0]}</b></div>
					<div class="col-5">Passaporte:<br><b>#${data[1]}</b></div>
					<div class="w-100" style="margin-top: 35px;"></div>
					<div class="col">Organização:<br><b>${data[2]}</b></div>
					<div class="col-5">Cargo:<br><b>${data[3]}</b></div>
				  </div>
				</div>
		`);
	});
}

const btncontrato = () => {
	$('#btncontratar').html(`
	${gerente ? '<div class="col col-lg-4"><i class="fa-solid fa-file-signature icony"></i></div><div class="col"><div class="contratar ">CONTRATAR</div><br><div class="btn_contratar" id="contratar">	PRÓXIMO >></div></div>':''}
	`);
}

const header = () => {
	$("#background-menu").html(`
		<div id="club">
			<h1>Aurora </h1>
			<h2>GROUP MANAGER</h2>
		</div>
		<section id="menu">
		<h1 class="nomefac">${groupInContext}</h1>
		</section>
		${gerente ? '<div class="img"></div>':''}
		`);

}


const edit = () => {
	$("#box_esquerda_quadrado3").html(`
		${gerente ? 'MURAL DE RECADO <i class="fa-solid fa-pen-to-square" onclick="SetGroupMsg()" style="font-size: 15px; margin-left: 5px; cursor: pointer; color: #fff; float: right;"></i>':''}
		`);

}

const requestMembersOn = () => {
	$.post("http://shark_gm/requestMembersOn",JSON.stringify({group: groupInContext}),(data) => {
		var nameList = data["result"]

		$("#monline").html(`
		${nameList.map((item) => (`${item["qtdOn"]}`)).join('')}`);
	});	
}


const requestMembersMax = () => {
	$.post("http://shark_gm/requestMembersMax",JSON.stringify({group: groupInContext}),(data) => {
		var nameList = data["result"]
				
		$("#vagasusadas").html(`
		${nameList.map((item) => (`${item["qtd"]}`)).join('')}`);
		
		$("#vagastotais").html(`${nameList.map((item) => (`${item["maxQtd"]}`)).join('')}`);
	});	
}


const updateMember = (id) =>{
	
	$("#wrapper").addClass("active");

	$.post("http://shark_gm/requestcargos",JSON.stringify({group: groupInContext}),(data) => {

		var nameList = data["result"]

		$("#wrapper").html(`
		<div class="close"></div> 
		<h2>EDITAR CARGO</h2>
		<div id="seterContent">
			<center><input type="number" class="form-control" name="Passaport" id="userId" style="width:95%">
			
			<select name="Grupos" id="setTag" class="form-control" style="margin-top:10px; width:95%">
			${nameList.map((item) => (`
			<option>${item["cargo"]}</option>
			`)).join('')}
			</select></center>
			</div>
			<center><button type="submit" id="enviarUpdate" class="btn btn-success" style="width:95%; margin-top:10px;">Alterar</button></center>
			`);
			const input = document.querySelector("#userId")
			document.getElementById('userId').value = id
			input.disabled=true;
		});	
}
$(document).on("click","#enviarUpdate",function(e){
	const id = document.getElementById("userId").value
	const group = document.getElementById("setTag").value
	$.post("http://shark_gm/requestupdateMembers",JSON.stringify({ id: id , set: group, cargo:groupInContext}));
	$("#wrapper").removeClass("active");
	
});

const deleteMember = (id,group) =>{
	$("#wrapper").addClass("active");
	$("#wrapper").html(`
	
	<div class="close"></div> 
	<div class="clear"></div>
	<h4> Deseja mesmo remover o usuário?</h4>
	<div id="seterContent">
	</div>
	<center><button type="submit" id="enviarDelete" class="btn btn-danger" onclick="enviarDelete(${id},'${group}')">Sim</button></center>
	`);
	

}
const enviarDelete = (id,group)=>{
	$.post("http://shark_gm/requestdeleteMembers",JSON.stringify({ id: id,group: group}));
	$("#wrapper").removeClass("active");	
}

const groupMenssage = () =>{
	
	$.post("http://shark_gm/requestgroupMensage",JSON.stringify({group: groupInContext}),(data) => {
		var nameList = data["result"]
				
		$("#amsg").html(`
		${nameList.map((item) => (`${item["msg"]}`)).join('')}`);
		
	});	
		
}


const SetGroupMsg = () => {
	$("#wrapper").addClass("active");
	$("#wrapper").html(`
		
		<div class="close"></div> 
		<h2>Mensagem</h2>
		<center><textarea id="text-edit" class="mensage" class="form-control" placeholder="Escreva sua msg..."></textarea>
		<button type="submit" id="enviarMensage" class="btn btn-success">Enviar</button></center>
		`)}

$(document).on("click","#enviarMensage",function(e){
	const msg = document.getElementById("text-edit").value

	$.post("http://shark_gm/requestSetGroupMensage",JSON.stringify({mensage: msg,group: groupInContext}),(data) => {
	});
	$("#wrapper").removeClass("active");
});


$(document).on("click","#registerMember",function(e){
	$.post("http://tablet/requestBuy",JSON.stringify({ name: e["target"]["dataset"]["name"] }));
});

/* ----------FORMAT---------- */
const format = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
};
