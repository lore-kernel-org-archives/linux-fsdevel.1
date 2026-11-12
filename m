Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507101;
	b=FvC/eW/KLraiO2TtT9ThTNjZExPmLfyahQs/bVIa2cWf1aTxRt0ywapRbOQ0yyDKybDJ
	 /E2su5de31C8NwhWA8Z91GR/5SKh1WwolVaZ74FBW0iRLob7ANr1UtYTAKoSkgld03U9U
	 t3A2lnGIZZ102oXNCtqEsvuCAlcIgHf6jXZhNdDqU/w+hflcHyt6eE/KqDG/Oyn5MHIoG
	 xY/0ee2RfcFlGXdOvoN+9qNruBygbwXu3pqRP+eOjvgXE8B3ar7ZSA9yV0FqR7cRpml2w
	 zyHrIq4u0VYxCl5IzHsw0h93o6yn6GB5QQ6GLMswsH/UfPZ2fRyDXlg2HUb7P7qvBrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=vbhDJD4+BQC4thd2CH24LWDde1jZ/0BhOjMBI9uZ0t8=;
	b=Li+p0GtvBQDW430lNxwB0ikdDY7/COjQBiY3ht8vnm0KoMHOtAFvGIlgRCl5kNTJfe7L
	 op/toUORr00sp6ZgtM/qKSVxcrHrMLhUYGdHvv9a9JJ1nQpjB7kDZ6HpAopFUP07gFd7U
	 DOUwjejZBRkZiLjv8hfqI9mknw9lyjJLLRzsnT03v6+eUVGFfNQx1P8y6szOpJjDDYvbs
	 HHNT4uHRraPSLMpt2YvAZQcQY18VIeh96DMpgEWyNGKTsPYTsz+4STFQDV1uvxxMaKt3S
	 lJjczhobel/5jXqf3UGvB0Q2xEjMDWcum85kgxtHmNGr9ZIqPewoM6Gj6huhJl89rBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=M+YUKf86;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461CC606A333
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 18:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 461CC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=M+YUKf86
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93e635220b4so1603185a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 10:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794507099; x=1795111899; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vbhDJD4+BQC4thd2CH24LWDde1jZ/0BhOjMBI9uZ0t8=;
        b=M+YUKf86JBPSifV9KHZNo/IxkhlariouSze/wFvYmxecLP4M+6xAZUhrMz8gE2MYHO
         lYJ49kyJas62Vgxh4zG1raIwc9fO2zqjj7bJz+BNADsw6yR4eLA38ko27KzlYs3Vpy0y
         UeDHfXAx7Tugez+dsbekHeJIex+zCllOcxf0v070kEeCohrpccAuYuwq4oubwcUfhVGb
         m4ExPq/MTUzCs9adjOmKOJpRMD+Z4DgmQXD6QdMV8OyBgqBXTYzOV7QiruZECqK/4xt7
         BoXXHg6uHdXiLuxrua+v0stzvXViN1wB/1q/3QErXiw5TKlV38h9pHDcTC+3HnbBwoxo
         Z7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507099; x=1795111899;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vbhDJD4+BQC4thd2CH24LWDde1jZ/0BhOjMBI9uZ0t8=;
        b=zmRi0YNTXm7lsQZ0ZWJXr6u6+VHTReokGOHnpvMaYIycCN4NgAHtYGHOQ2MlJN7IWc
         YMNw5wCuG1QDHUObKLJk70mec7WZF62GvDS+K2I4j5OBGG5ezfCinGfqlXayBBtnauwQ
         6GTxVEippfYJOLE8EDWOs4sp4qXWz4o9Rk3xITS/e14zMkJb1lbgrBWoDIHXpaLMjjjC
         LQ6YbbzML2KYBpDjjk+/Ru7l5M8j/9cL5L/HF2RKiOdzX9VuRvabnfSxNJP2pJb2YMJh
         oCfSowbpaDB7AIEkXCloWdPpV8SuDgTUJPDmwgeG9qRLpWI9RH35BMqLL/94eXupI0Ww
         iYRQ==
