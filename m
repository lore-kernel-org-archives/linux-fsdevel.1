Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2823F380FC1
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 01:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787623033; cv=none; b=q4PELOAOy91PNR236xV2/Izu+HRqITjUhxPVVWNJULVHsPD2TIAjEahOr5+2CYTdO+224e7L4DDAsQtisP9IV+4wIfdZl+6oaLckS43wIEq9jhhqppfmRRR0VpdcMX0tFXfmmxreR9/4/RldX2Rg/Sd82PRBxs3au0H+W3CFyEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787623033; c=relaxed/simple;
	bh=pZVlzetWbMYh7ME6E4V0pFedUH18QqKoNWMl8POGl5I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJmY7Fz5KomRWMvNMi1EhtqNvVsh3s4lRUQrsA/B3icP7BA3vMrV7CDg9YC18k7xXPEAO6FQSZLIxHPLO43uvuCzH1mnWX2D2A8Jcbjcf5akErd10c15XexykKzNl2f1qKAUiR330hamcUIQjBA0OJdtXsdL1fYwhalg4scCvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HH7c8Tfe; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH7c8Tfe"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso3175653a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 18:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787623031; x=1788227831; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T3Y7JSI1a8tq1uRjkFjsaZKcIVEv3JOwvcnDEKrHIyI=;
        b=HH7c8TfejefM2WmKkLInJ8CKQk4a8KfiCzSxA1VsvqVrD9jABGUUctol2ZL8/LB9Fx
         rnPKfxHW8bLHOV5ou/broZxif4tfLgRXYcLzZ8/m/r74P+B3fgPN4IbEqZhRzw55sumq
         GVeJIAwcJPtPwcKhKmxD9wAS30GnnfQZeHxsc37aHzr1+esEoXIghfmK9acvhrLTbfLi
         o6brHeEmbzDjqAVyduHrwZ4OKqLoplvED8CAsZDSBgBUBO80mg4lkgF/rFwO0SdNvWYV
         /xowp0Md3K2dDIgfMdUWREguJWvPzBKqPISRHxCopMz21TMHv/7IhYJ3E96hJoO7iqfl
         e6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787623031; x=1788227831;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T3Y7JSI1a8tq1uRjkFjsaZKcIVEv3JOwvcnDEKrHIyI=;
        b=f6zdyB6LWBZuu+9BCbMBuWENmHCb1w7ns7lhUbcmyIWO5qYRjFtdhqLGEocOqCi12a
         tCSgWRiCLfSblQDGOYlzT8UAlMfjoiq5bUpHvmgqkcz2goKS4J6QeKZiUfBKFl2GVu2I
         7kjgGMnz+M3iH8+G8P/zRrmvXm4LvaxIeNl+o2MYgvq7ROt4/ZEaaNyz5VugfQItZZLO
         wn9Up8nyx0dlMJ7uktauaCB0PP72uoinA0nJ0HETmTFuuQ5Nnbk1jSNMVrpAwZewkLyG
         SM01M33/W7+C8BHBo3dXTp/igOYKWP7fTbeDwLim8hD+zyfM88V0Mw2akyMXUIYiwQP7
         5ZaQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0QC8aFt+79hN9dT9lhohAaVq3joS/NET/bt1pJzIR40bPtr5TRIzx4VX8NmScjZdnGuFcEhgRErumoItW@vger.kernel.org
X-Gm-Message-State: AFuF++kvtmU157Y+u5l1YljEwyYUrzCtbl/AvAWl14mGSInJLFXDEzwz
	uq8Q5umgzQ91RN8R773o0Le7MdNWHkK0/NhPmiXpfIibCpR2D9eJTGBC
