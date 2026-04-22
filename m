Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCEA29D26E
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843771; cv=pass; b=LCAMaV1Q1r6zmabNrXoUm7fq3RlFpHQFriFC+blrpcZQ7/0VGpJMfOg6cMp6/EqHlnOvo/iAya8SFbxIkjgdo3xq2mDMWqRZM1q/yPf+6KoLpxTUphykSxfz9xNpkYDswF6iJQCg8fyi21zHbmzJEUjoyFo5XFBHGp7twl4L5dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843771; c=relaxed/simple;
	bh=vF7GFQjFiLQixPDnP5Oed+7TTmdjzfIGex6cBPqoVjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvHutTiArpbHPu8X9TwK5M5Z2EcT5MoS1yGwcIgwYRTF6LVoDZ9n5nIN1jDVszsR8K0+uHseY5vReOAddUx/U7Abm8Pwx4KgeSonzntNnv1L1ZPcDSiaGxGJ2TnXZBHmEJcyXcLPnUMeHOzeOrYBuAQi/w5dvGoGl1uf84n1l1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfiuHZ8h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddVENzxx; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfiuHZ8h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddVENzxx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776843769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R7pqyOAjUCUgv3uLiehuAJiB25itYZP57ABnNLwlQcg=;
	b=FfiuHZ8hroVl/7xg7HIRncUoVdgH/HJ2Sq9lCQnKMtsxzzi53bPvZcWDbe4Z4VSf9WJwkx
	v4kfGWig+qOvnTJ7wXI8o059FQy96zf+afBwEBofRmHLf7WbJRLHJIshje2CgiOUZC1jud
	Akieg0evBpu5pdUScqQwJYVzx0bIn7M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-3mCx1H6bNWS3z1DnIwu67A-1; Wed, 22 Apr 2026 03:42:48 -0400
X-MC-Unique: 3mCx1H6bNWS3z1DnIwu67A-1
X-Mimecast-MFC-AGG-ID: 3mCx1H6bNWS3z1DnIwu67A_1776843767
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ba7eadca2f1so213483866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 00:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776843767; cv=none;
        d=google.com; s=arc-20240605;
        b=i6jk9QAD73PE7HggRNw7cW2cRo3/8k2E2Q+OBkc+tDOAqgTJyQTwBx8D1A29x7Qori
         g3bHXGzoswQ9c00qLrW6xgRO6r9s4gn4l/VRf9zR0AvRNMg70uWttWAFHjLmrJelV2sz
         KDUmpxMcvsQ+UVWnhWAzjKtCHpgAnyEOGy0Luib6m8R8y9tnFCIGFzn7aIDXMTwN3PLS
         H57nvY/Dl28aE7mzPX3OeRHlvSCdWfTzdR1W+APbbyGeTIr+nytFI/kUL8NcYnbWPXNF
         rREpf8sv1s86TB5xWaLLRkTSb0AfBe8A5ZOY1U5y1roAVq+DrKs3P6aIFeq/uVvts+2X
         ZAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R7pqyOAjUCUgv3uLiehuAJiB25itYZP57ABnNLwlQcg=;
        fh=sdOms8qvMH23ar21FsJt0poJ5ahLFmwtxdStC+a5FYQ=;
        b=JXy3CkVrpUmtgIFGcQU9HVkKWY9dPgJqx4t75y0UEuiw2CaEZEOaYJjiTGjOP0UUFZ
         Q6QFG+Q2JuPklZL2JLQEki9EUIYdMwmY1ybrJNW7qN+I7NR4Ot1OT20PiuoFA31cUBPr
         qzg6adc7yHak8s+CNXdqVGpeCmxgxGkTdw6Qr3xEAJQ9XwhfJ2NeiKCI2Z6HRT1efKyq
         DwmVPTHzO7qSZATbeah5e2dmhH9DeJ+k+fxEJHmt7gy/lsBgBZ5LF/BDzC3jnseV6c31
         3JgG+YQ2iGg1n/zJd5NVbp7tNTMHgbk7NcdZrWsMrkNYNv8K0nvROingoRuQRGnHwZMc
         1Hlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776843767; x=1777448567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7pqyOAjUCUgv3uLiehuAJiB25itYZP57ABnNLwlQcg=;
        b=ddVENzxxGxYbqxcxIgSTm2xCQNjhOvRNCBnpUjSlbCr6zjbATCfmTUDhS5szHSSJw5
         m3V7Z3M5Y1tyOjIhazJSbwtRzJTH3EgE1Lk29ZoyVnEmixWp9oaLedrYfETAHpzFl644
         txJBwyWtcI54D87d7Anu80lii/Qb732xDrC8Jy5tO6Y1FH41KxirLwXl89YBhJSvPiIg
         hfjYxh1qRpVFtgP1RR1/hbKzDM9NIVEbx5AOP8tsurxfcDY3IR18csEA3EdT71vPWIl6
         Z+1H5WLjZ/Wd4AyjQUo5wPRQQOdnyQl5b0w4VfHvgFeLweuUvTxI665cUwI6mbrFHInq
         +4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776843767; x=1777448567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7pqyOAjUCUgv3uLiehuAJiB25itYZP57ABnNLwlQcg=;
        b=cpOsiBiCkC90i2V0IVBVDpb2qFELufgz9ABFVep3dz7C4fq+UUd5cg3L07kypP7OCc
         MP6E8RZTEqcBc/Ham9KU6EoLgwa++MYJy1zcN/IVxs+L+vcBdXNos+woJa1T7MCQrYYY
         M3OMkqlGloN99wIOjf7hoJwZ+l9XnlpZZSxHQkj2No3PLKZAqV6C3SgHN1xD6ZyW0ocO
         /imqrXw2dgBiX74wbFobGbKItVX3+12Mzy7vbkZdocBPEs0lCnGkCEN1CLtyB35DElVU
         V8Lg460XFJX5cXPcmRz4agLGNR44Yk9WNaNDhPtDXahpm9ikNOmWKJbDgo0/N3SUIBTL
         UPAA==