X-Forwarded-Encrypted: i=1; AL+hErFxAfpxpF4ByXCKAnbSu+G1lb5IxFMbcEEbbcKH0MCSHMxwdqYtXyBNg/erAkS5X5VsLv2iXrpHtiJb6P7t@vger.kernel.org
X-Gm-Message-State: APuU4Z+p6ijq80PSuPd12ybWEeLJ6+xRvjydWJSwuoWqkyD6Fq5lQhXr
	umnY3/2wxtgGLk87cOh5MwjUQSnMGxP3j/oUtsQZk2BEjBwvfmMgdNVRtuOxjxXChsc=
X-Gm-Gg: AYBFou1D9wV04wCPUKr8iq86pJEy++iZwHiJrPmy1kn3+E4mgFGcLqDPtlsWtijWghW
	KeXA94jVHg2yClE5ezohvx1wvXgGv7tHbYDGjJ6N361bni/8QMAy2YQQLI0mdY7Lr2DrP7lJf9+
	jNJW9NkR17k6Vy3Um+Bnl/FERVlCu+7tUOfgjsbyHK4ozA2D9r3dkqeFVcsQgY8z/u3UWj3fYOb
	TktOW1XC/Qe3jhgM9GLxHpB9z3y9VV0pzu7e0PFEomeSgxOJAQfs075R9vMays5/79ynwmON35h
	QlbnoMxiqTbSNjp90z28VO69Pic7FVPv2Ozg8U1u4QGaLysR85LTuYrNCux3PkT4lT+QXgv46p9
	KNm6U6Q9UD/gRTgANimFLh2FiiDASejhiTDfubi3VPRF4WD4Oy3bu6Jrb08BYX9hQ0qrZy66HPG
	wPt4ewnKK474OrR74J6Fsh/thF+N55QTaN3OSxAZrGmx87ZJV19qQLImd6gnFwFMkCxwt9zJCUL
	cLocU83T5vZXAdKPHbLA2mv+RUH8zDYvTGAqnfE89EbOM0zX8aasJuBlLQq3T5okb1tnfBuezVT
	6WLWMNqTUk/716kbRUaHF/e6nfNXeUuqq3DgyhI+Xs/cjZWw1hZdLs0j9/MlJFOTM+9GrvbU5B9
	44b1iJKs=
X-Received: by 2002:a05:620a:410e:b0:93e:c12c:fbc4 with SMTP id af79cd13be357-9494bcaf24cmr27719385a.81.1794507098958;
        Thu, 12 Nov 2026 10:11:38 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7845fasm776538885a.18.2026.11.12.10.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:11:38 -0800 (PST)
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
Subject: Re: [PATCH 09/13] mm/migrate_device: fix use-after-free of the
 anon rmap
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
 Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-9-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-9-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 13:11:36 -0500
Message-Id: <179450709690.482102.6960491372735414259.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> A munmap() of anonymous memory can result in a use-after-free of the
> anonymous rmap if a concurrent device memory migration occurs and the
> migration runs without the mmap_lock held.
> 
> This can occur for a long-term pin of device-coherent memory, or a driver
> evicting its device memory by PFN.
> 
> Consider:
> 
>     eviction                        munmap()
>     ========                        ========
>     migrate_device_range()
>       migrate_device_unmap()
>         try_to_migrate()
>                                     zap the migration entry
>                                     unlink_anon_vmas()
>                                       last VMA: free the anon_vma
>     migrate_device_finalize()
>       remove_migration_ptes()
>         /* locks and walks the freed anon_vma */
> 
> If munmap() runs before try_to_migrate() instead, the folio is no longer
> mapped and gets no migration entry. The walk still runs, and follows the
> stale folio->mapping to the freed anon_vma.
> 
> Resolve this by pinning the anon rmap of each folio which possesses one in
> migrate_device_range(), migrate_device_pfns() and
> migrate_device_coherent_folio() before its PTEs are replaced, and
> unpinning it once the walk is done.
> 
> A folio which is no longer mapped cannot be pinned and has no migration
> entries to remove, so skip it rather than migrating it.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: e778406b40db ("mm/migrate_device.c: add migrate_device_range()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Was able to reproduce/observe a slab-UAF in rmap_walk_anon with KASAN
enabled, and that this patch resolves it.

Can't say i understand the change well enough to R-by, but I can say
this resolves a clear bug.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

