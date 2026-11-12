Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487735;
	b=k8HqOLrnpgTNby1ftljDpCIiZa1Hk1xHy1Ry6GBeerM3G4w7tHWs+ZYha+f57mF8HZdJ
	 hgsXA11+tXw4P9Sc2xpJ88/X9woPTBqI6lMiuWfygr4ke+N6uWOeKBNqTSni/onSwLHO5
	 iJpIpQcwFPnyx5QreuehXA5R4J+uzj/p2jihFappIpOVm2YpXepfOEXSBPsrsRAFzbIMO
	 9RlHLvbqmtwYwR+tevgGRu5MbGdouRKyEx1FrawJ9ARi8OxShoWgURJO8sZD5vc/Fv+un
	 vi+RDj3OkFVuRAf4umkM6pqVrrbxZxlU4x9jlOMuWt8mbYAllO1g9bueocs5XiJP+Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fpPYP3LwQ7UH65N0IOsMYcszMsGFfM1KkS0iQ4klOAA=;
	b=sGJUV6AypQP1CVoH76m9PsXRtuPSWCCZINrwbYjcVJjmOuXZ/PqI8clb7behV2dt/FPV
	 cYVJiLU6I5s/YGqanflX+uDq0ezy3MuG0JKXtc7y8t/KkOFvF0lzDvxlfgyj9fCphGXvm
	 6wpA9+LaheIzz8KXsuCh+tBnddyaMyw6rikq/pHewOnh4BWCxOAsxHmm6jlxMWmdNa5dg
	 ytlYZCEpirjbYG65cJUhz8HdDIxZrmY74Nns2Hz/ubqIio6eMw6MF8FXTF13DQnmEjvbt
	 OWci7BEQnGYlbmF7rMcXC9a71UQKwNfBFkN7Q9rz2i4uuwWclgD8odbyISVm658pvAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=IFFBVctA;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939CD606A32A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 12:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 939CD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=IFFBVctA
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso27287235e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 04:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794487733; x=1795092533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fpPYP3LwQ7UH65N0IOsMYcszMsGFfM1KkS0iQ4klOAA=;
        b=IFFBVctA9vvTAyP/0s3JWanNwy1/EcxnDhkd8zecNe2Zf+clmKb89wyzJ05R1YSHXV
         LGyoa0dx5KRbjIqfPaeosKW4FG/S/TZ/bOzWAK3XQumO0htQZJfFTt/F2klbSUyWCNaQ
         UF3hx3dzAKtUu0xqzCsfpxy72op0flc9e0fgdTlwX5B2PNNljnzfTa0/Pt/1WbbZVmge
         r8OGw1wv49O1zcCNCHah1dBqI4xROCfQEeTbiMp5bcSXoRt6mPDtJAQRrwLu1ozcKZ/P
         qVAa+0BOCYHl6xriwV51z631YJ8BDLYVDO+Y6ZTTfdCoWZSV4i63QxofQ/Bzjzx/XaHi
         LCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487733; x=1795092533;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fpPYP3LwQ7UH65N0IOsMYcszMsGFfM1KkS0iQ4klOAA=;
        b=TkDm7cIc4Mm+OLr58VVU8JUYwVMFikk1CQlho141MVCZ/iap+AR4a0k7BbuSrpzk5T
         lUf85VM4C8UvnSBnHYm6m8buaEybX5j3GPDluNU1NjYdx5DD2cnEMeJAIz2t82JrtCd0
         a6U4sCi0LxjI9Yhy1Z6oGobbIwaEpk9+dkJu8EYmLyvCDSjR6UM0tqwhqEIqr077GP6U
         UMCn2+6b9Nze0SXeSKZZV6VRgjOYXRPEKVH2fdXHv7cLRO83HKJwZR+hOu7sO6REXn9J
         iPLjHlneOpWYUdrBzIQeQzEXt51p7y0Ho9Jxf/Dx52D/2PhQK1P1A5z8CbQhvdYDdP69
         4e2Q==
X-Forwarded-Encrypted: i=1; AL+hErGf9Jo3uZ6AdA+2lrSEMB9tXBej0p37E7+ZjozKcl+g92m+dGZZ7BTL7jwF1T27dm+kL0HyLcBUVUefYplE@vger.kernel.org
X-Gm-Message-State: APuU4Z8F7aYflC1o1r0PGPj/qZDDeOttJVwF3rYD/18axAuRGFfRxsYw
	My9yUMm9qupgKK9U4WzTp265MZvYE8cz661So15totXg7woLunH+FWLXAwitAWZKMSc=
