Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500145;
	b=HlCDgO1Jx+tyawbbMxhIeuepSoP8iS7aD5jXlXuZ8LkXmya4D2KLSYA1VTElGekrliAh
	 bGQkTf6JkwZhDsR9QaiI28RKyUgJoV88N2Rk9Os/heScOaA62o8VZgSOf7FwphgegP9oo
	 4v67A4EvwKjvLR3TRxMc5VqeUdN/tR/B0nWgLDPXoyT6VrLTHSOH5DR2m4zjCjC493Gwp
	 a/mbCIu8MwDFTx9TetUey4bp3AOlO9zMVQACImCE2LHMaRkYvXk3l84vFFsCjOiZsLD7I
	 NGN1pPTv86hfkGqGU6MGwJAyL1KSKjpXA/thiyof75nGe9/LmnU/JKKNJ54IjjJkz3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VnUBdoc3KTMUe7EeR2rhTTEffXeqsYq/yZz8D3wwCd8=;
	b=xH3TTXVetUSuxyHnc9m0Fx2epSxlTeFHc+UXfHUV819MDzjuFpdPTXiCjmVuz3eV3FX8
	 nZetIBhhBhGuABsDlB3VRNyVs+Wi62VB4G2Axtq43fB5+kzlQPV2BEkLhNZzp4Dk54njS
	 mwqPVR+c5Elp8Srv9B2RicvwD3oBTY9nuG5t/c8Z+Onf/TL7/VAC4FuOQLyrliSOGjcen
	 s/J3UvI/pMzIBycdEygKCgcrxWJz8cQ8cM+UOOyBaymwtcBR5t4P35otjU+vYsqnZJ3QG
	 mqOG0gpRtlxCKQHAnWiL38O1hWUVyPLnt/1sfz65/Tcxl4bPiu1vukM1MXkb3DNW+Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=CIR02JeM;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD881606A88A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 16:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD881606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=CIR02JeM
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b3a332105bso11202877b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 08:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1794500144; x=1795104944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VnUBdoc3KTMUe7EeR2rhTTEffXeqsYq/yZz8D3wwCd8=;
        b=CIR02JeMUeqiwaNu8adwhYsGO94jwgFq4bTAnht1vJREgKSPzbmZSb2EZd+sWeLUVp
         7nF3EEqCyqWAuRi8HgQEGY5lyD0SPNb6/UBKozHjSVdha6RjiG6JYWwWEL3IKIC7F1/X
         wAJPMJcEDMSck6TcKQEiChSYxGgraYKPQAVb7rQDacU5lZyuqyoBuZrnAbRpzQ5+JP+c
         25ewY62SYqnw4fwQeYGOHEwPM8mA898RdWmCh3SlxFXJBIjIGTZ5gs/7XqdUfDNrlLJR
         2ImpPBJIaEGYOlC28uXL/ZS7iozms9kF1K5tFd+BPM7pgRIw/gYQlgOKW0ucyU4eUb8K
         tiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500144; x=1795104944;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VnUBdoc3KTMUe7EeR2rhTTEffXeqsYq/yZz8D3wwCd8=;
        b=H6K3nVeFc5be+LcFtN0NLfhJj2QafMsX0X2cNT31tWk7/zwjYqdwCZx+97Z3lt56b9
         3Ltzo/BXxw8R9n9lDVBjU06SaN4dlQuKmxEsEUcln/zAu47MfgzWDViWawvcqwZve063
         RAXL11GcPLu35D5IXpb3GbAnVJVmfY01JfN/C+X94YrMszfIH+yxJiCHMOqEWuVBt6P9
         LOqD8cpvlEgMX+b9YVOWPW9fAUQjK1IyhfFNM/14LVHlPodTyiqGmj2i2mlceAYcMsHu
         mOQunM4vBAl8K7fdl5qOY7E5+iXmLGiZ+WlZ3Jiv4JFA0w59WQSUjqDpMJA3b7YUuI02
         Od1w==
