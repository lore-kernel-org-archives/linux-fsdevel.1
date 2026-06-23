Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB65388873
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236946; cv=pass; b=LCcgU6Oz7Koy5RC3kVRSrMVJP4Hz4Y9qJmQw+1sZcvocOjiq/zrwkZ1Ic2nWj0qso8pT1nsfGKQaBLG60z0DY/jEici4lEadThfu8bQsMVpPNHuT1k4UgexgCXh9ZT/CfvlegQFEy3a+kxWu5vdV4e2uQA33CWmfhw61aW3+udI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236946; c=relaxed/simple;
	bh=Am0C8/bl64PVJhSl7vSCB5XRQ4+yV8p59Vuevb6WpQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6HVsLpKMmIrrEGI51PXOxCpsJOnvzcXXsilAZmW67ACJlb2wGlvfuS/tS3QkdOi7zT675W7lE5dG3vjJASc57GjCKtpRA/bF/gRdR1/FfHZu3oBV+ATXlK/YDnNPssDdhVINXADEKynxA4RGg1hSaKIVJpdogSo38odePUE0bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLzwcvV/; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLzwcvV/"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso133731f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 10:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782236944; cv=none;
        d=google.com; s=arc-20240605;
        b=Ill2rzR1J7HPK62sChu73QwCKraaXUABY1lIY9lez1O/JRESg5GtRay4D9HdE5sKrh
         DqTEWx8tuFbxrZZRcnXo9X9ExIsVyBwlRC5K9q2CFrKvhouMMNpnArDQNz4PmVQzeCRZ
         cr8kKedB4sOZlNw3pmA1+3sxSLnhLDLGneKi30VjvPnaUk6voedbKBakmHwWt/GL0PrQ
         dqn7J4Gz2NpNgypY+drG1EBL6AQ0F8ypDaktQp1sySo3xzu7nyxTWCaLilkaP+4XvI/5
         otL6EGo4rEyEs/O57/15FCfcPh4MV8iAtBgPCD//n9nijSlqFb+BTc70brnj/+0xwl7D
         MN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ht+ij96XcA95mozwv771qFFzvMVtl9I1uO74pBpkfIQ=;
        fh=3cTlN/SEFa0QW2ElNd9dM5tM+0hkK51w2LrE238aSgw=;
        b=RQ40eQUd60CNYZOHdZdT/uPRlO2Vhu5HqV8m0dZ3ebD0CeAyD7x/OukybvNydUYO/Z
         AViGiT1IP88AsbQZM/gdnSAdEm8o/MonhlrIL8Xs7JmSIpWOgj05csg8bdgn3BLtMTkI
         0brjz3rghr3XOzj+lZi5Mbr2JxHR0WQYYNzLlzm9olIm2jCTrL6pdMYGicHxWvKJlUEx
         jrw8Z6DM5olDC+f0HhYznN/Aqpqdezw0IxpFo8uOS/tx8tGPh5jLiiRACQskINHxPd9W
         uFRhdk11PCLXIL5gJnfM8lrFwdZ8EOYFIBTAxO+LvXeedvt+N7OtZq+j0sFu7o+LJhwN
         yyBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782236944; x=1782841744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht+ij96XcA95mozwv771qFFzvMVtl9I1uO74pBpkfIQ=;
        b=SLzwcvV/8kPeupIEr1rAUYMrZ3urV7TYTdqqDTl5UxLIHvqMQp80gaNJ5w8fUF/mdA
         lmNPCftJ2WtvSnrw7+gwjjX3zHj+wUzI/TeXMBckhO5lAXTHS916r1LUGh1YSZ7fsmFi
         5ZKrHokDEO83poEgedECFlFx3spD3iKTHeZr5qf74E6/h6V6GmxRF4CLKwbnd16R28bs
         u9iEAPCoW50m8ysjyoWWCN/cq6o7jsjaE1umFOj+1iKZV2zK9u7suolIul/4WT6AIS8T
         XkyZ+Bkb4WD462NWUg22KFXpM3GPgxui0/VRT2MrGeUQgoHIb/LxTQ5+esQqwVmqIhlf
         mVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782236944; x=1782841744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ht+ij96XcA95mozwv771qFFzvMVtl9I1uO74pBpkfIQ=;
        b=gZvQk8dIsuRG65cD9sWooANDCpu7466CoRKbulPp+fj+XRh4Zg6r7aCFsySDNqD7Ru
         mSGGQrmW6xAgB45jyLLHjOr0MmgF2aDb42er0M7b3XZxruiye72KtMDvfd4DCftlJPGC
         nieadaO7UAGHhmr0mJOondqf0VtMKdynSie5/dC5jzKGelbJt9MFamdTqpld1EnOdhuK
         p4WPIJYrDGWiXpUtagR9rZ9S1L6Sxm16423M96BkVDr2LMexUOp+2IVaYKiTjC5WBZDy
         J44m84wlQUNLWZbMn7lk2Ihyx6V7HZIgFsq+g8ThlP0+ctC4dDgc5QXT8buCjQQHkH0I
         HqxA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6Q6TjlGgMcIGXkENvq1dKQ10kOwmaPTrjuX/IEEnXGkjRAPPTrnIGpBdByIcRnCxuuRWHLdfs6CD9CEdR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+a3n5ySl++DtafS1pLpLXzzy8KXrTcSyNN3QmyG7hu6KTBGt
	BAq1XOd6DjqHuumdg/At/qSbwuWwIziOQwBQ/Wc+xDyfXVdg/zptGnRUKIRdkCOElYY7GQAWr3I
	EhV4cCaEjy+CQ1eAgejFJexFRSyprvwI=