X-Forwarded-Encrypted: i=1; AFNElJ9xR79Ye1p2Wl2Df6Rf1kSQccYOjM9ecKhre7zBPoDWBRwmhQwU18ch3yMmcQn8RTWwPBQ3oY3c4i4+Az94@vger.kernel.org
X-Gm-Message-State: AOJu0YyP7t8+EhPZqLmK2JnAcaDcGaPSUTrMC1MfqD3LLIgLTBun4sQd
	ztb/gQwodINcWNZ4CTyiEfUjxo/0p0qlLqo5Oo0D+XLhzrEEx7yHQLiqBrtVFc/hFhlkCLIDdhz
	uvNQrRo40O9Xb3h1hGJIx9yi0+QB+AEsFYNZHbXa19W6kzBMsMG/d3rcetKtk27M+U2wNSy9zTt
	erJhSo70cfcpkj/kOc3MO61IEtL846+L2N+ONE7/1ETg==
X-Gm-Gg: AeBDietVzM92OLjW49jL9pkesLwGf2eE4hkluK4ijRgrHrE31NpFCOdsl8QW5OQjLIG
	DoppyZZWRIh7mD5ARsZirE0fzfgifxlxrS7tBLuaMGzz9InT+WHMffXVuKBR/gI0ji4m1sK48Ql
	g4TdHycl7/f5eoMeNSw1YM3jp4y8WrhKQX1GLk3m1iWNyaWMGkV7An0bDLGism3Els4ygYcIMDD
	mLrB3kDybV17YV3+yHsLz0qLEhlkNDkJbT/cjyoLkM1tJzzYQ==
X-Received: by 2002:a17:907:2d9f:b0:bab:9151:62a1 with SMTP id a640c23a62f3a-bab91516324mr5609866b.23.1776843766830;
        Wed, 22 Apr 2026 00:42:46 -0700 (PDT)
X-Received: by 2002:a17:907:2d9f:b0:bab:9151:62a1 with SMTP id
 a640c23a62f3a-bab91516324mr5607666b.23.1776843766284; Wed, 22 Apr 2026
 00:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeBv_xvDTmuzEhV1@infradead.org> <20260420100637.3584-1-ravising@redhat.com>
 <aehqUzvOHUoyLqvc@infradead.org>
In-Reply-To: <aehqUzvOHUoyLqvc@infradead.org>
From: Ravi Singh <ravising@redhat.com>
Date: Wed, 22 Apr 2026 13:12:34 +0530
X-Gm-Features: AQROBzAP74E-Qp-aIgk3t7Xdv4nHz2B53Q0bjR2_vTiec7DIITxhSJ5YPw7woRw
Message-ID: <CAF-d4OvKr103QWZDwN-d2jdgZN9KpO7E5UOHo30zwP3in3vZZQ@mail.gmail.com>
Subject: Re: [PATCH v2] xfs: flush delalloc blocks on ENOSPC in xfs_trans_alloc_icreate
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	djwong@kernel.org, dchinner@redhat.com, esandeen@redhat.com, cem@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 12:02=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> Note: posting the v2 as a reply is a good way to lose track of it,
> don't do that.
>

Understood, will post v3 as a new thread.


> > + * If the block reservation fails with ENOSPC, flush all delalloc bloc=
ks to
> > + * reclaim space from speculative preallocation and retry.  This is si=
milar to
> > + * the quota retry but targets FS-wide ENOSPC.
>
> Can you move this code to sit above the code that implements the
> logic?  It is much more helpful there than at the top of the file.
>
> Otherwise this looks good.
>
>
Thanks. v3 coming shortly with the comment moved.

Thanks,
Ravi