X-Forwarded-Encrypted: i=1; AL+hErHIMhw41uiv6IEovh0HZqMPJ7xKF86tzBu74vSW4CTUzxkzO7Ca0li0UwCs3zqOym77CTdWkJ3kXkzflyFk@vger.kernel.org
X-Gm-Message-State: APuU4Z8XZ/G+TdkDLXqto4YCKGPBXyK4ONAnhmQLrmrf4quEPjBm1U0Y
	4oMZMNc7peTcZtTkFGHYVr1q6UiQdnEcQPGmTXIZXsFRD2bFYSfrXZhvb5pRxeezc5Q=
X-Gm-Gg: AYBFou0PHFzPl2u58cmDhYLus+L1+DTFuRY3lxsxHKrlbwTp2CwMTzVVYV7Rlz8Hnqx
	0iHmNe8SQCjO5jLmNBjVyQaeq6GT9TvO5SOvxFygy0cLk5c4Ev4KfS0V9bspUn2/FB2PYorynKY
	NH9DOuvhzHQ8o85GrYavwOgRJ4BzOl8mbPDm5a7DuZeuqkkaMDOBssM4OfUKHYhcy/wp3oKHYK2
	ifOHdFbJ5BLbTgsVLI2UqQp5LaCAS7uyUgyrWEUBXqWpixBc/2bNx3k6jhm5/j1XoQYC+shTiQI
	qWYMs0K03PKMJe4BmGlHiAhyYRT3FL3D/oGgMe7Me0h6cQmFholnu/1lxDm6rLzA/mnxcyzFHkG
	URVrH+G/yQJMSamqDn5VeJOMgtMvMDsw0qBk2Ng4A6X1IEonjRBGIAUtYk1q1/bwdOQUoQBEA3K
	ircQ3OdulRmqs06j2/pZAgqyIO20L8BJFEXgz8UPutCz5JTS5doaQQFicZN62ckA5/WreA8HFMC
	BbpoXTquoOmxcLMdi1qQv09JZTDksjg7g/mBN5p9ezTFhSmkLC1x8dmNOSU6mRbGT1W7NNKCR1q
	kAa8Of2a5WKGuhHmDJiITv6gNFdf
X-Received: by 2002:a05:690c:97:b0:8aa:e4e7:c5a with SMTP id 00721157ae682-8b3badcc919mr23037017b3.5.1794500143784;
        Thu, 12 Nov 2026 08:15:43 -0800 (PST)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933d4317sm73615477b3.21.2026.11.12.08.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:15:42 -0800 (PST)
Date: Thu, 12 Nov 2026 11:15:41 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>,
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
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
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 03/13] mm: cachestat: restart the walk after each entry
Message-ID: <avXmLaznzWy27g5K@cmpxchg.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-3-3d2454362e8d@kernel.org>
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
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-3-3d2454362e8d@kernel.org>

On Wed, Nov 11, 2026 at 06:13:17PM +0000, Lorenzo Stoakes (ARM) wrote:
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
> Consider:
> 
>     cachestat                         collapse
>     =========                         ========
>     count a 64-page folio in slot 8
>                                       store a 512-page folio in slot 8,
>                                       with sibling entries in slots 9-15
>     xas_find() starts at slot 8
>     and skips slots 9-15
>       /* 448 pages are never counted */
> 
> Also consider:
> 
>     filemap_cachestat()                  __filemap_add_folio()
>     ===================                  =====================
>     counts the shadow entry in slot 0
>                                          slot 0: a folio of 32 pages
>                                          slots 1-31: siblings of slot 0
>     xas_find() skips slots 1-31
>       /* 31 pages are never counted */
> 
> Essentially the fact that large folios might be present means we cannot
> safely continue the XArray walk, and must reset the iterator each time.
> 
> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: squashed 2 commits, fixed up comment in code, and commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