X-Gm-Gg: AfdE7clOq9doTRsasVmfvA1jNxEpvg0MkF6rf1ZCeLdjlse3jhRHemBtwAGar5QPKJ7
	QWHA9rT3KjDMrFZ2JM8zBzynZEa3NUFN2X+zYn/3kDhkhbi0nVP8VrmRWPKdItwTosoLjnZSnoV
	JJGZRHaArAWg51tfKPRauKPEzJtlhaQJwLiVBRDcR4cncWDRezJxCgDW9d39fIEn7EY7CEeDYyB
	l02FDrxvHE3PK0eB69XEXcHHF7oPLM15BMJ0YUMCxpIpkyIe4QP3RxEPCI+ap2eMGEZUaPX21Oi
	cYC3nDVUZTtMvNssgD1fyU2VuoXm6KdhY6Kfop/SXezMqkuViT/S
X-Received: by 2002:a5d:4d49:0:b0:45e:73b4:85cc with SMTP id
 ffacd0b85a97d-465091bbde1mr24933374f8f.35.1782236943715; Tue, 23 Jun 2026
 10:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623004227.77628-1-jim.harris@nvidia.com>
In-Reply-To: <20260623004227.77628-1-jim.harris@nvidia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 23 Jun 2026 10:48:50 -0700
X-Gm-Features: AVVi8Cfm9kbbCqcjZjNY0-c2laT-z6gmlwGB6uadTiv-xqdtzhz7LXNXFfcOVDA
Message-ID: <CAJnrk1b8Z1An-WMijPkqQWxnEw-oECA8DK2Le17B1pR+p5i_vg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: allow larger read requests by setting bdi->io_pages
To: Jim Harris <jim.harris@nvidia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Sztyber <ksztyber@nvidia.com>, 
	Max Gurtovoy <mgurtovoy@nvidia.com>, Idan Zach <izach@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 5:42=E2=80=AFPM Jim Harris <jim.harris@nvidia.com> =
wrote:
>
> A FUSE server that advertises a large max_pages and max_write (e.g.
> max_pages=3D256, max_write=3D1MB) cannot currently obtain matching
> FUSE_READ request sizes from the kernel.  Buffered sequential writes
> arrive at the server at the negotiated max_write size, but a large
> buffered read() is split into several smaller FUSE_READ requests.
>
> For a buffered read, filemap_get_pages() -> page_cache_sync_ra() sizes
> the read against ractl_max_pages():
>
>         max_pages =3D ractl->ra->ra_pages;
>         if (req_size > max_pages && bdi->io_pages > max_pages)
>                 max_pages =3D min(req_size, bdi->io_pages);
>
> fuse leaves bdi->io_pages at the default VM_READAHEAD_PAGES (128KB), so
> a 1MB read() (req_size =3D 256 pages) is clamped to the readahead window
> (128KB, or 256KB for POSIX_FADV_SEQUENTIAL), producing four 256KB
> FUSE_READ round-trips instead of one.
>
> Set bdi->io_pages to fc->max_pages after feature negotiation.  As the
> code above shows, io_pages only raises the limit when the request size
> already exceeds the readahead window, so it enlarges explicitly
> requested reads without enlarging the speculative readahead window.
> This avoids increasing speculative page-cache readahead on behalf of
> an unprivileged server.  NFS does the same, setting io_pages from
> rpages while leaving ra_pages at the default.
>
> fc->max_pages is already bounded by fc->max_pages_limit (and, for
> virtio-fs, by the virtqueue descriptor count), so io_pages inherits
> the same bound.
>
> Suggested-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Jim Harris <jim.harris@nvidia.com>
> Assisted-by: Cursor:claude-opus-4.8
> ---
> Changes since v1 [1]:
>  - Set bdi->io_pages instead of bdi->ra_pages, per Joanne's review.
>    Raising ra_pages would also enlarge the speculative readahead
>    window for all workloads (including small sequential reads),
>    increasing page-cache readahead on behalf of the server.  Setting
>    io_pages enlarges only explicitly requested reads larger than the
>    readahead window, leaving speculative readahead unchanged.
>
> [1] https://lore.kernel.org/linux-fsdevel/20260602204430.18427-1-jim.harr=
is@nvidia.com/
>
> Notes on AI assistance:
>
>   The mm/readahead analysis (confirming ractl_max_pages() consults
>   io_pages only when the request exceeds the readahead window) and the
>   bulk of this changelog were drafted with an AI coding assistant (see
>   Assisted-by trailer).  The one-line code change was reviewed by me.
>   The motivating performance observation was made by me on a real
>   virtio-fs workload, and verification was performed by me.
>
>  fs/fuse/inode.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index deddfffb037f..c8373e537d2b 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1495,6 +1495,7 @@ static void process_init_reply(struct fuse_mount *f=
m, struct fuse_args *args,
>
>                 fm->sb->s_bdi->ra_pages =3D
>                                 min(fm->sb->s_bdi->ra_pages, ra_pages);
> +               fm->sb->s_bdi->io_pages =3D fc->max_pages;
>                 fc->minor =3D arg->minor;
>                 fc->max_write =3D arg->minor < 5 ? 4096 : arg->max_write;
>                 fc->max_write =3D max_t(unsigned, 4096, fc->max_write);
> --
> 2.43.0
>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
