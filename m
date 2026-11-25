Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795648428;
	b=UlqdZSsVzgNvKK7YZQ/ZRBTdSTbKmg43ZEeP9dcpyYQMfpLK7H1g5CJ3jE8+Fx+r4+8F
	 yjs1uNbkqN8yMV0K/bbbqcOgXmOC4PGjQOp1DIaIB29S+l8M3hsS/AdWdYFX17ZUheEKm
	 Vyr+uzsSXUxtYE+reYQLudoGGHXxAHN8G9/l2Y0fbBMDPx6e7sISXQtbrAdAiAylvImBI
	 JB1GnuP2VGyfNWswM7zw3QMtF45qxLs3o5Nt6WXBh5y/NEeDAfuhi3UbUzq0PFX/P3I8/
	 pgW2XlUP/S76e/8utSS1YJe7sXMnjsoNZU7BS3wdNDjJH9kmTm9BNDBLNevJL045bOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bmbARk3XHehA8pJF1qNbcXvK1JM9BX8FvFU7vWFVqag=;
	b=oXT+EDu7IA3btWKYfWmnYqTQWQ1p5P4PM4p93esSwyZe2cEgazM4Mw6QdRUcS+WHnaHk
	 PvgE00/LL3uiNjC54ak8e9yRMjyP9RxKcKbc0bgDaVXNKi9+ehaTmFO0LtXdnrHLePYXD
	 Ni1C3t/gLavWr3trUmD87h1aVCOPgfsMh9bGYfxEMYVcUo+ZGFPXoOTw7j61B3MrAfO6U
	 Ox7JEu/7OSi/Dc7YKIZFUhg2bh0lZULPk2lvmL4D5VoRLIiBIr+awbldmucIdlzRwR+lG
	 uaOmYus2A/JgZAAuJ2/imomMhap4vi7hhC+3KyTNPAet8KSJHgmoCHRSMU/Re0zKWMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SKxm+SOB;
	arc=fail smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CFB606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 23:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2CFB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SKxm+SOB
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb5b33e2ffso201735e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 15:13:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795648426; cv=none;
        d=google.com; s=arc-20260327;
        b=ljoVlClHOvNQ0/egdLbrKKnsDavpoJbj8Ftz1WhLEeMfFELW04H/KLIxqQqLpTKiaa
         FjvjIRqISjI1pIxOA80TbuocqaCVvazZK1yeAj/6LApcSqg9f5WZ0LF1vOetY7BPR/xo
         VEb5kwBKBO3xzZLoHvHv2uS/Flv67mLRN5Q3qMxabyQf+O9ZRhsOBC/i5ZoFous5dWMg
         jyxCf14kqBmGApMoHc41bwcoGJxkv6Xj+YJxK2QyTvJ2P76l4UHPkIBmUYq3KCrPNLbf
         ETMmgv2sLDEe36SkEwQT6iYiSeBohbb1Co/bRKzGDBNJbtuebe0mtss3hPZpWGL7scnV
         nfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bmbARk3XHehA8pJF1qNbcXvK1JM9BX8FvFU7vWFVqag=;
        fh=WdAMmris81Lucpyx4fAgLo46zOOs2EEDn3U1qTTvcb4=;
        b=FuMUt6GkBh0HOfeIJafFs/g4Z1MZuuppyglS3GR8D+PmVPtJfAla1KSHa4Uapky1G/
         88sOnkFsGF07YmudyFf6OPD8b1eNFt+g7VDQYchqpI+oSKbiE+cL9MJBTN0WdeH9ytSX
         CCECnWh0RBczOXJbiU2Rr1QveqLg439BIGuJMDqyst/TOENXhH9331btbc0SbS4YRgni
         Vh+TH/tW//eIKIUhT+SK54GaSzMGeptgtj2IamfBjtZKwDJPz6LBL9jTNxl/ROUqPzxt
         WNhrvGyy7J2CedH6Lq5XSnBlEx4IkK4cdX+qOJ7CAGqHATZnpZKGXdFlkXOMyrN/a4hM
         NXuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795648426; x=1796253226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bmbARk3XHehA8pJF1qNbcXvK1JM9BX8FvFU7vWFVqag=;
        b=SKxm+SOBB2ex/3j7AvV3T8YCOiYE5m3HgMGKpVoiU7GWNsXILHhg2MYsqT8e48n447
         3niUHGYlUJjgaE8qahNqsQA9/LJvBYAY/hs8KDbDqJjbsPi2KHAzQ0WUDY1PdH9HaSHE
         6JvuRmyYaTX7TwrNM7VBtsCvx7+iTh9uSXjROu8IqxPp0KApXfhZgpjZqIkP0C4iEH5m
         duqemOKs35oQuCy4TFOu9lUoYFPtIofX1QF4ccSvT54gOpIzT5/Y2A2pEKG4q6nWxkf1
         5OBBy3+F2DbM0Y25RYM3i7eUo27n5QvgdsE9QZYyQ+SpyGWyU4w9qKWCBsIBk9spnEN4
         83lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795648426; x=1796253226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmbARk3XHehA8pJF1qNbcXvK1JM9BX8FvFU7vWFVqag=;
        b=dphU8SwyvzpqlOk6kqTKEz+YeOnmJXBSHwVRl+BfKW954kgpjo6aLud+Wwl/284whZ
         qJIATgp5hjdE5d/XwBBn+lMn9M0DHVfieZIa+TY7V9bI/pabXR+/aPWQPm2EJQ9nZVU6
         B2tfsEfImIEaEUias9RR1SUtdY2kUsuo3YNNx6AzWNJBghfXN8x/34Il5rEKwzyqUWis
         oRVKmKeFndqKmd97/v7Sluha5C/PiY5hFc0Kazon9LksDx/a84HVFGXGNZRqTmBbsqfT
         aURiLROyOzfQWsxCPWryi4ePTdoYn/5q3xIJGOWGfS5nB2vdkwreWGb3Sa5hVg/9PhZC
         kL4A==
