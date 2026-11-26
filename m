Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.90
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658610;
	b=K+/utymJqEggW1ryyFIuF7im/AqqkVozGvpg4EOXd7xM/qiNcswxF7S6vQ2LrrQjltn6
	 upv3YtAnWWS9O9uj1f7dS0EyrtMy8or6TWHGLBcW6hi1OZhiRtcS+UdgX7VEUGfsMaxqy
	 i7AAAGR/p58aXwaGa4jzRY0r+Inmu+y/7jDEasIder+FsJVj0NZg/S2STHPXwRh7mEv5t
	 uR6ipy3jIFLu3jS5i2Y6mMx4JaHokwD+Pr5Yu55uXmJPVtm5kB3xZa63zBAHcs4QW1Zt0
	 cZH1yvx1uWNtGdJFLZnqkavFPQyzciXq8rBWZ3P0bvkaSj8IAuyApcP5FJfTVb2/BJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658610;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=mDPdURnq3OYJxD9FHhva4DbPjq66mRuiBiRc8sZ8u50=;
	b=isVQxDlgVfQ/zPvnirhWh+PyNg9gRZsUAEadF31g/1nGOGKEI/Wqh3hXpVB6Muh0p8/d
	 ikFI1BLPOnSimS3uzc5Lnb618/iO1VaIgoyiMtZKYUXeTw6EyGS+ofs4CitXWWH9AOU8S
	 l6HBOT6dJtd8qwLR8vFzxz80XOIHujAt7NSjlkrvIUJPZfd1TMhocu5FEFyX7QY6fGI7X
	 T5RKcoYLbQxGnbTwo+QtjY7b821Z99uIYA9cvRc9FZJyfytBYQ1RwOUcyahaFmudB2Z1G
	 EirSuMNjhuza4qYnvaZtGn0WLltEjT/2htj6tE6WdyD/b/Bs8Ti2sDRfjRB16tZ4+mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZErz2gHT;
	arc=none smtp.remote-ip=95.215.58.90
Received: from mta1.migadu.com (out-90.mta1.migadu.com [95.215.58.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0E606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 02:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CB0E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZErz2gHT
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mDPdURnq3OYJxD9FHhva4DbPjq66mRuiBiRc8sZ8u50=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795658606; v=1; x=1796263406;
 b=ZErz2gHTqsz8fab7qlaB/35lX5tzDF84D27Q3qVrATZPxzLDk9sBcv4U0VvjoYWHWc+zcj5b
 idNoA3INzUORoNAmYbOeoHPnn/zi9Dd5M+b2ckpPS5++szpfnoFxQwlFB23r4OEYO3rZlqvMBnC
 p5DjSxP24y7eMF6a17IEFdZE=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 99fa385bc754693e;
	Thu, 26 Nov 2026 02:03:26 +0000
X-Mizu-Trace-ID: 99fa385bc754693e
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
Subject: Re: [PATCH 02/21] mm/hugetlb: fix truncated copy result in
 UFFDIO_COPY
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-2-db27fd2f71a8@kernel.org>
Date: Thu, 26 Nov 2026 10:03:04 +0800
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
 Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <36B2540E-D15B-4A56-88B3-2283A26B40BA@linux.dev>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
 <20261125-hugetlb_fixes_2-v1-2-db27fd2f71a8@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 26, 2026, at 06:33, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> From: Chris Mason <mason@kernel.org>
>=20
> Folios that span more bytes than can fit into an unsigned integer =
(e.g.,
> 16 GiB folios on arm64) are problematic with UFFDIO_COPY: the result
> from copy_folio_from_user() can be truncated, possibly indicating
> success instead of an error.
>=20
> We will then continue with the folio that has stale data, and make it
> accessible to user space.
>=20
> For example, if copy_folio_from_user() fails such that the number of
> bytes not copied is a multiple of 4 GiB, we'll get an effective ret =3D=3D=

> 0.
>=20
> Let's fix it by simply testing the return value directly.
>=20
> This has medium urgency, as it's an information leak.
>=20
> Fixes: 8fb5debc5fcd ("userfaultfd: hugetlbfs: add =
hugetlb_mcopy_atomic_pte for userfaultfd support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: cleanup code and description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Muchun Song (ByteDance) <muchun.song@linux.dev>


