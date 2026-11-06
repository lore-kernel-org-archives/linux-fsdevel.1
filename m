Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997979;
	b=S10VcyBum71Ao50ci5z3AhbhSHuCGuxovCym8j6/FqzO3TPcipS4N72Wx1OHgotcD+Lo
	 LZKKMSNJEg+ZUXMlo5vSXm6CEBUYSLfOdRqcdH/+WxoyiVqUvWnVtl4F4ZjvULyRg43mC
	 v06grkDBura3l7B9Mz4xkKIr7UPFrOyIZkSZ0H/qRfDu1+ZIi7KXRJy9MoWyRbt5NH3K6
	 xOvekeTHAYWz4rZyVgCeRXQWKEPw4d4cgesnFT/2H/p5/Ikw1kC4GrNvcV1NJP5gggIA9
	 fPlsWQLXgaoh8ESgjIB1prdTVdPihzkB9rnKM7LXKyPE9Biy0/nw2EVeQjvNKQ3CLJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZEes90VLavY8K6YFysNzmt6SItRkZVxy3F/LlAcJTS4=;
	b=P7NAGfj451hwwSMWpAAIkYApgvSGOyQZK6Nb+OnwQ1pUqRtlLYYQp131TQA/nWIqlFOj
	 /IioA0wCL5ysiVhm4LayYLfJSj38P96Oqsu5X1/WKhpsfo7JSM/o3Qhq0+zyvM45+W7hn
	 3WXMbEsKnrh/c7X34iUwUrmk9668efe1h+ab+8SpEiCwzuxLmLhfk8XfoSuBYgP6A05Hg
	 WyO+Udnihgqtt5llEMUWBuQEPjHKXV0wLmahh7yJk+MLijZX4/U9dri8ePhvSQUii5lAi
	 JtlP8ie2qAR2cnRM9YK36IEK5QEICgQPlfWdUp3yh/FLfQNXxnmXOnSsBEVXPYt614Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ia03zhgk;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5E606A335
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 20:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C5E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ia03zhgk
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e503815adso95722085a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 12:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793997977; x=1794602777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZEes90VLavY8K6YFysNzmt6SItRkZVxy3F/LlAcJTS4=;
        b=ia03zhgkg8F62JJYs7M675TbPFObrCOv0u4oHOTJtFvqnTcmUDcbBVFNeSxJ9PD1Vd
         X3++rXu7ynGxcD6HJjYul9kMp2mTDpSN23R4UUoU0ZwdqEDcmhgNvxGOesSBXgouN8oh
         WDELPOC7iRZZXkBkQkIwq6qlSeuTE1ejJR5M5F/LnPE30IX4g/Ud6Zh3xUNRGf4pAPVX
         dMOu9Z+AvpbbS4FXZzZIAHlPF/xPfKu2d/QsjpRhkxiFFOUWUxlXnYq3llP5eRSIsIwj
         Judl3kx/z9/513cMlbrx7zq3FMlrSz13MdWcwld46RFB6UfDXOczNFtCUB4PVH9CamY8
         GLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793997977; x=1794602777;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZEes90VLavY8K6YFysNzmt6SItRkZVxy3F/LlAcJTS4=;
        b=ypkyDujy7NJssRvWyFpkXRiWoe6XPE26Q+mDF+XnJ+91oa9kJdJr0GAek6r75VU83t
         p+FNlKS8GWZMyMb7jsxCnIp6fJVtaThdYhIwpKjNtR4v1aHlGSJs2sG1lhQWuCCmJ+rA
         MhYEM+bvdJ0wXNxZJPUnm6CzVHZhrkS9ImZH4yg+Py+JrMQzY9g2pk3wvJvhuZZ5JGDw
         QxINpTtY4CuNoSGMyk6JQhjoNclN+h9PEfYD0uXW5d2Aw6HtXDv7raSQDniGtkvSffNS
         mI5Yva3qyACSRc3VtzwL6T1S/TlNC3SCvb3DtdHQaNekMu142TvnukyCIOjjgrTM8GQj
         7EqA==
