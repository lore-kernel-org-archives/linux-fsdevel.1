Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3F3DDAEB
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124759; cv=pass; b=F92TQVN7MF4Zvkv94AYaZh7vgg/TiLnpCI5XKM3E0wIDSyz6i/7+m0DGp1IOIXHBJIPWo7lSIfYbTu4YUyHsrmuosWRH5insNLvqCBtNvjHU/Qf8R94FXhk6jsChFc0uuqc8mGD27wqv0YzXB0BbE36WTo2//G87hzZVS4mAFbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124759; c=relaxed/simple;
	bh=kbPZdMmjRiUw9kQlr5YRraRVLhAIcOMWOiFdZR67d5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3NV0ZJJhxWXupkSWLXIJhPC2nWxaZ/Zxc2c6DeHfY6bSYLa1xs47PFG4nHJvIGWEX1ATqiLr2aewTHG+tZM5ppDO6B9ucxRR7eOylWf+8OQdA3bwH5xJFnHfMAdNdyzAujGCN+PJxWRFa1wSwHPiQVzg1ocbkH4qRxj6eU93Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csypwvah; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csypwvah"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b021916bd3so1028444e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 00:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787124756; cv=none;
        d=google.com; s=arc-20260327;
        b=M/cESvhmBB6nPGdyHPd9m/Y7foilSeXFmnJ5b8wYali+kL76nV996gggpHHIqsw7Rh
         infU/1wvWlk90t/FiqAcmvZTFQpZE1P43Jtv5pxL5uoboMu8ZAd1MaVTtyXuHvYFn/hQ
         gUu9DJWBs7JWu8S1tyE+XG99hPjOkhv65iLU7v/L6jFlkAuVamV60QVHpeTIEbguK9E8
         o7DlCx2MAv+jkTsnzgPVoSHakc5sTJ7jMJLBqFhPjiIU2ub3jzhTL3Uw8KGrimpt0WPt
         kJyV6SPOZe80VrLEXiuhs3ONj/Wom9i51xzymUL4Q9DbTEFBh0ywsMdV9sxe5mHfTwKY
         UbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kbPZdMmjRiUw9kQlr5YRraRVLhAIcOMWOiFdZR67d5c=;
        fh=lxBnm4ElkJp56hpZpGoPobvMGIKEuPsCDFYvA49nsOg=;
        b=pDSC1hOjxf1GmCnbBRIO83wH6+8LdCYtgBgVIrZp02Yufd2dOSJ9/SnTWwfBmJPo+m
         iAXoxr8yUAXpkf1iAmG8Y9pr2K9keiyJcAj2Xcgvl+Aro0CKIF2ER/VTE61Hqfe6HuFg
         AWajbrB/XX16dvabi76/a25NF4tQvl9hkuLch+H0EZ/F7wQ5dfpHl88RYzpkxDEYzA/R
         9AFahK/0GMHvmSvs0DHLEJiGwXp9n4mbbpmKAw483AQM1842h+4Ekhe2FJ99VHi3FQJ+
         bb0xkGcwFTQWwWdQoKLPGHsVrSBDmtF6c1CD95kZlxhpTrykw74Dkf3UR+piN0Nr3fuR
         Fl2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787124756; x=1787729556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kbPZdMmjRiUw9kQlr5YRraRVLhAIcOMWOiFdZR67d5c=;
        b=csypwvahxSyoUK0DIfFJaLCV0zBT0ZxLCxtakXVPLSTi5QNMzQZy7S+BB0kgjaISm7
         FBR0ajTnd/uX1LXl4MXOx0XDrB3ozyOzMaumS/F657hJAgfIAX2Yp5Tlu68+nOwnf4CA
         GkfBnQzr4vPBbaGU4PfeNx31yRULL7N9IjYPIQRHsjRtpjQixvvo/voYfoxR3x/f++J4
         x8EMdIluZtY8d1L917w83FlNWhjc52wnVwwkIOuWHQzWKy9phFHxkfV2a53dOoBpaXDA
         sknO+/ySVkMLIP/dugdlsVYJQ8E8kBUURjLdWYl90vDvIlLf3ZvqWaR+at9kz0Iw3dbT
         V3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787124756; x=1787729556;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kbPZdMmjRiUw9kQlr5YRraRVLhAIcOMWOiFdZR67d5c=;
        b=MA/curJ9UhO1RxmHQWmiu6ciKB8yF/PnPP+bwpxc386jLVy6DZHygG5cnD2PzbfAt/
         EIVULRCX9GXBbHd30g3zHq76gzd6fxJGzqwAH8E2Uyv3xelOSf/B3zLEJjBPejgKvFFe
         UJFXWQcT9/cXNpWGXhUNWrzCSppOAW+9MbytvAc4xY44RSrnJrUg0McYV6/2WrMqMrW5
         7fN+gYXb8pG21Ft4GP9vfjQHRNax3GFYn3hh8TWgHn1PiCYMwZqoJFhLa5MV21duuM5E
         0q0n44fOBQcLut/jon63FOREYhrjCJ4em9+cLkqPHsMius6DhbvpFg89nAgpyHQJ36EF
         uB5w==
