Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670352;
	b=vNGOhYVrxAvh0OL+jHwtTOJpdyVFjD2qUNeky2Hj7gUuJgsjIHd30FwzThyh2c05OP2v
	 K8mEg0Hulc+9P5oeH1Mdoe6vaHrtxvYHlbPkuupaq73XdCeEfsz7oV49kJa4uex3M57tj
	 Q6KuesNKDmM3dzghXBC/6ptOnMR9RjIGEDtqAq03GDploYKjlz2/We0vHNT1s5YAha4bi
	 JnLqdh4zVTUBcWPNoEr0rvPLdv3E0mtpf0bM9F0GU8u6p5oMUSB+LFQGlWKGgoljQwwWR
	 cIFK2O6aBB7+VI6VfzRhSNTPlCqEocpd8t8+ybCRG5W6KKTy9dkSh8083uX+6hfaWcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670352;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BbaPiTL6H4WZ6GFGaPfwscrQ5Ch3cEIZJw2AtO0Rfzg=;
	b=2UXtZccTbol07ccGxow3W7XTJljC3oRMLpr0kdtzNQ1fLJnZHMqxizLto57OpYPEDqP5
	 zYd6hMa+s0uz6zifGCXrBQEU09SlLyzcnauJ8A7McBa+Aip3gV2lkVYLpqyq2I/z9b4p0
	 tSWy+bTBgxDmMPE9bgViZenWvES0v6IZHoMplylUPSViwnKFRpvzZ4FhaVyrquR7SxwFQ
	 PDf8hkQ+eNpfuvizP0KaRhuMBDTzedzNQ6dKghaSxodKsqx7O2EWglnV1Z1UfWfQR1rtS
	 z1kxNpY54cV+/iL8j2zQ9U3TXrWMVPP/o2vpJ1MSdv/VCcFrBZOFViUYYYs/yDjPQVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpcXJpf3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC928606A324;
	Tue,  3 Nov 2026 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpcXJpf3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658D91F000C1;
	Tue,  3 Nov 2026 01:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793670351;
	bh=BbaPiTL6H4WZ6GFGaPfwscrQ5Ch3cEIZJw2AtO0Rfzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dpcXJpf3sD52gbowRF5to8CVEa3gg7C4pZ6ZzkTS+oYLeqnitL3DqyRwsZpvEi/4G
	 vBv154anEQfZac8igzhp52gFAzw+k5xqzjKlfXNKF0Jrx1qjCWBbKv4KMow3cbGA3g
	 4loLaeE474JG0TvLZqUjAMX7xLsJHnlwlAPlO+UKDFmzBgD7SX3of/zx/p8ETOA4NO
	 PqRXULOIGOEtaOGeJC+0H0rIg9Lif7yUfJOl6P6W5EID7iwrUd+rHVU130VVK6/Wjn
	 9ayoGPQ1CfNqGsxeS3ZLPpavW4wvUWdTGOt6fVjdEDiszIbp4nDwOIgF0oEdOYOk66
	 W9OjmsCymJJ6g==
From: SJ Park <sj@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: SJ Park <sj@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] mm: remove read_cache_page_gfp()
Date: Mon,  2 Nov 2026 17:45:43 -0800
Message-ID: <20261103014543.95070-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102-page-wrappers-v1-7-e7280bdb31f6@columbia.edu>
References: 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 02 Nov 2026 17:54:12 -0500 Tal Zussman <tz2294@columbia.edu> wrote:

> There are no callers left. Point the comment on shmem_read_folio_gfp()
> at mapping_read_folio_gfp() instead.

Looks correct and good to me.

> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
