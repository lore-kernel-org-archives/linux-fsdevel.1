Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA18246C825
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623990; cv=none; b=UproLVND8u31C5wDMI6e4VKZYUtMk1YcwbjaLphln8JgDQYiurt9ZB9I0Qu4tzV8KYoReTTrxgkZkdOQJKMM3usj/rpNNvaD09lKy7QH5h2W4MFXLS3p6L2w0JICCKN27usrp4xp4ZpI/boYbzPysaPdEEmQCRZnqUf2bP26xsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623990; c=relaxed/simple;
	bh=fbbCVXxT1ANltLofetS/dVm1nYc8boYcdGvU45amxOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lie5/FbCTEyo8zSHeWknnZ7cz55m2valadHNKpjFtPSosWwh0QbtFC6tdSi4h2da5ILVbqSloTB9xKhrCpd1CM1fSaDkHFg5IJXmJSQULF7CrxtT45ykeLeIkCti/wnVV2za2p35A+1lN7shMSywwaHGSglLSc6KUzAyX3UduOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SFZZDr0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SFZZDr0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146151F000E9;
	Thu, 13 Aug 2026 12:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786623988;
	bh=haUzX1yJaoSCQjBkM+FTLwJWwxXiI4Xbs+U7tNejh7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SFZZDr0msEMWKEXT06FkXlTkAMy42YabPqmsDRBoVSzmObCHAGUYaUYKe7tD8hoFx
	 98r5DNP3Ia4i1NXfWBANfT9LkisYinUWZVDjX2cDCTrAOAZh9bAzYCUX0s8qNhSSDe
	 MV5VqkITGp9Q73rtjNu6XjwjY0a6Vq8uRJfv2GXs=
Date: Thu, 13 Aug 2026 21:19:47 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-mm@kvack.org, geert@linux-m68k.org, daniel@thingy.jp,
	Arnd Bergmann <arnd@arndb.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to
 /dev/zero
Message-ID: <2026081355-remold-sterility-84f9@gregkh>
References: <20260813063401.1786548-1-thehajime@gmail.com>
 <20260813063401.1786548-4-thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813063401.1786548-4-thehajime@gmail.com>

On Thu, Aug 13, 2026 at 03:33:58PM +0900, Hajime Tazaki wrote:
> Upon a private file mapping request to /dev/zero, it calls
> kernel_read() in do_mmap_private(), getting a failure with the message
> like: "kernel reads not supported for file /dev/zero", which is because
> zero_fops defined in drivers/char/mem.c has both .read and .read_iter
> definitions.

Do you actually use a no-mmu system?

> Even fixing this issue, the map request to /dev/zero works fine without
> errors but the allocated vma isn't marked with anonymous because
> mmap_zero_prepare() isn't called under nommu platform, resulting
> vma_desc_set_anonymous() isn't called either.
> 
> This commit fixes those issues by:
> 1) use vfs_iter_read() instead to avoid failure at kernel_read()
> 2) calls .mmap_prepare on private mapping in do_mmap() so that required
>    preparations are done even in private mapping.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Liam R. Howlett" <liam@infradead.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org (open list:PAGE CACHE)
> Fixes: 4d03e3cc5982 ("fs: don't allow kernel reads and writes without iter ops")

Given the age of this issue, I don't think anyone uses no-mmu systems
anymore :(



> Assisted-by: cubic.dev:unspecified
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> ---
>  drivers/char/mem.c |  5 ++-
>  mm/filemap.c       |  6 ++--
>  mm/nommu.c         | 84 ++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 87 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 63253d1de5d7..dba24d0a7b33 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -500,11 +500,10 @@ static ssize_t read_zero(struct file *file, char __user *buf,
>  
>  static int mmap_zero_prepare(struct vm_area_desc *desc)
>  {
> -#ifndef CONFIG_MMU
> -	return -ENOSYS;
> -#endif
> +#ifdef CONFIG_MMU
>  	if (vma_desc_test(desc, VMA_SHARED_BIT))
>  		return shmem_zero_setup_desc(desc);
> +#endif
>  
>  	/*
>  	 * This is a highly unique situation where we mark a MAP_PRIVATE mapping
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d721986d5f46..cf02faad86aa 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4077,7 +4077,7 @@ int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
>  }
>  int generic_file_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	return -ENOSYS;
> +	return 0;
>  }
>  int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> @@ -4085,7 +4085,9 @@ int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
>  }
>  int generic_file_readonly_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	return -ENOSYS;
> +	if (is_shared_maywrite(&desc->vma_flags))
> +		return -EINVAL;
> +	return generic_file_mmap_prepare(desc);
>  }
>  #endif /* CONFIG_MMU */
>  
> diff --git a/mm/nommu.c b/mm/nommu.c
> index e40990e15831..a29a53c1c80a 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -37,6 +37,7 @@
>  
>  #include <linux/uaccess.h>
>  #include <linux/uio.h>
> +#include <linux/major.h>
>  #include <asm/tlb.h>
>  #include <asm/tlbflush.h>
>  #include <asm/mmu_context.h>
> @@ -856,6 +857,22 @@ static int validate_mmap_request(struct file *file,
>  	return 0;
>  }
>  
> +static int is_file_anonymous(struct file *file)
> +{
> +	if (!file)
> +		return 1;
> +
> +	if (file->f_path.dentry && file->f_path.dentry->d_inode) {
> +		struct inode *inode = file->f_path.dentry->d_inode;
> +		/* if the device is /dev/zero */
> +		if (S_ISCHR(inode->i_mode) &&
> +		    imajor(inode) == MEM_MAJOR && iminor(inode) == 5)
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * we've determined that we can make the mapping, now translate what we
>   * now know into VMA flags
> @@ -869,7 +886,11 @@ static vm_flags_t determine_vm_flags(struct file *file,
>  
>  	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
>  
> -	if (!file) {
> +	/* private and file mapping will be marked anonymous later (do_mmap_private()).
> +	 * and /dev/zero is marked by them at .mmap_prepare,
> +	 * which should be _before_ this point.
> +	 */

Wrong coding style for the comment, which is very typical of
LLM-generated stuff.  Always rewrite the output of these tools to
actually be sane.

thanks,

greg k-h