X-Gm-Gg: AR+sD12JJWeMyGCz04vQQYCQ8NVI0bR+s4RdYoJPdZPniuso03syQbl+XRHbywUfmhA
	2vpbyHGHGIcE8V9EBUbD/p+dpz5a3dXdtwhXxqkvb5gKfBelXhg6Pi7rCaJmG1dyQZc48IMjypA
	YxnaYje5jEjOXgyOuw7K2MfFZb+mfAP99FLdBOvp9C9zYyFmELoTIj9nusHfjlQOpN4SnkqYTNg
	rnBG5ubZXQiZy42v1CtaBInX56D5QkJujcCeJ5Mjh/7Gadu28ibo39bB/SPJBT1duC0sWVjyIMQ
	7uZsqfL0fWi+K7sKhApWB6NdrGz7S7DUWVIWqQxxoUMN/TCWvPt3HDFWDhYR8KrXWPdulSsJAMg
	NsXzoFMClVb6dYZghiRvd4EDk8lVyK6B4ARPxI+MB13rhcPuXcRQytS0TVYl6aiCIHLBxfSTh5+
	MFA5TG8DzwVc2TVGvPhNxK0fJWqOgGVQuyTIBRmOC7tlz6dvEcgf+tEnqGUduUg+mxooykxBVKd
	zNiZTxkCzpyR8UteV9B5dkxYt/989XLKUamdJWC9gNkdaEwzXLxN09K980nvilt4PLXPEm/z3rl
	9zgB9A==
X-Received: by 2002:a17:90b:582e:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-3964652c610mr5884454a91.13.1787623031308;
        Mon, 24 Aug 2026 18:57:11 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b64c48sm1675960a91.8.2026.08.24.18.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 18:57:10 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:57:07 +0900
Message-ID: <m2ecfnvu6k.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: ljs@kernel.org
Cc: linux-mm@kvack.org,
	geert@linux-m68k.org,
	daniel@thingy.jp,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to /dev/zero
In-Reply-To: <an8BlTgk7sc5vFJ1@lucifer>
References: <20260813063401.1786548-1-thehajime@gmail.com>
	<20260813063401.1786548-4-thehajime@gmail.com>
	<an8BlTgk7sc5vFJ1@lucifer>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


Hello Lorenzo,

sorry, I didn't answer this comment.

On Fri, 14 Aug 2026 21:37:38 +0900,
Lorenzo Stoakes (ARM) wrote:
> 
> The subject isn't great - before you're not allowed to mmap /dev/zero _at
> all_ on nommu, here you try to allow it.
> 
> I'm kinda against it to be honest, nommu has been functioning... I'll not
> say perfectly fine, given it's broken in many ways that nobody ever
> reports, but I'd say instead 'the same as it was' with no issue.
> 
> And you're not really explaining why you need this.
> 
> You're not correctly supporting MAP_SHARED-/dev/zero AFAICT at all, it'll
> just... actually I don't know what it'll do

okay,
I started this patch when Sashiko reported, so for me it seems this is
a bug.  I wasn't aware of the fact not allowing mmap /dev/zero on
nommu.

> On Thu, Aug 13, 2026 at 03:33:58PM +0900, Hajime Tazaki wrote:
> > Upon a private file mapping request to /dev/zero, it calls
> > kernel_read() in do_mmap_private(), getting a failure with the message
> > like: "kernel reads not supported for file /dev/zero", which is because
> > zero_fops defined in drivers/char/mem.c has both .read and .read_iter
> > definitions.
> 
> Can this be broken out into its own separate fix please.
> 
> It's not about /dev/zero at all but rather being able to MAP_PRIVATE-map
> literally anything with .read and .read_iter.

I understand.

> >
> > Even fixing this issue, the map request to /dev/zero works fine without
> > errors but the allocated vma isn't marked with anonymous because
> > mmap_zero_prepare() isn't called under nommu platform, resulting
> > vma_desc_set_anonymous() isn't called either.
> 
> "Resulting _in_ vma_desc_set_anonymous() _not being_ called either" is clearer.

thanks,

> >
> > This commit fixes those issues by:
> 
> Already 'issues' suggests >1 patch would be a better idea :)

agreed.

