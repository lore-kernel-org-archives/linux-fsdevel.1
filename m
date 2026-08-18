Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E01B1EFF8D
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037169; cv=pass; b=SEVyBsZblTY0V4Ao4md1+E3wEmJATrf3GBMjHxoqvzl3mpyXzZn/xgJR5IJe/Mf3u6ElhLvYnkG8SkWOBD/VhBuYBZE8qWJAlB+8k3iGYLNQwpZYm4oQgMaFywPWCyVl06Il/KFKcCdS9aPznrgp92G7M2fP4KA/8dJcljXLVt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037169; c=relaxed/simple;
	bh=FpOYufCf2SAq7OTotmpDVssQOat63zzN4SIaIrhhIto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zgby0kBmvl8/gRNZaStYAjmtvgCoi7i9uk4AWLAZYCE0VtmxmOWRiVW8bF0e+zpC9b2B2K1dQnQ0NHVKklJKdwPrB+3l47aVkkInckEIxZI24ZRumJ06q06EjXixpTSAnsWdHE5xLPRAl68QOtJrDmm+CskpAcQoVp9sgQuqNmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evaMsHjD; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evaMsHjD"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b29599b81cso5799596e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 00:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787037166; cv=none;
        d=google.com; s=arc-20260327;
        b=S039bA3PVNUQU/yHUhfZUyz4GDM+EmQh1BeRuwomEJa7YNwKCnHyA0m+unB6b5v1TR
         Ayin54mRw1Dwm1A6+/DNNnW/WPG2qjzfgrqGUCFrvyU40X7oMEeZDsZdpPizovBMGTVZ
         RXPcqKKr66UidWpk7PtMPAUSl4Su4X5mth+j0liC/5YMFnmFxfoYREKA2lLC0CsbqezD
         whvrTK6WPoxwnorpZzRt30oL5e09u6tAZ+mFGFlIIlA6q2+1GLSzkMQw+IcIwqO/0f8D
         3CYf9oS567hggrTskgrXooHNl+cChffwFJFEItyY8vh8A02Q3MGowHaRCmdlq/6MEw+e
         BGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6FvGvOD8DReTRRqwZg/NSE82RS2HpWUwu9kmOho6wM4=;
        fh=+jFel2gwEBgw2gAMuSkuTvKwIgXToj7ER9IUBconnyU=;
        b=LYTVdLkwrpmWz+d0KBGdkzw1jgGi3LGK7DOXsBdDzNtMHuKm/cMB/6oH7Gi7tq55pt
         eR31TlQV0zEKaw29djFqwkQ/U/IVr9jqYotg8ij3gE3DZKKOThvr8u/W9wLiHrKNKCJV
         9m6RKPr/jEKzQiXNmte9YOqq3gB4+u8Brl04CBnJwNmN0d3Nat57+Xkc5IhEse4RSI+N
         aiGtx8n6bIKMWJ0LRdGJ65agOBTPrLZwvl4NmQQmX1GlvRh1TqkQsPp0EA6ESZUcDkaK
         2d8ss9sHVkE3hm+3TfRWt30+1+zdIUt7fWJoBg9H920g23sWVS7kBenSxNs5S5ATPoCC
         Z5ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787037166; x=1787641966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6FvGvOD8DReTRRqwZg/NSE82RS2HpWUwu9kmOho6wM4=;
        b=evaMsHjDGw0k/aFQmPbSLDSFA8h4OOmJK0+VxDrs/dVOlTJ0EKKA1QmWeecaJv7paL
         dYCID8s1k7Gqlzc2nThfWITyyJYxWUPIa6eYHP3qM02ayCmpf1v4XApFRNLJ16Cq2PJi
         enyK59y5J0vhACJAz9CQuyxhToajIQMcKsWTxpS/cfH08u6BQG371uJlEC8olF6j5UE4
         mdnbbHBnsXEhLFRBbsQ6pja8Ym7VGes17cx8+FxtJDf/xHfNOumU3+VjO6CUL6cVyj4U
         34VUt7X1ZxgvFiUVgo+6OEuQVeu21LyB4O4L4UCpvTUF3emt7V8QXP7Mz58KF2xMEy32
         wn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787037166; x=1787641966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6FvGvOD8DReTRRqwZg/NSE82RS2HpWUwu9kmOho6wM4=;
        b=jHzAc3BT2RX2CUR7TeCPCP6OuxNavoe3694J4eN0224WJIJK8i7NEY/FdsriCJ6Lxt
         o7+Kdyf+mhBDQMxikmn8NeYqECnmAvnej3c8DwScN7/iIvanWl7phH9M6izUJMs3nPTj
         kzPpvPLCMOO2AryiQqhQBtZTYR94F26Xd1iv2j+gz015bL7O+y+XLmfEWP6AzejyYZOv
         IOu52/Y1Gbb4Xd+VoaRBhTji2UZNV+I5/FFk63dydheWH3BQ3foHxmIOk0VoDbqjK1WT
         H0tYKKAbAcaIR2VgVZismtOPMXpBypZ28x8Cwhh1hoq4nf4qrOdW5CUiX/gvlxpc61OO
         dNtw==
