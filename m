Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD9427A1A
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247804; cv=none; b=CmhSlefr1X2kMiHBKxgPKTb57Fwk1YteU7hJCBsqaSG6mVYYnA2KzRJE45/D+ZvqRE2udM4ID542AbuaJrJFR7GHnFH1alnxTg6G80okyIKvH8lGDfPPqXs7crz3hUcty9OYIHE3slpR2njSbYLW/G5rJtBnvcODiXLYWcXBHS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247804; c=relaxed/simple;
	bh=gRX+ywKIwU9OmqjBDAsui9Hd9CKC+9id0Hc8y1CHwtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhF0CMonNB7VhqHHZoUWoZTCn7HUWLnilYd1hqYLG42nbxNEWjtH8B2FGD527VQTBLHvkbfj6NYWJI/wvtalvG5O8O//h0oUPDLF2p5bGD47WOJSSGkDpXLfK/P5YyvfVC25auAwe+g3iDUbwkc04ZXFC8FHiESGopyr4NqCV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nO+po5ZV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO+po5ZV"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so29096065e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 07:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785247801; x=1785852601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YrD8ygHhYerz0DEj7rZWmow1dfxEDcUpsFk06vyQsjE=;
        b=nO+po5ZVcybFv/Sor/Aed6UzmGe3XIFOzK4280ewhpedlAjHznboWBlLfegaoGKZG8
         Kh4pFoEokkYydu2nP+uJFJONXyLnCG6T0pzwJAT1kKp0OyV68d5R1Bzdo6X9fT4SD8t9
         jlljI+l0kriKltk8ikLw6TP6e6BZk7DNYvr9+zNIczYTQWvmqJ89dzIJX4oPzW5aPpan
         mDcyNdO2VTFMAEVONO61rbg9bfjSbVZCD41GZeIKYY19iTe2yjdadnOgaebvLysIcA3Z
         e66eBt7WGUglIN0CWFIFccgrKzSxZbwUrgYi8pCqL8tqYW1kTuYeFqfajhWFSSEGb5i7
         3+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785247801; x=1785852601;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YrD8ygHhYerz0DEj7rZWmow1dfxEDcUpsFk06vyQsjE=;
        b=OVqmC2AIVjNdYnSifxnsfs/c/lkRL5Vuevrn5Qpi9VFz1cM70wSXsGWfCZaZyz2kLi
         Wx6GnWl7z61ms0tBSEOYuRwCtpJICydlm7GTkL6my3y5o8NpayrRUCg2k7Ht0U9K09v/
         ZuTl9ngfNUBcCMxYFOILzjioHMPiggjODQtIhF6HVUt1Qz9MV+CwobnKjMUpOcaXKPKi
         TUvrTruEKu7mQ2DtQz5Lb57Kkj3Ut8l2M5jdCMsdxDWCMwYwqE9WY12Wbfd7P4RjK9C+
         jkf5I3/2YQJOdF/3znyWRy16f5I0SMyPf1WvBrTYI+jYxAmcyOa/PyN0Vnl+YB5Q783k
         8KDw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/chmHs2OBugefmLwoUVrVwUwJy3AG/9psEAGPHCRV6DChgqnYmyCqcirIGAYvXKCCrcuqZIFxDRdjqnkx@vger.kernel.org
X-Gm-Message-State: AOJu0YxN2k1ks8QZVXBlQuiASUeutfiKRVBg3dEHbpXKCBhYFUIbdOXL
	P/sDktqCyBFr3aKSkmrUx0Tfn3K+M6qnf48pr5ijQqfPh3mCOxQzKvWs
X-Gm-Gg: AR+sD10x1jHt0Ag+4YFD+ZyIy+V+QlVA7w00GhCB/595sp+qP/tNkAQz7h+K1y0h+3y
	gpNEsKcMEiG7a+HSdOHv3rsRgICVsbRJqBVU8pE89uliLxYKvZYQFl0yOYqshuD8LsLGQe2/p3K
	gbLQMTqVESNSguQtgvrH61+lJwxX4dNOO8/FQnJ0UNv7Fsr8/pu27OlPIF4+E87KPqu7ExAlYAP
	+glIBbAQFqnPMT/c5pfmq8TKP0VT+Qu6R94aILTkLHZ7mM0IJRXYiOZX7fb11/1QxY07BBriCy+
	IV6OOhZoFcTJakSbDrUGkTJ9HJg+qDftlwxumwYcBz3cYZNLj5/SGpPY80NcttdzYqv1/OsVrcg
	Tj9O3164liYZZRpReiHExcaaIzkfA4SlJiowvC5i6E+EmJfrH5ufP2HPhnBYsQL5+vLBt+PNgni
	3E+IU0jVxkYP2SBNhQc65FIpo6bo7wMWNYXJgR6rWb728EsAUWErtwiawWX/bfQBJBMJ0VVNzOn
	B7KKg==
