using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class BucketController : MonoBehaviour
{
    [SerializeField] BucketCollision bucketCollision;
    [SerializeField] TextMeshPro textMeshPro;
    [SerializeField] BridgeController bridgeController;
    public CharacterType characterType;
    int answerCount
    {
        get
        {
            return _answerCount;
        }
        set
        {
            _answerCount = value;
            textMeshPro.text = "x " + value;
        }
    }
    int _answerCount;

    private void Awake()
    {
        bucketCollision.onHitItem = OnHitItem;
    }

    void Start()
    {

    }

    void OnHitItem(ItemController itemController)
    {
        if (itemController.isInBucket) return;
        itemController.isInBucket = true;
        itemController.transform.parent = transform;
        if (itemController.isAnswer) answerCount++;
        if (answerCount == 5)
        {
            gameObject.SetActive(false);
            bridgeController.gameObject.SetActive(true);
        }
    }
}
