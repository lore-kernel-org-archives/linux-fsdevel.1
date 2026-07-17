Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04AD3CBE79;
	Fri, 17 Jul 2026 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286446; cv=none; b=q3IKrMTvYGh6h9+Aycd3RapFJkCNzKjXZJZZl40lhMO9G2UZ+AAP2n2LK2ixrBpNYznTiAZhrqhpHLRn70+SwImhTRXdJnJVkT2zBBycfJ4sevfK+HSqEqZlVTnWsB+JxxaILOVEFuK/x3kYre8+1WmQspDycUWBmofqRUZnSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286446; c=relaxed/simple;
	bh=4kBO8qX+9n4HtoX8f7rzuw8LYcyzRA912E90vgxtXFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvOeVL1+vxBDBw2fjH6ihvS6Gkr2rnkYM5FscvoRr4LOmZMej+5rztWfrJDhR6xNQzuM5UgB9Vbp6vd3kTxa+DigDWXQTBDxMeYQsScOvIZyrNnHSnorkMpIwxxzprKTtZxHuhXSvCGU/nut9fCde7v4hP+jFwWioIy431UtISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dofqD/NC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dofqD/NC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127941F000E9;
	Fri, 17 Jul 2026 11:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784286431;
	bh=Qrt7GBm/iJQ0xT9tqvtXBOMrwF7xCOTKxp85twwhy4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dofqD/NCUtNXFT9e8cRUAwguEXHfd4naRLtJsBEqKHztpkIsDx6WdpAw2MAVdD5uI
	 AcGqpJE2MSWyL/nGIL3P7ZfaiAs5OVbzN1Uqfl4wg+BUNzSbxkP42GeDU57JZcmsfM
	 mZpPXlODsl0UyzEUJZzWB54Ennfw0y+vGO65uDkTeblfAvTVDelxnwEwSmk9lebpSz
	 9JcTyxOw6hTZwcy8p6SqIl4MBjYRxNWt9EAxtNxoBgM0I90+BLTOIil+rME3GzFUmh
	 00nkZf1BusqqTzJrGRGYb9SB9CwMG1L8LdLDhBoNzD8Mqk35OnU/6DuK5JwtItfzGg
	 AoMS0YgO6HCnw==
Date: Fri, 17 Jul 2026 12:06:55 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH 3/3] mm/mseal: remove further superfluous comments,
 do_mseal()
Message-ID: <aloK6qs03fPpI5Qa@lucifer>
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
 <20260716-mseal-fixups-v1-3-3a9609bf041b@kernel.org>
 <20260716173355.41a98b4e5d5a06772fd7fc12@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716173355.41a98b4e5d5a06772fd7fc12@linux-foundation.org>

