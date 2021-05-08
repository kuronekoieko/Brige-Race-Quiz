using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NPC : MonoBehaviour
{
    public Character character;
    public void OnAwake()
    {
        character.onStart = OnStart;
    }

    void OnStart()
    {

    }
}
