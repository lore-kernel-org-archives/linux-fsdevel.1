Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236833;
	b=KHbCKwzu3/hckZITDS89mL4J+FfTcbOpLlqexFK71kTUdqxu1HJqT+c2VRo6cAbwtSYZ
	 wU3hJi8Elrr708uW3aL9vEagfYO75FdXfivrJUCc0SYuQpfxtBqngUA2t1B+xiJw5N7PE
	 /QYrFJiZ7QVFjxrKHH6ZWPH/k4mDzgq0xll3Eu1YYjH0fxnLlzivXUpNTCp3m0DNAcVoi
	 4pOzZiR70wlPDY/T7q4ORiPyk1ihJSjwZ+HDG57IxrI2JrbHkQh8mWsmif6lyAl1gFDqr
	 1SXKlGMEtabsLsGtjIxUr2VoRhre0sRssw7gWNfUwjt7QJGEhgGa6TFXbOz4PnbG5dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=;
	b=lC8LiMiCoCUFng2n38RSLjbHUsiN7Ga+ry0TjUAjhriEte/geGM19bcmqyxBds5EwHFB
	 EO6FM3xW0BN/sG/onf1Ettbswt2P13JhrsR09aziKELvfZWi+UME/Lm1gFr6ZRiGg2pbv
	 YegFF6smdQRGflgqHechJgAAp14MgnC0zkiZb+neOl7EH/UytQZ/XHuEBZrzmd20LnAbK
	 0AZjHW/UXm2jXXWNb0kitsOsYtfxQaIlXcrgqx9voNtx/Fwj1FeXlrxmyCsC4Ke08rjo8
	 EWpLY8kOlAEsNb62U+DznPcqLBAhDkdCQBLN6uZ8xGDWXkcinyePjVEFvvwwRU3Cv6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="X0XY/GAi";
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A4606A31E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 01:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 181A4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=X0XY/GAi
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso353112a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 18:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793236830; x=1793841630; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=;
        b=X0XY/GAiMek/vFbkNlCS++xCJPhcJpRxEM4fx1Ljjv6aCGTfMX2iHg06Cuvz3jbJ3x
         Q0dDwGr1BIBMf5kqCtqsb5bfcPFaFZlUqEnSi6skik2W1J4zJ5GeZ5elYQvrlDRe91e/
         CP3Ywj3kmY6/6N/XufcgSAxLlc+irLxiHwNEWl3k5M1t7aKrd+VArviVR+LRPwX+IZPm
         GpA3SbXg+reoCoke8l+SC4GaT3nXvce2SqP/adtt8ITzlbRj4F9bRx8OgSUJIJiobyeZ
         u80Of7gLVfSgCHHisozRXuwKcVBjIh2eid1AKfwHBlqSo1BxKhOy27h+nd0r4z6VpL4i
         tJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236830; x=1793841630;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=;
        b=Nfj8v6mzVIwh5W4wCdKy0FJLGEaNUyTQRyWYS8/+KwHaMx2/QV5i/4lv8Pf21tIvSo
         Ode/qKwHVEf7LUXUSjiTdX7CfOK8s9IiZM+9QC+6Fj8Qy0m4fq2mgUR9EBMjjtpIcxLU
         5ChLAbVv4YN5hvGP4XOta/ujWSwJa6X4nXi6Np1NUC5K5HRHxL4cvdn6x2fqfBNUNj6w
         CLFZAB6EuqxW3ToLroFKGk0VFi/B0BD+QqXBgrKem0nCdy3Vai/sM3C/3jy0IpqQmN0R
         9qX5vV+yL1WQd6U/y5F+ZmpS/cWbgK5SrxwJEysw8LHSComoFd2sqlrrWRXdHgA9g/d0
         En+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxqzS9IKkFPNQOoY5SMXe0k21SZzenqfgzK1Yb7j+XGkTmwJNqluOSNhLIlHlzF+/pXDChRPgvWiBdFAYU8@vger.kernel.org
X-Gm-Message-State: AFq9FYKaGZw18a1oRqxzzy1v6e1/pu1XExIysuTKjKfLmytbUNcUyLEj
	sdJaDRuL1XwIPwLWdq+VXN9tjuGkI6LBmBmWx5u8+iyFtuIQVUElrDBAxy1916uTQYU=
X-Gm-Gg: AYBFou2RtvFOsv+hZ4Oc0t4QpmBZ6AW0DZBx7qLqqUjmxIFhEaZ98yCjBnSUv8fE8Wx
	HxwD0E2JxEuH15U6Nq+/U2CJV31VIQjqXt+Xh7YswEDaVFM6b67536ixvzdM9rxlpt47d4XQYPt
	sImmYGeFQuLr3XmbnVDwFBdF30/1N5+fiYHRPdF7ZO5FngzuOTRO2z9NsUB436kzsV9dPwDmJX5
	Fz1ILZEDB2+llcFuekAA0bks9SJLzPdu94YxZKSbz8FERqMdtLF4ZeTLBj2p4ECD1AkVgGfZ5Ve
	D0AnaiMiBF0O4zlvleYDj0nA5ARcq+8yJ955ci3eist+pFMTcI8iFyl9nQmtnfvM7dLOv9ZcrqT
	MB84koScQah+Qxsj5ojF3LP0iQADIGvojNQQ2Rt17NTCxaZNRrsRRcbGR07U0ng25ApWAwZJy/l
	px9w6xR55KdpWZ4iu1h/0uLoerAr3PBI/fKY3BMRiU7/NRvGdEvD1s6LqgB2nO+SPO5qyRvHbEE
	cjoKmP7H7YytPzCiof1IsZO2JEoEtgOvSpGiXK7W2thKsjvRzEVujTh45fkDcVZiBysRLsAJV/D
	mv6OOMmHYaMZGZOeXLGz
X-Received: by 2002:a05:6402:c507:10b0:6b4:8d8e:c5c9 with SMTP id 4fb4d7f45d1cf-6b4b0b82678mr569270a12.4.1793236830233;
        Wed, 28 Oct 2026 18:20:30 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd649f69sm671275666b.43.2026.10.28.18.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:20:29 -0700 (PDT)
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
Subject: Re: [PATCH 15/46] mm/khugepaged: always recheck the pmd in
 try_collapse_pte_mapped_thp()
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-15-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-15-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 18:20:27 -0700
Message-Id: <179323682749.453251.17316394789253085295.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> try_collapse_pte_mapped_thp() drops the PTE lock after it has cleared the
> page table, and takes the PMD lock and the PTE lock to remove it.
> 
> In between, MADV_DONTNEED with CONFIG_PT_RECLAIM can reclaim the
> page table. The pmd_same() check is supposed to handle this, but it is
> only done with CONFIG_SPLIT_PTE_PTLOCKS.
> 
> Fix it by performing the check unconditionally.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: adjust description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
