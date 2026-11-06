Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958978;
	b=DyCjs4+9JCQ5+QParvMt6wp5XFIkmWVRMrnykDCWg0sbgYqFfxvs1vFo3JgZC4EROqMQ
	 evD/j5zGO/Z83e3JMDdJSgPBN/YvIiLgJ05Pgs7kCEI8f3ik3gEHHk3zMqmZn3pxm0M63
	 NL2looSLRVXYvp30KH3RcO/tX5RK+S+9GqnCmyj236p33a2+QIO3X+3h6s63YKoB6A3wy
	 mdlxc52NpkmEHYNrlv6G8Nw28bUNSMMSHr+Hf7Lf8/tojNIYhYNPKgbXs6Ul4dvA12VH2
	 2X8PmqAeok6PCsACAj6opPkoSz48aeqPNl5nk2AEQPUyKeFwPpcSCDnjLhTcEr9+0TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PVNqNcKixHGsvQRk+aF9Z3pXurarEsFSJxJzB1XGyf0=;
	b=IP4PbNLlH52oAp05y+rgqlnQ1a6tVUxuQUr0TbtYwdFudMI0Gx8kmlKCEUMRqIbUAeXT
	 yMc4OzQegXTgwPF1ypZGd/j0b9xShCfL40VzVjrbwx+YTNHe78py1dsYGRvHTqg2ZAXde
	 A5R0AN6ssVUrJ6Jkn+BdSxpSptN0y6eepgTdyFzb9IUf+1qqyqPyF2clszFvrdg/ORu8s
	 GbgdOe1i7DtG0T+07cQRaiTL+QMpKL9qNZS5Ak5atxVBU1NQMtFCv7yQGmIqCLZ5mseXN
	 txGz55ica6NaKgoJh/bjsS7aRbh3tYOTbxrBzvq/97k6shjgNNV7iT94MVVOoHKsiBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1Xmkiwr;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B6606A326
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 09:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 585B6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1Xmkiwr
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-49376eb635fso41573f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 01:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958976; x=1794563776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVNqNcKixHGsvQRk+aF9Z3pXurarEsFSJxJzB1XGyf0=;
        b=H1XmkiwrX3YLzUoz8v63tW0K3f8HeQQMrYHC6NguBq0Yc1lHgV5BxOaPiQVM/nx5Kr
         Nv4Nkr/P+0smDYStmA0vxUWIevexJO6W3YeVFzXWxjpUb82YtyB7exO1WkMPRlrqshbw
         7gdELKEwKXzXZnlrkpHr1yD7exsMl5g9kqsHjwkVOrYoszaDhxn1MLxcOJF4sb/6L3MY
         sIdWD7L/keA+kAzxJc8rrEhKaeUKb4K3OJKzQ0cL4yoRHek+Sk1AtTQV2X8+u59Vj8dP
         k4wPQ0+F+f6g4v8Op0nmFGDXNrToQHYaCL+7LHoyjFE/RK0fmcwPf6Waptypct15sbUF
         jOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958976; x=1794563776;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVNqNcKixHGsvQRk+aF9Z3pXurarEsFSJxJzB1XGyf0=;
        b=Ce6cKrBiWc3TW5SpVSih1+KuY3vHG5KUUvCbSoHm/HmkG0ylUCkcnodi18zT8jH+nz
         gEBcHA7MIVeAII9gaSmtY+5BB02fVI/wvyjqKKQ2hEw2RGk/qwYLCj8/a0t2AzrGmHnC
         hQMoGoPWj48bPOUtlb5PlM8+iKK/YfHZI0Ug0G6wWkaabsiD6EPxyaJDgBce7syGc2z0
         JNq8HS2pXCM0hNAGQlZYoQZsCvGLO78C7FZYlK0ewvapJCzCcruK9Q/xV+Hs5SjoUaNv
         6Y7v3/Erb2Pu8iutJ1b3pRcwXNyOUUY66ahQN5dMqyKsMVdoJ6eIXz5zFSa1mF3sCO5T
         L8MQ==
X-Forwarded-Encrypted: i=1; AL+hErHH0YG2nWEI/iOseGs8Uyg+egITGMtyo2gXwHmKAnEtoKqGT2PfEpjstyDcBRO5FAQxon4aQASRCJtuKQQT@vger.kernel.org
X-Gm-Message-State: APuU4Z9J+w5SnyLz9V6i4LAesU8nedG7Z6gq7RorV1VekIG9jK6IODwx
	QmcZDPOXqqtr268b32yvo7SgrxI4dW5ZAVZ6HcrSW4t32WIWFHNwdad8
X-Gm-Gg: AYBFou1FdYo5YTnZ8snTrumsZAj1RVueSl81xDv2qQdZkEX2bkwyJRTgmM2Qss3Aw3t
	SKGZ1exI1D7Hvlp5dp43dTu2X89LnBd3W/EooKi5NY7S5+IQCR1wyLLhET08KVK8+fVptPXU0Q/
	XfNkPbPOVNPIRpeHR6Pm7llO6XmFt95VD/rwuLIBNTbTVDxEtPCl1w4bJ6YJ2Ju6BiSa53VFdTd
	z92z3Dw+3+Vg5QLPY7CEuJVy29nxcrtsV7s238TA3L+SacuSrsPfbyOeSq66h5frFn/tR1zuN50
	dsic1H/yrRkdYzYdr48f5ZR9no/xQLSSziwx630z/+gapepV+iubdZbEwNo8X8uKSnGtWvt9R5c
	MW/rPtfRBoQ0w2HbZrf2EqIotSRTohB9kQ8hjbJwk8Vfo6SSWO6BkWKUGAvX3dISOVlTTtnE5wa
	MI+ijuRxr2BGVv7KVDCkKuW+YKiKXFI+X8Ze8EXGJrjH9iAGqVr3Tqw1WmgkQYqws/grokWIMgu
	/maZPZ8sE3jg1G8QYRDJA/A4rZG7Y9knPVWYylJVIWUFJHbDNM2htcZzl4yFfGNqlDqX0MusQRP
	D69BwDw53vO4BqwU4jLK2LA=
X-Received: by 2002:a05:6000:26d3:b0:48e:6159:8274 with SMTP id ffacd0b85a97d-492765a3e9emr3874962f8f.27.1793958975594;
        Fri, 06 Nov 2026 01:56:15 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7dbb0d4sm2752385f8f.50.2026.11.06.01.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:56:15 -0800 (PST)
Message-ID: <e3e15340-d6c0-479b-867f-e5eeac1e0e2c@gmail.com>
Date: Fri, 6 Nov 2026 10:56:11 +0100
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
Subject: Re: [PATCH 3/5] mm/mmu_gather: flush pending references early before
 the folio limit
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
 <20261105-refcount_overflow_stable-v1-3-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-3-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> When a task zaps mappings (e.g., MADV_DONTNEED), it can drop the PT lock
> and defer dropping the folio references. In the meantime, page faults
> can refault pagecache folios, creating more references for the same
> folios.
> 
> Let's just request a flush after enqueueing a pagecache folio whose
> refcount reached a certain threshold. Start flushing well before new
> references are refused, regardless of the caller's privileges.
> 
> This is a temporary measure until we have something better.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
