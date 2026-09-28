Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6434D17BF;
	Mon, 28 Sep 2026 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638801; cv=none; b=BRAeJ3uTCb0EWsSjVp3urwZCQm2rFlWgHAhYpqJ+0Qlerf+i09tJXO/Ut5r/cuk9xOk1gb9DDY7oEsoYEYCpc+7S65jncaZMSZyzYFCmD9tOzvY+8ACTrB+OHlezXgEWK3YdwtNfI/g8mgoPNwCqsvucu00eTTZKLJ2y30R/f4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638801; c=relaxed/simple;
	bh=3Id3YZxHTEU6p1kro3m9VhN/Bchm+cOhsdhBMPdVY30=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sWPQFsPzPhbZFNiczSpgVrkZSKi07PUNA2nbNeTN/d1vZJuE3ipahbbYEHbuKfdac4oXzOqCXl/0ICvIJrI7JgqODjclTAqh+hYv0bDC/jSe/CWMUP/4tuIKhJfd2cf6h2Z+n/cvZgbJXc37XHcsggdQzCu3qjaaTzeldIhY19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YbM3qQSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YbM3qQSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391A51F000FF;
	Mon, 28 Sep 2026 23:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790638798;
	bh=1HFLO5rBdRNtlKvRCci2EuPZ1UPk8TFVkIuVr0KdXBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YbM3qQSOZprYyJJo1LOb+4d+Unzi6Iot229rfqkh1ZIpP15t4Xir0u6Ip6jr0ONa1
	 W32A/o6ob8UZY2av8Rs4ZiZzDO14UDp3WmYDpngemwMM5JwE5Lo9QT8cA9uKHVYhR7
	 gCT5kHe5AejMLxykgr9gbhIZ/9JtumReda/umMW0=
Date: Mon, 28 Sep 2026 16:39:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro
 Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/6] mm: make MAP_PRIVATE-/dev/zero mappings truly
 anonymous
Message-Id: <20260928163957.832a27ee9596a25a282c2707@linux-foundation.org>
In-Reply-To: <20260926-map-private-dev-zero-v3-0-d4781e84ccfc@kernel.org>
References: <20260926-map-private-dev-zero-v3-0-d4781e84ccfc@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 11:41:05 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> Historically anonymous memory was obtained in linux by MAP_PRIVATE-mapping
> /dev/zero.
> 
> The canonical way of doing these now is mmap() specifying MAP_PRIVATE |
> MAP_ANON, but we must continue to support the legacy means of obtaining these
> mappings.
> 
> As-is these mappings are an unusual edge-case - they satisfy
> vma_is_anonymous() but have non-NULL vma->vm_file, and their page offset is
> the offset into the /dev/zero file.
> 
> Commit 93c0c8dc87f6 ("mm/rmap: use anon pgoff to track MAP_PRIVATE
> file-backed anon folios") causes all other anonymous folios to be tracked
> by their anon index (vma->vm_start >> PAGE_SHIFT at the point of first
> fault), leaving MAP_PRIVATE-/dev/zero as the outlier.
> 
> This series remedies the situation by making MAP_PRIVATE-/dev/zero mappings
> truly anonymous with !vma->vm_file and correct anonymous page offset.
> 
> It starts by bringing the memory character driver into mm/ - this file
> implements /dev/zero, /dev/mem among other things and is already (as
> clearly indicated by its name) within the remit of memory management.
> 
> By doing this, the file_is_dev_zero() function can be provided, internal to
> mm, which allows for positive identification of these mappings.
> 
> Using this, first prevent any other mappings from mapping memory
> anonymously, then make these mappings truly anonymous and eliminate all
> code in the kernel that previously had to account for these strange beasts.
> 
> Finally, it adds userland VMA tests to assert the behaviour and selftests
> to assert expected merge behaviour.

Thanks, I've updated mm-unstable to this version.

> v3:
> * Added tags (thanks David! :)
> * Moved the reworked mmap_prepare vm_ops comment to 3/6 where it is introduced
>   and fixed a typo in it, as per David.

Here's how v3 altered mm.git.  Includes a merge fix for the
recently-added hotfix "mm/vma: predicate setting mmap_prepare VMA
fields on new vma alloc", per yourself.

And...  really?  I already had David's tags so we did a full resend for
a single comment typo?  Little -fixes had their role...



 mm/vma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/vma.c~b
+++ a/mm/vma.c
@@ -2816,7 +2816,7 @@ static int call_mmap_prepare(struct mmap
 	if (err)
 		return err;
 
-	/* It's invalid for mmap_preprare hooks to clear vm_ops. */
+	/* It's invalid for mmap_prepare hooks to clear vm_ops. */
 	if (!desc->vm_ops)
 		return -EINVAL;
 
@@ -2932,7 +2932,7 @@ static unsigned long __mmap_region(struc
 		allocated_new = true;
 	}
 
-	if (have_mmap_prepare && allocated_new)
+	if (have_mmap_prepare && !map_is_anon(&map) && allocated_new)
 		set_vma_user_defined_fields(vma, &map);
 
 	__mmap_complete(&map, vma);
_

