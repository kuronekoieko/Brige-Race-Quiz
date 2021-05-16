using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimatorIK : MonoBehaviour
{
    [SerializeField] Transform leftHandTransform;
    [SerializeField] Transform rightHandTransform;
    // [SerializeField] Transform targetPosTf;
    private Animator animator;

    private void Awake()
    {
        animator = GetComponent<Animator>();
    }

    void OnAnimatorIK()
    {

        //　左手、右手のIK設定
        if (leftHandTransform)
        {
            animator.SetIKPositionWeight(AvatarIKGoal.RightHand, 1);
            animator.SetIKRotationWeight(AvatarIKGoal.RightHand, 1);
            animator.SetIKPositionWeight(AvatarIKGoal.LeftHand, 1);
            animator.SetIKRotationWeight(AvatarIKGoal.LeftHand, 1);
            animator.SetIKPosition(AvatarIKGoal.RightHand, rightHandTransform.position);
            animator.SetIKRotation(AvatarIKGoal.RightHand, rightHandTransform.rotation);
            animator.SetIKPosition(AvatarIKGoal.LeftHand, leftHandTransform.position);
            animator.SetIKRotation(AvatarIKGoal.LeftHand, leftHandTransform.rotation);
        }

        /* //注視方向
                if (targetPosTf)
                {
                    animator.SetLookAtWeight(1.0f, 1f, 1.0f, 0.0f, 0f);
                    animator.SetLookAtPosition(targetPosTf.position);
                }*/


    }
}