X-Forwarded-Encrypted: i=1; AL+hErGt9Y8V3C1i09BiKLztVEHg7Xgmm+WYqy57TDT9c9MRGxwUkwpT27FuUddK3ZsXDKerU2YsmMKzmzTvVMRk@vger.kernel.org
X-Gm-Message-State: APuU4Z9NStEYJ2PZiy7LgOq6LumpQKr0GnM2P+4tJq+apv1T8O3LEdoj
	gbntOYyDb/wHDaXStymRlmINcVXSkMNO2qFdxoFc+U5cD4eRs4BpRvaaKDLGLl4A69tIa8kSbYG
	nzHR0R7+HjQnkhQVmoSCYA8eqaWVCgit5g5DEsCMR
X-Gm-Gg: AZFdTZe3hOpmxOrb2kMEnA6BU65jdNtVXFJEenMJdr751qilTEjet6q3duhrgWwcOhx
	0CN1catrjKRiW9slcN0JhuP5kXwYt8SRGCnG8lJyNDzNbIAcQzTf15yhnAKHi8k0foI7Ol0YjmF
	2O3WOHhjgxaSgOrLRCRJWL32YBlhI1u0cCjCqURQSXCfmGwEtG6rcrNMEJlctX3Av5qM2Ch7TOq
	KDJ4OTjTHBuqWy5rJ24zt6Higq0WZwzwdjXkei4mOYfxJUJOhYpJecvupyJ1Pkc/H8iOq2HqhvN
	GG1hb+d8SrxHIc1/nZEAvYrD7/EX7XYlVzzHcOW3rLdGh6F2SXaGBFnQz3G+fijqJ4EZtphG2/b
	7eiPJx9//uM5GNNwmgWnsaiDy8Rk8L8x6bImGXR98cwQzAnO0sPqDWMU1t+h8bYQv2RtpNg==
