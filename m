Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550101;
	b=dQhyTjJuOB3mtMnCjwhT7fU1nw2nyNB09amnWFrj8qNYM6c2qbhB+FnvN91lXGR1fNvD
	 V5u2dIqUp+9y91oI6uXdiAnoNgMdGiNQXkE4Pe+QGBrCPZDwJi3opfvLv72f1OvtxZ8FA
	 P7FSH/eKsIZFL7VIkerC0ipdwZ4/ovlfEk+ybr84A0hCJlId8Dm91PmZqt9Lc/S6UtYIK
	 Qx2exdnveXZIQbhHGY6b+iQuI7WGF3tIT3lHUajN63EZ3WY2g4ItfIxsVmLAR5/IFWSMI
	 kcTl6Q63F1XpCeGBabaQDJ4p6kSrZU+t0q7tnuyrPNcqBH0lQuaW62H5PXQqfL4MycQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IV7aCStFZdnFeaXhFPoQdGrpPnMKMt+5GDtnao0aM7M=;
	b=R7CJL1qu3KCAkkN4p7kcI/dHTTLnb72oh4dQ4y08TSXaaz1BmrV/KMNOYU75RF/fv64G
	 OAzy8gFBR46WoystijaDu+rJbsBEut7XKZZnw78CTlDeisRZvOX9x+xK2e8VkdHtbPkRt
	 RscP1jBAeY8sWRmmbrm0+tBxwvv4z1UXLwDh3UI1SrnWdebAWvfr7be3MJCHzCE6uQ8V1
	 BCTT4oLy5HKyvNttu4EACWMnkevFzQM3z60+C1eKG3+Fq/CA6K8ZgYwf6U4RQhRvuN4yR
	 2s9MwLc2UdSjhyo+t2BAl2LgEO9QIVz7ObV4A2XDI/m5jJEV4T1JZj+7IRUYP0TzDEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F8BWsB0n;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AE1606A323
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 19:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22AE1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F8BWsB0n
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a07b5f2795so395947b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795550100; x=1796154900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IV7aCStFZdnFeaXhFPoQdGrpPnMKMt+5GDtnao0aM7M=;
        b=F8BWsB0nCAqeb/AWcfO+HDVK8mZYlTd5OrAGXo+PDo4qNalYx0D3fOywTn36jlGI3o
         c+cNELy8fDLVUhaoRcT08PS33thK2uCkqwfG9C9YuYZMNa4hOWdKcnZwta+H9xQ9PyXj
         BerC9R4yihNnd8XXBnr17D3gJaZI3rr46c44Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795550100; x=1796154900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IV7aCStFZdnFeaXhFPoQdGrpPnMKMt+5GDtnao0aM7M=;
        b=gC1sUaU1ajDjZk9n3P9sSxhTy8SJz/o+DKvOElM7AEPM61i+qnr+SYHaFkPQTGoCKd
         feo+SYUEikqp7kgiAIVO9oFU4IqKiMDLOM7nLaL4S258617pjpmZTb0pYL860hwLpvvU
         IDlZw3LqlVFEfacT93bKxnHLI3wTRMKcL8ugtzQH1QQne3gr/75YhY7XRWH340kQSECc
         p6nwhSZMDeuh5zl1OkVQqa1AeirwQgO9OOtfBlUgUyOte+uWjZQsXKLnM1pbtg7eGDrz
         BsLHH9b0owAaMSFZ92JaAvY2vt/akxQiBDJsZKhz+Gn2Rh9NTMvOpelVmqt5C3w6KdF/
         WQBA==
X-Forwarded-Encrypted: i=1; AL+hErHmFy/qojFVYHBZvHSlXa+E18a59iw8zGY5h/7mbHdJDLfkZpGJrDvzKeFbpLDexBTZwAlIk+qOvjXLyR2o@vger.kernel.org
X-Gm-Message-State: APuU4Z/88INBPYlfwdGmF29n/RjSbAWBcZh8sxpSgZF0HZI6yBWXt+q4
	7upTmVRcQ8cODLI+XwKYBf2qQa3fHCARQ6EI4ukWImAfRwtVoACF4V80+EzYDG7dBg==
