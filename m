Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563644;
	b=UlWDdqtGqznSCKjfqK2C54IGDJqPzElpJrt8vxeDehYDlE5TObEkgZcNZgRDgyTiO6Ex
	 q98ULx5iA51o9Mv47sD1Gy4rHCAltsAAMzovcacbUD+nTsWqU28asxHIBUANKVP172rC6
	 HO3bOcxOopP5MyridAF1td3Bpg9Rhm6nO5NUHPm+eJ2yMJK7qYJcOAGCpf18swKVSE4tW
	 A6cl0FpM175VKKHXpBF5YMguehwvEUQOf7wapgHC03RwDPMzex5ykLQuOFwfy0hZauBrM
	 KcjzUKx1asD8mdHbTDX0goaQcEIf34kmJLVeijf11s3lBPq5DzEhn2ZTj9HzCZJSwhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563644;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=P8EQ9FC4cZYCHq8yHZtNznd9EQgrZ12HAlgtAWeleac=;
	b=bp2vAMlfJb3azGPclVY9WVsxwoz9iwIFz3pW1qYXksbGCc3tijwpdiXL/jDaygbMyhKp
	 Em+Z0hHUHSakISOPxO99ejYj+hEhb2TTj9bFkSq1tXEC5kmUMBOCeCBb+7gitRPpa6MmR
	 4W4fFafyb9JNmvNj8JU80n6/DiiaW9Sz4MNStBFzw1WbC658PC4PqNk0piEV9Oxo5za5c
	 0NY2cqAIPexQ8hbtby3o0x2gF3FmLbjnlbjlwpoq+kDl9D4gQ6IY4TeM5sQ/BvHsyQT3a
	 2cy3QcEFP/aAs612tVJr5j9VhV7onRIG5PSZ2ij9UKh4S+jFwJieCDZa5inbqjNyltg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f0wHaTbe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C9606A32D;
	Fri, 13 Nov 2026 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f0wHaTbe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7341F000C5;
	Fri, 13 Nov 2026 09:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563644;
	bh=P8EQ9FC4cZYCHq8yHZtNznd9EQgrZ12HAlgtAWeleac=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=f0wHaTbedH8MKd3xbBvnJTz6C3TbsBFAY862o2AQcfBrjdYCZA3KKd4lOYhc4HnOS
	 izioEzZzwmUKgaqN+BTovULVcLTwuMKzmhsM3ubNMZE53yu9d5l1ZvOzQAg97twAMR
	 M1C+9ppPdDuBhepWvTHZ2XnpoSlD6S+Ou1ltqktZfoiXbzqIpWy846z0TXOfHwz2Kh
	 rH0ywqW5+yfwOMr3/lL6BhxTLLZ081RzXBPdRO5jt2OwfRB8CaXvj4nv7up1OW30Ly
	 awPHrEqKhyxkGZvqah8xlnrPQemguFQVjnqn6N5tpOi0JMBf352YsDajD5YdT1recb
	 bBr9/SbnYAwkw==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20261112-bug-mm-shmem-undo-batch-v3-1-212db8c24058@linux.dev>
References: <20261112-bug-mm-shmem-undo-batch-v3-1-212db8c24058@linux.dev>
Subject: Re: [PATCH v3] mm/shmem: remove truncated folios from the page
 cache in batches
Message-Id: <179456363894.3289.16333011678633371676.b4-ty@b4>
Date: Fri, 13 Nov 2026 10:53:58 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Thu, 12 Nov 2026 04:05:12 -0500, Qiliang Yuan wrote:
> truncate_inode_pages_range() takes the folios it finds out of the page
> cache with delete_from_page_cache_batch(), which takes the inode's
> i_lock and the i_pages lock once for each batch of up to
> FOLIO_BATCH_SIZE folios.
> 
> shmem_undo_range() calls truncate_inode_folio() on each folio instead,
> so filemap_remove_folio() takes and drops both locks once per folio.
> Truncating, punching or freeing a tmpfs file or memfd made of small
> folios, such as a large /dev/shm segment, pays for that on every page.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: shmem-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/shmem: remove truncated folios from the page cache in batches
      https://git.kernel.org/mm/core/c/2e0dafbf

-- 
Cheers,

David

