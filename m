Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522C63BED17;
	Mon, 13 Apr 2026 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079010; cv=none; b=SWMj3SclVv+4G/iEfryTvxuQGu9qqX+unSyB4ogLtjpfdLYb9uD88ZsYD3a6umGXtWLBtzdmz1DgDSc9EsVz02e9rXHT+0XJIw5gbyJFMoyOtitmcH9rc0uT7C014tzWt4df/J9T6/SO8RGUGBEAaKQy9K5EgHv9d3YwYH7J7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079010; c=relaxed/simple;
	bh=ju44g2f6nitaqzcqt3MrF4XfBN5G0lGaHkRMYsfWfiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJ0taCuZubBY2XwwhtkgkxpRs6aPdaw+EHAcn6w0DlvO9RCrcPhHJtVcR3SCBx7hxQdbhDnDXMOmK6Czi3tjtcvM06BWPf0oPiENhCOn+cMAjMizbFpW/4050H7aCqbs7c3ggOur59yKWQ1ko5w4lR61jvJ9Pr4npZFi7LEI7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzKtNdJD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzKtNdJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78796C116C6;
	Mon, 13 Apr 2026 11:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776079010;
	bh=ju44g2f6nitaqzcqt3MrF4XfBN5G0lGaHkRMYsfWfiY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZzKtNdJDBre26quVvPblkzY5izZDtEfqSiY46VIL1ePjpEBoozWvxlbyj09smAWdN
	 /COz2RDPaoVdUhZdIbTGIZTNWtaOOg638KVKySwc0MocYQ0wNA7WjtUDpoYtai8QZp
	 ut7BH3GoaZ9u+Ztv2gntRvMxhdE40OTND0hpmcaIf87IwbEhO+QFaSu1I3DXtS1iLg
	 vv6SIyCcLFyspET1gpvg5GM08CNpBnm+Zm9MxVx2Yhrahm5M+CldogHZs/prBl9LZi
	 C4MkCRzU9PU4DVJno7GJlo8l8gmKca9d/vV1VrLK8X0OP+YB5PFW0+UbFwB8yqiPOA
	 dH2iCvRIQzPEA==
Message-ID: <f33b1c76-52fd-416a-882f-316dfed69017@kernel.org>
Date: Mon, 13 Apr 2026 13:16:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-hotfixes] mm/vma: remove __vma_check_mmap_hook()
Content-Language: en-US
To: Lorenzo Stoakes <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20260413105713.92625-1-ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260413105713.92625-1-ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/13/26 12:57, Lorenzo Stoakes wrote:
> Commit c50ca15dd496 ("mm: add vm_ops->mapped hook") introduced
> __vma_check_mmap_hook() in order to assert that a driver doesn't
> incorrectly implement both an f_op->mmap() and a vm_ops->mapped hook, the
> latter of which would not ultimately get invoked.
> 
> However, this did not correctly account for stacked drivers (or drivers
> that otherwise use the compatibility layer) which might recursively call
> an mmap_prepare hook via the compatibility layer.
> 
> Thus the nested mmap_prepare() invocation might result in a VMA which has
> vm_ops->mapped set with an overlaying mmap() hook, causing the
> __vma_check_mmap_hook() to fail in vfs_mmap(), wrongly failing the
> operation.
> 
> This patch resolves this by simply removing the check, as we can't be
> certain that an mmap() hook doesn't at some point invoke the compatibility
> layer, and it's not worth trying to track it.
> 
> Fixes: c50ca15dd496 ("mm: add vm_ops->mapped hook")
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/all/adx2ws5z0NMIe5Yj@shinmob/
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
> 
> Andrew -
> 
> c50ca15dd496 is in mm-stable, so thought best to do as fix-patch? Will
> leave a small bisection hazard (unfortunately) so putting this as close as
> possible to the patch it fixes would be ideal.
> 
> Thanks!
> 
>  include/linux/fs.h |  9 +--------
>  mm/util.c          | 10 ----------
>  2 files changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 0bdccfa70b44..f3ca9b841892 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2062,20 +2062,13 @@ void compat_set_desc_from_vma(struct vm_area_desc *desc, const struct file *file
>  			      const struct vm_area_struct *vma);
>  int __compat_vma_mmap(struct vm_area_desc *desc, struct vm_area_struct *vma);
>  int compat_vma_mmap(struct file *file, struct vm_area_struct *vma);
> -int __vma_check_mmap_hook(struct vm_area_struct *vma);
> 
>  static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	int err;
> -
>  	if (file->f_op->mmap_prepare)
>  		return compat_vma_mmap(file, vma);
> 
> -	err = file->f_op->mmap(file, vma);
> -	if (err)
> -		return err;
> -
> -	return __vma_check_mmap_hook(vma);
> +	return file->f_op->mmap(file, vma);
>  }
> 
>  static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
> diff --git a/mm/util.c b/mm/util.c
> index f063fd4de1e8..232c3930a662 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1281,16 +1281,6 @@ int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
>  }
>  EXPORT_SYMBOL(compat_vma_mmap);
> 
> -int __vma_check_mmap_hook(struct vm_area_struct *vma)
> -{
> -	/* vm_ops->mapped is not valid if mmap() is specified. */
> -	if (vma->vm_ops && WARN_ON_ONCE(vma->vm_ops->mapped))
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(__vma_check_mmap_hook);
> -
>  static void set_ps_flags(struct page_snapshot *ps, const struct folio *folio,
>  			 const struct page *page)
>  {
> --
> 2.53.0

