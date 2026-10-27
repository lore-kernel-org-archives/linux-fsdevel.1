Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072434;
	b=wOsiiEC6Uux85SR3AyTFklV/kh+U8y5SntgBfZV1uA24SGa8I+Bg+5NF83uwdGUWcxXe
	 it/S9rT+Ayo/hZcvqAKSfY0jMgFC5K/I6EFbk4oKeHhnocu1ehBChNcoy9z6mT2yZNQqY
	 n7bItOvFqF1tqPefJk7P1B7PFBhxYisjD9TfKGo8AARw1ApKWzpuLT3BywtQZ+KuHE+ds
	 21q9MIKtgcdUg53wpaIa/Mptz+YYSm1zI/W8AHhsYWA5ZvxmzYrWAtiQ85xHCWw0ADSo3
	 6eeVo9+gJApptm1yo9auYUcTJ0sHgV/kdTO7kn5GphlsLfMfG0SJGJfZPdP+UUmewUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=;
	b=wrlXC8LyrXNRsdel/V1EPLmTZfPBFK9so+LHWlxjj23uQKC070I386tPDYgBmHt5isGn
	 u01ieaGF9SX7TqgYk1UwrCpzoY6Pt5be55EVR/8frJfEsEUTPFueRV8HV6443MozXJ5Za
	 OvYXRU/J8QJjeIF3Uqdv1N1DLDKNI8i8pKLCp61HeAgVl7qLEOrHXbgzEpXwv3th+5GEZ
	 vAuhyu7AYdwbajLXAyWUh3dvff1LKbo5QdCAJsJSW55PtTli8E/hjZQOOwiUUGE7H6W4/
	 FryteZRHH1JBDX7ZF5vWzzOBmcb1wsH7Wd6gtKhTVB4hbSiI0hRLZ7KgEcWdwJ2PvNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=klpxKBx6;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D8F606A320
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 03:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98D8F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=klpxKBx6
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c46822eefb6so480736366b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 20:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072432; x=1793677232; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=;
        b=klpxKBx6XIdguBPv1gdEeaxX3Q5nBOE0QyQKgI+nQtmFi2e6yyGoD1z99atiOq/X0L
         29MGF1ep4EQ1gv/+055Qkplcqf1YtKuIcCv5aGSKHjEYK3jS7yM9nfCIB9wNkxkiBkUw
         3XYbbVntwybyBZUIqAVzhr/u8Gfrjw4XN/c1wAbiBcjL3VyyvbdMABrMl8JljkCI4HBP
         HDeVnIkL+LtyK7DjLzJaTMJ1PXNZWLEFJCqh4gUIf6KP43zgwJECwGuEgMjpM78oIwbB
         yrbDn8qUsI/PxLnPvbStsGGa4HcTlJR/M8tesdaSKCW5YkmlnkFTtYdIc+MJU/KUH2YX
         ocTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072432; x=1793677232;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=;
        b=TuX4YerjN13fqeAuABjXh6wQIh3K/u4jB8Gwajep2k6EJACjEuqO/RG47lKpLIAuZY
         I0J9ao9L0RZJ9yOLaT4LBG4aAXUoMtuFuNIPxYf7KZblhSyHAV5qkebvMM9Uke9REyfM
         cQIUbXOWl0BNSGrDDlq3PkyPJrEOFGXD2VlXblPe9KjHjbl7chke/G7WYVXm4naGbbpo
         +mm3aU7T9zZonZCCBQo+m1w7MruvnhYaNDF8sbI88RSoSnR/cqZUPG3ryemwVMP2+aoB
         jaj6QuNeefwXZFNsTuR/tsnTYYA6/mfrMWdVqA2ejVS5Yk7SVOsJa1JEY3TOUXf+1I5l
         asoA==
X-Forwarded-Encrypted: i=1; AKwUvBx6dAd1I2qCGDWjL+ZSttV00S+hrQFMLpGoEN7a5sXVKk2CNJ8jsunOeG9gGpa0w8DvedjNbbcbdWOEZpfN@vger.kernel.org
X-Gm-Message-State: AFq9FYJQuP9A65rY14U3w5zCgQl1Ld80+83DwnCE33Gi9BlnHNG3zbTt
	J1arSHhDMSsW38v/A4oLAm+U1PhON/YJFYRexc1ni8FnKuO/ykf3dgQVk4MV/jfyZXw=
X-Gm-Gg: AYBFou2EKiiZCy6S6V35ZKxYmyYrArIe0zktWYSo365bh+0mDzHhQp4xC1lYW/j6XxB
	6i6fZvzZj06IFYOm4hizWLViffcwn7RN2WbnPVSZl9kEn8zDa6zR/HXrmOFMSG7hOYYi1ydaG2T
	mYN61M1UukAeMbPHMy4jofv/ZngRuuISkrRiFzZalg+wxNiaFWeRQ5HpuNTv6QTzXteF4ZRiDtN
	zKy8biIFi7QwJDJUj3/KLlZy9BxeiRxeCZKcWnLiHxrcpVXtVNAIvwJjnzd4bBspXmOFixVHKAp
	/Ib68wVODb3hqivKchJY/bnDaGKL0ummXz0dt7I4iLZFFCZs7lRMWoafTITF/gA1Maf8Ajm4deL
	eaUKxd/MphM/uTAJsiaWDf7+4YfuPotUqswSDzG8j42u0Ay0b4CsOLNODv8/Bpg/wBNEBAGkdbp
	HA7tK5Xg2LpI5Zu42nLgAeDK1WhnIL0sBifRHFOiUfFkH+xKaCNZFzSvunzJpf8WWq65FhsfDfN
	xDbb/gcsI61F+cDPYm59Gk3/bDh6KFvF8YULoK1hhmf8Q==
X-Received: by 2002:a17:907:971e:b0:c46:723d:600 with SMTP id a640c23a62f3a-c46bde9f783mr916491966b.41.1793072431944;
        Mon, 26 Oct 2026 20:40:31 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e784esm379153566b.19.2026.10.26.20.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:40:29 -0700 (PDT)
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
Subject: Re: [PATCH 26/46] mm/mmu_gather: fix flushing ranges with 4 GiB or
 larger
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
In-Reply-To: <20261027-fixes_core-v1-26-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-26-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:40:28 -0700
Message-Id: <179307242835.1171062.11616590599815003560.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> __tlb_adjust_range() takes the size of the range which has to be flushed
> as an unsigned int. Its callers, tlb_flush_{pte,pmd,pud,p4d}_range(), get
> and pass an unsigned long. Consequently, a range that is 4 GiB or larger
> gets truncated, possibly to 0.
> 
> On arm64 with hugetlb, a 64k kernel can flush 16 GiB hugetlb PMDs, and a
> 16k kernel can flush 64 GiB PUDs through tlb_unshare_pmd_ptdesc(). So
> at least these two scenarios are affected.
> 
> Fix it by flushing the proper range instead of the truncated one.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: b528e4b6405b ("mm/hugetlb: add tlb_remove_hugetlb_entry for handling hugetlb pages")
> Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: use two-tab indent, simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price <gourry@gourry.net>
