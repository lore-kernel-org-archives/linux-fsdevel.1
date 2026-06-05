Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9492364943
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683693; cv=pass; b=ZQYXIyC1yxYf5kcb/n8KgQlkn3/MbS2vQAsTzWxciOxfVPATB7dmr2ZGSQiWCcowNKjLvrlxLYMLC3VXzYSCia8ZHsWcensXYifvvS22mk+o1/aiXjR9sKw9LFsFMk3ogNgenMZ4pNSUEKLmC7/V3q9flMHra0NcgXLKrK4cfGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683693; c=relaxed/simple;
	bh=pbjbbbVLp5K/9VlKm7ltVlHFEtpetfQvW99kkt5MiCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5qC45xey2FsQclFHbi/ZPnUuhWmuwYSvV37741VHDCNPo5UrAP42imAPhxKSEkhpoyEj1rblcU99KMAYmhMJlIKzGxyeA/zgrnkkm8quwT/Be/X3+VRscxocVzjedaa3hzRyowK2b8T4/4riotiQ6cFOm9aKeSLxFnzTGa7qXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+c0XYFb; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+c0XYFb"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef29c5561so1245138f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 11:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780683690; cv=none;
        d=google.com; s=arc-20240605;
        b=O16jvTJweKphiEKIPyHAkBKeih0tzJ0dtQsBxgu7nAwKeMg6xWsEokG7lQ9uE+9Azb
         3fYg0hlt78WZxZ3obRb+6lslK44PFYwa2bQGcToR5Fb9cbMPVR/lea2QjYj1n8b+5iP3
         ZrBedsH3plOhz9rkogqMTweBRKnkbmA5fRhS3YwS1Qf5xzOCNFs4Qdb8l6MN3ZVaBXog
         fsh9PAXU4aszLmxY933wZeu1/kCwKaE2QiHUZrr1sdooc//WjsoQfAFkTabDmWKbYzen
         59zEH71uRIjuuOZ7okMjr7G0TdT6xBNKLzC0UOOQ2a1d6zu1hk0OYIWyWF3tW6h8NlZ6
         uioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fL8UjqpME81l3rgq1Kb+5TD+88hOY862wHHXqtquuvM=;
        fh=BwZ7sj4hAUZApggSdagaCb4b/fI5Toz64ykxqwNrCKI=;
        b=GcXkaVtwEucphDFCX3M30iycCh3aXrdrQ2K2l4m2rFmFrd6qdSzlB8fRvj35E07l4c
         1PdZlkX3M/zIhYLeLWWYWkfTZzatWk1nQhwVMihublqiW5H2iZ6IeC0KdLlKutyK/dLN
         PxcySpAPPgHLd0DbHrHCtJGtKOYk2qrm70re9069xxBkLCwnq0h4FGN3MExH8w+b9QCQ
         jNk+XPT4f7SPXrhcTCBqi7aaU6ZTXS16qWdMMSD9+e2rZcjqaaINk2eX1CaapCB2JMwv
         /iPoqgFbtDdkDr7hR4ML3CaQ96etlL34D3VWStTFAym9ZgxLf7tXoN9BQEi2kx/Llg8I
         c7ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780683690; x=1781288490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fL8UjqpME81l3rgq1Kb+5TD+88hOY862wHHXqtquuvM=;
        b=T+c0XYFbGjK7Wk5AJU5ceXg3mcKfrIYq3TdYtGschadSNgmN6YsiRxn1pL7SaSyuMi
         pELUh/TtXSTLIYNrLL1U7DRw+ZasD37k8SLmysHgk9xpfdqHcSyLbZ+SIBN5YjxOcNs8
         7jN0H2r/RyNweG7reee/EFqZq27DrD9VcvNjpPS/GkHxOO78eUNDjT6/8RP2Lcbibwti
         nRDy9xA5Tq7evL+OQUKGyXbc/vQoGugHK4wZTIdtztITsqIwXwgZHwCnCIfpcxvMqHaR
         woVUGYgL2tW/DzJpSY4VeClgzM4HNhDpEybL1kDu34w6rK4TwJ2QmvFGlyL8tPYQIGBR
         RrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780683690; x=1781288490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fL8UjqpME81l3rgq1Kb+5TD+88hOY862wHHXqtquuvM=;
        b=PXaplQDCmXyEbt1L/4tioY3tQHDtT/2G5lC4K/PLRsqdx2jTPq6Z7SyR/lPFUt9EeW
         GSfYsvAiuDm7jiMI1gw1UgzCo1uniaz3S/AgI0Gl98eCpNtRuhyJxgliNxQFPdDEm2KV
         mBZXrYsoH9Feo9VBmA6qX+vv8kZ1AtRc8/hbJ9glGfWYJhaJrekpunsE+WaeIy89uGIv
         PZUPGHDuPqdUTrw0J+JgFp5QFh2kubopJdpWQZzDBNLkI28dXjiPIG+/1FpZBm3bJnYO
         7m0ZITKlDqp2Mx53vg5wTu9LjhMeQFq7u7KkwKUAfYhD8S2yWWLO1RqLh0MXvaqDO9nM
         P2Vg==
