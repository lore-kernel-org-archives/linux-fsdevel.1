Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC22DC78C
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 21:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165112; cv=pass; b=cfx17+aBUASKKIEadiz7N8fRss0ipO/HpxmFPsmDlraU7RMrimR1y7wHDAYDb8rLoZ9VNDxr+PFxHqBPAr780k4uzFfcGaC/W5vMyTQqAHqS/tAZbKoGMnhZd4NpjTBX4hxz3MxDL2MvK82f2/qRvPvAyDauhfwqG21Vpn9FnqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165112; c=relaxed/simple;
	bh=FpmQubblAsQpoxOUF1z2VQCYrco/qUz7f/N3cTh1srM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogwma267f3TEbKoyOOYZR8r3jUdmmLg8MSfR8NWW+0IhYZyTPUdARJ3l42LMos11iisPuZ7w9HJM9fYFQEisOR3gBXU7aE6v8/l0dfmXkevpitQHHweZkrnf/lVpNXejC73GIGPmNAOIvVoO+3Ynds9kXQ1qrQ2P4pL+1OPYAWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cv82m+W2; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv82m+W2"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4624c1409c9so3610273f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 14:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782165109; cv=none;
        d=google.com; s=arc-20240605;
        b=JxwLz7WO+Fu0WfMH1RKJaQTsGrr4FEQV3jRTE4rKRd1PK3NqyG3BqQWRvsGFnq2p9z
         lNUFc4kTZn8zIyfxKfm/VfJViAFoLQb0fHoOtVON+fpcuQRI+wTPhF4kReyZxQDyPkkj
         FW1PU8+BcCQSxRxPUWmjKqotMDt0+JpDicpauI3I91xkvTXWFX75hsNn9Q1LsLjrTK55
         D3Kubu0AZkaqBN1wFP57ACsEyfPQJfFUkqrzajk0JKB2MXb9dS/mZhhYrdjHNafQQpZd
         edZub1PN43dwK1YrnibKMxqrFSgBqX0+1x0pF4/IQhX97YVyO+bPsE/wElHMw1uUueii
         tHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xjEUxqC8qO1qlPJz0zZDAHSSpl23PeHKm/vTJBwS5AQ=;
        fh=6vxItvfL5caB6E9AYm+WnBGyxaa9NrTlWKhcz/I+1gI=;
        b=lNghxSlHCVeS/1epKBUle4EKGlzubQHY+xr20+d3JfXHv2p8Ar5IcXp90k8i8MAVs+
         0VfescgrSh36+bF1aJ+roR7DbxVqA9Ywf2tIQDKve7sDuYHn/NqEXZ6WvSZxvkRvKOYn
         jR/a6mj3zzQ3JdO0LNAv5A9Tle87Sg7VHrZqO7wcajrSqp3063th7N332eDbfc3d+Riy
         cS8YN5o/jHVb0QR/K+g4ntVG3S7xJ8/9cDHwOJzj52fF8QjWQod2gRxSPHVnbLKUcpcE
         ru/wI3nBUqUJC9BvbCYNheQbg1w+HYWoMOoclGzu+vx8vXHB9wz8OO7xq+Mzbc5IBalX
         rs0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782165109; x=1782769909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjEUxqC8qO1qlPJz0zZDAHSSpl23PeHKm/vTJBwS5AQ=;
        b=cv82m+W2uCvu1e8WbUbpgxrwU8cMGO4yzCec491jN77039Apc2iRdB7yyUB7aSXehr
         RHrWVqrrW9M5TLTdeUeB1ysLnPsfFtL5j8iBoBgCEQywG/Enovv24ExVNHJSsuW/7VFt
         wgzsYbtDR0S0Fy+u27THSEOnVUWhOCb1KD9cPOAlhguoGMrtacS0lpxjxbTmpjDrSipr
         wq3CdSwCopnIGZiZE5rNhnjr4E9GyPxjWSa4MGwvt7GVCGd250g1KOGhcm8GP78fRg62
         qPwRxfKTynujuU9kVZzzCQOSZX/TOuoRKvwJiAxf/jwR9JiewU3iiV+HdNT6JDq3jb+Z
         tD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782165109; x=1782769909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xjEUxqC8qO1qlPJz0zZDAHSSpl23PeHKm/vTJBwS5AQ=;
        b=p5VR5L+BmeM5RmdShVhAMfb8BPDTngepRrmUW4L2SGOXdupkBQGiWnwxq3F6WcSwmA
         4A84HRIHi7qcKciG7YywhuJPrebpqRSxlnupKl4yMykuj2ggM61r06oC7pGEMYjzjEAY
         87N5ihoLhQekq+c1wASrH6oJv7I4Lbn1IRQzb6Hnij9wjIZEpbCEplDKzwg7Xe/zot7X
         T5pRJNSgUdHBDhzfrf+GrEsGB1R0O+81zq8g2YZEZIhT9KRYljG+tXsYZ/fve1/qvY9V
         IaWZNNuVRhNX76H+2oJxZ9Au+YF5VYjl8UpuaVLb8fBu8lfsSPBo12kEeVZ69Gfvj9ck
         mKnw==
