Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925162;
	b=xNObbN1l9nNSWU6iqngWAK3t/unGxxq3jj/Jvr6XHmiTcxIWAO8VWB5eHX72CWFBuVH5
	 ibVBisbH0cQUjUQ6sxps5mU12C8V4SMYszE732QwiWinZ3gdPIE9adjfx4MLv2PJSvs22
	 WbRp4JPyz5oSgNLBkd5VfJZy+2vG9+RnOuNJ6wFTpiemjDY5B6DGLPGK/XWBIb4RNga2I
	 +ZTUBTTjbTdxTG3HX7/5PqcrfI6D8ClOK15SgjV5tvfWAAkgZ5TVGeelehIhjPiy/5QCm
	 0daC41g2/UtRSTktW0kyRfJlVk9QjU1RzAwoUJSV5ORoHx8EnnntBdh/FaKHsuKC+PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4FXZ9QjPMWSPXHYn/FS5PKL+JaPOXiDC39K9maTGAmk=;
	b=Od9iHvtu6aiUnFDjRFnAg8kUabllplZkQBtFi14aG7QgNE1WR+riXk226UJpIgDGNPvK
	 vAK84kjJ/xgs7Pv1Y2VRtM+PPmdojG+yEsgmQ0giMT011nhNl7L0lrLbcugrKRCpNBrZy
	 K0kjKG2pgH131hQVe60EJHtFPjrM8Ey0FiQ3T9O5G1caL4uHBNuQJEUqKbVn2BZMTIuaG
	 lMTADEIjVY3gl7SWdXm37YxYDN56Bhv60DLmQLNoKxOJhqyCtJR8zn5VlyuKbe5gYevpz
	 XoC8FpEYuLbRxlloOEG/mudxaoWn8Me6dExoJacfVwVgkTZc9FXR9vX1DgPuwgbq+YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=R7sopLzq;
	arc=none smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A3606A32A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 14:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F8A3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=R7sopLzq
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ae2fb3fe2fso40550431fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 06:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794925160; x=1795529960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4FXZ9QjPMWSPXHYn/FS5PKL+JaPOXiDC39K9maTGAmk=;
        b=R7sopLzqJ5XzQYAzHTd5xZwp6Sg5OlWt1FdPTd032lNm89iLSH4T2ZQHV0crGNIyme
         jU0LrAeToo2yG4tSe30EQjoI+2Zf9hGo77A71OgNnn7itLAoeNL5kZoOdVTCiiFW4pU1
         OK/ShgkzuP+xDjXDMEBoGgYa6hz4ElnQKk0uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925160; x=1795529960;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4FXZ9QjPMWSPXHYn/FS5PKL+JaPOXiDC39K9maTGAmk=;
        b=ipM/548bCWj0E5jlm6PGg+yjgdxD4ERNCkow0+6ehxq/K8jsx4FT2GaOLdIaABrsxs
         ddKr2fkvwxlc6XzmVkf7ObBlt+i6ueWUnfnMi20OOnSLfoy+Yokk9omLTjbTIvyb4/3F
         HzTfraaf2K6Pv4ehAhleK+M7lj6U/nK6rvRBGiyDcqw91RgdpEoR8EfKqNpLhb3lEu0N
         baYLx9MO/xEz6OaGauD/tcDJoAQEHOiIoExC0HyBbyZv6yNQ0Afq3iVAIYV8z6G21hTC
         Qcp26xlFxnVn1cuEoJNsnxTWaHBjGwpDHsQXAfp0hGBjryY1w3NoGYmCRv3xN9u9rvG4
         LDCA==
X-Forwarded-Encrypted: i=1; AL+hErEtWdR38xnCMXZp+zlx4kqUHX98betHhm2ldFs7wWbmsdyZ2C9vDggKlm1/GZeMaXKZq/do4G8Bxxx1lNvr@vger.kernel.org
X-Gm-Message-State: APuU4Z91Muw0ZJtbuuQAabF51Va+XIStLfY9XXuKXiKlDiTUk701OhSU
	TJUu3msgMDvfEQtYyTUEAMsusVkTbjkzDxgnzs4TDsO2hkLHpepVi7RaGFy9DmohMYBVPNEnSwn
	yxx39E2IEoFRzBw==
