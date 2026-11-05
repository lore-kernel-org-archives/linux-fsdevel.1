Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872180;
	b=bOEdKtKKqCZGx6cq6cMPAqqujQ7a/hK8q8FlG4vH0+uvNkj5aLz1TqSHyk/7Z5sEyF5d
	 4wmxwooaZ/zdIrg6rOYqSsvdZ7zm1pOBMTq7yJZ5j59FD/e8eWDzJAL118iMxNS51Ad9r
	 MbxbRdTw7dd6rs60YI1gnqe1ykLuxM0x9t9hVYaHdQlKVpDdmuwU9dmhVJwbMycfUUFjW
	 HCZtTiiHbF+SlKzO+S1bONpsDDsB+uCFcA33flKzp/uZUmjMcaqLzoVGfnY+zxTYLEr09
	 Q1SolPZyA9PljG8HK46Bpa+DDuE43x94I5YgImHK0RW+VKxk6IPSmZ6Mq+lcJQFRj7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872180;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=hxTX4TglBlcnwRKNy/gdxt9lj2TmNDvqrCwVL+kxWpo=;
	b=k+IcmDdk85/T7Hov4Hqfvi5PMxZhlYQsm67QyLnbz5F2wv4msOUzKzRZBIFZhzx2A7Bs
	 3gkvopq9q4YDabPincV09LPCvXeD2aLekZ2Cvs1oOyydWvfVia5rluLVkgqNM/8ImtfHM
	 ckuBBXjiXBS8wzNvtBrbPlBO/jWq8v9lfp9ULScXzzMsbQ4Etdp9/zFwZrc8cN5UAhEeE
	 3GcwAmKcrgpG4A3rU8HBixXvb1bGxzQO4NgzYz2TjyC/rbTB0NmbmTL71G+T3sQa93nen
	 BM8wLYAVGZfjVtICJRMEwhe6CciyTjDhczIKgiDr/mmN6XJZvKBfrVUeVrd6I8l5Xtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZEk0xcPG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DCE606EEA4;
	Thu,  5 Nov 2026 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZEk0xcPG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEC51F00A02;
	Thu,  5 Nov 2026 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793872179;
	bh=hxTX4TglBlcnwRKNy/gdxt9lj2TmNDvqrCwVL+kxWpo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZEk0xcPG7OcMzIf2u14VAVOl6GpPUYHf+L3nCdkVQRLU60PAc7WRZtHHkhgxN6H9i
	 Djsp294G/kXjLF6vHuZ16WK+JN40ZCPORmwNUt5ZIcriAJdL8nVvjBh5XSVRXL6i4m
	 +mvByiuJmSOoigV1uFzQ4hq6HgrKva2jDRPW+19sVV7Smj9DjexTuecxJ/uDEyL32O
	 OzvzN6nQOiWC+janptzA6iVisgRTq8hfM4vC65U8ZkSPmsU49fBKWE5auGZ46zRO0n
	 nxo5YTL6/Hpum/GpGVNpvqqjqp6NTRGC2+b9Nr3pd5WFPQLvLvxTb+jW4sMHZO8GV6
	 O/8WO/IU/44rQ==
From: David Hildenbrand <david@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Tal Zussman <tz2294@columbia.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
Subject: Re: [PATCH 0/8] mm: remove newly-unused page wrapper APIs
Message-Id: <179387217134.14545.11514432570963852326.b4-ty@b4>
Date: Thu, 05 Nov 2026 10:49:31 +0100
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

On Mon, 02 Nov 2026 17:54:05 -0500, Tal Zussman wrote:
> After some folio conversions done last cycle (namely ceph, f2fs, btrfs,
> fuse, and page_io.c), there are a number of newly-unused page APIs.
> Let's remove them and update comments as necessary.
> 
> Patches 1 and 8 are taken from the ceph writeback folio series [1],
> along with tags.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: core-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/8] mm: remove wait_on_page_writeback()
      https://git.kernel.org/mm/core/c/88e548fd
[2/8] mm: remove end_page_writeback()
      https://git.kernel.org/mm/core/c/57733524
[3/8] mm: remove clear_page_dirty_for_io()
      https://git.kernel.org/mm/core/c/447d4798
[4/8] mm: remove attach_page_private() and detach_page_private()
      https://git.kernel.org/mm/core/c/555b63e1
[5/8] mm: remove find_get_page_flags()
      https://git.kernel.org/mm/core/c/47a09332
[6/8] mm: remove find_lock_page()
      https://git.kernel.org/mm/core/c/9919cb21
[7/8] mm: remove read_cache_page_gfp()
      https://git.kernel.org/mm/core/c/1fded4e3
[8/8] mm: remove thp_size() and thp_order()
      https://git.kernel.org/mm/core/c/4efd0e4a

-- 
Cheers,

David

