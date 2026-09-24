Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFDB47987B
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790247329; cv=none; b=o8Kixkstg7Zq8Gf4WTiVY8sPhLRPMWJihbR+O2XsWyvTzrOpUJqVRCnoDBEU7u4q+B0o1zHYbqNridaM1KShThFY4KzUTaFgCTHGsbL+s5PRrSs0H3jEbqpdhhzp6GVSxqp+PtmB+B3tVN1zy0N9dP3ghuuMbyFCQIhbYh6ifT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790247329; c=relaxed/simple;
	bh=K66oXG1oLDQAtAwahwyeoNrSsRiS5HMTsY3DDt5TqkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rw+n0CAzT44LnV+I23eUTQVqZlZt4CgJpzQxg2Ij5YtW/cmcXpySIZvc9H7P28ZVkNgZ/CwC7SK5wFJXJH08XTXuprh40GxtIvyDE7c4VtdRSQGnFFxE8uMsd3LszTH41897NVVOLjkHY2BjTfUxkWH9B6wIu6Vcgd7DES9kOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/vMiWCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/vMiWCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D55C1F000FF;
	Thu, 24 Sep 2026 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790247316;
	bh=xlbgbPZXi2htDxCGRg59ISfX4CrG4HSElbDSTPyKcas=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y/vMiWCL+POKbjG5s8G1rzwAL2N0ldtWZAi3kVuVmbLBME/4gCozmzU4VPzUzztMd
	 9V6tLPIL5Sj5VWdVDttAeswn8rExJT7yBXFYFNvh8OtRQ2tA9KiarOPQRPzY+g+JMr
	 prd5+iv5yafNrHNTQ6sH7PL1W5sXR808TUjNakgeUoh4VBht8kxtee8v55xo8MevxS
	 TyRPKF69aUclvI7T4Ce8qgDMok6CU3kQwxG9K7k+RHit/C/L8UIeoUifIsHw6MPyqr
	 LdONXuhDGGiK9HEupy6bpX92f00ffGtu3HSkOD/uTYTB8V++u8S7+xlRn2XtTODN5K
	 dIytisM4mK17Q==
Message-ID: <6121136c-de9d-4577-a30d-f00dbe244e5d@kernel.org>
Date: Thu, 24 Sep 2026 12:32:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/15] hugetlb: Use the has_hwpoisoned flag
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jane Chu
 <jane.chu@oracle.com>, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Christian Brauner <christian@brauner.io>,
 Jiaqi Yan <jiaqiyan@google.com>, "Gregory Price (Meta)" <gourry@gourry.net>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-9-willy@infradead.org>
 <a51a6236-8881-4479-8f04-39676e0e1f14@kernel.org>
 <an3uN4TAAZ2miXhe@casper.infradead.org>
 <7608c80e-645b-4d07-bba3-ef45ee36fba4@kernel.org>
 <arGidwZQrrWVPAoj@casper.infradead.org>
 <7a23511f-365f-436f-b934-6a520510409c@kernel.org>
 <arQkP2uEzog8ChN0@casper.infradead.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <arQkP2uEzog8ChN0@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/26 21:10, Matthew Wilcox wrote:
> On Wed, Sep 23, 2026 at 01:40:24PM +0200, David Hildenbrand (Arm) wrote:
>> On 9/21/26 23:32, Matthew Wilcox wrote:
>>>
>>> We might be able to split this into two series at this point.  
>>
>> That would be good, because I suspect the "generic_file_read_iter() in
>> hugetlbfs" part is less controversial than the hugetlb cleanup and we can just
>> merge that easily without touching too much other code.
> 
> Oh, no, it's awful and complicated.  We could strip out the two bugfixes
> which are at the start of the series, but why would we want to do that?

Andrew usually wants us to separate bugfixes (especially stable ones) from
other work. Unless we all agree that they are not urgent and can go in in
the next cycle. I assume that's the case here.

> 
> It has to do with hugetlb not using the has_hwpoisoned() flag today,
> and to do that we need to do all the other cleanup first.  You don't
> need to read + understand those earlier patches; they have enough 
> review from people familiar with this area.  And sashiko ...

I think I reviewed most of them? Also, I like to understand code that touches
files I maintain. Independent of who (or what) else reviewed it.

Taking another look, most of the hwpoison patches are fine and I fully agree
that using has_hwpoisoned is much better. And if it helps to implement support
for the generic iterator, good.

Figuring out the actual hwpoisoned page for hugetlb looks like the right thing
to do.

I am not convinced about the huge_poison thing though, that originally caught my
attention.

So trying to understand the race we are trying to solve (that is independent of
the original idea of the patch set), I realize that these races are only on some 
slow paths we don't particularly care about for performance.


I'd just do the following to avoid that huge_poison thing and keep it simple:

From 9f175684aea7e1cebb1d4070c217a20c9e847294 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 24 Sep 2026 12:12:17 +0200
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/page-flags.h | 40 ++++++++++++++++----------------------
 mm/memory-failure.c        | 37 ++++++-----------------------------
 2 files changed, 23 insertions(+), 54 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f75d66c425095..c7f6ce68c6d15 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -909,6 +909,7 @@ FOLIO_TEST_SET_FLAG(has_hwpoisoned, FOLIO_SECOND_PAGE)
 FOLIO_TEST_CLEAR_FLAG(has_hwpoisoned, FOLIO_SECOND_PAGE)
 #else
 FOLIO_FLAG_FALSE(has_hwpoisoned)