X-Forwarded-Encrypted: i=1; AHgh+RqzXI4yBPEwaEzlCgwsaTr0s6S3lV8lsCGl97G4iKDZVaognq3fRQ3vX4V0rvbL8qzipzx/FDIuqNO+sB6k@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1on1zzGGF9uHtULwN8xrGvUAMG3Pg/dy75QscAzC4Z0diKNg6
	Eirz1gAS2PB9kvXII9EVr0cZjkIvsWDiCbYEHoEu4yV1ZDJGAB5Nun704R/M7f/sdOCb4tpC8mv
	ZQreE6OeJsLPBCJd/8ePtz1B8i8aRjBo=
X-Gm-Gg: AR+sD10L6lUbh8Fpva+qa4AgWHS5QUt4ObvS3TkoiOUlzxgpVxhx2DQxiX4h9OOx4D0
	Ipbt7x/lsoTfmx42owyEM2KvePxB8JZcyL0SFM3JK2qljXeqbFVqO/jb6X56LCvwgY6acG8dV5m
	Ijy6v/wAXpX9XLH0ESs7+tEmArW5u9K27hDdsfK9yDXUcfund2H332l66D4N5U4Kib1BZtKu4G+
	LmWfd4VJrv8sJ/uJ4X8QzIA+gkiG8ByX6WqDjjCq7JHK5br2XW4uXtO42flgW6TLdN1dRINREKi
	FoIiJagEngO9na89hugVoLNvUkNrobIQGwGcA/O4EzdB
X-Received: by 2002:a05:6512:1389:b0:5b2:a967:c0bf with SMTP id
 2adb3069b0e04-5b478b71daemr796477e87.10.1787124755518; Wed, 19 Aug 2026
 00:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818082740.498458-1-liubaolin12138@163.com>
In-Reply-To: <20260818082740.498458-1-liubaolin12138@163.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Wed, 19 Aug 2026 16:32:24 +0900
X-Gm-Features: AcwNN1WEkfsb1GN023q2QQh1bdvDxG_Mam_Tp3fggaD-rOX3nw_j8HdMpxInark
Message-ID: <CANFS6bbzESHvokdHamis_xtO=O7icTEsu_vpSsK7M+9uG9LTHA@mail.gmail.com>
Subject: Re: [PATCH v1 v1] ntfs: do not update ctime when setxattr fails
To: Baolin Liu <liubaolin12138@163.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liubaolin12138@gmail.com, 
	Baolin Liu <liubaolin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baolin,

2026=EB=85=84 8=EC=9B=94 18=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 5:28, B=
aolin Liu <liubaolin12138@163.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Baolin Liu <liubaolin@kylinos.cn>
>
> ntfs_setxattr() updates ctime and marks the inode dirty even when
> the operation fails. A failed setxattr(2) must not change file
> metadata.
>
> Update ctime only on success.
>
> Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

--=20
Thanks,
Hyunchul
