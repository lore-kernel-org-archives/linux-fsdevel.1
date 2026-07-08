Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2A3F58F6
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783546222; cv=pass; b=o430PVzbWJv4USyCw2Y1t1SIIvDBYjsAoOchtVNLvgxVU6exHLBLN+VrsCg2iLR4W1iJHp9Npx3yQB1pHdk2iU0xxOxr3UhgZGTszdBp1PUOT1mP4a+mHm7+E3WW1k3LEBmgYArx95BorekFtHQjxeJT8jr1CyO3cMzflKoJudI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783546222; c=relaxed/simple;
	bh=kgvdwCop/aLSvgkbu/K8xvwikDak1ekolcORsUSIrk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1JCqnrjvZxLaihyLU3t4wwtn8TG92If32TcgiekRYsS8MWYhIx7l6l6rShf1SEYHKjFbAJ5T28m8u7CO2J8nQyAQfSXeJNH46CfZDFYnAlAP1s6+RyNFr9OrJ/PNhfX2gqtYXSwEtUssIrDJajiF0bleri12TLNM5EqGOhVHCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJQy0fpJ; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJQy0fpJ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47df43bfb07so225816f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 14:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783546220; cv=none;
        d=google.com; s=arc-20260327;
        b=HepXfgzNXX2P58kgZrtz0U0l5c3j6AZHmPR+SNb2tU7AtCI+7vuPzQeJTxCRKgr6zZ
         kE5gCIs85wYiONJaWZ4M5L3t9prm/osjtwLAsSqpSjeYZL0cBSo8Lrj7TRIrpbU2bKlj
         Cn5Osuj9kmr6ZEZMtEjc7eKXYDBY0ETogEaHCpE8hugWyiTwuOqDeSnxhWJdM7qhTtIL
         aSiJGA0nPwTu1c2DRAcRRtQ2n1itg8Zn6OdDJsJNW5Eta9ffCYXD/4HxZab3c74mXbEB
         19yGA0zOZ54yeAk3TU/Yucyp1773NwQiPwen4tTqiCP6bGHh/nflYUb9MH6GtAa7uVUE
         uizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oysFZq6tAMslUX12xXRG6mkqYiMd4xCFaT2TvkVCwfg=;
        fh=eCeO4M8zAu/UcelLyMyohtWAeIIW0CxDnKeNlbHeLvg=;
        b=JW2Hy2nLD54qhaXAAB54q9wOXqNtP/d1/EIdiMmdXA3JTHWBhDc9khDlZ9sYBUYM9k
         QIfPDV9x3HOKL/+10HUY2QzoUcRfxmu5QvXYPBiy+lAlgTAiygQ4wrDbIXiUHecqZl+R
         6+iYkVN2RmWcDKup02g6liM3EOeBfu+/t4wng+PZgQT02Z52LgwQcCuSg31p6xmyejGD
         V6gNYJvLILInOBPudd3fVfT/5G0pggPCz8RtZIWlth6WkyTH5YSb6C4ydoMXJ5VVahRg
         Ipscec8Qma3SFAjpUBkWErR/FPlEKn/riCRg11zblwwrbNmHJDuw39oTdA9Gcv988jWy
         JgrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783546220; x=1784151020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oysFZq6tAMslUX12xXRG6mkqYiMd4xCFaT2TvkVCwfg=;
        b=RJQy0fpJv3jey4oVW3Jth+gMCS0D+qKWsZcVqK3QeSsQ16gmCFNS9CbpLD60E8A3K9
         TR6GMD4UmkmNdFvZaOPUhqUGwikiGSeaCAju2UOUhlbPWVCZVPLnjZPMxBSXi54koZ0F
         2H+qXyoHa9QRiF3yaFUfz0g1NU7tN9rNwXzcIDLuh2QKElrAlPHNL/LWqpY6p/+HyKWS
         AIrIDoqIE6vUo0+XdOw4g1DKMIynTJ3oZ9ud93GyU4yZ1+ig5asjfElCGEFwAh3LMI3N
         m3WEVBmDXtAAcC1nFvf5FzcJRztFbfE/O0sNannv8vHK+RwGLDhGQ9m+DluCnjakM9GY
         Ew5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783546220; x=1784151020;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oysFZq6tAMslUX12xXRG6mkqYiMd4xCFaT2TvkVCwfg=;
        b=aOaqHi5qXebnBo0JSQZtS1C5cfBdd0cXJgZjKC8Nj5n/usrq9m2kQrmvLocXhdxKVY
         zv6vpXg8nCtIV+4mRo1MIP24iHUY7rbiO6Idthh6ioCia0e1qWaZpwJYOBNFNXFxFxJU
         38ho3RZvhHeiR/Ay8g6P+SBezAs5RUX1GdKo99V1kIfT/kyTvHFrel3bdWi0Sl7ym9Zt
         6kb27edwkPw/SadfyfmS/xnEYwv2Ue19nNE1a21Xo9rNexzhYVmynbM5ChDh6ep3av4b
         3bo4YgVzQg6Pld61yfhwFrnMmuu6hcrpFaY0M5gd2DDVugnE3yUpmKZGnkgGhlWJSP53
         NaMQ==
