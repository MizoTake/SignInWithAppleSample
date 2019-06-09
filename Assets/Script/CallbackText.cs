using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CallbackText : MonoBehaviour
{
    
    [SerializeField]
    private Text result;

    public void CompleteCallback(string complete) {
        result.text = complete;
    }

    public void ErrorCallback(string error) {
        result.text = error;
    }
}
