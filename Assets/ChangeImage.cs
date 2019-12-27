using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeImage : MonoBehaviour {
    public Texture2D[] textures;

    public float timer = 0;
    public int currentFrame = 0;
    public float rate = 1;

    // Start is called before the first frame update
    void Start () {

    }

    // Update is called once per frame
    void Update () {
        Timer ();
        SetTexture ();
    }

    void Timer () {
        timer += Time.deltaTime;
        if (timer < rate) {
            return;
        }
        if (currentFrame < textures.Length-1) {
            currentFrame++;
        } else {
            currentFrame = 0;
        }
        timer = 0;
    }

    void SetTexture () {
        GetComponent<MeshRenderer>().material.SetTexture("_MainTex",textures[currentFrame]);
    }
}