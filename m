Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72E1A316E
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114261; cv=pass; b=cwM7Q+eRGho1cenSz+ogBPcOejL0zPxViiL5RE9sGWsty1KJ0fQ6C/9mXqzSwozZWFs++qJgVurX50J145XSB0wZIJ57HlyTny/GUZJnytfGo2FlyPDue706ZZKwCnInOiD9uvCNKc2CUfzh9WFfDgkG8EXgAf6MDt0LUdCKiw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114261; c=relaxed/simple;
	bh=a1bOwwaCmfU4XNHV/8/YKr0yPvqFQ3FaJ+P5x6K65FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naqzOzJ6uqLmj6RE98b4IChgrbaTq+NCsVDqmMQU7hwQWFH03QrDd47eNuZKvKlrLKpzZvDu+25Zjw8si5rXFcAgo5p3mxqpOi3RvF3P62T+Uh+WbGNQZIjKN8UN+PTVCT3NsIWPh1oBjA/zUOpJHCZOHO/fxEc8y/m01DZldz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRMQO8sg; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRMQO8sg"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3938cc204a7so1891121fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 May 2026 17:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778114255; cv=none;
        d=google.com; s=arc-20240605;
        b=TvH0pBslyjlNqMiMaSk1UDBwukZ/6Ica3aOt0xMxON76nR3v66boDZiZiFWAsM2vMl
         qc9MnE8eEhX3C5VHmuT8tsFf0e1hsaCCHamrBs7P+QGrbcDSNgDehzvFhMpKbPDnkkCR
         wx3rJlnQKEBMsP5XZTmBa01HkdrC6QW7KhxEKTtZrhuwPRBcCVlVF5KdKQ63Rc4uIEF1
         2lcp6HeFCLiiZDMZFyfQIIWL4o0nLYggub+E3i4EvFN8+mVST/3S+VAnnSfa+Z8wlRAv
         Eay8xGe9yTV8ddFMhEIf1glZN7u+A3K9UXk+DMxyiwkQEssb0C80xX6LAIcUrtJdVmW0
         76ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Nu/JbAiu7ivsPkfNKguKNhWbTjUJBMaIdrQCFA61Rs=;
        fh=GdXACDizXTJUazjr9vZcoRCmhOnZKkEQRjC/QifMLHI=;
        b=FXwGW60mROP5WAKS1mWJJJeDwc8R/H8HoASfP8zdlZgnxCCPzyUEaTx2/gmu9Hkcrf
         DGYoQAYS8BKVDOmZs6lsMWqeN8/pJKIoRF1Vu9oS/OqQ4ptva6RM2/f/hnActTbDBeU4
         J1ErSQODweFB3k5Q995pqrTxVvS/3mDffXw/Dcb4HZNWWs2FZ4V8Djt3UbrCkpgYjyTv
         6uPks4YcqTdT4iB56d9VRMENkyGsc/FHDMrADgdSKVoYfV7t7QBLWIRVTZ7Yb3Ey/HBx
         mOHoNCHWX7OpTAM438zxXl9grh6z2Z1PeVgfMbLGEoaPziM6CQ0g4fBXbRUgzlbW5/KY
         ynbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778114255; x=1778719055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Nu/JbAiu7ivsPkfNKguKNhWbTjUJBMaIdrQCFA61Rs=;
        b=DRMQO8sgAl9WE37+T5YNnBltGKL/PTzXA2DJj5b3Z/kcSElsLGfwsYPUOdUX5Vfiyd
         ImxXq7HjJTuoV1SqFQ4bqZ08hEeZwrrYUPN9VG9g7icbVVOrAMxvTnBWXBo4k46vJumN
         MHS7y6Rc6cCN1SpD1TCn35o1nBE/MoyXplmuYnygRSuOLeweatQZBXa2g4qT9FA5uRNo
         aohiNO3qzXcQZykHvXcGFB5pqku3Ls2Ijb+8QKoVqBGhBUJqM6eyn8EQH55zJJIE1RKU
         GiumZTxDh5jZbVEjvUwbbqzkcYtZxrUUtCsRbBcXrEVptrQ9xMSwrmoSxO3AaxYtIAxX
         EbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778114255; x=1778719055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Nu/JbAiu7ivsPkfNKguKNhWbTjUJBMaIdrQCFA61Rs=;
        b=KbUQ2Y2sP0AKsNXFMrlmgCJ4qqYGaFOqxko92FAB57gpofdMnFeAmTCeLM6qkMAy8y
         v6o4mIm8BVPEnfsL4u7PLJWU3/0aSBKaiYu2Di31Mlzd4QoPRGjlXVa5M/mObyBqdk21
         XD5GHcNXmNVHDDzv4axPhMbH6LdLbnl7ibstlFYlcAqGqNumxh7dd94iOgLmjS4hoJQc
         XNCrAXZB2CQHaWrucXqDmVIdZVmu6ADABgEm/TMYqrjbhAVs9AjHI3AlWVkejW0Jf7Yn
         gRW846WURFubLYcm5JosUvQYlm7QwdudGDqLfZLxHd0O+qxakGkJ+RZmvBp+yxsfNQ1+
         3MOQ==
