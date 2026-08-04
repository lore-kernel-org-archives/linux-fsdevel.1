Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472FF416875
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868988; cv=none; b=pID0YtBX8Jcy3PJqtV/MH7bQOxaFqo05v3Kzw1flf0kRRXzGeNuDfporWnZyxTG9HMn+DES3RB3EqwJPFAILlCkHs3Po3of2mpPc2GDlCgMmERb60FgkkrDY4YjeX0eC85L9P18ojgd0GLlmv7/SZKGB8thVdb8wQPUa0VkP7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868988; c=relaxed/simple;
	bh=oUVr5DqTjhZ3MSjayVJPYW8GOmY9QHeuYI1RKHNjUNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR3CvtGXnKkmzyBN62EiEgK5yx2UAoIhnza4xA5KMLEm+ISO9Md9LCOVzLbIh4hJxXOGvhfiqXNfIJ7GrlQMAA1DYrjN2Ftveh0DE+KHA2QWoMWWkHqu9YbDv7C1+pCVEOs63hUIHprzgmAzh0RH7eKfjxU9iIm9FUplmPOk7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NZwRZafw; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NZwRZafw"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8edda5d56a5so1398356d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785868985; x=1786473785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FdjiYMrOe4oyIn7wBQJUa3e8e6H1YyqfJPN5wr7l4Qg=;
        b=NZwRZafwQS0ZFwtOACE78Do3rSa+8292QRHwonWoPzzsY9PzQJ4YnowbxAVhPlvz0W
         FGlJilBJEhkWQAutUydoHBz6r+wT5VEu7F7i0gVlmKtM5vIsG2AG1UgD0YDjhLwx/f2/
         Ue289uP7vgWWuyCyLuYn+bXTk1gsz/B99V2v8EZWIJITKjc62mQSxVq+ZpCk7Y22sxpH
         Q0HzXFsId7QQkuH9aDiypmP1y97dfGiyNVNa0x3LF2UazQxiwzjR+a7wJhBfqTc6hWEf
         7v1YsetFaOHNT2iy0QRScI1vV5gUQ9R1ppG8CzfKH/lU78j53gUZQpPScj1X4JO8N2Vf
         WYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868985; x=1786473785;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FdjiYMrOe4oyIn7wBQJUa3e8e6H1YyqfJPN5wr7l4Qg=;
        b=jHQaU6UlMMH6ZLYBT5Hh+rZoLs0phIlribRRi8QPyhDnqOlf4azA2R/N4SZevdRkD/
         TpgX7AUqLi/f50hWJT16J8WdGgzNNP34/E3BKXsSEu7FMCCPdnX3+8azBzbONj2NGMCH
         1W1MDJ/RFa9rLchSaQRJyaYbWVp0JB06BIM1XF7QGeO0Hwxr6L2HsS08VzjU3x6ljY2q
         IGVHu6s9dyqNFIMXzPE0PFBq5cMT183U9H24YcGN0es5tWBN66YkNzn5Vjg2/iymQVta
         h5JmAxl0q6r0KR/vMYsgmakFMZqYgIp7Ljba3ntpKKG2KsHpcX61CtffPgxm4ms4IL9z
         LgIQ==
X-Forwarded-Encrypted: i=1; AHgh+RpqSDjHXpy6jreOQ7g5uUf7WL0zKvoZtb1HgftVTZmwOchogoNEYveWEzlf4y6sko5a47evCFqS3v6AjSo1@vger.kernel.org
X-Gm-Message-State: AOJu0YzaaDyzu83afkfsAtdAutPztuT+rPDh/1uN6RR6Ky+vVxW74sBs
	FBOaQh3i8rcZ7wszJrrE3R0Vjtner5qKmcQgYG0jHWw4QSKR+SAbed6r6hljZ7P0Hvw=
