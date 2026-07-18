Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F89846F;
	Sat, 18 Jul 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386286; cv=none; b=JoMp37aKKIam1l/iqoxMZfjfAS6IuUCs/+Qn3AGbu2mcOq+JqBBrvxP5k8SqlxE/JLgd2u1HSKElUzBFkYF1T1++nV7ThZqDGKQdO9OXrW/i2XfdgYrDk7BFOhvwjxu5kCMB3QemEbNde9jQPeSqPtTvITwn2HBpb+wxBJP7IVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386286; c=relaxed/simple;
	bh=QVTyAHdyQbOjaIzcZFuM8h+GebtHrm41hCcQoy2O7EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kczJcVjnrp/F66ZYwe3hBl50Cj3ugqByH0EzEPBC5GQ7Uwc5mSZZnKxibrhByFnB9Ws2qw76zoguyn5d+yEJ3l2L0G92lb/lo2qVS7rRJLkByIvhp2wSjD2GeXxUFfpOwm0JFo1xB07MSNvvLaYOhRJi8lvWp9rNgm7mIZbFqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWBF0EqB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWBF0EqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730901F000E9;
	Sat, 18 Jul 2026 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784386285;
	bh=RRQXKgZvVOLKJU51yTAps58jYtNd2L+HPiejoWLGke8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nWBF0EqBfhjHJvpdqs+h1dzr94c9R4BdvZwbvKLWoOESTja4JB8XXnNcOenPFuVrD
	 w7k7v7C0XoPBQ9ot5oa3yL77Ju8nMOEldt3fYz6cgfVAB+G39pdKaF88Ki3lc/9V6T
	 gL7bTRbDAm4Q7ch74uTOKPfnOaygB2dp5AQzutVMra7CSwPlrBvudf3cQy8AZUoEOU
	 Ao6sj4DJz/LIPxR9eCGY1xzCh0Zxlz3ViOs7LF7onoabL8Cnftip5KbkplrpgSd4Ud
	 DEZoMWo46oXL0e+rwwhLC4vLVh7414ZS3dRMbSlALPDPJ4RKbFbprP7iy6qqaZejt2
	 ovzYl7a1tfFgA==
Date: Sat, 18 Jul 2026 15:51:02 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 07/15] mm/rmap: track whether the page VMA mapped walk is
 anonymous
Message-ID: <aluQgZAL_fOL7hik@lucifer>
References: <20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094@kernel.org>
 <20260717-b4-scalable-cow-virt-pgoff-v1-7-cf24910ef094@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717-b4-scalable-cow-virt-pgoff-v1-7-cf24910ef094@kernel.org>

On Fri, Jul 17, 2026 at 07:19:45PM +0100, Lorenzo Stoakes (ARM) wrote:
<snip>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 5798427d007f..cfd4195ff1ae 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1240,8 +1240,10 @@ static bool mapping_wrprotect_range_one(struct folio *folio,
>  		.vma		= vma,
>  		.address	= address,
>  		.flags		= PVMW_SYNC,
> +		.is_anon_walk   = false,
>  	};
>
> +	VM_WARN_ON_ONCE(folio_test_anon(folio));

Andrew - can you drop this line please? It's incorrect (folio is always NULL here).

Thanks!

Cheers, Lorenzo
