Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667A3783B0;
	Wed, 17 Jun 2026 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735302; cv=none; b=GvJDfX33jq3mmAfbvxdoY2Gks8vOkJkGorH2MXWehqOANx1scU1jOh12YXmu9LC+CaYptjGt/ZZz3xAXn51q5SEIFnzsBOKJ5F6Bfp+s7LKAfSsmSxthC/VjsJynYi4g/Yd4yF0kHkWQa4cgbHovpdvJoCla9i7MIKiW55U9jC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735302; c=relaxed/simple;
	bh=tLbPu8C8b6r5OOHOvBiknQU5eGDzef/mN/LRiilAois=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhwrPUcs6dGjV6Z/Oy8FVbjXep2G2H3ZsYDOQHjM7x+3XvFJLkjFd/+C11ksKi7TWtd0wTt9hwiPeRTbh/uCwkXrTNHvhhDmwDWCA3J+CZDkn/qfQ74gJxz0XhGqHLPT9IhDlwfAuWPVqDJr047zt1vzSEAeWJvPdbmhW9O5Neo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hcURVoml; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hcURVoml"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KNYyO6SgPKl4C9MF3+RAjBkHpwVrxYNEfsKvOvBWLNg=; b=hcURVomlWT5nqRNu4mssXwPiRF
	7ktKlqqLah/ESrsnAO6TOGb+NLOJLeg9107bAxjEw9M9V3sAlzaUcCiLUt9apxycXIeiKiPih4gqR
	E2mufM5NaHDNLe8jEaU6Ts7ttO3cLylYfAZPi7Varz/WNutEv8s+8yBmeP0cPk0Kw4eYYvik0rd6Y
	RN9uSE61LUWHgRolMlUq/PO7+H4PurkY+ph7z/Xx842H8s48zJPs3mjU79lXW20E7Prs+cNTufO/w
	M4iDrprAndP9FvtTAFa9WZH9hBCX5oFdkS4wI1BDKX/NkpulEn0vhuVKEmqsmg7ftB/h8n3Cbc8Pl
	RmuqUqmA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZyju-0000000DNrv-0BST;
	Wed, 17 Jun 2026 22:28:06 +0000
Date: Wed, 17 Jun 2026 23:28:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jane Chu <jane.chu@oracle.com>
Cc: akpm@linux-foundation.org, jack@suse.cz, viro@zeniv.linux.org.uk,
	brauner@kernel.org, muchun.song@linux.dev, osalvador@suse.de,
	david@kernel.org, hughd@google.com, baolin.wang@linux.alibaba.com,
	linmiaohe@huawei.com, nao.horiguchi@gmail.com, lorenzo@kernel.org,
	rppt@kernel.org, peterx@redhat.com, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/11] hugetlb: Convert the vmf->pgoff to PAGE_SIZE
 granularity
Message-ID: <ajMfdQf-Fspwmstr@casper.infradead.org>
References: <20260617172534.1740152-1-jane.chu@oracle.com>
 <20260617172534.1740152-6-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617172534.1740152-6-jane.chu@oracle.com>

On Wed, Jun 17, 2026 at 11:25:26AM -0600, Jane Chu wrote:
> +++ b/mm/hugetlb.c
> @@ -5654,6 +5654,8 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_fault *vmf,
>  						  unsigned long reason)
>  {
>  	u32 hash;
> +	struct hstate *h = hstate_vma(vmf->vma);
> +	pgoff_t idx = vmf->pgoff >> huge_page_order(h);

If we do manage to make mapping_min_folio_nrpages() return the right
answer for hugetlbfs (see earlier comment), then we can avoid this by doing:

+++ b/mm/hugetlb.c
@@ -5936,7 +5936,7 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
        u32 hash;

        key[0] = (unsigned long) mapping;
-       key[1] = idx;
+       key[1] = idx >> mapping_min_folio_order(mapping);

        hash = jhash2((u32 *)&key, sizeof(key)/(sizeof(u32)), 0);

although I wonder if we still need the fault mutex array, given that we
now have mapping->invalidate_lock?