X-Gm-Gg: AYBFou1Re3jtHmgcpvPAf3Qcn1yGpbIfZMFY9HGN72kOd7xCooK4TUgWv8IFnbDUqNx
	JuqjF1EnsBpVsJbVm404JKOlmclwVmbLt3gMZaPe+IPM3C1U9A0YCUqls3tvKGRPBw8DW5X3/cb
	rJ8LwFbQs3Gd5r8HMUAV6PmPjHBWbiXuiKTbF5d5m/VoWPds8TaKPiurX9N/fjEGQgxL2z09qe/
	K8exwr1sfTJLc7BcxTIYjhlx1EOXFnK77VXtEOoD6mbowaqmyDANhCUNAhRGl8wApfXWD5UL875
	VRLahFgMidhpQmJdwGzVszPt6KvXrDnxHAgB8ULb67LSrgTDoA65cBc5sFWyAQSK1vuCHxoKyha
	+ZjngEjc9BtB29hWZtvtKbD9Cfe9Gm6K6/HY8WkNYRiuga/2mAMdO9sI/En41HxfGzPeWS/vImy
	VkWq1NcK8fN26UnfPzqDRt8LJkcHIRcnLl/O8QVhfPuQ4g+PJ06bLOsYWM4TFL/RPrlMIBtOtfr
	y9YjBgvWP2vjPJ70P8T5Xsrj/UuBLgYIK4FQX6ModmzwoxERiJZu/hjLoFh1aszuJ+76mkhvLVY
	O1SWafWcdVXY22Fl8y9mXxYsz+lwAE8BfYo4WapZMaM9V8bRSznq/70yNweUcec+
X-Received: by 2002:a05:651c:a182:b0:3a6:6831:6e28 with SMTP id 38308e7fff4ca-3ae2b49f232mr42991821fa.6.1794925160276;
        Tue, 17 Nov 2026 06:19:20 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae2b7d2ab5sm38352751fa.37.2026.11.17.06.19.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 06:19:19 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c144eb2f43so6248e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 06:19:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFBgD6RznC+L9xQ7TBywNq18kCdlvqcuFcykAVU8vjXBjzIS5dxD9DDwEopLNubgMmzUdpqaDjTIukz5RUA@vger.kernel.org
X-Received: by 2002:a05:6402:a511:10b0:6b5:5d24:5d90 with SMTP id
 4fb4d7f45d1cf-6b85b4c22d8mr72630a12.3.1794924698252; Tue, 17 Nov 2026
 06:11:38 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116230627.3537051-1-jeffxu@chromium.org> <2066d131-f999-4747-beb8-520d5e0ce1db@kernel.org>
In-Reply-To: <2066d131-f999-4747-beb8-520d5e0ce1db@kernel.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 17 Nov 2026 23:11:19 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DzTmyeVQxNdhdy8pPi+ts1cCgbztVJiMoNBeJWBzjdQQ@mail.gmail.com>
X-Gm-Features: AclHuK8ZMC6yRFY7VxkKfsQMYV8BNfasB49bEPdk_bBjeXaAi9-9aO4mXcafXvg
Message-ID: <CAAFQd5DzTmyeVQxNdhdy8pPi+ts1cCgbztVJiMoNBeJWBzjdQQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] mm: kasan: skip KASAN for GFP_HIGHUSER
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Marco Elver <elver@google.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Evgenii Stepanov <eugenis@google.com>, Ian Rickards <ian.rickards@arm.com>, Jann Horn <jannh@google.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Collingbourne <peter@pcc.me.uk>, 
	=?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, Baoquan He <baoquan.he@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Allison Henderson <achender@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, kexec@lists.infradead.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 7:10=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 11/17/26 00:06, Jeff Xu wrote:
