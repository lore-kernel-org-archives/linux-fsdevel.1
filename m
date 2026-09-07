Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF421188CC9;
	Mon,  7 Sep 2026 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788802710; cv=none; b=IZx330rvrbjIq3a3bK4jMsDuDDlRYnZiTTDvk1TPFDsMeyPYvivS7N6n+fdM5zFeTw9DqtG2s9V1BCYQfNrWiJlsFCQT7dS+SaVWUw5oE70TkTAjauE/AyDwdb1oAUcPTQNsXTaYp1MzAsyLYQ2iwUWJJv1JqkLQ0hb3LIKDqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788802710; c=relaxed/simple;
	bh=ZKFqm7/Ml5Qvs0OYSfvLzqhkLXSRb6h8ez4YXH7u3gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2u/LJCxf6leUkfy+99kkaCP3ZXvbH+uFLjCzfraP+xid7mg6cyi6Vy6zsCbLWhApn4otxHY/KAEhczL4J4LC0uqHfUSsAZC0soAKt4uUKHkaoIMmo6HCsClftgs8nh0FF6Vo0BI0KsT8EulzG3OTqgfElDRrL5b9MtrwpKzo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzMW3Iuw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzMW3Iuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BE21F00A3A;
	Mon,  7 Sep 2026 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788802708;
	bh=JYtjFp3g5gdPUFznyNGIYCvkhRU+oOhyCAUXnEZTtCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VzMW3IuwBAg0OTqQvmPn74oP0XsjLtq/qrNYYzxcb8nBQieMLuuNv34LCDXblb6dd
	 h/+fzPZzyMdUTiZvrTV8VGZ55uTkC/1tZk9TrYYk3rOSFoDASk6wZWlVmt5cmNApAH
	 JLSj1hCAl7D4YduZxjCE7Epw5GcJu5YyF2NN3i5OXGrp9JirRJ5HoT6KnWSvGX7AYZ
	 aja9CsaKR6GbO/BpEntARV7zMTsVDyD6NbjUsewLkDd7tHNBbEaUko7Onb6f6mxCF2
	 Zh2gq2ncPA/L5Z3K0jmjY+aO+R+7FbIyYg4erGHvbfD4HCGGwEjQHZXd5VaYoWRmZC
	 Kj70uAvm9nifQ==
Date: Mon, 7 Sep 2026 18:38:21 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/6] mm/vma: only permit MAP_PRIVATE /dev/zero to be
 mapped anonymous
Message-ID: <ap71GOPAeKHfHp5J@gremlin>
References: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
 <20260902-map-private-dev-zero-v1-3-a578c730cec7@kernel.org>
 <d6dc52e3-b27d-4663-848c-a2f270fb4c5d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6dc52e3-b27d-4663-848c-a2f270fb4c5d@kernel.org>

On Mon, Sep 07, 2026 at 06:56:51PM +0200, David Hildenbrand (Arm) wrote:
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 35e7a64855fa..4b8d430d9619 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -2621,6 +2621,19 @@ static int __mmap_new_file_vma(struct mmap_state *map,
> >  	return 0;
> >  }
> >
> > +static bool map_is_private(const struct mmap_state *map)
> > +{
> > +	return !vma_flags_test(&map->vma_flags, VMA_SHARED_BIT);
> > +}
> > +
> > +static bool map_is_anon(const struct mmap_state *map)
>
> I was wondering whether we should call this "map_is_private_anon", due to
> MAP_ANON|MAP_SHARED. But looking at __mmap_new_vma(), the existing "is_anon" is
> also limited to MAP_ANON|MAP_PRIVATE.

A 'shared anon' mapping is not anon at all, and that's handled early in
do_mmap().

I wish that we didn't confuse people by allowing MAP_SHARED | MAP_ANON as a
shorthand but there we are.

So I don't like to make that distinction on the basis that a 'shared
anon' mapping isn't something that exists :)

And then imagine vma_is_private_anonymous() vs. vma_is_anonymous() etc. It would
get silly, quick...