X-Gm-Gg: AR+sD12f/V7yHaPAhZ6H/MiQroGnpv1CcPqEWNDJi00h6Ib02rocALzubbEDAuKCuh4
	IGDTwo01wUg+wFnlmuAktNbJQ2fRdtgXxaWX0aIavz2QkBW8qxfjMv7clwwOjm+8sJed+Q87PUD
	xtL6Yxd9RjETxnc4Zs6Sy+5qNCtjt7wBe+vGyLiU1ahgpR0sXZtoJ0Ft2frTS5U7PbMdnqq6Hu9
	PLhxTrVVA8se9cYxbpRUG2XoCabA71q/fpQ+H3jC9atizBSl/tt8ztiJ+oDi/29FQMGVIrA90Dh
	XquBeY5O0cJ3a6CzHnE4hFbWvrwNOvcID4vmiBobfaBsL+u64oCjoPkDCIhF/z4fnEtjRiV7Ozm
	4w+tChDa76vxrB7OAVm8uc+zT9E2AfHksBYV+2+PAZzMxneNir3IfKkUEMBpnuynX8s+N8r6K7P
	qi0kYhQHigyG2MqVYfS67SfiMOYCPSNp8aHF86WfS9vEcnu/A3HZOEDMbj69Qx4eSF02FcyUXXa
	iaeGXLmVDj2GFbtamK4GTCOz9Cs44L19Ib3Rmux0229
X-Received: by 2002:ad4:5c45:0:b0:8ef:867c:b8be with SMTP id 6a1803df08f44-9088109301dmr17916816d6.8.1785868984851;
        Tue, 04 Aug 2026 11:43:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ffe09f0sm7914906d6.22.2026.08.04.11.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:43:04 -0700 (PDT)
Date: Tue, 4 Aug 2026 14:43:02 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v8 08/15] hugetlb: Use the has_hwpoisoned flag
Message-ID: <anIyVIUzIpsVDtro@gourry-fedora-PF4VCD3F>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-9-willy@infradead.org>
 <anISVv340bo1l9as@gourry-fedora-PF4VCD3F>
 <anIWdALS_1pmGA-t@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anIWdALS_1pmGA-t@casper.infradead.org>

On Tue, Aug 04, 2026 at 05:42:28PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 04, 2026 at 12:28:06PM -0400, Gregory Price wrote:
> > Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> 
> Thanks, will add.
> 
> > > -#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> > > +#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_LARGE_FOLIO)
> > >  /*
> > > - * PageHasHWPoisoned indicates that at least one subpage is hwpoisoned in the
> > > - * compound page.
> > > + * folio_has_hwpoisoned indicates that at least one page is hwpoisoned in the
> > > + * folio.  That page will usually also have the HWPoison flag set, but this
> > > + * is not possible for folios which have HVO (see memory-failure for the
> > > + * scheme used in that case).  You probably don't want to call this directly;
> > > + * use folio_has_hwpoisoned_page() instead.
> > >   *
> > >   * This flag is set by hwpoison handler.  Cleared by THP split or free page.
> > >   */
> > 
> > Had to google HVO, and didn't see HVO directly mentioned in
> > memory-failure.  Maybe worth expanding HVO to its actual definition and
> > a sentence on the quirk.
> 
> It is mentioned earlier in the same file:
> 
> include/linux/page-flags.h:      * Limit mask usage to HugeTLB vmemmap optimization (HVO) where it
>
> but that's not obvious when reading a patch.  I'll just expand it here:
> 
>  * The has_hwpoisoned flag indicates that at least one page is hwpoisoned
>  * in the folio.  That page will usually also have the HWPoison flag
>  * set, but this is not possible for folios which have HugeTLB vmemmap
>  * optimization (see hugetlb_update_hwpoison() for the scheme used
>  * in that case).  You probably don't want to call this directly; use
>  * folio_has_hwpoisoned_page() instead.
> 
> > Does "Hugepage Vmapmem Optimization" just report poison for the head and
> > we lose the sub-page poison information in general?
> 
> We only lose the sub-folio poison information if kmalloc fails in
> hugetlb_update_hwpoison().  In the happy case, we retain knowledge
> of which pages contain hwpoison (and later in this series, we actually
> expose that information instead of just pretending the whole folio is
> poisoned)
> 

Gotcha, thank you for the additional context.

~Gregory
