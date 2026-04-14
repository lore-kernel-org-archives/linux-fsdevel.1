Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CFD1C01;
	Tue, 14 Apr 2026 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776143851; cv=none; b=roXeG/wr2vrQBJfJBcT59Rh+VYZKNzk0SKMJK3O0v5Gk6StNvt4ny4Ml5vMo0UKhDf4lQLtSlTlR21y7bWCfIxAiH5psfrbqDyMOf2OxNlXYKjAEI3LwkoLkttPvOnJtU+iocgGaVTb8+aI69EuMd5FVz2v1259R39sQCN1EpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776143851; c=relaxed/simple;
	bh=82K051Tep/JkEig50wE4zoQmsPmPeGZ44gpDUIO1KyY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uOh8h9ngPXcqtTz3nJDTs75WQr8GmGnzZa5FuRwyPVSe880ChoCUE0U3TuTPHTnz8M+pLd4LAoXn6+7adeVEu4hgoaGmTmu155CRqAJf0+fwYPcr2Ee9T8QrqskMJCIvOsWwz5Mfj/nMNuJZ2ArdcJXp5bwe82cwWHC/Shokp5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=12sUYr1m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="12sUYr1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742AEC19425;
	Tue, 14 Apr 2026 05:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776143851;
	bh=82K051Tep/JkEig50wE4zoQmsPmPeGZ44gpDUIO1KyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=12sUYr1mFI8KyEGPtwEEyJm/H3SK5yWb3apghtC+Y6KWqtz+TlkuU3OLAq8gtd3nf
	 f0YI29yQdVlArq7MbdKsJaf1aGsJMxxYe+u8ef+22H2bp7RnIhlPWEBcH+8FfuGoGC
	 xn0vqs060EZnSWWKem3d1work+YJmIkWgmePZJ1M=
Date: Mon, 13 Apr 2026 22:17:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand
 <david@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH mm-hotfixes] mm/vma: remove __vma_check_mmap_hook()
Message-Id: <20260413221724.c939e483e83304fb40e3d6da@linux-foundation.org>
In-Reply-To: <20260413105713.92625-1-ljs@kernel.org>
References: <20260413105713.92625-1-ljs@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2026 11:57:13 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> Commit c50ca15dd496 ("mm: add vm_ops->mapped hook") introduced
> __vma_check_mmap_hook() in order to assert that a driver doesn't
> incorrectly implement both an f_op->mmap() and a vm_ops->mapped hook, the
> latter of which would not ultimately get invoked.
> 
> However, this did not correctly account for stacked drivers (or drivers
> that otherwise use the compatibility layer) which might recursively call
> an mmap_prepare hook via the compatibility layer.
> 
> Thus the nested mmap_prepare() invocation might result in a VMA which has
> vm_ops->mapped set with an overlaying mmap() hook, causing the
> __vma_check_mmap_hook() to fail in vfs_mmap(), wrongly failing the
> operation.
> 
> This patch resolves this by simply removing the check, as we can't be
> certain that an mmap() hook doesn't at some point invoke the compatibility
> layer, and it's not worth trying to track it.

Cool, thanks.

> Fixes: c50ca15dd496 ("mm: add vm_ops->mapped hook")

That's presently in flight mm.git->Linus, So I'll include this fix in
next week's second batch of MM updates into Linus.


> c50ca15dd496 is in mm-stable, so thought best to do as fix-patch? Will
> leave a small bisection hazard (unfortunately) so putting this as close as
> possible to the patch it fixes would be ideal.

Yep, I did that.