> > Hi all,
> >
> > Currently, GFP_HIGHUSER_MOVABLE includes __GFP_SKIP_KASAN (commits
> > c275c5c6d50a, 70c248aca9e7, and 0a54864f8dfb), allowing movable
> > userspace page allocations to skip KASAN page unpoisoning on allocation
> > and poisoning on free under CONFIG_KASAN_HW_TAGS (ARM64 MTE). However,
> > GFP_HIGHUSER does not include __GFP_SKIP_KASAN, even though it shares
> > the same kernel-accessibility contract in include/linux/gfp_types.h
> > ("for userspace allocations that may be mapped to userspace, do not nee=
d
> > to be directly accessible by the kernel but that cannot move once in
> > use") and differs only by !__GFP_MOVABLE.
> >
> > Moving __GFP_SKIP_KASAN to GFP_HIGHUSER addresses the performance issue
> > below (following up on the earlier drm/panthor discussion [1, 2]). The
> > swap issue from that discussion is not addressed by this series:
> >
> > 1. Performance: For every 4 KB page without __GFP_SKIP_KASAN,
> >    mte_set_mem_tag_range() tags all 256 16-byte MTE granules (via
> >    STG/STZG and DC GVA/GZVA) on allocation and again on free. In
> >    graphics and UI workloads, DMA-BUF (system_heap) and DRM/GPU
> >    (shmem/TTM) buffers use GFP_HIGHUSER; while steady-state rendering
> >    reuses buffers, window resizes, surface transitions, and app launche=
s
> >    synchronously allocate and free tens to hundreds of megabytes (~32 M=
B
> >    per 4K RGBA frame) on UI/compositor/render threads. That takes a
> >    significant share of the 8.3 ms (120 Hz) / 16.7 ms (60 Hz) frame
> >    budget and thrashes CPU data/MTE tag caches (especially on
> >    cold-cache free). On Armv9.2-A, skipping KASAN cuts ~32 MB DMA-BUF
> >    alloc+free latency by ~80% (~98% faster close()) and improves the
> >    OpenGL score of an app-loading benchmark by 15-23%.
> >
> > 2. False-positive KASAN report after shmem swap-in readahead [1] (not
> >    addressed here): when a shmem page is swapped in,
> >    swap_cluster_readahead() also reads the neighboring swap slots and
> >    allocates their swap-cache folios with the gfp mask of that shmem
> >    mapping. A neighboring slot can hold an unrelated page that
> >    userspace maps with PROT_MTE. If the mask lacks __GFP_SKIP_KASAN,
> >    that page's folio gets a KASAN tag in page->flags. When its owner
> >    faults it in, arch_swap_restore() writes the saved userspace tags to
> >    the memory, but page->flags keeps the KASAN tag. Later kernel
> >    accesses through page_address() then use a tag that does not match
> >    the memory and are reported by KASAN.
> >
> >    This series does not fix the readahead path. It only removes one
> >    way to hit it: shmem mappings that use GFP_HIGHUSER (e.g.
> >    drm_gem_shmem_helper / panthor) now pass __GFP_SKIP_KASAN to
> >    readahead, so the neighboring folios no longer get a KASAN tag.
> >    Shmem mappings with other gfp masks that lack __GFP_SKIP_KASAN
> >    (e.g. GFP_KERNEL) can still trigger the report. That issue should
> >    be followed up separately, for example in [1].
> >
> > What changes for users of GFP_HIGHUSER pages under CONFIG_KASAN_HW_TAGS
> > (other KASAN modes are not affected):
> >
> > - Access through vmap(): nothing changes. Those pointers already carry
> >   the match-all tag and are not checked today.
> > - Access through kmap_local_page() or page_address() (for example
> >   ramfs): accesses are no longer checked by KASAN, as is already the
> >   case for GFP_HIGHUSER_MOVABLE pages.
> > - Buffers that the kernel itself fills (pipe, FUSE, kexec, RDS) keep
> >   KASAN checking by using the new GFP_HIGHUSER_KASAN (patches 1-4).
> >
> > GFP_KERNEL, GFP_USER, slab and vmalloc() allocations are not affected.
> >
> > Patch 1 adds GFP_HIGHUSER_KASAN
>
> I really don't want us to spread KASAN-related GFP flags in the kernel.
>
> There must be a proper way to abstract this.
>
> Why is GFP_HIGHUSER not sufficient? We were already told that this is mem=
ory to
> be mapped into user space. Placing data structure on it and handing out p=
ointers
> to that would already be a bit questionable.
>
> So what are the ways to avoid GFP_HIGHUSER_KASAN?

I think the idea behind GFP_HIGHUSER_KASAN is to make it possible to
skip KASAN for GFP_HIGHUSER by default (for most of its users), but
keep it for some of the users which today use GFP_HIGHUSER for their
memory allocations, but could benefit from the added security. As per
the other patches in the series:

  pipe, fuse: use GFP_HIGHUSER_KASAN for pipe buffer pages
  kexec: use GFP_HIGHUSER_KASAN for segment pages
  net/rds: use GFP_HIGHUSER_KASAN for message pages

That said, I'm not familiar with any of the code mentioned by those
patches, so I can't really tell how much they would benefit from KASAN
or if their choice of GFP_HIGHUSER to begin with is correct.

Best,
Tomasz
