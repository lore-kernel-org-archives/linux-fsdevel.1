Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A758C3E7BAF
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543764; cv=pass; b=HO4fpGSVU11J4FM01A4VPUKjmnEhYBoTmE50Af4vLnPGH/5RyLGUpECetTVod534IbW29WWU5ABMwrhnDWp+dDxe29tWemuSs8IBPA4P3uY4X35Hi2ZFnGctd8RmZboBQbXZvglIlV6jTxcve7pO7ZMB33jkjVyACY+PeSxykrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543764; c=relaxed/simple;
	bh=Q9VW6dWLsKZN9qsm4oRde88bufG6z6b2KVMtuc1sieo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NksQCUohw6TIvlj47Ut69HNPdt+6aQAko3jdlM8cVgx81djVzoXvGCVIudsU8Bcq8Npx/l7WRTev7ua32l4bgrJIeJrOWnO+mn3Meg2diP//hoR53rE3T8UCk65nnDtMoPBbDv9Hlh6onjWeOvEmagERASyxjubnwCjwhumhgrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6YI35d4; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6YI35d4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47de0093c42so1168375f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 13:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783543761; cv=none;
        d=google.com; s=arc-20260327;
        b=ZGv97Sg2/EnajrRbDbQ8uShfhmB1Oh986hiHn1G/Lilkcaxj6PCZAisEk/kjwxRgLK
         FpHbsqYr6ZvhbtOTgGR63XwC4gRA6EqA3ZMhWv3e2LwAEQzRxFpq/sPzU/s0paRT/2gu
         v93Eajbe5dNl30qxKr4FGSeMTElJCpTX6TynLk5iXXLtsxMNi7444OnhbJQTq7HakIxY
         M/ljRo6hfppld4XIRgJ9rAkvGp/gIvxFLhCkqkEFCI8R3NcKgnwu7FUkLNCvCPE8GiWF
         t2nAOe6eprp8T9TQrLZzsSt9Oaj1m7rJAbdaeBn2vJzK1CyL8R5RRp8kq3bbevsENWk5
         9WQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q9VW6dWLsKZN9qsm4oRde88bufG6z6b2KVMtuc1sieo=;
        fh=eCeO4M8zAu/UcelLyMyohtWAeIIW0CxDnKeNlbHeLvg=;
        b=ExA3gJjdIgZzR50nSdnpQbXo4UJ0v1DJ92xUIieWrXMsPY03kfsb5zHN4q0bWsj4Gi
         iPlfGO6zm8nf6oBNfb6OQLBEBgBuRPk47V3NToCm0WSdY8R2QKJwWMtvmj1ADHl9jAyI
         5Pn3LVr2HHclWVQDL6Jw2pGuBfvbOn8PB8bB3EY79gAFT31jDE6VzBkcfb4sko0xdWY6
         55y+TbzGU66BmW5hWtiP+imjJWYwRicooo3FkUG+N8wKSchabkJd/efWw3EBlELuCd2e
         NE2o2jyP0INyMSRUnvD7d4XUnILbtdXsYsCyLEvUuHtm9ey4Y8QWt7L4PyiO5PJc/j3C
         +46Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783543761; x=1784148561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q9VW6dWLsKZN9qsm4oRde88bufG6z6b2KVMtuc1sieo=;
        b=J6YI35d4A591y/l9NV+Z0NQvnoPUQbpRN8Whh9nwKsuE5uIsFRhwicE5lsSaX9SW+E
         Di+WL2TwrbqJ/0H7Nr5HJnC/3YMrSeXN/ygtovw2u7gMqtdOCmkfpLvrYv/ROXE8w4cE
         QpkTY6N5Xi4BScXm6jseBFnoOZMDjOW5nCqANjxyyrPi3V3fRHUp6Puso7TfhsIwe9vO
         MOR6wrS3qy0zcvJ3yxZ0DJG2NgX40A1doEjW60MlFFLm728bTAwC5MuTROKaxYGHP0Lf
         3lDH3c9jWHE+fWaYLIttP0mHGLmT0UV72dftoUNPsN0759LG/3yRdb/5C4g9XjDJUWZV
         SAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783543761; x=1784148561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q9VW6dWLsKZN9qsm4oRde88bufG6z6b2KVMtuc1sieo=;
        b=obs9C2LBGq3YxogqDbvYdYpvObMXKlyv9t5BJiAZZmtOCIrUsOnbtvJP4jXC+5+Bbg
         PHczZoLgzBMPh1EiqqFx4a5ifjtb7PQiAop9cLgp48jilj+BJeT5DdLqyOX5zWdccY8w
         Sn36hrKs67IQV1jkvd74ztymUpXv9iX0bW39KG3Fdn6Kyyu56jdafHXTEwdgLl5W54gS
         pxUFhYC0I+XfzCAcgNZ7k8fXWWzvajbbfP7aIGu1N9gEQRHUgeZ0lM8iVmfGnSTxOkKz
         4TZ6qepYYgJ9tZTa6DQ1d1YIr+WsfjXElRGOS2u2ffiv+UVBPK1k4xDMHmrfWKB1IfsW
         rJhA==
