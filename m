Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706400;
	b=HD7UbGh/1RSj1Dax9QWA84zU0L3IQ1rW+ty08tI4q1ezGPzPbMc0kFCWscGW4LklV96k
	 7WdSjGC8OXoURfSC1dCKmpfjLd48zSt5NWsVwOlZZ1V96Zko1D4weOu1oqdOghc5B6xQK
	 h0gtuIgVu4POANpxIAXXvpSBEsHscLeIOsz+QgVbBlGzf6XZFZ8ppOiH01BFAKgs9g8PJ
	 iKO06jwVC4lZd/nDpTG/u93r3X7rbWkjDP/ojAFOBkZ5+4XyMAVe3c3yjvYuwcYeSbxF4
	 7AtqJdRlyjaxymSFHqpKokmjrT1P2bqf14w/9A0swvVADaLoWZmd79StL36YX7YcIvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706400;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1h7SuxIdXP1BrmLiSW0TA0Y4x+A0dQHqIxOY0fZWzgw=;
	b=2EXNUdm1G9VBOC/gO9KFQAZo4hMcahlXMNWOKujwdOo1qtEzHgP9qLsJXXJq/kxbjQF4
	 p37nOhmJVawJEYvbuSkFk0o3FI7J10p746EbGdr/bjif88VIRkDvaUtt2HTKjw/AHOLUb
	 P6+s4+lvMmFGEXfwhNEvADJ1grtam9vJ9gPllXqbRp7uaDXdoq9VT19sWDVeJ/f7oehto
	 VkWZoyZuuE9MvxeskXsNxBqyRy028yu4aZlrQOmz+JNBVGLcsEJJhsedtk7CpMT2qxZOx
	 1uv28t0ByN5Ejh9q991TUOoZ8YTocsUz0b07UkDXxhdhfxTby3w6RnN9HvbA3LO6nRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=M5WQx64W;
	arc=none smtp.remote-ip=95.215.58.231
Received: from mta1.migadu.com (out-231.mta1.migadu.com [95.215.58.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA19606A329
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 11:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA19606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=M5WQx64W
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1h7SuxIdXP1BrmLiSW0TA0Y4x+A0dQHqIxOY0fZWzgw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793706391; v=1; x=1794311191;
 b=M5WQx64W3OrKv3IrbfaaaUU8t9LBurF+lIi1NsZf+TH86Tb8kzcQtOfRinqCLkp6vbJeJkjn
 Wdwp+SEY7bV+SCApfixGc5g2PSWIhjsr5o8DnWz2b+eULeX3U8KrowNWRCDh9p9CW2PdjVmXutk
 fgWn2GKcQL5AnmV3qr19TWzU=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4c5c651460189e35;
	Tue, 03 Nov 2026 11:46:31 +0000
X-Mizu-Trace-ID: 4c5c651460189e35
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	mason@kernel.org,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 41/47] mm/ksm: check large swap-cache folios before mapping them
Date: Tue,  3 Nov 2026 19:46:26 +0800
Message-ID: <20261103114626.15764-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-41-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-41-d6437171ecc3@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Oct 31, 2026 at 10:40:10AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>KSM folios are always small, but their shared swap slots can be read
>back as part of a large folio in the swap cache. ksm_might_need_to_copy()
>skips large folios, so another process can map a page with an incompatible
>anon_vma or page index. Reverse mapping then cannot find the new
>mapping, preventing migration or reclaim.
>
>Apply the same compatibility checks to large folios as to small ones.
>Pass the page corresponding to the swap entry and copy only that page
>when necessary. In do_swap_page()'s copy path, decrement only that slot's
>swap count, because the source swap-cache folio can now be large.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: f1879e8a0c60 ("mm, swap: never bypass the swap cache even for SWP_SYNCHRONOUS_IO")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

LGTM1

Reviewed-by: Lance Yang <lance.yang@linux.dev>
