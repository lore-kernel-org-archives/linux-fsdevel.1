Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501612;
	b=SFyXv3i6Uxrq6nZ+ais/3hHXEcUJImsXnp8BWT0S5GLSwCUb8kckHLmZ3ZJlqO0bNXlq
	 0ZjO8gbY05/ktP7T2BfnDOAEEJ/aXtQ6PqWPJ9r91cNqZUHVtEOrsYm/9SZLBVcSyUta1
	 lsRHEp3mrK1UxyCdqttKbofZk4HljzNQkuygnEGT32JYoueOqVIbLocl90d6lSjQqa2HC
	 WLGHOgDOe6JKiqbSB2dk4bSvHrfQ5L7swoeTYJPqWLXjC6jPQUvZb7xKQ771ubwAKz8fb
	 8/Rrv0Iop2AOcuhQBZ5vktyQ9qzXDppgu6bZczrZED6Cv8STOGJO1lRQxQcyEG8lciQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=gtnUQwywPg0HjDfSf6ZrnT5Doe5dkWtLl9mYnrnpV/w=;
	b=WoVqPEaU5xnZsaqIFoULXf6AF+uhywkaFWfQ4RVtsiDPqKc/7F+CvmGpu8qXMbxGIRaW
	 hlCjdR/OhL8dFUwQ3xQ4xQbU09BUL4WHvBBFTq8cJAPid+GdHZ8TmXORlr1Tlaq3o1WYj
	 6KjoBa12+YdUQ1bodXDrhms6Tz537ceonf2scexT33y4ke5rBxkm4jRhsb1NubsS0VLWM
	 7n3m1yVBU60Yghwew6OWam2YPEcMC8fn7Et4Tq8KtCf1P3g9+bKLnSU5Pj6yWK6Xxp1Zb
	 URlte/2APtkUtoLoa/zKwoVmNwJeR9HVgEjDL81HtH4e0RHesJ7YomaZbVSQWXBhZ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=O+DAQ0p+;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A860A2637
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 16:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E8A860A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=O+DAQ0p+
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f079a63b8so446420385a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 08:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794501611; x=1795106411; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gtnUQwywPg0HjDfSf6ZrnT5Doe5dkWtLl9mYnrnpV/w=;
        b=O+DAQ0p+eIDSWQW3zo2Q/MrrLgcOKNX8FdCMKb49EJWHINNSHZaTfsadj2jmqQ1g12
         LnLu8a7JhBPx0qycHLmEdEwec6SWcTnhAUd2fCJBOA8M90SPmDF0wCrtCqPZXQyPHn6b
         a35PVEXvOhs1FFJfGl4HQvD8aaPL2YOPGzQ5y4c/+OnMnEFPKZzX6fbsaB5aHAlwql6w
         Jjhm6UEGtNlv88Hxte+DwArsoTMVDpUokmmhrD/VsRXL6lWI4d/IfGSLrv8eHbaQljAj
         EwFC71R6o2ws7Ex2IpmCb0VcIgIe68rZbENbCyZxtGtQzOArIzNbkHa+FizN6w6FoC1e
         0okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501611; x=1795106411;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gtnUQwywPg0HjDfSf6ZrnT5Doe5dkWtLl9mYnrnpV/w=;
        b=seoNM3lLBLVf4LFxoWwlhUqKO/0VcaUQm13uiQJ5WokiK4jaDkfz7WPcnUAFzF1DYi
         XDpFFKg3VMx76QOlD21c5ATJErlj/XhlDZycd2AvEwhZGi+nv0Lpa/xb5NNpB267ZzZl
         bZIPhWyboCxNIwQ025idbPUvY7rXmEoTuQYfdW1Tdx9cyM4XcisOxHkhK5uCb2f56P9/
         akCdiEtvB1UPfSxrxdjHDPT5ZjFvd0yMTZBwh6DjHYm+yig1fFRuzzaMyZBqTknH0gsl
         ZZf4zZcprDc9a0/qvjo2ZwX8FdMxaFXsqhVlbf4ik/I0uox5HovmO7cNzXzR47CNZNe6
         QRvA==
X-Forwarded-Encrypted: i=1; AL+hErHYLfCSWJ+XHH0AuHbo1lXNdm9fzg8mIO8lua99sE5A+/gl8b0L/A5LTe3INntcF5FRoLo/AD0PdbViHmca@vger.kernel.org
X-Gm-Message-State: APuU4Z+TJe1kcuJqoMsKdXrUwQ1Y9YeUMBk7HX3aPYDqzvQhH+maGGLT
	yOFnJZxe8fZ3++X4G5KPWQDk+Z1GRRvFTx827yY0Zm9c7zY0dTHcNPKop6Y2Zhik32Q=
X-Gm-Gg: AYBFou35INCT9wIOi6aPuycB+KQk3oyTJEOF90rOI5iJCjGO5R3xzcDtttEbL9Y/RVd
	Xojl7XzhdRLF36oKmj9FGfBjWvTE9O1G43drTdsuRvHMasPZO4wBTYeEQglO3bfUQSWy6Dsah1Q
	g9y6wDUm7aaw3at2t9mBrdbIZcdgi/plbdtG2WOjlZ2uVCEIuPCgtngYRmsIsaamlQ8U//Dz8ES
	nubJclxluEoO3eQz+/beIyNlvDEENiWPmjHRXd9NFSgChb0B2NARmMmhAVFnPvbYKLQXJFQmMXV
	U9leb0JV+4t94shRC8PUCxkp7PROSWqBe/4aRK1P6186g8+HSi2QCnGi0AEj+XQkE1ZcwNXlwK0
	xYC/H3oI3Sqj2mcT2PQxcQwPqViLB+ttVVu2ni07yZ60ujcZho0Kts/oUQ72yLhSEbA7/yoLh4i
	E1c5vMOXlZCsyn9D3WgytEXb4F+jxlL6fTdpglfAC5Ba8khhlKyMZJeibkP58i9Q6vXs+//rwzU
	IqiAxN4VxZTX97y44IAzZhowkAGvzij/rE+K/m/bQZlIFLJ+7car9zI5Gtp/z1t5GBp58Bw/E1z
	Sbsas3mF64HPLdw4a7+adTfDIR1u6zk/mTgEPMXD0D9wqVlprGYSP2xnEgAmImT/kqJa20wklaN
	QNNZWgE14
X-Received: by 2002:a05:620a:4626:b0:945:ad43:1d59 with SMTP id af79cd13be357-947b000d7a5mr1094709885a.75.1794501611290;
        Thu, 12 Nov 2026 08:40:11 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7ffa11sm759904885a.43.2026.11.12.08.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:40:10 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 03/13] mm: cachestat: restart the walk after each entry
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-3-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-3-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 11:40:09 -0500
Message-Id: <179450160935.482102.15213700511149025586.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> cachestat() can leave cached pages out of its counts. This happens if
> the entry that the call has just counted is replaced by a larger folio
> that starts in the same XArray slot.
> 
> The issue is that filemap_cachestat() walks the page cache under the RCU
> read lock, so racing concurrent collapse/split is possible.
> 
> Thus, an entry can be replaced immediately after the walk has returned
> it. When that happens, the next xas_find() skips the sibling entries that
> point to the slot of that entry, since ordinarily they belong to that
> entry.
> 
> However a concurrent collapse_file() or __filemap_add_folio() (when
> replacing a shadow entry) can store a larger folio in the slot, in which
> case the sibling entries belong to the new folio and the walk still skips
> them.
> 
... snip ...
> 
> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: squashed 2 commits, fixed up comment in code, and commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