X-Gm-Message-State: AOJu0YwaBhHNm5v1hdV1fNR38AOvKkLzNndC0GiPNUIiWANmndPvv4BK
	zyC2ERhVvqlenb9yKv7zVUZWpkqVUO7iV+T9RvQwsbkrwpHByqhYD9Kvt5kS7ZrLAV/1FGyjgZa
	QC64eFapmk802n8rHhNg8d043YmRxN5s=
X-Gm-Gg: AfdE7cmTdQSMmyO69/+k1baGBmpqe66ufpt4wHe0Q0vk/IeC7L13KtEI8+dUDBXFKPB
	WtO1taXP5tL5u4qr3QgDlHFNtFZXuX3h5s+nitSEU+5lebQtSqTgiwoig2CdsB/R+jwfglmLPRX
	NcOES195Lz9LUJL+pTR4AgCdXTZ0TOCGZzDdC+xrjJsQLpewYkPWWTBl03+L+gooZ1ybdHAj4W8
	F1V/oRtASxhiXOvrMGyOv0/k51k14WjK3mMSeYmclXvTBQ/zIcc/9Ak8ONIMSCEm6ZWddJphigc
	3Z7J9yOe6W+8x87DynDhk+W97CvWUPbU0pCeuChq98VlhnfrpezRKb5NXlv2cj8=
X-Received: by 2002:a5d:5f46:0:b0:45e:f439:9def with SMTP id
 ffacd0b85a97d-47df0748abcmr4605746f8f.15.1783543761001; Wed, 08 Jul 2026
 13:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520030357.679687-1-yi.zhang@huaweicloud.com> <20260520030357.679687-6-yi.zhang@huaweicloud.com>
In-Reply-To: <20260520030357.679687-6-yi.zhang@huaweicloud.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 8 Jul 2026 13:49:09 -0700
X-Gm-Features: AUfX_mznUJrD1oBo5FB4GQ9nk03mR1fYO3mPw7ij3a7Di9C6mAcrn22LiWqCwR4
Message-ID: <CAJnrk1Ykp94kZr5tfXrb0j6O=-gLM3vAL0V7ziAxm39oKOmv_g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iomap: add comments for ifs_clear/set_range_dirty()
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, brauner@kernel.org, djwong@kernel.org, 
	hch@infradead.org, yi.zhang@huawei.com, yizhang089@gmail.com, 
	yangerkun@huawei.com, yukuai@fnnas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 8:15=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.com>=
 wrote:
>
> From: Zhang Yi <yi.zhang@huawei.com>
>
> The range alignment strategy differs between ifs_clear_range_dirty() and
> ifs_set_range_dirty(). The former rounds inwards to clear only
> fully-covered blocks, while the latter rounds outwards to mark any
> partially-touched block as dirty. Add comments to document this
> asymmetry in block range calculation.
>
> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
