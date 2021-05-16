using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class BucketCollision : MonoBehaviour
{
    public UnityAction<ItemController> onHitItem = (itemController) => { };


    private void OnTriggerEnter(Collider other)
    {
        var item = other.gameObject.GetComponent<ItemController>();
        if (item == null) return;
        onHitItem(item);
    }
}