X-Received: by 2002:a05:600c:26cb:b0:4a1:fb0b:1c9c with SMTP id
 5b1f17b1804b1-4bb9169f045mr2044145e9.10.1795648425836; Wed, 25 Nov 2026
 15:13:45 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org> <20261125-hugetlb_fixes_2-v1-7-db27fd2f71a8@kernel.org>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-7-db27fd2f71a8@kernel.org>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 25 Nov 2026 15:13:32 -0800
X-Gm-Features: Aa3M54o0VivDc1V8RDqLgeYd6VEevBgWlfFAdGAu_CvY1Dn7_qwvILYBeMeboYQ
Message-ID: <CACw3F51O9kQut0+uOCgP4BEB6VmsmhFVLFxvLXGJPeD-dk0n5Q@mail.gmail.com>
Subject: Re: [PATCH 07/21] hugetlbfs: don't zero poisoned pages in a hole punch
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Jinmeng Zhou <jinmengzhou22@gmail.com>, 
	Hongfu Li <lihongfu@kylinos.cn>, Andrea Arcangeli <aarcange@redhat.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Dave Airlie <airlied@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>, Mel Gorman <mel@csn.ul.ie>, 
	Dave McCracken <dave.mccracken@oracle.com>, Andy Whitcroft <apw@shadowen.org>, 
	Adam Litke <agl@us.ibm.com>, Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	James Houghton <jthoughton@google.com>, Yang Shi <shy828301@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Pedro Falcato <pfalcato@suse.de>, Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Matthew Brost <matthew.brost@intel.com>, 
	Byungchul Park <byungchul@sk.com>, Alistair Popple <apopple@nvidia.com>, 
	Wanpeng Li <liwanp@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>, 
	Kenneth W Chen <kenneth.w.chen@intel.com>, Hugh Dickins <hugh@veritas.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, Joern Engel <joern@logfs.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, 
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, 
	"Kirill A. Shutemov" <kirill@shutemov.name>, Sasha Levin <sasha.levin@oracle.com>, 
	Guillaume Morin <guillaume@morinfr.org>, Wanpeng Li <liwp.linux@gmail.com>, linux-mm@kvack.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@osdl.org>, linux-doc@vger.kernel.org, stable@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 2:35=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> Since commit 8625147cafaa ("hugetlbfs: don't delete error page from
> pagecache"), a poisoned hugetlb folio stays in the page cache, and we
> must not access its poisoned pages.
>
> However, hugetlbfs_zero_partial_page() zeroes the partial folio of an
> unaligned hole punch without checking for poison, which can cause
> issues like machine-checks.
>
> Let's fix it by simply not zeroing poisoned folios. We don't really care
> about their content: the folio can no longer be mapped, and read() only
> returns data up to the first poisoned page.
>
> Only zeroing the pages that are not poisoned would need more thought, as
> we cannot reliably identify the poisoned pages; that is future work.
>
> Note that a folio that gets poisoned concurrently, after we checked it,
> can still be zeroed, and sync'ing with memory failure handling is also
> left as future work.
>
> This has low urgency, as it requires a hole punch on a poisoned folio.
>
> Fixes: 8625147cafaa ("hugetlbfs: don't delete error page from pagecache")
> Cc: <stable@vger.kernel.org>
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  fs/hugetlbfs/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 2e8672ae2fd52..5437a55d14f1c 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -656,7 +656,8 @@ static void hugetlbfs_zero_partial_page(struct hstate=
 *h,
>         if (!end)
>                 end =3D huge_page_size(h);
>
> -       folio_zero_segment(folio, (size_t)start, (size_t)end);
> +       if (!folio_test_hwpoison(folio))
> +               folio_zero_segment(folio, (size_t)start, (size_t)end);

Clean fix, LGTM.

Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>

>
>         folio_unlock(folio);
>         folio_put(folio);
>
> --
> 2.56.1
>
>
