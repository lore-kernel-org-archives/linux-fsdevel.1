Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B491397;
	Fri, 28 Aug 2026 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787960249; cv=none; b=WvdAI83YS+0PXxmrqKenRlQN/d1RsU8hdxNc1SOpZzir/BbwmAZnooWkxg8rwqqRVNhNZ0z1rKC6DpVk2/m2qpj7PwnawF1+1qvIjx6/QLoqmnMIGnDrAmwNjJSNvilTcoJ1Ku7gLX8gFoaET7oKqje7eramHvJCZl/l8qV2GcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787960249; c=relaxed/simple;
	bh=ZnmkW+RgD0OU9oJfaYp7vHJ/SZPbNHl0/ZpS5/VXN3s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=djjNEAj2vl4P3BxCG87hiieHjui+du3v6gv8LSzrNb6Tytfe2L8LT+mzi7il73/SAn2p7104pbtdytMzpklh34w98pMWHiAKkWU0xA380me29+VgO1aoe/K8qUsXMFQfDvf2Cnn2ba9BzskHKAlhakCmKbA6c8Y07QZokyA3QmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WtMGDD7R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WtMGDD7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B5A1F000E9;
	Fri, 28 Aug 2026 23:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787960247;
	bh=O991VjvH7uZlraIXABzGMwBQxEqiEiD6+/CXOmqauVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WtMGDD7R5+HuwLBWHNuiKVmTEwKuGdqE7xYNCvsdKfkb0D4adYX/RIp1TpxDH4lex
	 sQD9MvOb3xbp85bYgCFCe6AUh7WMh7SRG6QnfvsyUCEmd4634h49DYiNACt3ilQwvt
	 mJujqkg+MtRd9K1a7zv4F0cxLnSqtu/4PArxYI7c=
Date: Fri, 28 Aug 2026 16:37:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] squashfs: harden fragment index table sizing
Message-Id: <20260828163727.748343f2c87610ac6cd89dfb@linux-foundation.org>
In-Reply-To: <20260822143328.68867-1-kmehltretter@gmail.com>
References: <20260822143328.68867-1-kmehltretter@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 16:33:26 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> Two integer overflows undermine fragment index table handling.  One is
> in the original fragment sizing macros.  The other is in a bounds check
> added by commit 1cac63cc9b2f ("Squashfs: add sanity checks to fragment
> reading at mount time").
> 
> Patch 1: the fragment byte count wraps on 32-bit, so the index table
> is allocated too small and squashfs_frag_lookup() reads out of bounds.
> A crafted image triggers a KASAN out-of-bounds read on a 32-bit build.
> With the fix the same image fails cleanly at mount.
> 
> Patch 2: the check that the table fits before the next one adds two u64
> values controlled by the filesystem image and can wrap.
> 
> Built W=1 with gcc (x86_64, i386) and clang (x86_64).  Strict
> checkpatch is clean.

Thanks.

When fixing bugs, please always include a clear and succinct
description of the userspace-visible runtime effects of the bug. 
Especially when proposing a -stable backport.  It should be easy to add
this to Claude's prompts!

I expect that Claude could also generate reproducers for such issues. 
Although it may not be trivial in this case, as a corrupted fs image
will need to be created.  If you are able to generate the reproducers
then please document this in the changelogging in an appropriate
fashion.


Sashiko review of this series claims to have found a whole bunch of
similar issues which you may choose to address:

	https://sashiko.dev/#/patchset/20260822143328.68867-1-kmehltretter@gmail.com

I don't know how useful this report will be - the first part seems
wrong in lots of ways, as if Sashiko was using an ancient copy of the
code.  But the things it claims aren't there have been present since
2018.


Anyway, let me get these fixes queued for testing while we await
additional reviewer input.
