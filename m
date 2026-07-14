Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FA141A907
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054664; cv=none; b=FpOF7BtaxcSohtBL0iMcGCH5Mbw8FLuWRKapfpyVwX4c6S4yBon5rgRk+hTQ3PX75R7nd0s3s/dtKnThYAWdqVrOptY/5/C/C1Hf78xitCd93BnpDJTem8SQXM/ieiVy7ZDts+N1xyGLdBZerPd31J1I8ZCL6i97KZkYAzIbrsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054664; c=relaxed/simple;
	bh=Z5KeD7JVkrSSAcUbU0XQgU1/M5SFtwy89UpH77KvcNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aia6WDdK1hH13UgLUS++AByxHWoL+mZyPJyJYclm/65lHd/aqqBYM70WPcD7Td9sxaBo9sgdtMv1PDW0GV6gDEu6gVLRPTcqqZL4Udxn473PrP/r/8mtzV5NuSaYGhSrAF4SZsZS0w78gbie17lblPiOsSmPQawg90Pwjz9L5rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kb5ECDFR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kb5ECDFR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UYp3fFoWaSvK1ZQvrg6poTd1wGmPJuU6X2lxSu3LEoA=; b=kb5ECDFRCSmGPS58Y3hiuDcc41
	QgrD3XNA/n+0hqGvX6V3+LUkM+guvHdz7BsE5Qg+wG7/FBNkhYi6Ijz7HHfhfg/7Ch6km5/HfsU9+
	QIrCbbNc4xdLVE2cMgZnjxdLZs5yl84AUJOr331G18eR+UWv25l3eSUIuNcwEihVtuhL4f2tfsjqj
	ivv3/rWbcdTRbzQVY4CB+7ZvbzhYn7+c3Xo7HY3PS+eGysVyQuRE13uk927cV5uXt/tAJ26cmWLbp
	zlL/ZIZZ/ReVIsbHA1tLlzu+M5MEVu9bidXtwnWKHXvok2SmyJg/Xty9DdRFtpSVJTamEA+1l/dbi
	Re2YN95Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wji76-0000000Fj3Q-2ka3;
	Tue, 14 Jul 2026 18:44:16 +0000
Date: Tue, 14 Jul 2026 19:44:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v3 9/9] hugetlb: replace hugetlbfs_read_iter() with
 generic_file_read_iter()
Message-ID: <alaDgCdMQvrfUL8f@casper.infradead.org>
References: <20260714180840.3731244-1-willy@infradead.org>
 <20260714180840.3731244-10-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714180840.3731244-10-willy@infradead.org>

On Tue, Jul 14, 2026 at 07:08:39PM +0100, Matthew Wilcox (Oracle) wrote:
> From: Jane Chu <jane.chu@oracle.com>
> 
> generic_file_read_iter() now handles hugetlb poison, hugetlb page
> size and missing folios correctly, so we no longer need a separate
> hugetlbfs_read_iter().
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Co-developed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/hugetlbfs/inode.c | 109 +------------------------------------------
>  1 file changed, 1 insertion(+), 108 deletions(-)

What I was _testing_ had this hunk in that I neglected to commit to git
before running format-patch:

@@ -784,6 +784,7 @@ static void hugetlbfs_init_regular_inode(struct inode *inode)
        inode->i_op = &hugetlbfs_inode_operations;
        inode->i_fop = &hugetlbfs_file_operations;
        mapping_set_folio_order_range(inode->i_mapping, order, order);
+       mapping_set_authoritative(inode->i_mapping);
 }

 /*

