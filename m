Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793096590;
	b=xDZU68Uvq4DsHRDpLMH9WJNVhcVvnDSJnKDzxAxuLpzqURRgRqkHDzuQP/Ei8jSX5al8
	 TzBjeCXSN6ox9CSHUa5oNXukz1gBnA/uMDpOE0hY+nD2Umte3Sdm1BcyaW+uE+L+b3fXH
	 QVywX6C8RckaHr9hmFbKycaSUpTQGqRcGLxB3I9y6qunu6wOV1O1TtCWKa3sN7puP/7RX
	 hMujOLKpVzEEEn+HlRe6kKyblvqCBVSQzZmocP0eOh0tRkL/IL4g19i2DiKaJLS5pUJDY
	 H1Kvl1WCfL467s2wcBzzHiR2ye4tF2CGgcqog/GmYKR3wgtTR8o7PHl8z61jMBlTYdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
	b=L11TvkIGBYs8HE1mQtEZaVln57yaRuFjzASgQA8XDurEX2SyNkOOxF0YXixWD7L1KVnE
	 5yxT1qO1nk+XYQQjfElguQcvjskqDq+OqYjx0js5y8wu3Ev1Igonf5taoEwZK0f0/LSlW
	 psJyJCALdWCMPNZQuFGvBqdqLxWZ1MAwOh/osSmXyja4k/EXzIlb4JaOpzFbSRUdg7UD8
	 D2RedlWuiODTV7MLs+/uD/tfOvfQNfhvC2rPbImcJCV/Upync8MIRvzy8to6A6xPyHNKi
	 y9nbUyD4Ya/Q6a1c7e8C9wuEw06yHq13esOAQ19osjtRgv+YtVZf89HrLHh2SKsw2Qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rlxPCoS9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22CD606A31A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 10:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B22CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rlxPCoS9
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c34bff61551so580856066b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 03:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793096588; cv=none;
        d=google.com; s=arc-20260327;
        b=cyKG43auzNEqPd2OPkacxe2OYd5FGsyGSYm5znAqpmchHdfbc8ppEcLU7+H6jfOgl9
         MD/nwOQZBviUi9vgk0o+uq3je7qxN4OC7nZccgHgTt1yxMuo70oXpWf550e/CDTq9WyX
         0T4S8TckOLpkQEf0MixiNJt9LtZnwZd/JlDH559MCVyWXRORSOmad4DUj7HKObFn9qSw
         xYQ8utfoa9mgMG55PTFd4APH7VlV8EWKV+JkHCLXPKIDE9sre67yBC0jXiwkLG88tmAO
         j8VHRd0vVCmozgc32aTTB1snXoMFPPJOfT6qW7Na1JVe1ZZyqMaraSJcTAJ3mTWtTBgk
         a84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        fh=VxRky26iWYSUqRQJcqrvQ8i3Qblw2I5FnVvZbheQLMw=;
        b=eG5Bs9zaSm/6QCSTzsyYvZCJw1GcR6o9ZhBdNFFFdBnqwahTwoYsStTSamwcKBvxDh
         aVIHZlxKM/T1Mmdg8A1ek/O1AWTQxSXXS7YiHyVNFIfRUtuXuc0GtBiinLuQyGJivZmQ
         wW2Gszq62ond17Z+Tp+HJHioWnyyvJzyG6/83A4Qr8IfLAvIg74861dzqjRZ+4LsfHSY
         ggkHPbXwxnShuJponWwGfeQvMuO3thFLq4ovEVjeQ5Op5pkhukNfe7P7k2kFnhFJuMZw
         1c/MhSAhF3i2R7OJY3jt/syA0f6cy0SPd5yQvU6PnjpO681OP6x4IHYfGrqUin4SO92m
         4cVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793096588; x=1793701388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        b=rlxPCoS9TacJB5sbR4/DuCvg1gHofa48v4RHRIbBlyZQUhw6r7bL6zg7MUtgoZBxKQ
         lt+YYPbrvQtc79S9rfvuPcGOb7C0BZY3qgF3U0I/tVnJgBGJx6xt/DMQpY30uai4QsoX
         P5Z/pcj6R7IGmpyEZjIkQ8RE3etZC17RDFgvcM6Y+9bhDyYYZoMMp/cQ3dx0FSoFEG3E
         yCnpC60BmhPOCYYuljKb2FIw3gC9JotwIBxNU1pFqurxlv0c49doWeUpfGKBEj/1fv6d
         Iu3zIa2GIe2Vu2FDkwEINlHF1PCgOTqXmfejtN27WWbwQvMYwFzZDiaJKRXsAeQtFbxn
         7XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793096588; x=1793701388;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        b=lvHQ2FnGRo3pYOm/fBx+vlEuFtCJ83GfmJ4fX8Lej7FpVHep5QMI9JqBnu9Hea47Qj
         dtBhwACrfmqOQvIpkLOXl6s2Lvcdhi8Lo1KVFHHW+hLhyvXcjJ1y36cHNNHfVhQpNXjA
         TmITJ9jPcvusIt91P8kROMAmK9DjHV3kZrLVG4w9li8lTzWeBm09eu4H9qiX/VQWayy3
         6L4R/nIXbPBWF3XBVhowsRlqSnMxG0chWzNWR3/nanhTHScBnvRqvoHxi2wCTNpMwvcq
         xNTIepLoyqSM1XwSHY0JfTpzoJIS2kA3P7jEdN3xrFe+OkG6MOx5UhgO2dOevnFZdk3R
         7Kyg==
