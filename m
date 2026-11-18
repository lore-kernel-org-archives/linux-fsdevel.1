Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965346;
	b=TbRBPS8szG2j9Wo2hjLGeKOgmR+gcf1h/K7pTeoTGVYTby4Bs1/g3UwAomyZ1lKWalna
	 Sl79gBXfDOqYG+GOuhtnc+P0D0dY/dh0yYMHJmkvwiFfVEEdzAEvMThJeiIXhiOcm2Gd6
	 mQIhNBlIxEB6ilz1lLMEmvyzFxiCckC0Vr9OWdZ0C4lCnbsgFi2JbwXAPeayLml8+hIp2
	 wSYekDleBVbyCMlitCAurcnSmi7TLzZPLhdWV3YPXc7KBrORwIYHxOs1+ZgZHm8c29LOC
	 NLNfCoPlxnRQZGRVzVEF+ivP7mUjNtQRuG+a8ILNVo8dHMbDfRVSxa0UIhoRwQYi22A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9QrBc0w3KV6ChVNAVMzB1hWL9AMrXve7Stq4IEHc3B0=;
	b=r9ZphlxrfKJn1Wc+Lgp3Qm3OrUS4kkhMxZhGVOGB46Yr3E4b6hSD0zxNa6ziSR/MRqGk
	 8ACGKxHJ3NAjLE1IoIXLPiauBZgoWCAyakS0sS/r3d3t48BbbA5tp4xV4Ss1YhegGhNuk
	 BkznjA5jXTWSQt3urhAyzMOJWGyVTaherO0KwbpexyBHPuBxM8+bitE06nG6+bs4Qyuwz
	 Yah3IabOnNqEPHWM9o2s+zni0TuFQoa30dYniDIuprRz/1AqiP2vUbpZG+wqZtnAnlvMc
	 Ri1FXxLmqlf6C6q39oY8AEjbXB9jd72F/hWO5d9Sg7PYAaKbGyj08DUVOeWLAWWJtVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=H1AWSx2s;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FD0606A32F
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 01:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7FD0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=H1AWSx2s
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b0b133f64fso39491a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 17:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794965345; x=1795570145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9QrBc0w3KV6ChVNAVMzB1hWL9AMrXve7Stq4IEHc3B0=;
        b=H1AWSx2s6yA5CZ4Kphq2OZbv2w2xBgnzcUeDJNakKtwKJr6At3ZCbGY3hZkAUsj/yp
         b5eUHT+IBOFEmxJxWhffm3Hlml2THIgqdS86xaG1IYJpNQXva7wATT2dVNqb6auf9kHq
         Hf8xzqkAwAP9npo0A8KFtaAQ+dIAC/LDfvn9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794965345; x=1795570145;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9QrBc0w3KV6ChVNAVMzB1hWL9AMrXve7Stq4IEHc3B0=;
        b=xGaOX/xKNLOk6DVm6ykx7FhLq+U1+j8EDXXoAIDjX5OmcMC3JaRBgbgS2bRiVpUscX
         XPa/nW2FH9hj24kGtKFuT5zi0rV4U1yzry3qGhpwkCH0+D+hFZH33Y2mV1iZ2kak2lr/
         CfFFKd98Retd2q46ar0Px8fn66/uVMyeoD/DepqnXL91OOLlMHmYcgZiCgRFaARhIwRW
         FaQwuPlr7jvA9hNAe0MrU4UDOsBuLSJeo70HOKCLQ14JYojsZkhWmYR684hoR6Kq/KZg
         qwTuE3IbOeL3Fopm+lWXn3VWMXMNoyxYQptqxiEaBmW+7F/AmXaBxq6Vbd8oUbuFmiI0
         xmlg==
X-Forwarded-Encrypted: i=1; AL+hErHx6B68Zaycu1PZoRq8AYlwzJtKFKQGKOurFSSSGQb76DecYse3eprKanL6U1Vk7bUvqfW/3NHnRM8j27kX@vger.kernel.org
X-Gm-Message-State: APuU4Z8rXrBsrQoRBl4S0JYozwkwKwOyYdeuxx6FWRe4q3nCfgebwry4
	J8BtW+m5hKauWqrkHfnWwELgdwubEUviiEOiPjJTuh1k/8gPoEq4ppNUhkrG/DZQ3A==
X-Gm-Gg: AZFdTZcVqaB3fJvlIyj1TCJJn/ha+4orv9bAOj4uDg6BzS9r7lfIL88voqWG6Rbu/SX
	0xDRhXyyrpa+JHK1V+0gZ3JEPucUUMt2D1OzEfzcEm0q/6GfedmiQZ0CE0PLigcc8mla9mQyI94
	n/gkyRYJjJ53QKjD3v1XFIqsRSqmOD6Byu11xsPSwFwvxdgM/ZuqRvR1YKzqDkEi+HM/sQerf9P
	myR3xaJyDFXHCihwJbGBz/Q7Ubru3b19Yl5VFcnrbgrkxhQhRENngngRXmPIcyOsiVjVgj3GsGX
	CM6m3ZWRerIU5LfnwQO1PKxgV99P62kKQGzRoZdaQ2Nxh6SMCNlX1rJ8x50UtuL+iES90KtmVKm
	RS/BGO8VoxQWamWftrVUnFV8ROarW0N9WyL6QvOu7hJoWDHNOrl+JmKoUkEy5kmdnrQ2vTdolCY
	LwXB5Z2c7QxG3W8e5n38/PvQQg3YK0zOUP0Pt4I/TzDAOrzWWzsAuzwt68RLEPN6cpPV/AX2M/b
	iOOxt8sFIGpnCmM9XR1Man60vjhRXCivLWbxrLx+1JG+Onu11NuZYNMS5nbjatLEm+s0BLHKwP9
	ggxIyAlfpTEJc/ipzK13m/1W9pxjDC6Y6qzGNI1DbPyzAk+jYYzMsXLKPCIZW1gVsBauChs=