> > 1) use vfs_iter_read() instead to avoid failure at kernel_read()
> > 2) calls .mmap_prepare on private mapping in do_mmap() so that required
> >    preparations are done even in private mapping.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "Liam R. Howlett" <liam@infradead.org>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: Vlastimil Babka <vbabka@kernel.org>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Pedro Falcato <pfalcato@suse.de>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-mm@kvack.org (open list:PAGE CACHE)
> > Fixes: 4d03e3cc5982 ("fs: don't allow kernel reads and writes without iter ops")
> 
> Yeah as Greg says, it really suggests nobody is using mainline nommu in any
> serious way given this is from 5.10 and would require avoiding /dev/zero in
> a way that seems kinda unlikely.
> 
> Should be Cc: stable also but not as a combined patch, the mmap_prepare
> bits only came in recently.
> 
> > Assisted-by: cubic.dev:unspecified
> 
> Unspecified? :)
> 
> Really the best approach nowadays is:
> 
> Assisted-by: LLM # it wrote the whole thing
> 
> or:
> 
> Assisted-by: LLM # it merely complimented my dress sense
> 
> Or whatever :)

I tried to follow the way described in
Documentation/process/coding-assistants.rst, which says

```
  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]

Where:

* ``AGENT_NAME`` is the name of the AI tool or framework
* ``MODEL_VERSION`` is the specific model version used
* ``[TOOL1] [TOOL2]`` are optional specialized analysis tools used
  (e.g., coccinelle, sparse, smatch, clang-tidy)
```

but cubic.dev, which I used for the assist, doesn't document about the
model they used.  without MODEL_VERSION, checkpatch.pl reports an
issue.  Thus put a name for the moment.



> > Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> 
> In general this is opening up whole new areas of code to nommu and given
> nobody seems to be testing anything I'm not sure I'm ok with it.
> 
> Since forever /dev/zero's been disabled for mmap in nommu. So I don't
> really see the point in making it work at quite a lot of risk here +
> necessitating doing some more nommu stuff in unrelated areas.
> 
> In any case, it's probably worth waiting for me to do my follow up series
> on /dev/zero next cycle, which will inform how it will look for real
> arches.
> 
> It's worth breaking the read_iter fixup out of it though probably, and the
> mmap_prepare support.

understand, anyway I would wait for your update, and go with another
patches for the fixups.

