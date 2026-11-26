Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657764;
	b=fyG/UgVrD6MKSfZrzbvUIuY9jANKHVVYP2RZvlpcDHW2HlCpUwdiMGggQCOR6Xg5Q5ph
	 /X24WGf0XHz2w38CFP1wbkVoxm9Y3lOi9MwMdgjx7331WM9LpjqdriSIE4cS+5jVI6NEx
	 DXDIIgSDCZJVTQC53xknsZgl+ztqj337bI7ha/a25syq/Jir98K8yDvejAu9+2yX5fdEa
	 pa8Q1m/F+TyzytmsBDSIVh1Z6JfVbvh8fC8xkllMJwGFVJKPts1HHPgbxduQMtJ89qGeZ
	 +c4eNWM1SNkQ1i/UWvYgDuTjgILUGP2uTaabpOAS5gqcDY29EX4XAd0fRHw0ALJR4RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657764;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=fUm7OIYCLKHdOAGzUrU+yCvxeSMK1SFSB33JMsVoO2I=;
	b=VdmmYXJfA30QYPwawtiiMHuwGMJx+G/gS+5+WLNJDpExt0Ezl7qwUvkzHAvNGkg4cgF3
	 u8bG6E09LmETyhaDXOo3p1fBSAsfa+xeZs3AVXHDVG/11bqfJHjzMHj1aguTOaLFKPb8A
	 O3GCDB1wHNA+Nl7UIH2IFM4YFKJav/wQW/lEVAqia/nI8sRdoLPGpUJCAzQVPGaxKua2G
	 l6vqDZS+OzGRqUHnLFaMfIzpJEsN6NXpQUqOYtdJSTElXgsVd6rJHawaXpXSGc4pZ0RpT
	 RymLngmNvDuDWppV00mkjmxebRMHh+Ob5zIC9oXTnMKd1X67fIgSTCsUWh7x79x8whA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aMSuIjFe;
	arc=none smtp.remote-ip=91.218.175.131
Received: from mta0.migadu.com (out-131.mta0.migadu.com [91.218.175.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351C606A333
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 01:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B351C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aMSuIjFe
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fUm7OIYCLKHdOAGzUrU+yCvxeSMK1SFSB33JMsVoO2I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795657761; v=1; x=1796262561;
 b=aMSuIjFeh4f2FLL/56THyfcFowmeUkUx6P1VIJ9B27LIOUqpYyLg05kO8UgS0XxuWrQ0uLEe
 wHWaqRd8lLt2/u/GNijK1dZxKrb/xvt8HOZniac+RmYZKWpY2f4sUmH1GxWBA2c6mJu37g9n7mJ
 KKfvFBq4raildqYZVdjfTA88=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ce709ea24b407893;
	Thu, 26 Nov 2026 01:49:21 +0000
X-Mizu-Trace-ID: ce709ea24b407893
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
Subject: Re: [PATCH 01/21] mm/hugetlb: charge the copy made at fork to the
 parent
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-1-db27fd2f71a8@kernel.org>
Date: Thu, 26 Nov 2026 09:48:52 +0800
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
 Chris Mason <mason@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7774BE16-BDD8-41BF-9FE7-E383F333B4E1@linux.dev>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
 <20261125-hugetlb_fixes_2-v1-1-db27fd2f71a8@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 26, 2026, at 06:32, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> When copying page tables during fork(), the child is not yet assigned =
to
> the right memcg. When copying possibly pinned anon hugetlb folios, we
> must charge them to the parent's memcg, otherwise we can end up
> allocating more hugetlb folios than allowed.
>=20
> Let's fix it by charging the copy to the parent's mm, like we do when
> copying small folios in copy_present_page(), introducing a new helper
> function alloc_hugetlb_folio_for_fork().
>=20
> This is a hotfix for v7.4.
>=20
> Fixes: c2deb1356d82 ("mm/hugetlb: charge folios to the target mm's =
memcg")
> Reported-by: Chris Mason <mason@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Muchun Song (ByteDance) <muchun.song@linux.dev>

Thanks.

