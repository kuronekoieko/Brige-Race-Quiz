using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using DG.Tweening;

public class ItemController : MonoBehaviour
{
    [NonSerialized] public Character owner;
    Rigidbody rb;
    Collider col;

    private void Awake()
    {
        rb = GetComponent<Rigidbody>();
        col = GetComponent<Collider>();
    }

    void Start()
    {

    }


    public void OnOwned()
    {
        rb.isKinematic = true;
        col.enabled = false;
        transform.eulerAngles = Vector3.zero;
    }

    public void Release()
    {
        rb.isKinematic = false;
        rb.AddForce(owner.transform.forward * rb.mass * 5f, ForceMode.Impulse);

        DOVirtual.DelayedCall(0.2f, () =>
        {
            col.enabled = true;
        });
    }
}