X-Received: by 2002:a17:90b:5390:b0:3ac:a11a:7c88 with SMTP id 98e67ed59e1d1-3b3d07af9f8mr1892178a91.3.1794965345247;
        Tue, 17 Nov 2026 17:29:05 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cde3b98c75bsm243073a12.10.2026.11.17.17.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 17:29:04 -0800 (PST)
From: Jeff Xu <jeffxu@chromium.org>
To: David Hildenbrand <david@kernel.org>,
	Tomasz Figa <tfiga@chromium.org>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Evgenii Stepanov <eugenis@google.com>,
	Ian Rickards <ian.rickards@arm.com>,
	Jann Horn <jannh@google.com>,
	Jeff Vander Stoep <jeffv@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Collingbourne <peter@pcc.me.uk>,
	=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kexec@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/7] mm: kasan: skip KASAN for GFP_HIGHUSER
Date: Tue, 17 Nov 2026 17:28:58 -0800
Message-ID: <20261118012858.289236-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
In-Reply-To: <CAAFQd5DzTmyeVQxNdhdy8pPi+ts1cCgbztVJiMoNBeJWBzjdQQ@mail.gmail.com>
References: <20261116230627.3537051-1-jeffxu@chromium.org> <2066d131-f999-4747-beb8-520d5e0ce1db@kernel.org> <CAAFQd5DzTmyeVQxNdhdy8pPi+ts1cCgbztVJiMoNBeJWBzjdQQ@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Nov 17, 2026 at 11:11 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Tue, Nov 17, 2026 at 7:10 PM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > I really don't want us to spread KASAN-related GFP flags in the kernel.
> >
> > There must be a proper way to abstract this.
> >
> > Why is GFP_HIGHUSER not sufficient? We were already told that this is memory to
> > be mapped into user space. Placing data structure on it and handing out pointers
> > to that would already be a bit questionable.
> >
> > So what are the ways to avoid GFP_HIGHUSER_KASAN?
>
> I think the idea behind GFP_HIGHUSER_KASAN is to make it possible to
> skip KASAN for GFP_HIGHUSER by default (for most of its users), but
> keep it for some of the users which today use GFP_HIGHUSER for their
> memory allocations, but could benefit from the added security. As per
> the other patches in the series:
>
>   pipe, fuse: use GFP_HIGHUSER_KASAN for pipe buffer pages
>   kexec: use GFP_HIGHUSER_KASAN for segment pages
>   net/rds: use GFP_HIGHUSER_KASAN for message pages
>
> That said, I'm not familiar with any of the code mentioned by those
> patches, so I can't really tell how much they would benefit from KASAN
> or if their choice of GFP_HIGHUSER to begin with is correct.

Thanks David and Tomasz for the feedback.

Tomasz is right about why I added GFP_HIGHUSER_KASAN in v1: out of
caution, I audited existing GFP_HIGHUSER callers to find any that never
map the pages to userspace and instead fill/drain them in the kernel via
kmap_local_page() (pipe, FUSE, kexec, rds). Since this series intends to
improve KASAN performance while preserving its security aspects, and the
performance impact on pipe/FUSE/kexec/rds was negligible in my testing,
v1 was optimized for minimum behavioral change.

Looking closer at both of your questions, I agree that the security
benefit of keeping those 4 under KASAN is minimal -- e.g., only linear
overflows out of the pipe/FUSE/kexec/rds page, since none of them store
kernel structures or pointers. That is the exact same trade-off we
already make for GFP_HIGHUSER_MOVABLE.

To avoid introducing GFP_HIGHUSER_KASAN, I see two options:

1) Simply keep those 4 cases under GFP_HIGHUSER (drop patches 1-4 and
   7), reducing the series to just the GFP_HIGHUSER change and its KUnit
   test.

2) Switch those 4 callers to GFP_USER. Since CONFIG_KASAN_HW_TAGS is
   64-bit arm64 only (!CONFIG_HIGHMEM), GFP_USER is identical to today's
   GFP_HIGHUSER on arm64 and all other 64-bit builds (and if 32-bit
   CONFIG_HIGHMEM=y builds still need ZONE_HIGHMEM, that could be gated
   on CONFIG_HIGHMEM, though that feels ugly at call sites).

(1) seems much cleaner to me. David, would (1) work for you?

Thanks,
Jeff
