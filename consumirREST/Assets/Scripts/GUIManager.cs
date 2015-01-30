// Created by Pablo Marcos  c2014
// http://www.pablomarcos.net

using UnityEngine;
using System.Collections;

public class GUIManager : MonoBehaviour {

	private string playerIPAddress = "0";
	private string country;
	private string region;
	private string city;
	private bool isObtainingTheIP = false;
	private bool hasIPResponse = false;
	private bool errorObtaining = false;
	private bool askingApiREST = false;
	private bool hasApiResponse = false;

	void OnGUI(){
		if(GUI.Button(new Rect(30,30,100,100),"Start!"))
			StartCoroutine("GetIP");

		if(isObtainingTheIP){
			GUI.Label(new Rect(200, 30,400,30), "Trying to get your IP...");
		}

		if(hasIPResponse && !errorObtaining){
			GUI.Label(new Rect(200, 60,400,30), "Yeah! Your IP is: " + playerIPAddress);	
		}else if(hasIPResponse && errorObtaining){
			GUI.Label(new Rect(200, 60,400,30), "Error obtainig your IP");	
		}

		if(askingApiREST){
			GUI.Label(new Rect(200, 90,400,30), "Checking the API REST...");
		}

		if(hasApiResponse){
			GUI.Label(new Rect(200, 120,400,30), "Country: " + country);
			GUI.Label(new Rect(200, 140,400,30), "Region: " + region);
			GUI.Label(new Rect(200, 160,400,30), "City: " + city);
		}
	}

	IEnumerator GetIP(){
		isObtainingTheIP = true;

		WWW w = new WWW("http://checkip.dyndns.org");
		yield return w;
		
		// Esperamos un segundo, deja que llegue la respuesta!
		yield return new WaitForSeconds(1f);
		GetIPResponse(w.text);
	}

	void GetIPResponse(string HTMLResponse){
		playerIPAddress = HTMLResponse.Substring(HTMLResponse.IndexOf(":")+2);
		playerIPAddress = playerIPAddress.Substring(0,playerIPAddress.IndexOf("<"));
		hasIPResponse = true;

		GetIPGeolocation();
	}

	void GetIPGeolocation(){
		StartCoroutine("AskWebservice");
	}

	IEnumerator AskWebservice(){
		askingApiREST = true;
		/*  Si el parámetro hubiera que pasarlo por POST lo haríamos así:
		WWWForm form = new WWWForm();
		form.AddField("ip", playerIPAddress);
		WWW w = new WWW("http://freegeoip.net/json/",form);
		*/

		// Pasamos parámetro por GET
		WWW w = new WWW("http://freegeoip.net/json/" + playerIPAddress);
		yield return w;
		
		// Add a wait to make sure we have the definitions
		yield return new WaitForSeconds(1f);
		
		WebserviceResponse(w.text);
	}

	void WebserviceResponse(string jsonResponse){
		JSONObject jo = new JSONObject(jsonResponse);
		
		country = jo.GetField("country_name").ToString();
		region  = jo.GetField("region_name").ToString();
		city = jo.GetField("city").ToString();

		hasApiResponse = true;
	}	
}
