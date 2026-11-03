Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793669698;
	b=wF8kszSMwtes/KsLbA05a8XFh9mv5ailQMIeEYp94JHcQ3ClDjeFBDxYFOpRCM1cjyST
	 t/uGkQfuMNAnd/aE5IpVYzbKd/pdgfkUd6NW7a2EQBTqjB3V6Ka65vEOcQD/S8l52PuKy
	 XFfKwoyALattxhf7+TOa5KTOJL4gQnpPzJuRKTlO2crtniTqVjJFBbCAOSlo7n1u82JiO
	 ykON7PgkKVn3LUNjonzv8gCXwO5ndlzFe13TvS5XEE/FGe1XKE4yWumCcRIgrF1w03PeT
	 o+MIvCRyJn1ze8ZXzpveTP90wn8LyFVuJIypTebjWunmG1axoTvJBX/QuPUwmQZGZzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793669698;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=56rap1o7worJIx5XKJcXXzxaY0FYuZMs60jrSq6DFxw=;
	b=Z4M+Noy1httNCBHay/7kw5TjadqOy/g/pvyYkXJ27mhzYxzfujSyY+/yvPDK43xIZKqu
	 I1PSAXrh3I2vAx99RbyjKrRBPTBi6+79GYFx7q6DPm/9RPTxUSicPwCdOvD5uXxc23pPO
	 SHps2IHp5sIO1OLvcVKF2pCaVwQckNGQPdM6e9yCY0R4caQ/HyBQRPJsDhcajlxpXVcK0
	 PeWMfeC2FPm4UJhnwuYLAsu+vzecqkvekDaMdmIt5WSy8mV4eFUXDR/6gbohXju/ZMsXe
	 WWsgRDfQvarSBUGIN/oIMXB2wVmh9wWXvvRIc3TbPVSLcleDcB0TvD+pHPhnZ3Wp6lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuWOEBPE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192CE606A326;
	Tue,  3 Nov 2026 01:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuWOEBPE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29F11F000C1;
	Tue,  3 Nov 2026 01:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793669697;
	bh=56rap1o7worJIx5XKJcXXzxaY0FYuZMs60jrSq6DFxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OuWOEBPEQbnyxrnhhRefJZallXrO2CFILZlBkI/exfpF1YdIQaHjTBy8NgtrRcNv9
	 dlwMPJYGRhhadNj3olCdeIUMd3pEepnEGAkK3Sg9/k385MOStv3+y0tMa74pB6P33T
	 1PvcqV4nt/qb96eyavODI4qydUoRHT1yHv1/jmRcoACCaroPfGdJZAYgmzwTT17lwa
	 Ri/npoqchZfzYoGy9fziJf7Udljsa6F6ewwuPjKb8ZC9tN4k5ODq4qLZI1U1EkO9o7
	 TTBAuA9/aldvTzZOuwrSTv1rtaEeJGdR1/li/lYHwnkaYXfLnpns+V9yoUxxdPKG06
	 mXBbA8jRfHN/A==
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
Subject: Re: [PATCH 1/8] mm: remove wait_on_page_writeback()
Date: Mon,  2 Nov 2026 17:34:49 -0800
Message-ID: <20261103013449.93977-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102-page-wrappers-v1-1-e7280bdb31f6@columbia.edu>
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

On Mon, 02 Nov 2026 17:54:06 -0500 Tal Zussman <tz2294@columbia.edu> wrote:

> The last caller was converted to folio_wait_writeback(), so drop the
> wait_on_page_writeback() compatibility wrapper and its declaration.

Makes sense to me.

> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
