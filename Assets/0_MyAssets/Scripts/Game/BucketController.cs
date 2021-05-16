using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class BucketController : MonoBehaviour
{
    [SerializeField] BucketCollision bucketCollision;
    [SerializeField] TextMeshPro textMeshPro;
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
        if (itemController.isAnswer) answerCount++;
    }
}