X-Forwarded-Encrypted: i=1; AFNElJ9eZ9jUT0Vv5Qo27lb7owQwoukhf9VkA2OBNFstfj00xCzNDvtDPBWRk/XrS59QQ8JHi15iBSFCJ3+SbuCq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4C9WRtfCZfVL9ZN7NuPIPtzTpMErqjTGoNdtLlqv7PZXH3pWK
	xI3tnYbl6+u18dCLEDhcTNB0iz9RB+SVC7QyWQQu0pWFTbzU4BM7Kkh6V2IY6G87yB+JYn0zTb1
	xGeaE9loQyGdhDVkR3IJEkEXjHUuHdXcU1yo1
X-Gm-Gg: Acq92OGpgevKSraCgR/yyA/bqaBXzJ/jA/7K1Jfm0KbtKYuejZv/lVw2ruFj5Xn/rcX
	54w9lE+4znHWGYEb8vcIqieY8OMXdpMYVm3JsP1mY+v49HqGp6VYNpN5+oBCjNonzkVbNF5OQyI
	LiMaW+3up+LHFRGvOfxGCyeKicM5Yjsmbsi3ry4qzXWiMGLIRcNXN0cdxjnECPeEaZsUr6xcR1j
	njqVkT4VGKS4ijQrsLFNOp8L9Mkzmm/M1x7/iQcVRAKwrKOkDjs+xJgAFxK1F+LaP9tK5a+0jkR
	CgWvErN1qz4tqhIi
X-Received: by 2002:a05:6000:46d4:b0:441:1e1e:a050 with SMTP id
 ffacd0b85a97d-460302eb18dmr5275229f8f.16.1780683689871; Fri, 05 Jun 2026
 11:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602204430.18427-1-jim.harris@nvidia.com>
In-Reply-To: <20260602204430.18427-1-jim.harris@nvidia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 5 Jun 2026 11:21:18 -0700
X-Gm-Features: AVVi8CetW31iZskHFTAEzcAQ8ombqSfZV3tgNUrIHZqkn-LqfeuAUSypjbyWrCE
Message-ID: <CAJnrk1aYKZnN3N+-y2kLtPksfRZngfRKLNVzqyo_c5Ysdm5cNw@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow server to increase max_readahead via
 FUSE_INIT reply
To: Jim Harris <jim.harris@nvidia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Sztyber <ksztyber@nvidia.com>, 
	Max Gurtovoy <mgurtovoy@nvidia.com>, Idan Zach <izach@nvidia.com>, 
	fuse-devel <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 2:14=E2=80=AFPM Jim Harris <jim.harris@nvidia.com> w=