> > ---
> >  drivers/char/mem.c |  5 ++-
> >  mm/filemap.c       |  6 ++--
> >  mm/nommu.c         | 84 ++++++++++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 87 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> > index 63253d1de5d7..dba24d0a7b33 100644
> > --- a/drivers/char/mem.c
> > +++ b/drivers/char/mem.c
> > @@ -500,11 +500,10 @@ static ssize_t read_zero(struct file *file, char __user *buf,
> >
> >  static int mmap_zero_prepare(struct vm_area_desc *desc)
> >  {
> > -#ifndef CONFIG_MMU
> > -	return -ENOSYS;
> > -#endif
> 
> > +#ifdef CONFIG_MMU
> >  	if (vma_desc_test(desc, VMA_SHARED_BIT))
> >  		return shmem_zero_setup_desc(desc);
> > +#endif
> 
> This is pretty horrible already :(
> 
> You're also letting VMA_SHARED_BIT be a return 0 noop, that
> seems... unwise?
> 
> You can use IS_ENABLED(CONFIG_MMU) to make things vastly less terrible,
> e.g.:
> 
> 	static int mmap_zero_prepare(struct vm_area_desc *desc)
> 	{
> 		if (!vma_desc_is_cow_mapping(desc)) {
> 			if (!IS_ENABLED(CONFIG_MMU))
> 				return -ENOSYS;
> 			return shmem_zero_setup_desc(desc);
> 		}
> 		...
> 	}
> 
> But again, I don't really feel that nommu should be enabling this and I'm
> changing the /dev/zero stuff anyway.

noted.

> >  	/*
> >  	 * This is a highly unique situation where we mark a MAP_PRIVATE mapping
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index d721986d5f46..cf02faad86aa 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -4077,7 +4077,7 @@ int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
> >  }
> >  int generic_file_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > -	return -ENOSYS;
> > +	return 0;
> 
> Err, no, making this a noop breaks it?
> 
> I'm not really hugely fine with you making this be the same as CONFIG_MMU
> either as I am not confident in the change being correctly audited given
> the until-recently total lack of testing of nommu, and now very limited, as
> well intentioned as it might be testing.
> 
> I would prefer anything that currently doesn't function with nommu to
> remain so.

as I mentioned, I would defer this patch if maintainers think this is
intentionally disabled, or it is not the right moment to change the
behavior.

I'm pretty fine as this is a Sashiko-initiated fix, not personally
motivated fix in real use case.

> >  }
> >  int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
> >  {
> > @@ -4085,7 +4085,9 @@ int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
> >  }
> >  int generic_file_readonly_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > -	return -ENOSYS;
> > +	if (is_shared_maywrite(&desc->vma_flags))
> > +		return -EINVAL;
> > +	return generic_file_mmap_prepare(desc);
> 
> Again same objections as above re: doing real-arch stuff in nommu.

noted.

> >  }
> >  #endif /* CONFIG_MMU */
> >
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index e40990e15831..a29a53c1c80a 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -37,6 +37,7 @@
> >
> >  #include <linux/uaccess.h>
> >  #include <linux/uio.h>
> > +#include <linux/major.h>
> >  #include <asm/tlb.h>
> >  #include <asm/tlbflush.h>
> >  #include <asm/mmu_context.h>
> > @@ -856,6 +857,22 @@ static int validate_mmap_request(struct file *file,
> >  	return 0;
> >  }
> >
> > +static int is_file_anonymous(struct file *file)
> > +{
> 
> As stated on the cover, I don't adore this and that's all changing soon
> anyway.

understand.

> 
> > +	if (!file)
> > +		return 1;
> 
> It's 2026 use a bool please.

thanks,

> > +
> > +	if (file->f_path.dentry && file->f_path.dentry->d_inode) {
> > +		struct inode *inode = file->f_path.dentry->d_inode;
> > +		/* if the device is /dev/zero */
> > +		if (S_ISCHR(inode->i_mode) &&
> > +		    imajor(inode) == MEM_MAJOR && iminor(inode) == 5)
> > +			return 1;
> 
> This is horrible really. The /dev/zero stuff I'm doing kinda had to do
> _something_ this this (in a roundabout way) - well I thought so - anyway :)
> 
> But yeah again wait for me to do /dev/zero follow up.

understand,

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * we've determined that we can make the mapping, now translate what we
> >   * now know into VMA flags
> > @@ -869,7 +886,11 @@ static vm_flags_t determine_vm_flags(struct file *file,
> >
> >  	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
> >
> > -	if (!file) {
> > +	/* private and file mapping will be marked anonymous later (do_mmap_private()).
> > +	 * and /dev/zero is marked by them at .mmap_prepare,
> > +	 * which should be _before_ this point.
> > +	 */
> > +	if (is_file_anonymous(file)) {
> 
> You're kinda throwing in a bunch of random stuff in 1 patch you really need
> to break things out more.

okay.

> >  		/*
> >  		 * MAP_ANONYMOUS. MAP_SHARED is mapped to MAP_PRIVATE, because
> >  		 * there is no fork().
> > @@ -923,6 +944,29 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
> >  	return -ENODEV;
> >  }
> >
> > +static ssize_t nommu_read_iter(struct file *file, void *buf,
> > +			       size_t count, loff_t *pos)
> > +{
> > +	struct iov_iter iter;
> > +	ssize_t ret;
> > +	size_t done = 0;
> > +
> > +	while (done < count) {
> > +		struct kvec iov = {
> > +			.iov_base = buf + done,
> > +			.iov_len = min_t(size_t, count - done, MAX_RW_COUNT),
> > +		};
> > +
> > +		iov_iter_kvec(&iter, ITER_DEST, &iov, 1, iov.iov_len);
> > +		ret = vfs_iter_read(file, &iter, pos, 0);
> > +		if (ret <= 0)
> > +			return done ? done : ret;
> > +		done += ret;
> > +	}
> > +
> > +	return done;
> > +}
> > +
> >  /*
> >   * set up a private mapping or an anonymous shared mapping
> >   */
> > @@ -993,7 +1037,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
> >  		fpos = vma->vm_pgoff;
> >  		fpos <<= PAGE_SHIFT;
> >
> > -		ret = kernel_read(vma->vm_file, base, len, &fpos);
> > +		ret = nommu_read_iter(vma->vm_file, base, len, &fpos);
> 
> Hmm so now you just assume there's always a .read_iter and error out if
> there isn't one?
> 
> Seems questionable.

you're right.  I should consider such situations.

> >  		if (ret < 0)
> >  			goto error_free;
> >
> > @@ -1080,6 +1124,28 @@ unsigned long do_mmap(struct file *file,
> >  		vma->vm_file = get_file(file);
> >  	}
> >
> > +	/* call mmap_prepare function if any */
> > +	if (!(flags & MAP_SHARED) && !(capabilities & NOMMU_MAP_DIRECT) &&
> > +	    (vma->vm_file && vma->vm_file->f_op->mmap_prepare)) {
> 
> > +		struct vm_area_desc desc;
> > +
> > +		vma->vm_start = addr;
> > +		vma->vm_end = addr + len;
> > +
> > +		compat_set_desc_from_vma(&desc, vma->vm_file, vma);
> > +		ret = vma->vm_file->f_op->mmap_prepare(&desc);
> > +		/* private ramfs/romfs mappings fails with -ENOSYS so,
> > +		 * fall back to copied mapping.
> > +		 */
> > +		if (ret && ret != -ENOSYS)
> > +			goto error_mmap_prepare;
> > +
> > +		ret = __compat_vma_mmap(&desc, vma);
> > +		if (ret)
> > +			goto error_mmap_prepare;
> > +	}
> 
> Again break out code into separate functions please!
> 
> I invented this compat mmap_prepare stuff to handle stacked file system
> mounts, and I intend to remove it once the mmap_prepare conversion is
> complete.
> 
> But I suppose... maybe stuff could be migrated to nommu.c at that point as
> a local fixup just for it.
> 
> Probably worth breaking this out as a separate patch too then so
> mmap_prepare is properly supported in nommu otherwise stuff will break
> there, eventually (with X year lag possibly inf on reporting of course ;)

understand, I will take this into consideration.

> > +
> > +
> >  	down_write(&nommu_region_sem);
> >
> >  	/* if we want to share, we need to check for regions created by other
> > @@ -1196,7 +1262,7 @@ unsigned long do_mmap(struct file *file,
> >  	add_nommu_region(region);
> >
> >  	/* clear anonymous mappings that don't ask for uninitialized data */
> > -	if (vma_is_anonymous(vma) &&
> > +	if (is_file_anonymous(vma->vm_file) &&
> 
> As above re: this function.

understand,

> >  	    (!IS_ENABLED(CONFIG_MMAP_ALLOW_UNINITIALIZED) ||
> >  	     !(flags & MAP_UNINITIALIZED)))
> >  		memset((void *)region->vm_start, 0,
> > @@ -1247,6 +1313,18 @@ unsigned long do_mmap(struct file *file,
> >  	ret = -EINVAL;
> >  	goto error;
> >
> > +error_mmap_prepare:
> > +	if (region->vm_file)
> > +		fput(region->vm_file);
> > +	kmem_cache_free(vm_region_jar, region);
> > +	if (vma->vm_file)
> > +		fput(vma->vm_file);
> > +	vm_area_free(vma);
> > +
> > +	pr_warn("mmap_prepare failed for %lu byte allocation from process %d\n",
> > +			len, current->pid);
> > +	return ret;
> > +
> >  error_getting_vma:
> >  	kmem_cache_free(vm_region_jar, region);
> >  	pr_warn("Allocation of vma for %lu byte allocation from process %d failed\n",
> > --
> > 2.43.0
> >

anyway, thank you for your time to looking at the patch.

-- Hajime
