using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ItemGenerator : MonoBehaviour
{
    [SerializeField] ItemController[] itemPrefabs;
    ItemController[] itemControllers;
    readonly int itemCount = 50;

    private void Awake()
    {
        itemControllers = new ItemController[itemCount];
        int itemPrefabIndex = 0;
        for (int i = 0; i < itemControllers.Length; i++)
        {
            ItemController itemPrefab = itemPrefabs[itemPrefabIndex];
            itemControllers[i] = Instantiate(itemPrefab, Vector3.zero, Quaternion.identity, transform);
            itemPrefabIndex++;
            if (itemPrefabIndex == itemPrefabs.Length) itemPrefabIndex = 0;
        }
    }

    public void OnStart()
    {
        for (int i = 0; i < itemControllers.Length; i++)
        {
            Vector3 pos = Vector3.zero;
            pos.x = Random.Range(-5f, 5f);
            pos.y = Random.Range(5f, 10f);
            pos.z = Random.Range(-5f, 5f);
            itemControllers[i].transform.position = pos;
        }
    }
}
