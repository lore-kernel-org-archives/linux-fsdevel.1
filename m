Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793669798;
	b=h6GXbL1CftCjUvhjhG8+cFF3p3ZCERg0QdxNtygmjFbWSGp7rHOMCuHifV0szI5W9V8T
	 c3d19bssUu7Ylb7XtDWqJN8KbzF25GnQF3hGy53LFQILkAThW2JYGdY3/rvYt2ilVvyQv
	 qmFlW3k0lJ+/goGNfDVxMMDkQLbulzWyRRRIMGXcE0XlR88Yotdbq5OHq3mVhQjrlz+Lj
	 MFKpYBEhC401ocSKy1NoMpDrZ5vqYWRgZhX0gcHPh+HIyIkb9N6VnvTQZAwXnljm1b2+r
	 xaJDAGlTPRcHOQvUORnBuk+XaKc3TBN4HsDyOU4XKV9YgsTyMvJu+qhAE/o60vzs36A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793669798;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=y46+NJ5aqAHpCrKu6VjLDpm+yebJcad5AzOl3gzfzyk=;
	b=oVDM41xnG8YdBQXzpQTZNQZrSuG4ZHBeixgAL4V7ZWq4aGYukMAcq3DuLGBQE7e4vraC
	 HwT/5VF2LCZdEdw7bqyIC3yTgbXLlT39lYe0DYyWGf+4K9ANjWdMwUDnd05hyG2hKId+T
	 F53MGXY/EOwfPn4w5lr7XWbc/Tv3pImm5WtDw545HCUCIsej/vr36xUeeRoGQaFZWqIN8
	 jUInG/jSWW6Nx0v4h+18rRshlLCC7Lu9pdEaXoE5Em1BKDWE0pjKr4I/iYBsrEDZd1C1O
	 LBDSU9j3dhN/HNn830Xv5UGbsmCRWVRU7h6jqDtIxgL6d9sDO7gd4dIEXzk0MH2OmTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLHAsFVr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B079606A324;
	Tue,  3 Nov 2026 01:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLHAsFVr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5964C1F000C1;
	Tue,  3 Nov 2026 01:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793669798;
	bh=y46+NJ5aqAHpCrKu6VjLDpm+yebJcad5AzOl3gzfzyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kLHAsFVru9ldiCUzwG8pcEIm685zZg5oPrTwKMzUyM60f2CKmLCvXyCfCD+PhWfyX
	 raK/9se8VbJvZy93e+TrAiYYxLvI9wsoDk10fran98JIXZvNChsmpPaXOf50B4qkuL
	 rDIq+NRyq0r+Ky7r9RiZjF6Wb9IYL8RGDnhP4OEicrdtr+PsKcX5L6Oy3cuxuDZJd1
	 XsH+WOWwUM+/VWye+3AUnK7/GSQrUWbQoXl+J/CaRs6gQx+Rf02HRkyJJV6mZpOhjQ
	 TXeDdeNUZFY+rBVzBF+H8d0QVd2LtTB9t/CbMSVa3tW6lCOYMPPr3oVRNUD/Rx1tnG
	 yJXp6nZtlKxFQ==
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
Subject: Re: [PATCH 2/8] mm: remove end_page_writeback()
Date: Mon,  2 Nov 2026 17:36:29 -0800
Message-ID: <20261103013630.94182-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102-page-wrappers-v1-2-e7280bdb31f6@columbia.edu>
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

On Mon, 02 Nov 2026 17:54:07 -0500 Tal Zussman <tz2294@columbia.edu> wrote:

> There are no callers left. Update the two comments that still named
> it to refer to folio_end_writeback().

Makes sense to me.

> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
