Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D173ED5BE;
	Fri, 17 Jul 2026 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285089; cv=none; b=dUfriD5TbVJO4p79Ck/3C8QbYrGh5/wTA5RomsjgwLFKXpfL7tW+NFcGZTkoPORhjznZQZprznANnOkOIVfCn9zl3f+3laOYWJ6U04hTFUy4jKQd0C4KodTNFSLuSAakJwzmI/SizqQJ5cuGqyeQjQprcclfKb3hJylLNvsQjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285089; c=relaxed/simple;
	bh=Wdzqp5wa3soePfX6fWzgi1ZvNkeGG8MyljZ1scsB0yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ramsb+S3Z6ABev78Ib1DEPxeEN7fUk+Iw8KnWN0aznl85VTjyyZxegqS1YtrPsmD0sxzCjnDvFNL+xZSnZz4j5NVCKTDxqd9drrwGiYn30c0RbuwsVsexX6mY6QNH69E4BeQ4qHeR/BZh9vkk+948/hG8dqjscz/LpimToMhr/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY69zUrc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY69zUrc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78931F00A3A;
	Fri, 17 Jul 2026 10:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784285087;
	bh=eHs+//3nOXllOD1t7Xg5VKCQ6tfAQohJOscKS56YnWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RY69zUrc27gRY/2/3P7rQ1om4I6DEDwHEzDPpKOEkJMk/iR9h/bW7q8szbBDNa6qf
	 a4WGov540xLp9aYsnhZxLzuFFzpheD93NjMxMBIlurg29bzWmc+lyEYNx3anLg5s6a
	 SEcGb2Zl8u8j/TB+O96rsO4YAwXU7uceO83Z/zmV+FqkCt1ggmvg42GH1OJf0T9Z1s
	 MjgIJqEj+StYxDQdBfWPxO/nvbxvpFgmkKbte89Jz/HKOIfhHYpOfJEWLyVMIFlJgh
	 FdEoQ41Bk+FQTfeNGcyk52bnFAy5wPtd8+aZm9NwGpS7xhbf7kMeMYRoyEfxkBs12p
	 qyzSQkYDw28RQ==
Date: Fri, 17 Jul 2026 11:44:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/mseal: remove superfluous comments, fix confusion
 around mm
Message-ID: <aloF9UUOZdSLjByI@lucifer>
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
 <20260716-mseal-fixups-v1-1-3a9609bf041b@kernel.org>
 <2a109ef0-76b6-4e25-878f-b779ce09a1ed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a109ef0-76b6-4e25-878f-b779ce09a1ed@kernel.org>

On Fri, Jul 17, 2026 at 11:33:13AM +0100, David Hildenbrand (Arm) wrote:
> On 7/16/26 15:43, Lorenzo Stoakes (ARM) wrote:
> > Remove comment blocks that don't add value and eliminate any confusion
> > about whether or not we permit mseal()'ing of remote mm's by explicitly
> > referencing current->mm consistently.
> >
> > Also avoid ugly goto by using an else branch.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  mm/mseal.c | 48 ++++++++----------------------------------------
> >  1 file changed, 8 insertions(+), 40 deletions(-)
> >
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index 9781647483d1..207fea89c61e 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -16,28 +16,7 @@
> >  #include <linux/sched.h>
> >  #include "internal.h"
> >
> > -/*
> > - * mseal() disallows an input range which contain unmapped ranges (VMA holes).
> > - *
> > - * It disallows unmapped regions from start to end whether they exist at the
> > - * start, in the middle, or at the end of the range, or any combination thereof.
> > - *
> > - * This is because after sealing a range, there's nothing to stop memory mapping
> > - * of ranges in the remaining gaps later, meaning that the user might then
> > - * wrongly consider the entirety of the mseal()'d range to be sealed when it
> > - * in fact isn't.
> > - */
> > -
> > -/*
> > - * Does the [start, end) range contain any unmapped memory?
> > - *
> > - * We ensure that:
> > - * - start is part of a valid VMA.
> > - * - end is part of a valid VMA.
> > - * - no gap (unallocated memory) exists between start and end.
> > - */
> > -static bool range_contains_unmapped(struct mm_struct *mm,
> > -		unsigned long start, unsigned long end)
> > +static bool range_contains_unmapped(unsigned long start, unsigned long end)
> >  {
> >  	struct vm_area_struct *vma;
> >  	unsigned long prev_end = start;
> > @@ -53,11 +32,10 @@ static bool range_contains_unmapped(struct mm_struct *mm,
> >  	return prev_end < end;
> >  }
> >
> > -static int mseal_apply(struct mm_struct *mm,
> > -		unsigned long start, unsigned long end)
> > +static int mseal_apply(unsigned long start, unsigned long end)
> >  {
> >  	struct vm_area_struct *vma, *prev;
>
> I guess using
>
> struct mm_struct *mm = current->mm;
>
> would reduce the churn?

Ah yeah true, I avoided that pattern in general because of confusion that
arose from it before. Maybe over conservative :) can change on respin.

>
>
> Anyhow
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