X-Gm-Message-State: AOJu0Ywn6CqRCfA+bGyRQvZWbW/KpqPIv+p5unNYOTot9FT1prHI0egR
	dhEb0Rkd08sent+x3uSQhxxc/bErlcWcJN7cv0rWNkWwUuKeHh7hc4oWx75qaeVGTqEjtFXr61M
	XWNBGq7o7srVWyHJsJnVOukKi9nJLapM=
X-Gm-Gg: AfdE7cn0Ju8DDc+WBXr+ceTb5k+RFnnZeZ6vpVIaetmrjBWB4XwwbVimcvUt1XMUM1B
	qJdTr/eFeNyqjwRFMiBStfylZsxzA86wHOPdMEyzV7L5XQyfChZVkVI2KpeEKrkRjrwDY5hS4g7
	pg4EBmKGwX2fJJob9lGe4hKQb3coT3X4IDfXkVjUjExgvln2X4xuDs7a+METVowvt9tiEsp/6rS
	dK7ofAXBPeDo6EtV1UMNEHccNBVSdKegNcysCc1f3CP78aHaAUJcvld5VPvwiiflw5NGq3bit8X
	1aAm8po6KREgWaEyuwFrS9OBs2QYRQ8op8FX0rh6BKeak+6pt3YS
X-Received: by 2002:a05:6000:1a8d:b0:46e:997e:b4c5 with SMTP id
 ffacd0b85a97d-47df07318ebmr4686335f8f.18.1783546219649; Wed, 08 Jul 2026
 14:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520030357.679687-1-yi.zhang@huaweicloud.com> <20260520030357.679687-3-yi.zhang@huaweicloud.com>
In-Reply-To: <20260520030357.679687-3-yi.zhang@huaweicloud.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 8 Jul 2026 14:30:05 -0700
X-Gm-Features: AUfX_mze2KSMzcr9sNQr-lNuBFUay6tZXCOW1WB9AHVpL4GFldBmQybXidQ8yFw
Message-ID: <CAJnrk1Yeqij31Geuv55Es+si0zRqzCGe-B=hpw_DjT11AsRcTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iomap: support invalidating partial folios
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, brauner@kernel.org, djwong@kernel.org, 
	hch@infradead.org, yi.zhang@huawei.com, yizhang089@gmail.com, 
	yangerkun@huawei.com, yukuai@fnnas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 8:09=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.com>=
 wrote:
>
> From: Zhang Yi <yi.zhang@huawei.com>
>
> Current iomap_invalidate_folio() can only invalidate an entire folio. If
> we truncate a partial folio on a filesystem where the block size is
> smaller than the folio size, it will leave behind dirty bits for the
> truncated or punched blocks. During the write-back process, it will
> attempt to map the invalid hole range. Fortunately, this has not caused
> any real problems so far because the ->writeback_range() function
> corrects the length.
>
> However, the implementation of FALLOC_FL_ZERO_RANGE in ext4 depends on
> the support for invalidating partial folios. When ext4 partially zeroes
> out a dirty and unwritten folio, it does not perform a flush first like
> XFS. Therefore, if the dirty bits of the corresponding area cannot be
> cleared, the zeroed area after writeback remains in the written state
> rather than reverting to the unwritten state. Fix this by supporting
> invalidation of partial folios.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/iomap/buffered-io.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 64351a448a8b..876c2f507f58 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -761,6 +761,8 @@ void iomap_invalidate_folio(struct folio *folio, size=
_t offset, size_t len)
>                 WARN_ON_ONCE(folio_test_writeback(folio));
>                 folio_cancel_dirty(folio);
>                 ifs_free(folio);
> +       } else {
> +               iomap_clear_range_dirty(folio, offset, len);
>         }
>  }
>  EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
> --
> 2.52.0
>
>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