X-Forwarded-Encrypted: i=1; AKwUvBxGUDC6iN/smPJYaF6mihC+d2qf3/QIF5n4cdf6oZpUOY9PUImGMa0a7XEOrncEEJr7pdJyvkvfBZ+ibH56@vger.kernel.org
X-Gm-Message-State: AFq9FYJENpXezBv3/Qs2CQ3zuELRFqIpmNs7kRsh7hjvHPrhWcLTJp6B
	c0M3cuArrxTf8wOyd0ffiYJ8LW3h+WUiyiR71Tj0CH8UwuI3CJFFXsrwbqXt3LoEaMTaqWWwnsA
	CORfimwtOqdK9C0M50YzfaGL33NftIlo=
X-Gm-Gg: AYBFou38OAT8goEV2iM2PLpgHhq48LlvNd2ulMD+A+aZabPj4MNnGWx2LelDlPS7B19
	sOefRHSRaQt3HftAEcuMYUD3tXSx8xfk7OAlKrlnu14hcyKJONRlUu8ZsxuXj6K9RJpwjqc5tdb
	srlPz0f4xMIvzzqFWyZLp3GSoZELorrcrGFHC30u9haNB3eKZhOncJu69A9jM2bOWkIX0yPlWAI
	P/XqsxDN7wbzbbCPxHxUDrnAH6FUbuLvSjmoag3jckyQkgtrYwcrD0ZbcC/7GDHljP7a4uDAVfp
	s1Fc11DXqa0/0Kdfnc/yRQcCh8lU3PfRAbcTNvR21bDCrWkYfw9bhZfsLur8keeviwSQjB2+Mc1
	oJFmSmd650ore/7kT7YCuKdL1l91/1PWpeDXlB9xRgs8GrZOdyNfTLwUqU6m95BMQQROVXQ==
X-Received: by 2002:a17:907:86a3:b0:c31:5bb8:4b3b with SMTP id
 a640c23a62f3a-c46bdaf85e3mr1028439166b.2.1793096587718; Tue, 27 Oct 2026
 03:23:07 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org> <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 27 Oct 2026 18:22:29 +0800
X-Gm-Features: AclHuK-sc-Sst_xgCP0rWexz2ICrmdMlmxE50eDjh8zWXXtcyxqz8s5Avp5yS-o
Message-ID: <CAMgjq7CgeA5OYUuXAQF-PQ_LkmsLw2V3VzRwPUdMYTcGCmYCbA@mail.gmail.com>
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking PUD
 and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:18=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> From: Josef Bacik <josef@toxicpanda.com>
>
> MGLRU passes stack copies of page-table entries in walk_pud_range() and
> walk_pmd_range() when walking to the next level. These copies can become
> stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a PTE
> table concurrently.
>
> This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
> support page table walks"). Likely, earlier locking masked the latent
> bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
> retract_page_tables() without mmap or vma lock") allowed concurrent
> retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg locking
> for MGLRU") dropped the walker's outer RCU protection.
>
> The fix is simple, so just fix the original commit so we don't have to
> speculate. To fix it, pass the actual PMD/PUD pointers. This restores the
> RCU-protected lookup and validation against the live PMD. Note that the P=
UD
> handling is required as well to handle folded page tables correctly in al=
l
> cases.
>
> Fix generated by an LLM and sent by Josef Bacik in private.
>
> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: handle walk_pud_range() as well, clarify+simplify description,
>          adjust Fixes: ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Kairui Song <kasong@tencent.com>