>
> > +{
> > +	if (!map_is_private(map))
> > +		return false;
> > +
> > +	return !map->file || file_is_dev_zero(map->file);
> > +}
> > +
> >  /*
> >   * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
> >   * possible.
> > @@ -2634,8 +2647,7 @@ static int __mmap_new_file_vma(struct mmap_state *map,
> >  static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
> >  	struct mmap_action *action)
> >  {
> > -	const bool is_anon = !map->file &&
> > -		!vma_flags_test(&map->vma_flags, VMA_SHARED_BIT);
> > +	const bool is_anon = map_is_anon(map);
> >  	struct vma_iterator *vmi = map->vmi;
> >  	int error = 0;
> >  	struct vm_area_struct *vma;
> > @@ -2651,7 +2663,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
> >
> >  	vma_iter_config(vmi, map->addr, map->end);
> >
> > -	if (is_anon)
> > +	if (is_anon && !map->file)
> >  		vma_set_anonymous(vma);
> >
> >  	vma_set_range(vma, map->addr, map->end, map->pgoff, map->anon_pgoff);
> > @@ -2669,6 +2681,10 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
> >  	else if (!is_anon)
> >  		error = shmem_zero_setup(vma);
> >
> > +	/* Temporary MAP_PRIVATE-/dev/zero workaround. */
> > +	if (is_anon && map->file)
> > +		vma_set_anonymous(vma);
> > +
> >  	if (error)
> >  		goto free_iter_vma;
> >
> > @@ -2777,6 +2793,10 @@ static int call_mmap_prepare(struct mmap_state *map,
> >  	if (err)
> >  		return err;
> >
> > +	/* Hooks cannot mark themselves anonymous. */
>
> I guess this comment will be stale soon (after #4 where you drop the
> set_anonymous part).

Not really, it's there to catch drivers doing something silly/broken (likely by
mistake).

I want to catch that early. I have a 36 patch series that extends this kind of
idea... a lot :)

>
> Should it be
>
> "vm_ops are strictly required with mmap_prepare"
>
> or sth like that?

Well that's confusing though, because desc->vm_ops defaults to &dummy_vma_ops,
and we absolutely do not require drivers to set vm_ops at all.

And as far as the driver is concerned maybe it's NULL? They maybe don't realise
:)

So the idea is to say don't allow them to try to do something they can't do.

>
> > +	if (!desc->vm_ops)
> > +		return -EINVAL;
> > +
> >  	err = call_action_prepare(map, desc);
> >  	if (err)
> >  		return err;
> > @@ -2799,10 +2819,7 @@ static int call_mmap_prepare(struct mmap_state *map,
> >  static void set_vma_user_defined_fields(struct vm_area_struct *vma,
> >  		struct mmap_state *map)
> >  {
> > -	if (map->vm_ops)
> > -		vma->vm_ops = map->vm_ops;
> > -	else	/* Only /dev/zero should do this. */
> > -		vma_set_anonymous(vma);
> > +	vma->vm_ops = map->vm_ops;
> >  	vma->vm_private_data = map->vm_private_data;
> >  }
> >
> > @@ -2882,7 +2899,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
> >  		allocated_new = true;
> >  	}
> >
> > -	if (have_mmap_prepare)
> > +	if (have_mmap_prepare && !map_is_anon(&map))
> >  		set_vma_user_defined_fields(vma, &map);
>
> Ah, we have mmap_zero_prepare() for handling the shmem_zero_setup_desc(). I was
> just about to ask whether we can just get rid of this here.
>
>
> But, hold on, do we now even need that? Could core-mm now take care of that as
> well, and we could just remove mmap_zero_prepare() entirely?
>
> That is, we'd make shmem_zero_setup() in __mmap_new_vma() take care of this?
> Then we might not even need shmem_zero_setup_desc() anymore.
>
> Maybe harder than it sounds at first.

I think I'd rather that be a follow up :) this series is about eliminiating the
one last (I hope?) corner case for anon VMAs.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