X-Forwarded-Encrypted: i=1; AFNElJ/U5qGbHFc7xQMI5gnNy5amiE2p+HAWoGFskC7qXBB1eR4cQAdaWF35/oS/BnTkeMZe0dYB9hOyY39IABlm@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxjJyjJW2OLbe1HHwBOhO/FcrwgWyaRLd3vmyvtBWNg+2Ur9l
	tgIPEIQJPGFY+XzWx1TdPP0JkeqSJ0p2gEYNV+THWI1docgJ4pO95CVlUdMg7s4eI/pqd7N/kxK
	deUN6ENOPbX3dJpiuRWZEdFlfJY6E+bQ=
X-Gm-Gg: AfdE7cnkoHgpABQUAY75syxaBVEDF4Q/wx1hE9GI2NxeOicVk7bmgM0V2Qg1i0OBUcb
	B4a4mmuSKw7G9NuDoaPbzWAPxOTlXvzZhK5VdGoC+R/PybRu6mKBeLtcrvUB4/OtM2Gd+p9Xcxp
	sP8K1BaxfCG03qGxEYTkQZbXqKTDOoGn7EWWQWLLOdr2434MsuC9baPQMjew9tH8dwD4X1jP1xU
	2x1Mrfx7tNMsMOgg/vYQd/hc8jhF+QiyfvLbW+xph6KfqjdvOHYN+Gs3U978IPr/gv+TtA3Gms2
	++prKIE9vic2jFp6ZGn/aBmNN68mmQ65aTRea8MF+8DRX1fZvG6M
X-Received: by 2002:a05:600c:3f14:b0:490:b446:fb8 with SMTP id
 5b1f17b1804b1-4924908ac6cmr166056525e9.11.1782165109012; Mon, 22 Jun 2026
 14:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619050105.439956-1-hch@lst.de> <20260619050105.439956-2-hch@lst.de>
In-Reply-To: <20260619050105.439956-2-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 22 Jun 2026 14:51:36 -0700
X-Gm-Features: AVVi8CevIgfNYxQYNyFNPu8nm9hh_BhFChXmfrfRf0pPdEn4KUuqrVDih803y8Q
Message-ID: <CAJnrk1ad7Wxr9CB4P1=VZPUS_BRmHTTmRVXVgRjM628iFCZh0w@mail.gmail.com>
Subject: Re: [PATCH] iomap: submit read bio after each extent
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Kelu Ye <yekelu1@huawei.com>, 
	Yifan Zhao <zhaoyifan28@huawei.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 10:01=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Currently the iomap buffered read path tries to build up read context
> (i.e. bios for the typical block based case) over multiple iomaps as
> long as the sector matches.  This does not take into account files
> that can map to multiple different devices.  While this could be fixed
> by a bdev check in iomap_bio_read_folio_range, the building up of I/O
> over iomaps actually was a problem for the not yet merged ext2 iomap
> port, as that does want to send out I/O at the end of an indirect
> block mapped range.
>
> So instead of adding more checks move over to a model where a bio
> only spans a single iomap.  File systems can still create iomap
> that span more than an extent if they want to build larger I/O.
>
> Reported-by: Kelu Ye <yekelu1@huawei.com>
> Reported-by: Yifan Zhao <zhaoyifan28@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8d4806dc46d4..7449cfd995d5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -524,6 +524,14 @@ static void iomap_read_end(struct folio *folio, size=
_t bytes_submitted)
>         }
>  }
>
> +static void iomap_read_submit(struct iomap_iter *iter,
> +               struct iomap_read_folio_ctx *ctx)
> +{
> +       if (ctx->read_ctx && ctx->ops->submit_read)
> +               ctx->ops->submit_read(iter, ctx);
> +       ctx->read_ctx =3D NULL;

Does it make sense to move this line to the bio submit_read callback
instead of unconditionally clearing it here? If we clear it here, I
think this makes read_ctx only able to hold per-mapping state instead
of also being able to hold persistent state across mappings. fuse
currently uses read_ctx to hold per-request state (though this patch
wouldn't break anything since fuse only ever returns one mapping
covering the whole request).

Thanks,
Joanne
