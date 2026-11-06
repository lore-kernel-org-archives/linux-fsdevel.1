Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958143;
	b=rrZr17W1oZ5vYMMGmZ4U+fqtH51Wz6ULri1bKUIcfAiPOfWB1FgmtzYvoqYQXB5WoRyi
	 49osTG4SwsYjbvRf7FuEL6V3Fq+lhvPugbPfncXWXOn5/KSHrCMkZaq77rVfneK6yZaFW
	 l/5DJ6EFok2FyTcF87+3wbuatbiUfZoW7tRrl+pw23MD0m1U2J6RcX9D23zy21J06QY9P
	 Gi+QK1qjBr8P19CDoIwIGTtQr/Bq9D9szUdOWRXB/0/ZeYvDxWw/EtBb/pHH5c1bTxkgu
	 SBQTFtxzbFX/QIL403Wfld12qC7rBqMXTepVnlVqhvMvvE6Jwz5T7i9Gn9aJgddGtJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wxjoU6eh1AnEB74q9TNTzzgoHGIbkez0gtAfCeShC9g=;
	b=tCTmYDk4fTRULMSFIvbm8WnCfwyJtO8zxC37SABED4p818NZWUnFYkeHvWWghYaGgQXh
	 +CalNLGPtRINF4OTUt7ufDNgqJFpLVkDAoMvvpyU6DaDb+oUMc/DFAzhsSDBf6wGrpGmj
	 x29/jlBUYHCC4TeFw7DkLHI8xWk5yyDyWudZwGwOnwf3jb6/SzBaxPaS2htenarpmQq1o
	 Pnf99Ooj0vCRckKrc1fz1ufo6m41BXmaoBPn1Z4iWNVPm3WIo1mwIEgroJFftW/k9ojHT
	 7FDVeAJ9TPDnY2r6CXY2V9hLKOV2Jdj3qR0EClNxY/WrX7RtJwHLCUUgIq4NXD//bzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5aviNlW;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05CF606A90F
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 09:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05CF606A90F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5aviNlW
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b467581b98so3093215e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 01:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958141; x=1794562941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wxjoU6eh1AnEB74q9TNTzzgoHGIbkez0gtAfCeShC9g=;
        b=f5aviNlWe44WrD8IRdQX6ADMuIeIzKR0W9+k5UrolgZdhp5s/PGxmiZR+YoERBoVJ/
         6icSuT1pJK1BhDf9IIxn5cOoFPu3PXRcOjMBVS/auhQmMFJtiS811F3SN0M+HYUhfQ3z
         zv/RNhWZeAqD7XzxOLY04ZCApDq0VHzqjeoX1GyvA8W4WDjDzzcBAxWierLV9QWXD/NZ
         UQ+7cbI6on3aS/XAL23R+H0tD54FGUBzA783tY3f96ogm/iz8k5ihmez/pJCMZMaPljs
         p05ksTgKwyP1b297hjQpu/uHw9xgDm+3JpKi0vgksCEUrs8AbsWwzuqXcRGIAUH0fsFK
         Fu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958141; x=1794562941;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wxjoU6eh1AnEB74q9TNTzzgoHGIbkez0gtAfCeShC9g=;
        b=BxNm8MFN+xVKwDBOMSgIqV+NBpy3FFvTWIYs2RkZGQrYiklsGMgIlAXgxy4MDDUwjy
         pyNHX97itkgoPCCOb1+oUg0ax0MhcQzw5mDmPLRe0Up+yBKkF213kCPySDy3hKH5GKVf
         xrYxrBAQbwTdiK3vYxOGw0SJjG+ETMCaxOxGrGf2Aty+7Rhaj94kyRqB26/C8UFpTsBL
         A5wbS1LxwrrVhU1rIjhTL/FnD0PnN6dwfdlFxAoVZ7uuBHTp3TAVhwthVp1IUYS46+oO
         qlAbo5djan5gQx1J7QUdUiW5qkc9GkO5wZiPoWLUI0XnEQyeDfql5kdj0c2k2e0p8cCk
         Rk1Q==
