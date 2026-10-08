Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E3D4E533F;
	Thu,  8 Oct 2026 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473489; cv=none; b=rxphPjPrCnrV3t+ZtTjCoO/dDoLC3uNTpGm3ArG/a23htuMAYY8t+me/zkPYjMAvdjyYfvzvCtGYHF9a6bQ+qo5zbbeoXlDWx5ue+Qw5X+8GMl4q2DtvxZlDg+pCyRFHj/PzErq0Soy+vyKrFm1zdoXB6gieTmqpBU81k02v2TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473489; c=relaxed/simple;
	bh=z5JyqdjBAFKr3gmdYDGazOEacf+lSxusgwLqGM0Levw=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lU1jDHgKWoB0KhyWpPKyh9aLaFETsB3szeJ05b0ueeVhHi/JBaLBE70nbU2aISseltmQgIgG5a14HfmSvUg/3J1oSop8C1rGs6tcGdStxDBlMmj5PRxXRcQGs7dROeCCh92PuK6NdWMgC6xbu/mW+PLAj4hrlW2BXhmvnsOgyIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=notCj0oY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="notCj0oY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C501F000FF;
	Thu,  8 Oct 2026 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791473488;
	bh=1C8aurPJzK/wJUnjdRt/POJZVmCHvh4rqZatlItZkIw=;
	h=Date:From:To:Subject:In-Reply-To:References;
	b=notCj0oYOmJTZdKJ1nQwQDZzte5321kXLZnZgmSnB8CCKK4MLhVBq3f7b7fo4KfWl
	 e0pzoOLjGssbkrTRqAfMg032MTqcuGRkIjxMcF8DRaD4Lnl7lesVWIicUdcRQrpIlx
	 XEEpb3ejC4rgB8SYVtXxji8IGLxk/RcbLZK8bhQM=
Date: Thu, 8 Oct 2026 08:31:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jan Kara <jack@suse.cz>, Ayush Ranjan <ayushr@modal.com>, Pedro Falcato
 <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, Matthew Wilcox
 <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, David
 Hildenbrand <david@kernel.org>, Gregory Price <gourry@gourry.net>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts
 page cache / rss counters
Message-Id: <20261008083127.0305bac995e8b84c67e46bbb@linux-foundation.org>
In-Reply-To: <20261008082304.bc6f4bd6c80fe6432abd4fc5@linux-foundation.org>
References: <20260924061708.1645968-1-ayushr@modal.com>
	<arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net>
	<20260925053027.1998394-1-ayushr@modal.com>
	<20260925065013.3682431-1-ayushr@modal.com>
	<20261003033107.1488699-1-ayushr@modal.com>
	<20261004222831.bdd648a2b406f02747dd9e40@linux-foundation.org>
	<fyswoh7wpxzlbnjjanggjd2jz6yispmeirhwjl3wzi57nacddb@bjkb6kxyfcal>
	<20261008082304.bc6f4bd6c80fe6432abd4fc5@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Oct 2026 08:23:04 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> A useful next step would be to instrument truncate_cleanup_folio(), e.g. warn
> immediately after unmap_mapping_folio() if folio_mapped() is still true.
> That should distinguish "unmap failed to remove an existing mapping" from
> "some path installed a new mapping afterwards", and narrow this down
> considerably.

does this seem useful?  If so I can add it to mm-new/linux-next for a
while.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm/truncate: catch shmem folios still mapped after unmap
Date: Thu Oct  8 08:29:04 AM PDT 2026

Instrument truncate_cleanup_folio() to determine where the shmem "still
mapped when deleted" state is introduced.

truncate_inode_folio() calls truncate_cleanup_folio() under the folio
lock, and truncate_cleanup_folio() calls unmap_mapping_folio() before
filemap_remove_folio().  If a shmem folio is still mapped immediately
after that unmap, then the unmap itself failed to remove all mappings (or
a path outside the folio-lock serialization installed one concurrently).

If this warning does not fire but the later "still mapped when deleted"
warning still does, the mapping must have appeared after this point.  That
distinguishes the two cases without otherwise changing truncate behavior.

Limit the diagnostic to shmem and dump the folio on the first occurrence.

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/truncate.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/mm/truncate.c~shmem-truncate-unmap-debug
+++ a/mm/truncate.c
@@ -156,6 +156,16 @@ static void truncate_cleanup_folio(struc
 	if (folio_mapped(folio))
 		unmap_mapping_folio(folio);
 
+	/*
+	 * Pin down where the shmem "still mapped when deleted" state appears:
+	 * if the folio is clear here but mapped at removal, something installed
+	 * a mapping after cleanup rather than surviving unmap_mapping_folio().
+	 */
+	if (shmem_mapping(folio->mapping) &&
+	    WARN_ON_ONCE(folio_mapped(folio)))
+		dump_page(&folio->page,
+			  "shmem folio still mapped after unmap_mapping_folio");
+
 	if (folio_needs_release(folio))
 		folio_invalidate(folio, 0, folio_size(folio));
 
_