X-Forwarded-Encrypted: i=1; AFNElJ84lzKD3hnQZYDoMEj1Tgf4kHBGkS+BQ4f7ItYNQYV9/qnCXbadby7M/2iZGPnUKFuv27t39jcmmygxJ3W+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Vxs/ygEKOl+92UTlUzkLph3AxPdZRnj3LEiFuMYsyQCDDdX3
	OSoJ/Ey3oRN4Tqs3YgFaMH77MzzjX+wNhEa1Rgek5/SWm5lAveO9jI5dxejWgzDfdOioAuajBgT
	jmi6a1R2f0wYCvzW/SI/14aPts81Y0WU=
X-Gm-Gg: AeBDieve59ZNIhCCeot+O6s8jALhvKvQ0pi30pJ/td1q3tMA/J1U3iJOxk1f01YW3jN
	FM4Ry+S+FBmaNOnaHDm770/oxq1vaGllXkKhqD28q1srR/2RvKETM8MuJLMPs99BhXv+orwvynG
	8mTBzn2DO63GzxdxeGLXEUhvHHdsgrLmFovoEajuf4413dJWdlxEv946vLq/0d0ChuhtUE1KyrL
	JOwjUqa2o9gup3wKtl5SdLKhvetajd9RIR5wnvujOXl3xJkLOsCoBDxs7mmjQ3Z32Q/a5fOydrQ
	351XdCbo9xOp8/6IXw==
X-Received: by 2002:a05:6512:3046:b0:5a4:56:aa88 with SMTP id
 2adb3069b0e04-5a887ce5cb9mr2146894e87.27.1778114254653; Wed, 06 May 2026
 17:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504154851.3034915-1-charsyam@gmail.com> <20260506092448.521995-1-charsyam@gmail.com>
In-Reply-To: <20260506092448.521995-1-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 7 May 2026 09:37:21 +0900
X-Gm-Features: AVHnY4JNlOFPoe_DZB5xKUQ_gQX4-nn5si1UWH4an-mkIHd_iPVcwuo8IXE_5y4
Message-ID: <CANFS6bYxRQ5RWCumT+N+KCJuL5d61=64RDV9qfXOhdfpQsE6AA@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix out-of-bounds write in ntfs_rl_collapse_range()
 merge path
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 6=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 6:24, Da=
eMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_rl_collapse_range() merges the run on the left of the collapsed
> region with the run on its right when they are contiguous. The contiguous
> check chooses a clamped index when @new_1st_cnt is 0:
>
>         i =3D new_1st_cnt =3D=3D 0 ? 1 : new_1st_cnt;
>         if (ntfs_rle_lcn_contiguous(&new_rl[i - 1], &new_rl[i])) {
>
> but the merge itself uses the unclamped value:
>
>         s_rl =3D &new_rl[new_1st_cnt - 1];
>         s_rl->length +=3D s_rl[1].length;
>
> When @new_1st_cnt is 0 this computes &new_rl[-1] and writes 8 bytes
> before the kvcalloc() runlist buffer. The path is reachable through
> fallocate(FALLOC_FL_COLLAPSE_RANGE) starting at vcn 0 against an
> attribute whose first run after the collapsed region and the following
> run are holes. In that case ntfs_rle_lcn_contiguous() returns true
> because both checked entries are LCN_HOLE, so the merge path is entered
> with @new_1st_cnt still 0. Such consecutive holes do not occur on a
> well-formed runlist (NTFS keeps runlists coalesced in memory), so this
> OOB path is only reachable from a crafted volume.
>
> A normal runlist has no element to the left of vcn 0, so the left/right
> merge is not valid when @new_1st_cnt is 0. Require @new_1st_cnt to be
> positive before checking or performing the merge. This skips the merge
> entirely in that case instead of clamping the merge target.
>
> The out-of-bounds write can corrupt an adjacent slab object. On a
> non-KASAN kernel, it is reachable after a crafted NTFS volume has been
> mounted read-write with the legacy fs/ntfs driver, by a local user that
> has write access to the crafted file.
>
> Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator=
")
> Suggested-by: Hyunchul Lee <hyc.lee@gmail.com>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>


> ---
> Changes since v1:
>   - Skip the merge entirely when @new_1st_cnt =3D=3D 0 instead of using a
>     clamped index, per review feedback. The clamped form silently
>     changed the operation's semantics from "merge the run left of the
>     collapsed region with the run right of it" to "coalesce two
>     right-side runs"; the new form closes a path that is only
>     reachable on malformed runlists. Behaviour on well-formed runlists
>     is unchanged.
>
>  fs/ntfs/runlist.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
> index da21dbeaaf66..e7de3d01257e 100644
> --- a/fs/ntfs/runlist.c
> +++ b/fs/ntfs/runlist.c
> @@ -2056,10 +2056,11 @@ struct runlist_element *ntfs_rl_collapse_range(st=
ruct runlist_element *dst_rl, i
>          * consists of holes.
>          */
>         merge_cnt =3D 0;
> -       i =3D new_1st_cnt =3D=3D 0 ? 1 : new_1st_cnt;
> -       if (ntfs_rle_lcn_contiguous(&new_rl[i - 1], &new_rl[i])) {
> -               /* Merge right and left */
> -               s_rl =3D  &new_rl[new_1st_cnt - 1];
> +       if (new_1st_cnt > 0 &&
> +           ntfs_rle_lcn_contiguous(&new_rl[new_1st_cnt - 1],
> +                                   &new_rl[new_1st_cnt])) {
> +               /* Merge right and left. */
> +               s_rl =3D &new_rl[new_1st_cnt - 1];
>                 s_rl->length +=3D s_rl[1].length;
>                 merge_cnt =3D 1;
>         }
> --
> 2.43.0
>


--
Thanks,
Hyunchul
