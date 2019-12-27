using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RayTest : MonoBehaviour {

    public Vector3 mousePosition;
    // Start is called before the first frame update
    void Start () {
    }

    // Update is called once per frame
    void Update () {
        Ray r = Camera.main.ScreenPointToRay (Input.mousePosition);
        if (Physics.Raycast (r, out RaycastHit hit)) {
            mousePosition = hit.point;
           transform.position = mousePosition + new Vector3(0,0,-1);
            
        }
    }
}