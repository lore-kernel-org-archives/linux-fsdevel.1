Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E667406826;
	Mon, 20 Jul 2026 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555162; cv=none; b=kqaGxMbKed23Hc8+fcwccr1Mf6EFfVT3SJ8wD1ontf9qBjy9uOosk+lscuzCpVeAXajL3RO948Zy74ta3JerACgj1ug+2oqrCLjN7Vmm0Pxd1Zz50g13T8vUv0J4s/y4lSq5OSg6HEe4+QHgtZbCX/EcOvZ10jvgilhBU9TjvKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555162; c=relaxed/simple;
	bh=mtsGfv0qZo8eE+b6wV0mg1potj8D90YUibrQdPUxUuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/wVHBKT+vxHZerICmUqEqzgq+Mc/MFeva55ipt8dqAPGmnskCJj0vknE2RVObNc7T12CaJcR/QuHMsidt2sMHpLTSl85mq8Ry8OZaxHTegJTDXUW9FxCLHfk1Mx4zmfHKZKu+A7F3n6uzTJdwN3tElp9Vu+gG2zquiHf0rR7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEZ/VcLn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEZ/VcLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0001F000E9;
	Mon, 20 Jul 2026 13:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784555161;
	bh=mtsGfv0qZo8eE+b6wV0mg1potj8D90YUibrQdPUxUuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FEZ/VcLnT0A7eMkVOjqoltnaWxaLQzMGlXqa68s0cMd8wgtcFQS07Sk+oKGtBEu9t
	 Yszn6sQNStr+J3MBNvAZtgx3U7nA2B1wG/hx6rh6MvbKKxUOwxxoB7voevnsZXvare
	 4ARLE8P4AoB5CuR+V0N1sj8Bnt0U4dGXsY1TT2S3eUOG4/oduebt4tadZkXMhJh8V7
	 eSzKXW8uQ4UZw2T/XpOAfbaTT2SjTXnFTuwPXDksb5g+VURDvdFDGpKk9xwezeJoBx
	 9214spBP3MDSR6Hm597U+mFiV+Lxaw4okAfNWWbAPnf1rHt48qowukrjIipbNeSFyA
	 jkG/wtTGSppwQ==
Date: Mon, 20 Jul 2026 14:45:38 +0100
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
Subject: Re: [PATCH 00/15] mm/rmap: index MAP_PRIVATE file-backed folios by
 virt pgoff
Message-ID: <al4F3fbXFNTiI4xU@lucifer>
References: <20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094@kernel.org>

Dealing with the sashiko feedback ([0]):

Since there's not been review of this yet, I'll send a quick respin with the
valid bits of the below addressed.

Many duplicated variants of:
> vma_start_virt_pgoff() is wrong for zero-initialised VMAs prior to
> their page offset being set up

<incorrect>

Sashiko seems to be using a crystal ball to predict that I won't set this
field at the same time vma->vm_pgoff is set, which is incorrect.

Nor does it quite understand 'this feature is not switched on yet' :)

Also in the sensitive case where asserts might fail due to chicken-and-egg
'assigning to a fresh VMA', I use e.g. __vma_set_range() which doesn't perform
the assert.

Note that vma_set_range(), which is typically how the pgoff field is set, now
also sets virtual page offset.

Many duplicated variants of:
> vma->vm_file is an incorrect check for anon because of 'special' VMAs such as
> VDSO, VVAR etc. not setting this, so don't assert !vma->vm_file and assume
> it's anon.

<incorrect in practice, but dubiously valid>

These are only called in instances where a virtual variant of vma_start_pgoff(),
linear_page_index(), etc. are called, that is places where a 'special' VMA
should not have that called on it.

However for belts + braces will update the asserts to also test
vma_is_anonymous() (the 'special' VMAs have vma->vm_ops set so will be excluded
by this).

Also noticed linear_virt_page_index() was not updated to account for
MAP_PRIVATE-/dev/zero being made into pure anon, so will fix that too.

(will send fixes for this on respin)

> Does this patch miss updating the VMA merge criteria to check anon_pgoff
> contiguity?...

<incorrect>

Another case of sashiko not understanding the meaning of 'this feature
isn't enabled yet'.

I make the relevant change _when I enable the feature_ to avoid bisection
hazards.

>Can this result in a NULL pointer dereference when CONFIG_DEBUG_VM is enabled?

<correct but already addressed>

Yup :) this is valid but already reported by syzbot and already fixed, both
inline with a note to Andrew and also locally to be sent in any respin.

> Are there additional core anonymous folio creation and validation paths
> that also need this update to prevent breaking reverse mapping lookups
> when the underlying behavior changes?

<incorrect>

More of sashiko not understanding the concept of bisection hazards or the
fact the feature is not switched on yet.

> Does this change break NUMA node interleaving for mixed MAP_PRIVATE
> mappings? (9/15)

<incorrect assessment, valid that it's something that changes>

It doesn't 'break' anything, but it does affect it.

Commit 88c91dc58582 ("mempolicy: migration attempt to match interleave
nodes") already makes it clear that this is best effort and may cross VMA
boundaries, so this was already fuzzy in the sense that it's best effort
and designed to endure a varying 'base'.

So CoW'd folios of MAP_PRIVATE-mapped file-backed mappings will simply be
equivalent to the base varying.

It's also very unlikely that anything in the wild relying upon this
interleaving behaviour will be doing significant amounts of MAP_PRIVATE
CoW'ing, as in practice this is largely used for things like ELF image
relocations, etc.

I will update the commit message to mention it.

> Does this code miss asserting virt_pgoff for adjacent VMAs modified during
> the merge? (10/15)

<correct>

Trivial VMA userland test change, fixed up will send on respin.

> Does this code unintentionally overwrite the anonymous state of
> MAP_PRIVATE /dev/zero mappings? (12/15)

<correct>

Yeah it does... I deal with this correctly when I make
MAP_PRIVATE-/dev/zero mappings pure anon, but this is a bisection hazard,
so have fixed this for respin by gating on !map_is_anon() when calling
set_vma_user_defined_fields().

> Does this missing device type check in map_is_dev_zero() allow block devices
> sharing the same major/minor numbers to falsely match and lose their mapping
> data here?

<correct>

Yes :)) I added an `S_ISCHR(inode->i_mode)` check locally. I was not aware
that char and block devices have entirely separately major/minor
namespaces...

Cheers, Lorenzo

[0]:https://sashiko.dev/#/patchset/20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094%40kernel.org
