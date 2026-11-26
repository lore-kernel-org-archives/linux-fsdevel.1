Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658747;
	b=WsbrgDF9YkiOcZMw9QVN185nDBfW89XUzUObQXQZIyFm4/cXSa06mD7qhnoxj5fn73CT
	 kFuu3Csox5v/6nmRsGIbgDSQ2KTWx6BwIGQz3hC60Sp0n/uQhNI7Ej6lUVv/qo1bcm3gm
	 auxhCduVxnFlRpS3NoI7gzjE73kREMPLSz4IQe5BtSvrf5/2HC6Vd0j3GhpLXHQ1Nf49P
	 FWhPYNRkeMq26pe5bXC7Vrgu+s3ha6nhiwCBnrG52byaVhXFz1/5snZuEWl6tnHiq3VI5
	 3mY7Sjc8UzkhXeftthuZaQd536fPWZxogcK45IzfPVOE/G5YMmID6o8zRqt/Skcd4hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658747;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=WtwI+c9ObEOaIfdXp9STes6sTUCSWn6KexSqCuHMD30=;
	b=VpfhP0Fywl9S6OQdnW8n/AwidKp9TyKA9UzrG7q0S3xW8V0KUI/5n64QvQkZRLIHiOWg
	 uyI2GN6RY6L1xHsmQCZ3rNBzuu9MbJJdHAwX/vt9dq1G8iihwZ7xsMyTOSUJf8yg5M3L/
	 qz6cdb8n3HkEP5Q8itaOG0bybrHEMsyHyZ1wkTO8yOPBrykXeeKvB/r++Lcf5XSTflgfN
	 JxDt6ymBGydm+JsDQtfBxViflxUEsj+wQuQykkx+DS+wNCCXbkZmrBE2Lv07pwRvCGWuz
	 XIpg3XTz/F91jlsZWkXlHfZKW9zPkwmZ87xbn72VTd+g69d9SkSszGOWzZZrKy5qVcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CVShjB8q;
	arc=none smtp.remote-ip=95.215.58.210
Received: from mta1.migadu.com (out-210.mta1.migadu.com [95.215.58.210])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18242606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 02:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18242606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CVShjB8q
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WtwI+c9ObEOaIfdXp9STes6sTUCSWn6KexSqCuHMD30=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795658745; v=1; x=1796263545;
 b=CVShjB8qQ7qAzh4mixJMxw40VAJKpj/4y1j0cDUIt5JjbLW+kd+JJpU2nVTYjJHjX733+0ip
 3kK9o+dOF/dvt+y9VU6UGV2PyBPNTgNBnCPqRVdtLtxnXM6/zgazAZfnIO3VzAMyFVJ5wB5Bx7s
 WTNj1msmqmOkk8SfzKfwyU/Q=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bcad4ddb13afde49;
	Thu, 26 Nov 2026 02:05:24 +0000
X-Mizu-Trace-ID: bcad4ddb13afde49
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 03/21] mm/hugetlb: always mark new page cache folios
 migratable
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-3-db27fd2f71a8@kernel.org>
Date: Thu, 26 Nov 2026 10:04:25 +0800
Cc: Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jinmeng Zhou <jinmengzhou22@gmail.com>,
 Hongfu Li <lihongfu@kylinos.cn>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Dave Airlie <airlied@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mike Rapoport <rppt@kernel.org>,
 Mel Gorman <mel@csn.ul.ie>,
 Dave McCracken <dave.mccracken@oracle.com>,
 Andy Whitcroft <apw@shadowen.org>,
 Adam Litke <agl@us.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>,
 Lance Yang <lance.yang@linux.dev>,
 James Houghton <jthoughton@google.com>,
 Yang Shi <shy828301@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Pedro Falcato <pfalcato@suse.de>,
 Gregory Price <gourry@gourry.net>,
 Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Byungchul Park <byungchul@sk.com>,
 Alistair Popple <apopple@nvidia.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>,
 Andi Kleen <ak@linux.intel.com>,
 Kenneth W Chen <kenneth.w.chen@intel.com>,
 Hugh Dickins <hugh@veritas.com>,
 Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>,
 Joern Engel <joern@logfs.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Michal Hocko <mhocko@suse.cz>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Sasha Levin <sasha.levin@oracle.com>,
 Guillaume Morin <guillaume@morinfr.org>,
 Wanpeng Li <liwp.linux@gmail.com>,
 linux-mm@kvack.org,
 Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@osdl.org>,
 linux-doc@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C615E9EC-BE52-4F33-86D4-4FE7F911EEAC@linux.dev>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
 <20261125-hugetlb_fixes_2-v1-3-db27fd2f71a8@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 26, 2026, at 06:33, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> hugetlb_no_page() and hugetlb_mfill_atomic_pte() only set
> hugetlb_migratable for a new folio once they installed the PTE.
>=20
> If they back out after adding the new folio to the page cache, for
> example because the PTE changed or is no longer empty, the folio will
> stay in the page cache without the migratable flag set.
>=20
> Later faults will find it as an existing folio and never reset the =
flag.
> Such a folio can never be isolated for migration, which breaks memory
> offlining, alloc_contig_range(), longterm pinning and memory failure
> handling.
>=20
> Worse, if the folio is not longterm pinnable, because it resides in
> ZONE_MOVABLE or CMA, memfd_pin_folios() and the longterm GUP path =
retry
> forever on -EAGAIN. memfd_pin_folios() cannot even be killed, which =
will
> be fixed independently.
>=20
> Let's fix it by setting hugetlb folios migratable whenever (1) a new
> anon folio gets mapped; or (2) a new folio was added to the page =
cache,
> like hugetlbfs_fallocate() already does.
>=20
> This has low urgency.
>=20
> Fixes: cb6acd01e2e4 ("hugetlbfs: fix races and page leaks during =
migration")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Muchun Song (ByteDance) <muchun.song@linux.dev>