X-Forwarded-Encrypted: i=1; AKwUvByr+IJIiznjiHqvu+xXlXWib9YIBD8VVDlSPePZmD89QEIxcNOels9GrmFqTjR16tr2fUQgh5FgHUsrCYie@vger.kernel.org
X-Gm-Message-State: APuU4Z/sLNI5a1MdqQT9p6T24UBMxLKZUK53DMyZHtLsbe4Y2lYco1ay
	obiQBcsUhEzQZhrnU5yoPcjHGLD3sG9pwYEUxvDsgYPh0AeC7U/80Eix
X-Gm-Gg: AYBFou2h+GZGWjCOy7p6zfo5JCPZzrClo5wZn3ZnqqHt7jBOzmi3Ot+4caJCib9FLVx
	Nd6TSWUwI8Ow5pGpRuu2W89ssu9admB0NsAvwJYFrrulcxIq4rDstDiMjiRss8NMFzm9ltgw0gy
	ZBx7UCj5WcR8l7o0mwCkV7GNOQHUwHDwe0og6O83MOjd6Q/rPK/bPrUAjE3tHuefT+FQeum9gE7
	rfrL2QZQVThEwW7lumm3R/bhJfs2ykZ7l/DkW1DNpPg3sftFnn6s5iLQ9cLtdXxyv10Vg1UJQma
	ecUL1RlNjRRINq2fiKEcSOACpu0JR0tN9cSizqLUsOtglhZEXejnu9lyxAyXCa0V/c/EAMT1gUz
	Xw95m3r15yh3e+DEjuzxFKiIK0VQ/nD1/RlwxbzxZFCDHE9zwAkDzwH0t8wsut1FUPckfsUi3NE
	Eo0aOqXkW2rHwo7vCbkYrFTH9l4kC5EdRPTwb3CUp6roYR8NTmZm60VjyH/QW1PDU9oWOimY04W
	KIzw7ceVd84kZ5mHUdzRdQjmiQsXTrTF5sVqZ8N6+axHa8rgx1qpwnvChyTrkP2rv++SVm9Uq+A
	vgR89ksZktlULMOdu+lQg94=
X-Received: by 2002:a05:600c:c168:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4b6db2ba2demr25269125e9.4.1793958140866;
        Fri, 06 Nov 2026 01:42:20 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b741cdd8d7sm22361285e9.1.2026.11.06.01.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:42:20 -0800 (PST)
Message-ID: <528e3a0e-04fb-427f-88c7-63a7f4bbc505@gmail.com>
Date: Fri, 6 Nov 2026 10:42:17 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] mm: limit pagecache folio refcount when mapping pages
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> With large file folios, overflowing the folio mapcount and refcount
> became possible. For anon folios it is currently not really an issue:
> each large anon folio can only be mapped once into a process.
> 
> That's not really big news, but it's about time that we do something
> about it because some modern technology might find ways to abuse it :)
> 
> One of the enablers for that was commit ddc58f27f9ee ("mm: drop tail page
> refcounting"), however, file thp support was added later.
> 
> File folios can be mapped multiple times into the same process, allowing
> for processes to hold many references to the same folio.
> 
> As a short-term solution, let's introduce two folio refcount limits:
> one for ordinary consumers and one for admins. Leave some headroom
> before the refcount goes negative, which we really don't want (having
> the mapcount go negative is also not expected).
> 
> Start reporting SIGBUS if we run into limits. When restoring mappings
> from migration entries, instead zap the pte/pmd entry. We allow for
> slightly exceeding the limit to keep things simpler.
> 
> This is far from ideal, but better than all easy alternatives we can
> backport comfortably. For now it fixes the big problem: letting
> the refcount (+mapcount) go negative and cause trouble.
> 
> This is only a temporary fix, we'll follow up with something better.
> 
> While the refcount checks are not required for order 0 folios, let's
> just add them for consistency: each folio_add_file_rmap*() and
> folio_dup_file_rmap*() needs a prior check.
in mm-new copy_huge_pmd() now does a folio_dup_file_rmap_pmd() at fork,
since Konstantin's "mm/huge_memory: copy file THPs at fork like
copy_present_ptes() does". doesn't that one need the check too?

the rest LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