X-Gm-Gg: AYBFou2WoPGh2zzbHjCtid6HdWRveaTD2oGhQZc/Nlwdshz9mZSRxDxjdJN7IvJRCs9
	ZhF16Ivc9cx9/orrciZTgpg1gtZCt6Jzm8oqRJBe3EHw0zbKs1gdbvQtUloVdCNhw0QkfK7h8vd
	q4fLXSYHG54BrqA56jeN7fMAoJPsq4mqmbGQrI6rcYXRsvvInLEQ/8A9pgZ1T7h/16CffH63eD6
	JrY/RYTcT8/889LRKJk6ZDR31FGEw7vQ3acvXQ8wbK3+4/RmJJx4o6Y9aWDU1sv21JvYtdsr+wo
	StyMwb54zURSXY5dRZUpq10RxKSP2gFL+zjQhgkKl2s3/SI7zXooWqj2ILusm1AKIHKv/69aRlZ
	5xVqyXyQBQzDROPFFLLamQzRCG2H72AtAMg5JGp+J+Iivgr5h0ZeDRvlo19BkLt65R4ndsagFJH
	UKGLZo0bB07eWrwbp8PjPyF0kyuK8Ra12xV+MqzWo92yIpo0on4vbzu4v0YcnLYL929p9M3/rXH
	xYntUkvZAUT7M+EJeetOlSGeGBLmsreRTNh4OkTDKn+s68PGj+KxpD60IsedIez7k4osM5hfiVY
	YPiuBiPsqtNELxeHjtB/NfVla8d0h1Maqip08fEFOpQ=
X-Received: by 2002:a05:600c:190a:b0:4a7:9006:b176 with SMTP id 5b1f17b1804b1-4ba0936c8bfmr102512485e9.7.1794487732984;
        Thu, 12 Nov 2026 04:48:52 -0800 (PST)
Received: from localhost (109-81-94-245.rct.o2.cz. [109.81.94.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e251491sm71286495e9.2.2026.11.12.04.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:48:52 -0800 (PST)
Date: Thu, 12 Nov 2026 13:48:51 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>,
	Balbir Singh <balbirs@nvidia.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>,
	Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mark Brown <broonie@kernel.org>,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
Message-ID: <avW1s2wvz1PB0-Ln@tiehlicka>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
 <avWmfXu39vtp0DM9@tiehlicka>
 <avWsG-zmuniUFio7@gremlin>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avWsG-zmuniUFio7@gremlin>

On Thu 12-11-26 12:14:32, Lorenzo Stoakes (ARM) wrote:
> On Thu, Nov 12, 2026 at 12:43:57PM +0100, Michal Hocko wrote:
> > On Wed 11-11-26 18:13:15, Lorenzo Stoakes (ARM) wrote:
> > > The OOM killer can quickly trigger again after having selected a
> > > victim. That victim might not have freed its memory yet, but its mm will
> > > be marked MMF_OOM_SKIP by this point, so the OOM killer will ignore it.
> > >
> > > This can cause the OOM killer to kill an innocent process when the first
> > > might have freed enough memory to relieve the memory pressure.
> > >
> > > Fix the issue by freeing the memory before marking the mm MMF_OOM_SKIP.
> > >
> > > Note that the task which calls mmput() might not be the victim - if it
> > > took a reference on the mm (e.g. ptrace), it may hold the last reference
> > > and release it when it calls mmput().
> >
> > I do not follow the reasoning here. MMF_OOM_SKIP is called after the
> > address space has been unmapped either by the last mmput or the
> > oom_reaper (or both when they are racing). Now all your patch does is to
> > call tlb_flush_mmu which I suspect is to release batched pages. But why
> > is that needed only for the oom victim and why there was no final flush
> > in unmap_vmas?
> 
> Sorry maybe commit message isn't clear enough. I did have to pare these down
> from really massive ones.
> 
> And yeah tlb_flush_mmu() is about freeing the batches.
> 
> unmap_vmas() doesn't have a final flush, it relies on the caller to figure that
> out, and just batches up.
> 
> And currently tlb_finish_mmu() comes after MMF_OOM_SKIP is set (in
> exit_mmap()), so at that point the memory is unmapped but whatever the last
> batch is isn't freed yet, and the batch can be large (PMDs are single
> entries if I recall correctly for e.g.).

OK, this makes more sense.

> This only matters for the OOM victim, hence reinstating MMF_OOM_VICTIM, which
> made the patch _way_ smaller than the one proposed :)

Should we simply do that flushing unconditionally before setting MMF_OOM_VICTIM
then?
-- 
Michal Hocko
SUSE Labs
