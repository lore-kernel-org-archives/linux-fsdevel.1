Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670035;
	b=UOQ0xFhrX5nCInOEqteGBCnutRJXcAm4m91Gm6JtMWNSLQtW7RenflfAdPSp2Cq+KKef
	 1Z9yO1zTxJ4ATw4rxQpLVYvN2U64o1nxvoE6Zb6ZWB3PMiIUY0kbBjonGYrpeVT6OoiOj
	 2tyMW8jkCH+b1HCCWCSVYP/wo62fDR9pCEs1ybjubRIoByBZVBvRWnTrY4hwgaxDf/DmR
	 Efc/wILP9e5N2zARqvkFABAr8IDUIWZuasV9CWh7daTieY772fzOtwY2sJf6T7rcSqUcx
	 v3hAmNGpkIBFdgAx+p87iB3KMhlR2OxWHZ4B4ybyy/uzeS2/Irxzdfxxl0rmL+NHYvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670035;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lxuID3na6jcmaf0INynZ+Nu/ftUjIft6QCqWcvBvJ9M=;
	b=oIkjrJMGac1UYtZ/QYu5T6lQmy3k9GG0EIe4CnRQ3LPIsbOGtUR44yIzT7qZuG3Qcpe+
	 KaC6zfT9VgC4XDINlI5QzxHChCCdjSYcz9Pb9O4xI1y6NX/Y745u1kJe2fBdFMwPjqjz1
	 34HFXe4PEkHWjEazd9cVugKmI8Alf4LzT5A/y9rSe+ysQhUJaPL5DRyjlbRsByn05cha9
	 2l2hA8sX5ERYbhMpltmA2u9EgAAKDf96tHtGhqiTaCZXAKz/vCpPPu7xJD6oJt4zs62DN
	 p4aMbqEB0HUJVskwW4tuNbVT1rvMwo8dwbPv/1qLrJQxR09wry4Z0NZwRHkgstggcoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l42pQxJz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB84F606A324;
	Tue,  3 Nov 2026 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l42pQxJz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AA71F000C1;
	Tue,  3 Nov 2026 01:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793670034;
	bh=lxuID3na6jcmaf0INynZ+Nu/ftUjIft6QCqWcvBvJ9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l42pQxJz/NJJJUj2WioihB+JwaAfF2N2Hieh4EES7cYxp8Ln66AXn++rXYnKtdJKE
	 Rg76+im2/hjoX+ffyqCJEfg3Q36qPlLm0IAgV8msk5mun211Mj2r5INr8738kGZqur
	 8xSsxROemxzi5pvr/Jaa9y8A71xX6QSHQbwxXx3iVTqt0FPkVd7+CKXHmJksp1MSYX
	 Wk7lADe1T+lHKAHr4/GORNV7KnXLNt2vq7JJRukMu3yPAsy6U2Ut+nINKncBGIDVfc
	 emsMAB2YDIJgSsfVjlVNR/aAh6AbJzQLxhmCBbJhyG+Mp1h1yL057JEsepD3Db1QvD
	 q0MRWdbEGdaww==
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
Subject: Re: [PATCH 4/8] mm: remove attach_page_private() and detach_page_private()
Date: Mon,  2 Nov 2026 17:40:25 -0800
Message-ID: <20261103014026.94537-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102-page-wrappers-v1-4-e7280bdb31f6@columbia.edu>
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

On Mon, 02 Nov 2026 17:54:09 -0500 Tal Zussman <tz2294@columbia.edu> wrote:

> There are no callers left of either wrapper. Remove them.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
