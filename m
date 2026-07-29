Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8BF38DC45
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337526; cv=none; b=df1F32MFC02GpIZW+nngXP9XS89mx8FSi66K1q2LsQoB6FeuweXDmEqZXee44SyeuUti6zoWShAuM+MHWUb6laETDo+jyb1HgpvnNhIIwWtrytgZpJs6BdC/xjtxA2DBqbp8Pg+rfGcRUrBi2NdUXG0wqg8T4sZzU+kjzTnmhow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337526; c=relaxed/simple;
	bh=XANEl4Y71d9XEh5w5zCcKYOFujyJfLTF0oDYWZxt/Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDvLEU9T3Cf1eN5RmTbjWzF3GfcfkFlFkRmkoF0C9Vv59AV7Sg2ISsbuH/yRlT5kQXxxzxz0hDoSh5wibzpvuoscDf0Kp/L2SBgyyEOq0tzwMund8inKK/vo+2C6qBleCPjYKcuJuj97KWWA9iRtawIG+SwwCpP4v2Crew1sjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TsYYT5Ux; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TsYYT5Ux"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xpVwuT6Hev1WjQlh3dFEN4IM8UxH5igy66lsCYZfjDk=; b=TsYYT5UxfFOVD0AK6tj0Em2/CK
	GkXbE5tsFlQLvVWpTPyxYWZ53zOKFGNy/RzWZz+F/FKIElb6H2XKcgDSh7NT1yEpBvTR43bLwKq6M
	7PDf9tEg0QfCW85pUPYAyB7US5FyhQjgOXw/qPHM5bZhT/y65d0St/3CVc66wtWvA479Lht1I7USq
	cZ2S05Q1fD6Zpj5g2hfiyuY2IQozk871nyl7sz3U+To4lgpLm+nRSWtUtlJAPyqdQtcNHXt4ZZDIl
	3XH1IyImsqNkwSZvu1OjCvCUak/A1MoFkH2qDfuMXvZ/QNBn3W5+kRoKBpiBW9jwi4PYbct3g4Y3w
	NThsYNSg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5qM-00000008KbO-3XwE;
	Wed, 29 Jul 2026 15:05:14 +0000
Date: Wed, 29 Jul 2026 16:05:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v7 06/13] hugetlb: Use the has_hwpoisoned flag
Message-ID: <amoWqtYhXm9_Bxhf@casper.infradead.org>
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-7-willy@infradead.org>
 <amlQYkGgLmxmwX9_@gourry-fedora-PF4VCD3F>
 <amlrjtaFSEQLYbEO@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amlrjtaFSEQLYbEO@casper.infradead.org>

On Wed, Jul 29, 2026 at 03:55:10AM +0100, Matthew Wilcox wrote:
> > > @@ -2725,13 +2748,19 @@ int unpoison_memory(unsigned long pfn)
> > >  
> > >  	ghp = get_hwpoison_page(p, MF_UNPOISON);
> > >  	if (!ghp) {
> > > +		spin_lock_irq(&hugetlb_lock);
> > >  		if (folio_test_hugetlb(folio)) {
> > >  			huge = true;
> > >  			count = folio_free_raw_hwp(folio, false);
> > > -			if (count == 0)
> > > +			if (count == 0) {
> > > +				spin_unlock_irq(&hugetlb_lock);
> > >  				goto unlock_mutex;
> > > +			}
> > > +			ret = hugetlb_clear_poison(folio);
> > > +		} else {
> > > +			ret = TestClearPageHWPoison(p) ? 0 : -EBUSY;
> > >  		}
> > > -		ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
> > > +		spin_unlock_irq(&hugetlb_lock);
> > 
> > Adding new synchronization here without noting why - it's not
> > immediately clear what this synchronizes.
> > 
> > Is this just fixing an unrelated bug / should it be a separate patch?
> 
> This prevents a hugetlb folio (which in this arm we don't have a
> reference on) from being freed.  I think it ended up in this patch
> because Sashiko pointed out the race during review of this patch.
> It could probably go in its own patch 

OK, split out into its own patch.  The 0day bot chewed on it a bit and
came up with a config that enabled MEMORY_FAILURE and disabled HUGETLB
which showed a missing hugetlb_lock symbol.  Here's the new patch:

commit 9df49152f5de
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Wed Jul 29 08:41:50 2026 -0400

    memory-failure: Prevent hugetlb freeing during unpoisoning
    
    If we fail to get a reference on the hugetlb folio, then it might be
    freed as we operate on it.  Prevent the freeing and the attendant races
    around manipulation of the raw_hwp list by holding the hugetlb_lock,
    which is also held by the hugetlb code when freeing hugetlb folios.
    
    Fixes: ac5fcde0a96a ("mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage")
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2abaf99321e9..50eab2c23299 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -110,6 +110,17 @@ extern struct resv_map *resv_map_alloc(void);
 void resv_map_release(struct kref *ref);
 
 extern spinlock_t hugetlb_lock;
+
+static inline void hugetlb_lock_irq(void)
+{
+	spin_lock_irq(&hugetlb_lock);
+}
+
+static inline void hugetlb_unlock_irq(void)
+{
+	spin_unlock_irq(&hugetlb_lock);
+}
+
 extern int hugetlb_max_hstate __read_mostly;
 #define for_each_hstate(h) \
 	for ((h) = hstates; (h) < &hstates[hugetlb_max_hstate]; (h)++)
@@ -279,6 +290,14 @@ unsigned int arch_hugetlb_cma_order(void);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
+static inline void hugetlb_lock_irq(void)
+{
+}
+
+static inline void hugetlb_unlock_irq(void)
+{
+}
+
 static inline void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 {
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 944e6e1d4971..1dd0e7b99bb1 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2725,13 +2725,17 @@ int unpoison_memory(unsigned long pfn)
 
 	ghp = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ghp) {
+		hugetlb_lock_irq();
 		if (folio_test_hugetlb(folio)) {
 			huge = true;
 			count = folio_free_raw_hwp(folio, false);
-			if (count == 0)
+			if (count == 0) {
+				hugetlb_unlock_irq();
 				goto unlock_mutex;
+			}
 		}
 		ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
+		hugetlb_unlock_irq();
 	} else if (ghp < 0) {
 		if (ghp == -EHWPOISON) {
 			ret = put_page_back_buddy(p) ? 0 : -EBUSY;
