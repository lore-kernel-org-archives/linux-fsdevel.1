Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36E7423E9E;
	Fri, 25 Sep 2026 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328658; cv=none; b=mzN9/+zmgv32DYDgeJr8Mhlqg8kav642wlACxk7QbrMiP0k6SoxByFh3pSQjyxptGgol1vlDFzrfS2PbVA4ip9SUxvtljc8smk5+0oHooOFJUi3l8nGxO9ALx1Ew7IJ9VBcwBURQjsUaxbkgQvOh2ANoW9FYdMAXOgzu9XvG1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328658; c=relaxed/simple;
	bh=LKh6dn1KjHYb5AhpB8AXcwmqtYM9xU387WK0TklJmjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlS+DDuIOsDERDgry54FY+wmAkzdKhkoMXFftnorub4Esbn7c8a3SC61a5pXgKVovaN6tduzNIkHl39d5cooaLa5HmHHvh4Hp1GGWOUTTL/33UvhEb+HCEAWhGPTzWZHeYyLnPd1ZRzuEcFsNUeajEICJZe4EBLRCdEw+S7aAdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrcRyvDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrcRyvDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795571F000FF;
	Fri, 25 Sep 2026 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790328657;
	bh=2ZPvROUzm2CS6Mg3envH0hZ0KiQZJyc6fxn16uw0Jxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PrcRyvDk4tQWcaU7YEM54W8UvoKbXWTsquEdmtoe+PYIWP1qcTzpTyNSl3z8mlgsQ
	 LnSdpsSp5U1oLFwFTRGHgnsAaa/t4O0DZfc/HpojLpvBH4Ws06rN2p3zjR+lEyU74Y
	 TKj+ZFQZ7G3M9v+D6ciK4niXnj9PpzhQvrBEJUrX4Unu4TU4tWJyC0sxWMrKPxeV7r
	 qQeOts850usAoS0s56E3+ILHWvhC7dLh5y+1WfoyozqGrj9lplRCwt/iy0EIg13t8X
	 Wnz9pnIIQ+MMfCweN9eQgW1+VBOj1ghs7MNXejm1bsj3qlRD1/i3uJVkBLidSwsNhf
	 WJYtkR1Hqu7Hg==
Date: Fri, 25 Sep 2026 10:30:45 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 01/40] mm/vma: fix mmap_prepare file handling, remove
 file_doesnt_need_get
Message-ID: <arY7e_4p27Mic7bH@gremlin>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-1-4583d8a23bca@kernel.org>
 <arVOW_frpIU_JbbP@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arVOW_frpIU_JbbP@gourry-fedora-PF4VCD3F>

On Thu, Sep 24, 2026 at 12:28:39PM -0400, Gregory Price wrote:
> On Thu, Sep 17, 2026 at 05:22:10PM +0100, Lorenzo Stoakes (ARM) wrote:
> > +static void put_map(struct mmap_state *map)
> > +{
> ...
> > +	if (map->vm_file && !map_same_file(map))
> > +		fput(map->vm_file);
> ...
> > diff --git a/mm/vma.h b/mm/vma.h
> > index e97bd2dfa786..f15faa83f3d6 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -394,8 +394,10 @@ static inline void compat_set_vma_from_desc(struct vm_area_struct *vma,
> >
> > +	if (desc->vm_file != vma->vm_file) {
> > +		fput(vma->vm_file);
>
>
> Sashiko pointed out that this could be null if the vma is "anonymized".

Sashiko is wrong :) I wish I could mark responses like that so it didn't
regenerate them on each respin.

(I always run sashiko output received for each series through a frontier
LLM anyway + fix stuff that is real, see the changelog for series for those
things that were valid)

You can't reach this code without a vma->vm_file.

>
> Previously we'd discussed that anonymizing a file folio is more of a
> wart than a feature, and IIRC you intended to remove that (i think?)
> when you removed zero-file mapping "anonymization" so some of this VMA
> stuff could be detangled.

The anonymising as existed before clears vma->vm_ops not vma->vm_file.

The new _actual_ anonymisation for MAP_PRIVATE-/dev/zero clears
vma->vm_file but only on the raw mmap_prepare non-compat path, stacked
MAP_PRIVATE-/dev/zero is not supported as a means of getting anonymous
memory (and would be a really strange thing to do anyway).

(In general stacked file systems only operate on regular files anyway).

>
> If this is an intermediate state, do we still need to manage this NULL
> scenario, and when we drop the anonymization mechanism we add a WARN()
> that says someone is being naughty?

Nope not at all.

No code path can get here with NULL vm_file and it's already the case that
a driver setting the wrong thing NULL could trigger a NULL pointer deref
anyway.

Nothing in-tree does anything like this and out of tree drivers can trigger
stuff if they want but it's not for us to worry about (they already can do
that locally :P) :)

>
> ~Gregory

--
Cheers, Lorenzo
