Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.237
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959621;
	b=xLg3dXSOA4uznfPyLR7Cp4HboZrE6FxDaJfUm7wv6e9c1ko5TlliRKkq6wsbxn1MnFqq
	 yZxk0u0LOFY0J4DbwlqF9ErYSeW3uFvmvqd+RAxz72zo6ssddDDrOgmRv/LxfOnnnkVxe
	 CFc9IobQQC0nQ16i/9jQxKGIzTBZ8x0OtkA5kK6LP+12Vpsq9i9FudEfSO8OuLyMyb/+V
	 m4Zp1HUV1aKmY3gJWrOcqZxSFFf2Prq5A0MGj3boK643aPjcV+/GiNuDBwk/WaOUBGvKp
	 lu2kNWEUu5nOiKyOnAZnGfAoWcE09HLiahywoWMcww9a46BTIs0pOoBXMZAS9PVsDtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959621;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wS8HVyR4zbY3pfGi/Mj8Yz7yzAVziAm8n3+oqxcnzgc=;
	b=Sf9YKiKt8uu4a2tBhgOq8e0LlVVUe+kANbL7+agtrhlANlZHJxIdwNq2CMPRdB8hdlwU
	 RTnMA2AUGccAOBncGaofYkZnUFBzd/mjddZ9cMzIwJ3jSFm6BFx+yQO3FA/RLUeHaA387
	 BMBFa3cEs5EQe1GzsHuna/qoe2Bs6MVRKBT5mNxW0vNw/gVBBsCZMLnXoCxZmxq+kh5Sl
	 TLDJn4+Lhi6vPWxMosF1tTW12jGGQRL69B2sdr5413+zSJ38Y0Ao4u3gtQeBWEKY3oi0D
	 Vf9qXXFC6wRvrvS8SjDFAOietqDi5VJHe7bKlkyAmoZWja0QalHvcxvkTqasa+gKprg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EziUgwa2;
	arc=none smtp.remote-ip=95.215.58.237
Received: from mta1.migadu.com (out-237.mta1.migadu.com [95.215.58.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197E7606A331
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 10:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 197E7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EziUgwa2
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RbNpr/gp/P3/FChdryWgHiDNE03PXpM0ZDpmAqvKnzE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793959619; v=1; x=1794564419;
 b=EziUgwa2y6pX6lOUce9W+3Pcj4so/8hyEMAWywYesjK8x6xHOAX/A3zDdlSpe6i/qDPi0g8V
 QNh1T9foTRG6i+++DrYKw5bF27iENNmcG9PEKvCKss+gS3dYDWPFzg9K0E9L0zqjnAwhnYd68dG
 Lso2HTCdggWNVfngEUj4sCWc=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b7c33c397d809dcb;
	Fri, 06 Nov 2026 10:06:58 +0000
X-Mizu-Trace-ID: b7c33c397d809dcb
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: azpijr@gmail.com,
	david@kernel.org
Cc: akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	peterx@redhat.com,
	hannes@cmpxchg.org,
	songliubraving@fb.com,
	riel@surriel.com,
	hughd@google.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	robin.murphy@arm.com,
	steven.sistare@oracle.com,
	jhubbard@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	iommu@lists.linux.dev,
	mason@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: limit pagecache folio refcount when mapping pages
Date: Fri,  6 Nov 2026 18:06:45 +0800
Message-ID: <20261106100645.77296-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <528e3a0e-04fb-427f-88c7-63a7f4bbc505@gmail.com>
References: <528e3a0e-04fb-427f-88c7-63a7f4bbc505@gmail.com>
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


On Fri, Nov 06, 2026 at 10:42:17AM +0100, Jose A. Perez de Azpillaga wrote:
>On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
>> With large file folios, overflowing the folio mapcount and refcount
>> became possible. For anon folios it is currently not really an issue:
>> each large anon folio can only be mapped once into a process.
>> 
>> That's not really big news, but it's about time that we do something
>> about it because some modern technology might find ways to abuse it :)
>> 
>> One of the enablers for that was commit ddc58f27f9ee ("mm: drop tail page
>> refcounting"), however, file thp support was added later.
>> 
>> File folios can be mapped multiple times into the same process, allowing
>> for processes to hold many references to the same folio.
>> 
>> As a short-term solution, let's introduce two folio refcount limits:
>> one for ordinary consumers and one for admins. Leave some headroom
>> before the refcount goes negative, which we really don't want (having
>> the mapcount go negative is also not expected).
>> 
>> Start reporting SIGBUS if we run into limits. When restoring mappings
>> from migration entries, instead zap the pte/pmd entry. We allow for
>> slightly exceeding the limit to keep things simpler.
>> 
>> This is far from ideal, but better than all easy alternatives we can
>> backport comfortably. For now it fixes the big problem: letting
>> the refcount (+mapcount) go negative and cause trouble.
>> 
>> This is only a temporary fix, we'll follow up with something better.
>> 
>> While the refcount checks are not required for order 0 folios, let's
>> just add them for consistency: each folio_add_file_rmap*() and
>> folio_dup_file_rmap*() needs a prior check.
>in mm-new copy_huge_pmd() now does a folio_dup_file_rmap_pmd() at fork,
>since Konstantin's "mm/huge_memory: copy file THPs at fork like
>copy_present_ptes() does". doesn't that one need the check too?

Ah, good catch! My local tree didn't have Konstantin's series [1] yet. And
right, that path needs a check too I guess :)

[1] https://lore.kernel.org/all/20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-2-c56d0d26f970@virtuozzo.com/

>
>the rest LGTM:
>
>Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>
>-- 
>cheers,
>jose a. p-a
>
