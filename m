Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1BA37B02A
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037776; cv=pass; b=SeiXkFu+F0LrjoGS3NynbEVY6KyXUG3fXGkTsUCbvr09mgpsC2ISL+TpBegCUemoa/fqQsM7BvPNEvCkkvrn453xvNWjP7KTdZMcllhn5SxFXUhmoP4+PcZ8ibmggeYZj6lkczF5MiZdEFluG1RzZ0/e06a8iubO1FFWXerc3ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037776; c=relaxed/simple;
	bh=FwQhZLzllF7dmgApB52aXXJrH6s0In3T1Z/oUo3wQKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcUqpRYn1JxuVdIDDLoBJ4QA0RstSsbAPaZGX/igrXjj7XLqVZm9C1szwfJ896F/2bVu1/GoFX52MCn4JNCnu7Y5ZS2PqQVfn9H0RPAU4UzYuVXrMuVw2SS2S86XkeDuSc+4thgxnJh2AooROqAFGXI2JVqPddtdl8DpHnrFvvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5qf9uXe; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5qf9uXe"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b4740ec30cso416330e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 00:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787037773; cv=none;
        d=google.com; s=arc-20260327;
        b=OcM3vAzZS921WTtYVOPCe/V39HwfoSF1M45abnO4/3Mub1XSPUaX4+4QHMfJMc7RUw
         2+OrOFzCvwm8b+b2pciojQLGDVbWUhCHW+q9K9tgtuvuSmNhsOrUSvfE3Os77YNvBEN2
         RIUZxymDyWwkvFqCRs0gqoqL8QdYINYkePZkUSPe5qAu1oPIH+95vm5uJCLIEDzp0syF
         VNJd6NL5/YF0p/seLJ0Zh9M4p3rv1xM6BOFrD/AmzwthrqHF1Lg8NVPJ059u/sHi0EJ8
         DVgiP9EuL5h6FEXbHLWIosiytf9yNigfSM8SR049SGW5KfnCcs+0Ivhjj+rgiRNzmA7Z
         Jo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+DQMlPkAFCYQI52uFIjl5+NzLnRwl9JYk/ITeSCHPas=;
        fh=SHXsTrlC2dBzfEDDdtkDl3I6Xg7TvMOwPzTvCeDddMY=;
        b=QWpeyLEfsPw1BZFUTTen1v6sXYLmC5TpyXRJPmnl5Q5880ZCGbg7PJXVxPHbELE42H
         9M4DuhtHP/zc1+Uqv4SSa+YspFVSZUToivT1dxlsozVq0lOWHOCAA7Yaj2h5Ed2uBmWu
         v+7T8i5qEfKBXdo7BFR1b8mQgG/urTfmO4xsDXVFH+jghTNwZRY0QWHK1pDaJ98z0iRI
         EdvHYwBlY7UU7Xxya8phlAovUj73+raLBYlm2pHMMxauU794UTMHf6h8oo+fSnE7ee2K
         C0STMZuOkSh/zAnhb5Fb1/y/qlMHHvjd+nhL4lycqS169D2tdKflAEHU5f4bZ8I/PbOX
         hh/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787037773; x=1787642573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+DQMlPkAFCYQI52uFIjl5+NzLnRwl9JYk/ITeSCHPas=;
        b=R5qf9uXeGZQMczetU9CxgrEX2ioKYNrE8BmmSNQcmdci0TZMy6AJfavdov8yshP9SM
         yNphBxBzVJAP2Ke+4aPB4oPoOyfkcld1RyUxZvf5XyjAgqjmbXizVUTSoBqEqwW9SSJt
         HqRjDNDAgSVdGiFciwQDMgvEzbcmhLT0gBY10QLm2f/UXQFCx9GmLOJejVDwppxRm0aA
         XbQy/ukHcePsw/ZySLeb9bNSQsd77Ch4CMFoR4ZzUqj1xdgVtZXsnzgICVuWMrei4wRD
         c9Uh+AynnCog55P2r/o0avila6P0dhIJY54beIVBqXGabZCXI+Ej0anvScZSvcWBnYke
         kvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787037773; x=1787642573;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+DQMlPkAFCYQI52uFIjl5+NzLnRwl9JYk/ITeSCHPas=;
        b=i/AdI9jCYHuwaV2qBMHwosKrx/6vEzItcYSEXsj4tY5eeGqwOIUGMEWMfJztfpu8xh
         fEqDSbnFlpK5dkfyHFYVbh8UiUF8lzOcvqPpiLj+j8XdYjdxwecBKkqW3VX/NlDrVz+Z
         QAqjmQYFoY/Ck5Y9jYY6vB1qfurm7s7kJRlq3BT5o86Bd4bX8izoypyzc3MzDxdQjK/K
         QGFrEFaR7P0Uk3ppzf2gRsRGQrEP0NTuI73m4e1XBrcNIuReqFM7k0ZFT/KArntLRhBU
         RkEbYzMoXCsD8y0hzThuiWdwOS29rj/wGQr4QjT9C9+EQJkApOPM6LEy1Zcp0w3pLQGN
         IFRw==