X-Forwarded-Encrypted: i=1; AHgh+RoPLQt/ATUdQu8W1IOGdLZhjH9kG5OJtbPRis0O3THqn2JNJw4kyN0/42mB2TXUPbG7G2yCn7tfh+ObLUFT@vger.kernel.org
X-Gm-Message-State: AOJu0YzMRobGAJs67ynYTDkxbphG+4KT2BHOaGc+FjqnH8gw1318V69X
	yBgBFJxF9/FFFEPX9jM8WBIjgRbybt65QhLW25AFiYJ2hHwhwoVClo9yAxPPVQaMNmRnDXyC/rM
	cBPISJkEYYvRXbOUJefOjC9/hmLxUcY+P8wiH
X-Gm-Gg: AR+sD13uFbKUbRal6sRbYopMVCPc3HpF7LodcWsJfwONZ2o4toOMAWj5b7LmvG7pTwf
	D3yLVvFVpbRGkyV+0g+Dkhfwhu0tNpMxVaU0BoR8etVI6SVkLwyirPbZodmxUztrsvZJeJNwggs
	vzpJZ6VDNo/aT+t4KzBuEUvt4oiPWptXYIhkO9rKWyjQhNz8Z/L7rjRGiLPz9T0opVhymi7AihP
	XBND07IzIhlUo6vUE+JTsPtWriehncHJcg5hxA5oTxVFCsulKVKZxfOIb1KSsDoCkg8c+4Mh7+3
	fZSn+d5UAlXPsJlVZhs6XHRDNxjfFnnsanRsFlbEbskA
X-Received: by 2002:ac2:4c56:0:b0:5b0:cce:da00 with SMTP id
 2adb3069b0e04-5b472aca93amr850611e87.1.1787037165986; Tue, 18 Aug 2026
 00:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bcdd72e1-707c-4bcd-94cc-572ba781d00a@gmail.com>
In-Reply-To: <bcdd72e1-707c-4bcd-94cc-572ba781d00a@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 18 Aug 2026 16:12:33 +0900
X-Gm-Features: AcwNN1XQfIKK01f2J6RmUy0trYeJsiIHDe-RZbhP5DvCuYoWb7uPcUEOM0_MOlA
Message-ID: <CANFS6bYX=6nSiqyUAq+51ujL+YodOkTpY_aD5aTQB4b9RcN9hA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: prevent out-of-bounds write from a corrupt runlist
To: Dennis Tighe <dennis.tighe@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dennis,

2026=EB=85=84 8=EC=9B=94 15=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 3:41, D=
ennis Tighe <dennis.tighe@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> For the cluster bitmap ($Bitmap), __ntfs_bitmap_set_bits_in_run() uses a
> cluster number as an index into vol->lcn_empty_bits_per_page[] via
> ntfs_set_lcn_empty_bits(), with no upper bound on the index.  On the
> deallocation path that cluster number is read from an on-disk runlist, so=
 a
> corrupted runlist naming a cluster beyond the end of the volume writes pa=
st
> the end of the array into adjacent memory when a file is freed.
>
> Reject cluster ranges outside the volume before updating the array,
> mirroring the nr_clusters check already used in ntfs_trim_fs().
>
> Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator=
")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
> ---
>   fs/ntfs/bitmap.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
> index b1436b3..fb65bce 100644
> --- a/fs/ntfs/bitmap.c
> +++ b/fs/ntfs/bitmap.c
> @@ -138,6 +138,21 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi,
> const s64 start_bit,
>       if (start_bit < 0 || cnt < 0 || value > 1)
>           return -EINVAL;
>
> +    /*
> +     * For $Bitmap, @start_bit is a cluster number that comes from an
> +     * on-disk runlist on the free path.  A corrupt runlist can name a
> +     * cluster past the end of the volume and index
> +     * vol->lcn_empty_bits_per_page[] out of bounds below, so reject it.
> +     */

The runlist corruption is already rejected by
the preceding commit.

https://lore.kernel.org/all/20260811021548.15328-1-zenghongling@kylinos.cn/

> +    if (ni->mft_no =3D=3D FILE_Bitmap &&
> +        (start_bit >=3D vol->nr_clusters || cnt > vol->nr_clusters -
> start_bit)) {
> +        ntfs_error(vi->i_sb,
> +               "Cluster range (0x%llx+0x%llx) outside volume 0x%llx;
> corrupt runlist.",
> +               (unsigned long long)start_bit, (unsigned long long)cnt,
> +               (unsigned long long)vol->nr_clusters);
> +        return -EIO;
> +    }
> +
>       /*
>        * Calculate the indices for the pages containing the first and las=
t
>        * bits, i.e. @start_bit and @start_bit + @cnt - 1, respectively.
> --
> 2.47.3
>


--=20
Thanks,
Hyunchul