X-Received: by 2002:a05:600c:a44:b0:495:4856:2659 with SMTP id 5b1f17b1804b1-496c6439442mr28377265e9.9.1785247800886;
        Tue, 28 Jul 2026 07:10:00 -0700 (PDT)
Received: from zhangbo56-PC.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45b1c2asm82737265e9.5.2026.07.28.07.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:10:00 -0700 (PDT)
From: Bo Zhang <zhangbo0325@gmail.com>
X-Google-Original-From: Bo Zhang <zhangbo56@xiaomi.com>
To: pfalcato@suse.de
Cc: fmayle@google.com,
	jack@suse.cz,
	akpm@linux-foundation.org,
	david@kernel.org,
	kaleshsingh@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	surenb@google.com,
	willy@infradead.org,
	baohua@kernel.org,
	Bo Zhang <zhangbo56@xiaomi.com>
Subject: Re: [linux-next:master] [mm] 7b32f64bc5: pts.svt-av1.Preset13.Bosphorus4K.frames_per_second 45.8% regression
Date: Tue, 28 Jul 2026 22:09:42 +0800
Message-Id: <20260728140942.3849047-1-zhangbo56@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <amiCX6kcQneMZu3-@pedro-suse.lan>
References: <amiCX6kcQneMZu3-@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 28, 2026 at 11:33:22AM +0100, Pedro Falcato wrote:
> > With my conditional approach:
> >   At step 5, vmf->pgoff=896, vma_pages_left = 1024-896 = 128
> >   128 < 128 (the condition is false), so _max_index stays ULONG_MAX
>
> This is exactly what we're trying to solve.

> > The key point: when mprotect splits a large file mapping into adjacent
> > VMAs (common for ELF segments, or read-then-write patterns), there's no
> > benefit in preventing readahead from crossing the boundary, so the data is
> > still sequential in the file. The limit only helps when we're actually
> > near the end of useful data (within ra_pages of the VMA end).
>
> This is completely missing the point. This change tried to back off from
> reading _anything_ past the VMA _on purpose_, due to ELF file spillage.
> This patch reintroduces spillage in a very obfuscated way.

Hi Pedro,

I understand the ELF spillage concern. However, I think it is better to
distinguish two different scenarios:

1. ELF segment loading: .text is typically a few hundred KB to a few
   MB, access is random (e.g., instruction fetches jump around), and the
   data beyond the segment boundary (e.g., .rodata padding or another
   segment with different access patterns) is not useful to prefetch.

2. Sequential mmap of contiguous file data: SVT-AV1 maps frames
   sequentially from the same file, and the data beyond the current
   VMA boundary is the next thing to be accessed. Same applies to
   mprotect-split regions of a single large mapping.

In your earlier message on Jun 18 [1], you noted that SVT-AV1
"progressively mapping the file data for a given frame" and that the
old behavior of "page faults for a given frame starting readahead for
the next few frames" looks "reasonable". I totally agree, and my patch
tries to preserve exactly that behavior for the sequential case while
still limiting spillage for the ELF case.

Here's why the conditional check still handles ELF spillage:

For a typical ELF .text segment (512KB = 128 pages, ra_pages=128):
  - First fault: vma_pages_left = 128, 128 < 128 is false, no limit
    (but ra->size starts small, won't reach boundary yet)
  - When readahead ramps up and approaches the end:
    vma_pages_left < 128, _max_index is set, spillage is blocked.

For VM_EXEC VMAs, Frederick's patch already has a separate code path
that unconditionally limits readahead to VMA boundaries (the exec folio
order path). So ELF .text spillage is already handled regardless.

The regression comes from the non-VM_EXEC sequential path (mmap read
of data files), where blocking cross-VMA readahead has a real cost
with no benefit, the data is contiguous and will be needed.

The 45.8% fps regression and 870% major fault increase are not
acceptable tradeoffs for blocking readahead that would have been
useful. My patch preserves the anti-spillage behavior for the last
ra_pages of each VMA, while allowing the readahead machinery to work
as designed for the bulk of sequential access.

[1] https://lore.kernel.org/oe-lkp/ajQbXthzbr9xgUIM@pedro-suse/

Bo
