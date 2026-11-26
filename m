Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.109
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658959;
	b=QnxgR7U4LB3vmvpbT3ghyel50Hu5uhnq9AikB3/p2z8pVnHbFXAUrPoWI927Kqfg08Rs
	 cf1qK4SYmSAttaZLOtZLmaRFZVQvwsz8haWUZxiE0Tk1axp2XOAP4rL+d32P4s0bq2vRw
	 gD0bo/H9ynyyqKajk8Ea4YDz0q1uHELBkqta10Oadi7Uc9z55wf0QXOw8GSoyfXr4sc7l
	 6joQw/crIE+AoBTMFWiKMTA2JVuM8kXnNLdWdGa6OEf+uLdr2IWyWGOh4/O9ijI/kxwR7
	 LNHXgJ8qtOYcuoTiGXWoE0vJxNQ4jNR4e/SwtLvkEnE1yRQHFTZEPdGaiWkLoMjB6tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658959;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=CcruErW631cRyNVYcZhaTd+ooyBSWxhrtfIr60h9UBg=;
	b=GUthOY9tLw/pfwLUa8HQFpyWa7uLrC7itsuWxBpf5IsNAPxhf0vQ2Yw5INjnINGuMeGD
	 5klweySaxFrsS0HPLm08R2OKh4U9p1kJOjEB0KLR1VYJnVjl5NWX/yevcYE2ZRp8nwWkV
	 HP0h6MQ5lEEXdQDH44HcUqcgJY4u/BZEJYGTeaRqz3A+rtkBqbkbfwiWqNCLCeT2Qx9UO
	 XxULptCLEFm+z0XCmzfN+0+0PbEIsjaAYz0mw3FGZmGtEdcVRHnWkZgqCTqtLzAJt62jq
	 ZNFTXECjVN3YRyczl93j14V2NLf9esHpYGlHHC3F9UOLyDwtqJMgMUnkBMiELzrGyPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iHiygrY4;
	arc=none smtp.remote-ip=95.215.58.109
Received: from mta1.migadu.com (out-109.mta1.migadu.com [95.215.58.109])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D38606A31E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 02:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09D38606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iHiygrY4
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CcruErW631cRyNVYcZhaTd+ooyBSWxhrtfIr60h9UBg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795658957; v=1; x=1796263757;
 b=iHiygrY4YdMMVg2PiVGi7WPUsuMeCiRWM6CpkTSUqvsjiB8j+BahxwGM+iwWHTN8s2d4ECK+
 rD2PKTT8rm58DkMPRcCSgEq+SLUBU5EijXFnr1RTqgFh4CWIK7gmgjY5Ho7W6XPV0ubECqn0KyG
 WbO2danQxz4doYswc8WhOKrQ=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e1cc9e9085ce54e2;
	Thu, 26 Nov 2026 02:09:16 +0000
X-Mizu-Trace-ID: e1cc9e9085ce54e2
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
Subject: Re: [PATCH 10/21] mm/hugetlb: only check PMD table sharing for
 PMD-sized folios
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-10-db27fd2f71a8@kernel.org>
Date: Thu, 26 Nov 2026 10:08:45 +0800
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
 stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7348490D-C5B9-4471-AFE9-CDE68FDBAFF1@linux.dev>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
 <20261125-hugetlb_fixes_2-v1-10-db27fd2f71a8@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 26, 2026, at 06:33, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> hugetlb_pmd_shared() reads "pt_share_count" from the ptdesc of the =
page
> table that maps a hugetlb folio, independent of the folio size, to =
tell
> whether that page table is shared. Only PMD tables have a valid
> "pt_share_count"; for other folio sizes, such as 1 GiB folios on x86
> that are mapped by a PUD table, we read whatever another user of the
> union left behind.
>=20
> As a result, such folios might be reported as shared in smaps and as =
not
> exclusively mapped in pagemap, and mbind(MPOL_MF_MOVE) and
> migrate_pages() might skip them.
>=20
> Let's fix it by adding hugetlb_folio_maybe_mapped_shared(), which
> combines folio_maybe_mapped_shared(), documented to not care about =
page
> table sharing, with a check for PMD table sharing only for PMD-sized
> folios, and using it in the affected callers.
>=20
> This has low urgency.
>=20
> Fixes: ca1a47cd3f5f ("mm/hugetlb: fix hugetlb_pmd_shared()")
> Cc: <stable@vger.kernel.org>
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Muchun Song (ByteDance) <muchun.song@linux.dev>