X-Gm-Gg: AZFdTZcADm2yJPf0ykRZikPzuPox+n6cxpuMouuPnUSlki3RXP88daCnw7ck+n6b5A2
	NMbWyUtrQTkd2DTOn/QyFUn4MIQiXDPlYN0nMGeRqtiUf2LDDpvRBJyPI0onpiOFwDeRr7ormW9
	5RWILd82yxQM1g7yts4p/yPsW4x42gKSK/K+Ze733bIsfSZxOIvXdyIzzJGDH2pyxaqDQffkvUe
	OzR8i1NN3Auc54nE+MWDBPKAtijXSHf5VUSYi0onYjlRGPcTud6tYoaeGRLrwuvV4l4pGlLqofN
	1FdTphHJOqknruYEbth2wfyXbtjI3pt0KH8Yp60HOCZntmkopvxCtSTWn73j7TOwavoVxhiFUZg
	/RugGMm9ZHl4P43kwyRsz5+tVD7cERT9NSinCH8TVJfO/MNnGGhB0Et0Px5Edg6Wq638yUapm9h
	632BbM8BffJqISWg9Qhjn9M8/tEZ/nWa8SpZVW9Y9vFXFKFnDHGIOhToyInkkGWxHcSEYWdnJhE
	CjevCJckXCAvgtqPiH9YMKmw+V38Cr+3LHZtgNbPYH0X2qg2PxVyMYD/0NfmfApValXmFZxB6dK
	4uwY1nfua+/jt9WcjLsyuFdbLJdCjcX7HHEG435BMAswXD3/c0KNTKzimLFrB7ivS2zAKw==
X-Received: by 2002:a17:903:4688:b0:2f0:7d6d:4a09 with SMTP id d9443c01a7336-2f07d6d4bc1mr137239435ad.1.1795550100419;
        Tue, 24 Nov 2026 11:55:00 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2f03f142b8bsm72335435ad.70.2026.11.24.11.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:55:00 -0800 (PST)
From: Jeff Xu <jeffxu@chromium.org>
To: David Hildenbrand <david@kernel.org>
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
	Ian Rickards <ian.rickards@arm.com>,
	Jann Horn <jannh@google.com>,
	Jeff Vander Stoep <jeffv@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Collingbourne <peter@pcc.me.uk>,
	=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Tomasz Figa <tfiga@chromium.org>,
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
Subject: Re: [PATCH v2 1/2] mm: kasan: skip KASAN for GFP_HIGHUSER
Date: Tue, 24 Nov 2026 11:54:55 -0800
Message-ID: <20261124195455.164425-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <7ed1f755-5759-4b5b-ae00-a814f16b7903@kernel.org>
References: <20261123033111.2349160-1-jeffxu@chromium.org> <20261123033111.2349160-2-jeffxu@chromium.org> <7ed1f755-5759-4b5b-ae00-a814f16b7903@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 24, 2026 at 09:10:53AM +0100, David Hildenbrand (Arm) wrote:
> On 11/23/26 04:31, Jeff Xu wrote:
> > -#define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
> > -#define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE | __GFP_SKIP_KASAN)
> > +#define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM | __GFP_SKIP_KASAN)
> > +#define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE)
>
> Can we please add a big fat comment above GFP_HIGHUSER, explaining why we use
> __GFP_SKIP_KASAN and which security impact this has?

Sure, I'll add a comment above GFP_HIGHUSER in v3:

/*
 * GFP_HIGHUSER (and GFP_HIGHUSER_MOVABLE derived from it) sets
 * __GFP_SKIP_KASAN to skip HW_TAGS tagging on allocation and poisoning on
 * free. These pages are meant for userspace data (e.g. anonymous and page
 * cache pages, DMA-BUF, GPU/DRM buffers) rather than kernel data structures,
 * and tagging every granule on allocation and free is expensive.
 *
 * Security impact: under CONFIG_KASAN_HW_TAGS, these pages carry the
 * match-all tag (0xff), so kernel accesses via page_address() or
 * kmap_local_page() lose HW_TAGS out-of-bounds and use-after-free
 * detection. Callers that store kernel data structures in these pages
 * should not use GFP_HIGHUSER. Generic and SW_TAGS KASAN are unaffected.
 */

Thanks,
Jeff
