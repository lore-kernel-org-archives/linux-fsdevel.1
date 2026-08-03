Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F216E64AA4;
	Mon,  3 Aug 2026 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785801322; cv=none; b=ECKfxYx4RXsum2dPCL9uGBTaHjQNsrZ6AM5O5wYJZo8bMH2a883pEcjDgyv1gCXorUU696MefihRp3AXleeYKA5duUH/LEdqcAN9l45gcLHWltGgv7XGjh2MZg76lIo3jgLpZzhK0YQsySXJVUry2Nqadu3r5u3NiolTWXJTy2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785801322; c=relaxed/simple;
	bh=dWHgX6/LNshsXdY0gfcQLUIkK6De6AUM9ZeE8zjIEso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaHbDVjlPNdZMWUrNSD4hRkm3VHp+Txwn6wGBEoQSCem7T/gzIE3jsTbaI/D/GkAip9U8pBaNMv3FNKVE22ojOxYmViTnEvsnvPhfhC3GGvdzWAA8J1CWcqZ8a+MwWR9BwksmjuAMR0uNNtD/YssA5tX/oTHkAJti/xA8mHa6fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtGEZUNf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtGEZUNf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A071F000E9;
	Mon,  3 Aug 2026 23:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785801320;
	bh=QvcmvXr4acqUWBRh7hziDDp8JEZdMtVWzfIqcampLcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RtGEZUNfVk1jOgNOJwApSJ93O6cVC45ktiN2j42C43XLae4gT7K0HxtErE329zu6Y
	 4q1mEBzTDnzUbmn1OURLkSbBTmQJewI+Y6tf5wHTwUYU05Z3Meug4Fm+oc4/qqZqXE
	 xSaSxhssLrPHFanyR2w62mPUk2uHFQDsY+APGSl/m/zgFlQfzvQqSXOELjBmVyK5Z2
	 ZH2j1I/wSxiSXllvvgkwdz24/JoVF76jb877bCjAEig9Bko1o5oI3KFWoKE4hg+/Cl
	 /ZTzrxndYjiGyPujGg8KW0p1CK5WBj4Vxu8QsyZXgGXwSUpyd7LTOBAIHjESgRcrXJ
	 skL+Bc38weOCA==
Date: Tue, 4 Aug 2026 07:55:09 +0800
From: Gao Xiang <xiang@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Jan Kara <jack@suse.cz>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <hongbohbli@tencent.com>,
	Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 07/14] fs/erofs: mm/pagemap: add
 readahead_folio_reverse() to avoid folio->private
Message-ID: <anEqXXa69OpwJ7ej@XiangdeMacBook-Pro.local>
Mail-Followup-To: Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Jan Kara <jack@suse.cz>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <hongbohbli@tencent.com>,
	Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org
References: <20260731-remove-pg_private-v1-0-142c97ba3562@nvidia.com>
 <20260731-remove-pg_private-v1-7-142c97ba3562@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731-remove-pg_private-v1-7-142c97ba3562@nvidia.com>

On Fri, Jul 31, 2026 at 10:13:30PM -0400, Zi Yan wrote:
> erofs needs to traverse readahead folios in reverse order to achieve
> maximum performance by
> 1. reading all folios from readahead_folio();
> 2. storing the prior folio pointer in folio->private;
> 3. traverse from the last folio to the first one.
> 
> Add readahead_folio_reverse() to achieve the same function without using
> folio->private.
> 
> It prepares for a future commit that replaces PG_private checks with
> !folio->private checks. After switching the checks, erofs's use of
> folio->private without bumping folio refcount can cause unexpected
> outcomes, e.g., in filemap_release_folio(), try_to_free_buffers() becomes
> reachable.
> 
> No funtional change intended.
> 
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Codex:gpt-5
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> To: Gao Xiang <xiang@kernel.org>
> To: Chao Yu <chao@kernel.org>
> To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> To: Jan Kara <jack@suse.cz>
> Cc: Yue Hu <zbestahu@gmail.com>
> Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
> Cc: Sandeep Dhavale <dhavale@google.com>
> Cc: Hongbo Li <hongbohbli@tencent.com>
> Cc: Chunhai Guo <guochunhai@vivo.com>
> Cc: linux-erofs@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  fs/erofs/zdata.c        | 11 ++---------
>  include/linux/pagemap.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 74520e9102596..b59f2745a8e72 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1902,21 +1902,14 @@ static void z_erofs_readahead(struct readahead_control *rac)
>  	struct inode *realinode = erofs_real_inode(sharedinode, &need_iput);
>  	Z_EROFS_DEFINE_FRONTEND(f, realinode, sharedinode, readahead_pos(rac));
>  	unsigned int nrpages = readahead_count(rac);
> -	struct folio *head = NULL, *folio;
> +	struct folio *folio;
>  	int err;
>  
>  	trace_erofs_readahead(realinode, readahead_index(rac), nrpages, false);
>  	z_erofs_pcluster_readmore(&f, rac, true);
> -	while ((folio = readahead_folio(rac))) {
> -		folio->private = head;
> -		head = folio;
> -	}
>  
>  	/* traverse in reverse order for best metadata I/O performance */
> -	while (head) {
> -		folio = head;
> -		head = folio_get_private(folio);
> -
> +	while ((folio = readahead_folio_reverse(rac))) {

Yes, it's needed due to EROFS compression metadata design and on-demand
partial decompression, the last extent in the readahead request can be
parsed as a partial extent (means from the starting logical offset of
extents to the necessary offset.).   Since there may be many extents
in a single readahead request, so it needs to iterate backwards here;
but the actual compressed data I/Os will be issued forwards.

Previously I tend to avoid touching core-mm so it uses folio->private
but if MM folks can provide a new helper, that would be very helpful
(one more words: all folios are locked in the forward order previously,
so it won't have any deadlock risk).

Thanks,
Gao Xiang
