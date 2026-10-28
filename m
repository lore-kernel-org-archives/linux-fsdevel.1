Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793228055;
	b=GcFeGU2fEXt6sz/+F/EA5ZBo7ojsKkuFAW7I/nkEhjvQoKExGvMBfTLmg5DZg76uUCkM
	 jL55PVmUG1NQ0S5NO/6FuoABidpjQhgL1W9pVrQPZHls6tTVgK+0I70kx+emrGLWqLvSp
	 Hn06ItNQ7XNtCHJW+RKzCRVlbGqLSTN58e9V247vhsti9CAUsDfoKyC5k2TNGyzUyN3N1
	 b2+iHj2dx36FEsfV8DowCr0GGffqgCBgmw6hi1llApGR2gSZaguedES3vT+Gojhh+JoIn
	 iCtMpXn3nZVR8kHKJzsF0ua8KupDkZOLhgUrlRh8/1diq7dgpO/ArKjxZuKCuyvt+RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793228055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=1nzL/A4OIGWxPEaAp0V3O0CBZ7XOASlD1R5vK61L67g=;
	b=N5CPbX7VilXfqsxY1MFfHeil2SZNysL9BSRPqZF4iqz3rPsLnhdZlaTI7VYVKpf0qrHR
	 rEqN/sIBcEygsskZSae9WUajL3F6oz/ZvJubpgUvLTms9CYR62GTLW7V2al/CXNPfQiI3
	 dGckglYspKVmm6rEc5SFvEWuS3UNtbrrorVKZAUsP23nXe6tdQ9Q7YCRwUDzXWfcj18YN
	 tO60pBW9UIJDYwIGDtTZHj3FpSbYOVzoVOZgKPQ7/C9tHtfb+W1Rurih6rzitNPr1zsfC
	 r7FmzCS0GqopSz7NEYElb6/Yn7a9BzXMAldyy3UAvFaBMHyTJkNjB3bjde/NnK3T88Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Jd09Eqyr;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900A606A330
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 22:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2900A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Jd09Eqyr
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b45f9ec1ceso1905733a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 15:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793228053; x=1793832853; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1nzL/A4OIGWxPEaAp0V3O0CBZ7XOASlD1R5vK61L67g=;
        b=Jd09EqyrE5Ah8cRBCETOBxDbT9b0oGnFriZ7N/vtIFnR4atxKwoVXBEkw9jWiyscaL
         9cBv//XvhVx0QHadjkJLBobkr5XoWyssGxmav1gWZI3g+BwjlhfZWo65PjCsgnm9H3K3
         xu5Gt8LjlHXosZzQxl27itMRU6XM03eBrNEUzaUgmLacP/vWk9QUrBawj9QiMopYPRXA
         tFTTkouWxIpyyRzhMiRtstmfu3ZGpQ3UoEM6m+ucddIsmxmD56hyTjhxLKo4VCQBrV7A
         s99qsxF/HxZexb7mRhlnvehngAX2PDIIfWSoapPGufqyJfpOj/CE/u6FaQ8yHPJb3EEt
         tvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793228053; x=1793832853;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1nzL/A4OIGWxPEaAp0V3O0CBZ7XOASlD1R5vK61L67g=;
        b=krf1mlCo7W8xnnV6nZYjvMxT1v06ydIZVyr+WS/wqoMtvAjOG35F0ovtfrVh7S/84v
         deBkqJrzzrkx2nBucFE187JFT7QUX+oReij/arqDLxJKtAF1XP9ZdiO4Ytjlyr2ZPMU5
         7o9glnWa/WrmAF/STie+Gwl6kFcBGr4kXDp/5oLuyfRoGf4euRahhiIIYw3U2QxXxsdl
         ex6+ZUMSbfcP5OD2wdL2PqUa6cb5cALl9NZJrSLM9fIzGuTrbAn0RTZgHkH/tNNU4QoM
         +JpTnIS/98rWqWcZDtUqzz90oVzFbseUzDqIFavFF1lqZb+YmSVkzE6W03FcYRfeKNnf
         ZVpQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbBGnReNJw7euq9pt/jAqUUaiST9EczEmHhYHfAKf/0ulds8+q0IPgaHkcB9ANfGR1bn37bx50hl7Eh9PT@vger.kernel.org
X-Gm-Message-State: AFq9FYLNQV1DDjMpWKjidyU7gT05EsWQIVki+M60+IXYeXrDAafbZK+G
	mKMlF/begZ9xWNT8m+N5dELx6JyHAroMmz+gawtv87/9gfnva+7gVLABUKkI4qwaWfSfTJMslft
	ISA+vmew=
X-Gm-Gg: AYBFou0hTJrQT1FpY0sw2LdQJiVDEuAlYFgfAeQMOZ7G7bT4925m5GSi63odrKZVKdU
	Mh+Zvv8Uasy5qbNIJ2KZehge6JMzF898h40Eu4hKOdBvjhnImMOMnHQmIMWMQwMpiTRfC735TFk
	eHS5x/+mrPCRy8j9kMVY/anJZd0zV6YUUV0KhsaW/dsk51gE+eMZO6bF6TZWRyz0OHO6kQRNMwX
	VCMkiZshjq8xeXEI5MMbHexHPqMZN1G6LUUxYLzcGqUJVi3VutKfrpayn/wWe3tMxe0rzbUW9ta
	132P1b4JW0AViurb29lCaK1GFXJPgHo6VsmhKaVB1NXSxGacd2LxgjeGAwLtvjsdJP6xdPL6VhS
	Oy5lq7U+ag6oFW4WjRg2nugfW/vDHrKMeruI/6QvfVfMKMw1Uy+kF2rnzvMAgss7fjPdOBlIlj6
	Q7P3ytUsWFVxHO9FYeQOktv13ca+07XMOutMWr3vW0uuJpOWTMUyhWEvHskxraDSHoR7++88xgz
	gdt6p/SAoOKORgdBpGFoDIX+DjmxFXaQEH7gyGuLkwwBQKhLu7lCS+QcPnMM3iIuWpOsucR/5pe
	n9AmO3pFVw9TLxXJ0ilQjJHINKfQAxS6lmDfJaUuR70=
X-Received: by 2002:aa7:d0d3:0:b0:6b4:78c3:b8bf with SMTP id 4fb4d7f45d1cf-6b49cbfe65cmr2043596a12.26.1793228053385;
        Wed, 28 Oct 2026 15:54:13 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:49::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4964601f2sm1991741a12.37.2026.10.28.15.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:54:12 -0700 (PDT)
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
Subject: Re: [PATCH 45/46] mm/memory-tiers: unregister empty tiers outside
 memory_tier_lock
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
 linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20261027-fixes_core-v1-45-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-45-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 15:54:10 -0700
Message-Id: <179322805093.453251.8441529644965692562.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:18 +0100, David Hildenbrand (Arm) wrote:
> When offlining a node's last memory empties its tier,
> clear_node_memory_tier() calls device_unregister() while holding
> memory_tier_lock. A concurrent sysfs read can hold a kernfs active
> reference and block in nodelist_show() on that mutex. device_unregister()
> then waits in kernfs_drain() for the read to finish and release its active
> reference, while the reader waits for the offlining task to release the
> mutex.
> 
> Return the node's former tier from clear_node_memory_tier(), making the
> helper more similar to set_node_memory_tier(), which also returns a
> memory_tier pointer. Let the caller unlink an empty tier under
> memory_tier_lock before rebuilding demotion targets, then unregister its
> device after dropping the lock.
> 
> Fixes: 9832fb87834e ("mm/demotion: expose memory tier details via sysfs")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