On Thu, Jul 16, 2026 at 05:33:55PM -0700, Andrew Morton wrote:
> On Thu, 16 Jul 2026 14:43:11 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
>
> > There's no need to abstract do_mseal() any longer so put the system call
> > implementation in the system call declaration.
> >
> > The comment around do_mseal() is strangely formatted, overly long and adds
> > a lot of superfluous information that the code already provides, so boil it
> > down to the essentials.
> >
>
> This patch
> (https://lore.kernel.org/20260716-mseal-fixups-v1-3-3a9609bf041b@kernel.org)
> overlaps muchly with Leon's "mm/mseal: fix mseal documentation for
> 32-bit kernels"
> (https://lore.kernel.org/20260715131258.55499-1-leon.hwang@linux.dev).
>
> I'll remove the mseal.c changes from Leon's patch and I'll retain the
> rest of that patch, after adjusting its changelog.  Please check all of
> this!

Thanks! And sorry Leon - we definitely don't need the majority of the
comments in mseal.c - so this change essentially makes those changes of
yours unnecessary here.

>
>
> Here's what's left of Leon's patch:
>
> From: Leon Hwang <leon.hwang@linux.dev>
> Subject: mm/mseal: fix mseal documentation for 32-bit kernels
> Date: Wed, 15 Jul 2026 21:12:58 +0800
>
> mseal.o is built only for 64-bit kernels, so 32-bit kernels fall back to
> sys_ni_syscall() and return -ENOSYS rather than -EPERM.
>
> Drop architecture description in mseal.rst, since the arch feature doc has
> the latest state of mseal for each architecture.
>
> Fix the CONFIG_MSEAL_SYSTEM_MAPPINGS typo in init/Kconfig.
>
> Link: https://lore.kernel.org/20260715131258.55499-1-leon.hwang@linux.dev
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> Acked-by: Lance Yang <lance.yang@linux.dev>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Anand Moon <linux.amoon@gmail.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Leon Hwang <leon.hwang@linux.dev>
> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  Documentation/userspace-api/mseal.rst |   14 ++++++--------
>  init/Kconfig                          |    2 +-
>  2 files changed, 7 insertions(+), 9 deletions(-)
>
> --- a/Documentation/userspace-api/mseal.rst~mm-mseal-fix-mseal-documentation-for-32-bit-kernels
> +++ a/Documentation/userspace-api/mseal.rst
> @@ -50,8 +50,8 @@ mseal syscall signature
>           * The start address (``addr``) is not allocated.
>           * The end address (``addr`` + ``len``) is not allocated.
>           * A gap (unallocated memory) between start and end address.
> -      - **-EPERM**:
> -         * sealing is supported only on 64-bit CPUs, 32-bit is not supported.
> +      - **-ENOSYS**:
> +         * The kernel does not implement ``mseal()``.
>
>     **Note about error return**:
>        - For above error cases, users can expect the given memory range is
> @@ -62,7 +62,8 @@ mseal syscall signature
>          memory range could happen. However, those cases should be rare.
>
>     **Architecture support**:
> -      mseal only works on 64-bit CPUs, not 32-bit CPUs.
> +      mseal is built only for 64-bit kernels. 32-bit kernels return
> +      ``-ENOSYS``.
>
>     **Idempotent**:
>        users can call mseal multiple times. mseal on an already sealed memory
> @@ -131,11 +132,11 @@ Use cases
>  - Chrome browser: protect some security sensitive data structures.
>
>  - System mappings:
> -  The system mappings are created by the kernel and includes vdso, vvar,
> +  The system mappings are created by the kernel and include vdso, vvar,
>    vvar_vclock, vectors (arm compat-mode), sigpage (arm compat-mode), uprobes.
>
>    Those system mappings are readonly only or execute only, memory sealing can
> -  protect them from ever changing to writable or unmmap/remapped as different
> +  protect them from ever changing to writable or unmapped/remapped as different
>    attributes. This is useful to mitigate memory corruption issues where a
>    corrupted pointer is passed to a memory management system.
>
> @@ -143,9 +144,6 @@ Use cases
>    the CONFIG_MSEAL_SYSTEM_MAPPINGS seals all system mappings of this
>    architecture.
>
> -  The following architectures currently support this feature: x86-64, arm64,
> -  loongarch and s390.
> -
>    WARNING: This feature breaks programs which rely on relocating
>    or unmapping system mappings. Known broken software at the time
>    of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
> --- a/init/Kconfig~mm-mseal-fix-mseal-documentation-for-32-bit-kernels
> +++ a/init/Kconfig
> @@ -2120,7 +2120,7 @@ config ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPIN
>  	  from a kernel perspective.
>
>  	  After the architecture enables this, a distribution can set
> -	  CONFIG_MSEAL_SYSTEM_MAPPING to manage access to the feature.
> +	  CONFIG_MSEAL_SYSTEM_MAPPINGS to manage access to the feature.
>
>  	  For complete descriptions of memory sealing, please see
>  	  Documentation/userspace-api/mseal.rst
> _
>

LGTM!

Cheers, Lorenzo