+FOLIO_TEST_CLEAR_FLAG_FALSE(has_hwpoisoned)
 #endif
 
 /*
@@ -1047,29 +1048,8 @@ PAGE_TYPE_OPS(Slab, slab, slab)
 
 #ifdef CONFIG_HUGETLB_PAGE
 FOLIO_TYPE_OPS(hugetlb, hugetlb)
-
-#ifdef CONFIG_MEMORY_FAILURE
-static inline bool folio_test_huge_poison(const struct folio *folio)
-{
-	return (READ_ONCE(folio->page.page_type) >> 23) ==
-		((PGTY_hugetlb << 1) | 1);
-}
-
-static inline void folio_set_huge_poison(struct folio *folio)
-{
-	folio->page.page_type |= (1 << 23);
-}
-
-static inline void folio_clear_huge_poison(struct folio *folio)
-{
-	folio->page.page_type &= ~(1 << 23);
-}
-#else
-FOLIO_TEST_FLAG_FALSE(huge_poison)
-#endif
 #else
 FOLIO_TEST_FLAG_FALSE(hugetlb)
-FOLIO_TEST_FLAG_FALSE(huge_poison)
 #endif
 
 PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
@@ -1096,7 +1076,14 @@ static inline bool PageHuge(const struct page *page)
 }
 
 bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page);
+#ifdef CONFIG_MEMORY_FAILURE
 bool hugetlb_unref_page_hwpoison(const struct page *page);
+#else
+static inline bool hugetlb_unref_page_hwpoison(const struct page *page)
+{
+	return false;
+}
+#endif
 
 /*
  * Check if a page is currently marked HWPoisoned.  This check is best
@@ -1111,8 +1098,15 @@ static inline bool is_page_hwpoison(const struct page *page)
 	if (PageHWPoison(page))
 		return true;
 	folio = page_folio(page);
-	if (folio_test_huge_poison(folio))
-		return hugetlb_unref_page_hwpoison(page);
+
+	/*
+	 * It's not safe to query folio_test_has_hwpoisoned() due to concurrent
+	 * splitting.  As we don't expect to be called on any hot paths, simply
+	 * always take the slow path for hugetlb folios, whose per-page poison
+	 * state may be tracked out-of-line.
+	 */
+	if (folio_test_hugetlb(folio) && hugetlb_unref_page_hwpoison(page))
+		return true;
 	/* In case we raced with hugetlb transferring flags */
 	return PageHWPoison(page);
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c0a402522c216..d713eddf47640 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1869,13 +1869,8 @@ bool hugetlb_unref_page_hwpoison(const struct page *page)
 
 	spin_lock_irqsave(&hugetlb_lock, flags);
 	folio = page_folio(page);
-	if (!folio_test_huge_poison(folio)) {
-		ret = PageHWPoison(page);
-		goto unlock;
-	}
-
-	ret = precise_page_poisoned(folio, page);
-unlock:
+	ret = folio_test_hugetlb(folio) &&
+	      hugetlb_page_hwpoison(folio, page);
 	spin_unlock_irqrestore(&hugetlb_lock, flags);
 	return ret;
 }
@@ -1908,23 +1903,6 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 #define	MF_HUGETLB_PAGE_PRE_POISONED	4	/* exact page already poisoned */
 #define	MF_HUGETLB_RETRY		5	/* hugepage is busy, retry */
 
-static inline int hugetlb_set_poison(struct folio *folio)
-{
-	if (folio_test_set_has_hwpoisoned(folio))
-		return MF_HUGETLB_FOLIO_PRE_POISONED;
-	folio_set_huge_poison(folio);
-	return 0;
-}
-
-static inline int hugetlb_clear_poison(struct folio *folio)
-{
-	if (!folio_test_has_hwpoisoned(folio))
-		return -EBUSY;
-	folio_clear_huge_poison(folio);
-	folio_clear_has_hwpoisoned(folio);
-	return 0;
-}
-
 /*
  * Set hugetlb folio as hwpoisoned, update folio private raw hwpoison list
  * to keep track of the poisoned pages.
@@ -1933,7 +1911,8 @@ static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 {
 	struct hwp_page *p;
 	unsigned long flags;
-	int ret = hugetlb_set_poison(folio);
+	int ret = folio_test_set_has_hwpoisoned(folio) ?
+		  MF_HUGETLB_FOLIO_PRE_POISONED : 0;
 
 	/*
 	 * Once the hwpoison hugepage has lost reliable raw error info,
@@ -2163,10 +2142,6 @@ static inline unsigned long folio_free_raw_hwp(struct folio *folio, bool flag)
 	return 0;
 }
 
-static inline int hugetlb_clear_poison(struct folio *folio)
-{
-	return 0;
-}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 /* Drop the extra refcount in case we come from madvise() */
@@ -2796,7 +2771,7 @@ int unpoison_memory(unsigned long pfn)
 				hugetlb_unlock_irq();
 				goto unlock_mutex;
 			}
-			ret = hugetlb_clear_poison(folio);
+			ret = folio_test_clear_has_hwpoisoned(folio) ? 0 : -EBUSY;
 		} else {
 			ret = TestClearPageHWPoison(p) ? 0 : -EBUSY;
 		}
@@ -2816,7 +2791,7 @@ int unpoison_memory(unsigned long pfn)
 			folio_put(folio);
 			goto unlock_mutex;
 		}
-		ret = hugetlb_clear_poison(folio);
+		ret = folio_test_clear_has_hwpoisoned(folio) ? 0 : -EBUSY;
 		folio_put(folio);
 		if (!ret)
 			folio_put(folio);
-- 
2.43.0



Makes /proc/kpageflags scanning slower with hugetlb folios, I don't think
sure anybody cares, really. We could add a way to safely check in a racy
way the has_hwpoison flag, but I don't really see the need to right now for some
debug infrastructure that does these racy things.

-- 
Cheers,

David