X-Forwarded-Encrypted: i=1; AHgh+RoRKOba8Cr54rRFzWVpkzl3wWrlz73yos9dDZ0qQ7icfTmT3/JP7sk5JqWpKcXYdnXT4y49tisORW+nbewM@vger.kernel.org
X-Gm-Message-State: AOJu0YzGmnW404I/P6oO6JAhQTcob5522sZprkiK9Xw+ys2eOl+9y18j
	VdM+Wu0zxQqcAzzQU8gSnaiw45q8hCidEv3r0a7a9mylbG4nltNdSmpr1P3TmmXNOalM4gEcpmy
	Wp5Y/mZ+o/zFwAcSXi+9cdwwZX2G5DUU=
X-Gm-Gg: AR+sD10wREBOroJI+KvT/5pfkffCfMouP4VdhIubhBftq7UKwYTF5tXvEPUOShrYVVT
	BzPEYdLUJqiJavogWbElXlA8gDZxgXyxrNLhbOHa8snERIG8FHf0vdxACY1s9d7/WYtB9d3kQHn
	GsKvmshkIRRylqi+9Pz3l5cmPJy2UKmvEymDx2lF0KOg0y2oATLw1ZCqYIJJoEt2fNIPG6CSXe9
	lQRAbUuWpw48tMIKB/jUuNxjDvfLZy4DfNXEZnVYfi3vh8PpwlGP5PAKxPNXA+A0OZHmZJ+Krmo
	I4WLsRvAC4sXkRkwTE2sO6wAvwKRUVUa/I8BRqo7Ue5AcOfGD0mBsLc=
X-Received: by 2002:a05:6512:a92:b0:5b0:c96:cc8c with SMTP id
 2adb3069b0e04-5b45915bd7fmr4917981e87.12.1787037772906; Tue, 18 Aug 2026
 00:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a01e914-db1f-476b-a371-170e3b179bea@gmail.com>
In-Reply-To: <6a01e914-db1f-476b-a371-170e3b179bea@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 18 Aug 2026 16:22:40 +0900
X-Gm-Features: AcwNN1U2_gJccFkThgxGR3YFSo1dLihrvySNO1Q9AxaQ3FeHDoHzcl6cyJp34Wo
Message-ID: <CANFS6bZyAXG=kphdiq-Lz5+xePW5qvS1SSuGMdoXYvF42f+-sQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix off-by-one page overflow in ntfs_decompress()
To: Dennis Tighe <dennis.tighe@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 8=EC=9B=94 18=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 12:18, =
Dennis Tighe <dennis.tighe@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The per-token range check in ntfs_decompress() uses
>
>      if (cb >=3D cb_sb_end || dp_addr > dp_sb_end)
>          break;
>
> so dp_addr =3D=3D dp_sb_end falls through to the symbol copy
> `*dp_addr++ =3D *cb++`, writing one byte past the destination page. Since
> NTFS_SB_SIZE =3D=3D PAGE_SIZE the destination is a single page, so the by=
te
> lands in the adjacent page, and *dest_ofs is left one past the sub-block
> end (the later `*dest_ofs &=3D ~PAGE_MASK` then yields 1, not 0, so the p=
age
> is never finalized and later sub-blocks keep writing further past it).  A
> corrupted compressed $DATA attribute then produces a bounded run of
> out-of-bounds writes when the file is read.
>
> The fix is to break as soon as dp_addr reaches dp_sb_end; a full
> sub-block still completes, as its final copy advances dp_addr to exactly
> dp_sb_end.
>
> Fixes: 1e9ea7e04472 ("Revert \"fs: Remove NTFS classic\"")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>

This patch looks good to me, but I could not
apply this patch:
  warning: Patch sent with format=3Dflowed; space at
    the end of lines might be lost.

Could you send this patch again?

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
> Reproducer is available on request if needed for validation. I was able t=
o
> craft an imagine that would exercise this scenario leading to KASAN UAF
> errors on read-only mounts.
>
>   fs/ntfs/compress.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> index 76bd806b41e..dc5ad951dc6 100644
> --- a/fs/ntfs/compress.c
> +++ b/fs/ntfs/compress.c
> @@ -352,7 +352,7 @@ static int ntfs_decompress(struct page
> *dest_pages[], int completed_pages[],
>           u8 *dp_back_addr;
>
>           /* Check if we are done / still in range. */
> -        if (cb >=3D cb_sb_end || dp_addr > dp_sb_end)
> +        if (cb >=3D cb_sb_end || dp_addr >=3D dp_sb_end)
>               break;
>
>           /* Determine token type and parse appropriately.*/
> --
> 2.47.3
>
>


--=20
Thanks,
Hyunchul