X-Forwarded-Encrypted: i=1; AKwUvBz0F+wdbUdutJvSP257k/615ywuLvGTBZxiUrKDHxZhxi1pY2tBtrNkHx/5YKcDlrvCXiK5v2z86NfmjAHJ@vger.kernel.org
X-Gm-Message-State: APuU4Z++S1x7Qds0nLTAfSccIlH4E/Le8c/OVH1GHqDSw/bIf0yCakTl
	snUiIgz58Vb7TPrQnNMKyXjP5NBRT+paJDwUSTD3aNY5wIH7EZAQhwXb0IcxoCRRJk0=
X-Gm-Gg: AYBFou2KP9PXY+QAI3kDr/SQ+UC+hMgTSyQKg3WuBB69IHYEfbcLKlceKwUKNW8oCaK
	5pdIq6SzhrYR6bZrKv3++bEgbZJJk5RAHQat3sRl1F+fdYPt/adIUIlhUN3olWRZq9XNmRwCNkL
	tgjegUvmdoT2X6VHpj51b171uti0llLApey4soG5Om8P/FqSp+6MEVA42c4J0XJE61f+8OKB9GR
	z8gZ0bLcqp+XDbYHnxFRdjGoV8AGR8Pvc/wbaL0IfkFJie0033PyIgzanSgUyRgONmIhiLLbxOD
	lIY3vSbL67hRCdDQuT0q9dLvRJrjbO6KN8mUO2vszp4ZKaMaGQmYsVMl5wjhu62EcL9gpROe1vB
	uiGvtcRT6e35PbC6YLs1HC1mK4yEuTCIjJKoBb41WRI1kLpgLgPt83NCbhWQ9WT4j65uLYwz8vo
	qY14CI8GlRqAqYCIVPPZj4r2rrVKwCwlrFlgRLQSFOStye98l1KwQ9qCO/gPn3pVbblPbQodzg7
	MjiYewhP6std9R+urNz7SwnNBOM4vGgDpU4jKZvh/K25vR5KciSlUBnmeBQBxIe6ho92yxsX1mm
	1KBI8+Mf9aTQjMaKSs0dYYDq+3BjSdpeUi4j12yQG3P4m4seIJAv8+rhEHm2HiNtg1Es2KDV59+
	6aPCU+ijDHw==
X-Received: by 2002:a05:620a:4507:b0:939:a003:7127 with SMTP id af79cd13be357-945f35a6235mr574216085a.52.1793997977262;
        Fri, 06 Nov 2026 12:46:17 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6ac8d02sm28364526d6.42.2026.11.06.12.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:46:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xPQpE-00000007fOt-0vRe;
	Fri, 06 Nov 2026 16:46:16 -0400
Date: Fri, 6 Nov 2026 16:46:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
	Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] iommufd: fix cleanup when adding memfd folio pins
 fails
Message-ID: <20261106204616.GL663069@ziepe.ca>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-4-70b9c655da3e@kernel.org>
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
In-Reply-To: <20261105-refcount_overflow_stable-v1-4-70b9c655da3e@kernel.org>

On Thu, Nov 05, 2026 at 02:10:13PM +0100, David Hildenbrand (Arm) wrote:
> folio_add_pins() can fail after memfd_pin_folios() succeeded pinning a
> folio. Upcoming folio refcount limit checks will make this easier to
> trigger.
> 
> Let's fix three problems in the error handling:
> 
> 1. pfn_reader_release_pins() uses the allocated array size instead of the
>    number of folios returned by memfd_pin_folios(). With large folios,
>    cleanup can unpin uninitialized entries. Remember the number of returned
>    folios and use that during cleanup.
> 
> 2. pin_memfd_pages() returns on failure without releasing the pins acquired
>    by the current call. Release the per-page pins for folios already
>    expanded into the page array, and the single pins for the remaining
>    folios.
> 
> 3. pfn_reader_next() returns on failure before updating batch_end_index,
>    even if the batch already contains successfully expanded folios. Update
>    it before propagating the error so cleanup releases those pins as well.
> 
> Fixes: 92687c793644 ("iommufd: pfn_reader for file mappings")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  drivers/iommu/iommufd/pages.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