rote:
>
> A FUSE server that advertises a large max_pages and max_write (e.g.
> max_pages=3D256, max_write=3D1MB) cannot currently obtain matching
> FUSE_READ request sizes from the kernel.  Buffered sequential writes
> arrive at the server at the negotiated max_write size, but buffered
> sequential reads remain capped at the kernel's default readahead
> window (VM_READAHEAD_PAGES, 128KB; doubled to 256KB for files marked
> POSIX_FADV_SEQUENTIAL).  A 1MB application read() therefore turns
> into four sequential 256KB FUSE_READ round-trips instead of one.
>
> This is because process_init_reply() processes the server's
> max_readahead response as:
>
>         ra_pages =3D arg->max_readahead / PAGE_SIZE;
>         fm->sb->s_bdi->ra_pages =3D min(fm->sb->s_bdi->ra_pages, ra_pages=
);
>
> Since the kernel sends its current bdi->ra_pages as
> init_in->max_readahead, and bdi->ra_pages is the default
> VM_READAHEAD_PAGES at this point, the server can only ever decrease
> the readahead window -- never increase it.  Even if the server
> replies with max_readahead=3D1MB, the min() clamps it back to 128KB.
>
> This clamp dates to commit 9cd684551124 ("[PATCH] fuse: fix async
> read for legacy filesystems"), which introduced max_readahead at FUSE
> protocol 7.6 and used min() to preserve legacy (<7.6) filesystem
> behaviour.  Modern filesystems that explicitly advertise a larger
> max_readahead are silently overridden.
>
> Other filesystems set ra_pages or io_pages directly from negotiated
> server/device capabilities: cifs sets ra_pages from rsize/rasize,
> ceph from rasize/rsize mount options, 9p from maxdata, and nfs sets
> io_pages from rpages.
>
> Use the server's max_readahead response directly, bounded by
> fc->max_pages (which is itself bounded by fc->max_pages_limit and,
> for virtio-fs, by the virtqueue descriptor count):
>
>         fm->sb->s_bdi->ra_pages =3D min_t(unsigned int, ra_pages,
>                                         fc->max_pages);
>
> This is backward compatible:
>
>  - Servers that echo init_in->max_readahead back unchanged see the
>    same effective readahead as today.
>  - Servers that reply with a smaller value still reduce ra_pages.
>  - Servers that do not negotiate FUSE_MAX_PAGES see no change, since
>    fc->max_pages defaults to FUSE_DEFAULT_MAX_PAGES_PER_REQ (32),
>    matching VM_READAHEAD_PAGES.
>  - Only servers that both negotiate FUSE_MAX_PAGES and advertise a
>    larger max_readahead see the new behaviour, and in that case
>    fc->max_pages already gates per-request data size.
>
> Signed-off-by: Jim Harris <jim.harris@nvidia.com>
> Assisted-by: Cursor:claude-opus-4.7
> ---
> Notes on AI assistance:
>
>   The code analysis (tracing the readahead negotiation in
>   process_init_reply(), confirming the behaviour of ractl_max_pages()
>   in mm/readahead.c, and surveying how other filesystems set
>   ra_pages/io_pages) and the bulk of this changelog were drafted with
>   an AI coding assistant (see Assisted-by trailer).  The one-line code
>   change was reviewed by me.  The motivating performance observation
>   (a 1MB application read producing four 256KB FUSE_READ requests
>   against a server advertising max_pages=3D256 and max_write=3D1MB) was
>   observed by me on a real virtio-fs workload prior to any AI
>   involvement, and verification of patched and unpatched behaviour
>   was performed by me.
>
>  fs/fuse/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index deddfffb037f..272026f11a34 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1494,7 +1494,7 @@ static void process_init_reply(struct fuse_mount *f=
m, struct fuse_args *args,
>                 init_server_timeout(fc, timeout);
>
>                 fm->sb->s_bdi->ra_pages =3D
> -                               min(fm->sb->s_bdi->ra_pages, ra_pages);
> +                               min_t(unsigned int, ra_pages, fc->max_pag=
es);


Looking at how the mm code uses ra_pages, I think this will also have
the side effect of upping the number of pages read into the page cache
for speculative readahead. I don't think this is safe, at least not
for unprivileged servers.

I think setting s_bdi->io_pages would be a better fit here. fromthe
logic in page_cache_sync_ra() -> ractl_max_pages(),  this would only
exceed the readahead window size limit for non-speculative readahead.

Thanks,
Joanne

>                 fc->minor =3D arg->minor;
>                 fc->max_write =3D arg->minor < 5 ? 4096 : arg->max_write;
>                 fc->max_write =3D max_t(unsigned, 4096, fc->max_write);
> --
> 2.43.0
>
>
