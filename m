Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670501;
	b=kAQjuNNKpugyCJnXKEChifZhFV+wGm0ZufVavD+MJmXwPXi9u47k1o30G8pTrZVpvOQt
	 pqIQPA6UpaQYBAhCwBrx3+jOmjn/X8J7xqBN+o1/EycdB+yBWSxIrqc5t3XPZ1ECBsdn2
	 3CK5XHBut7epUAkD85VUgyRy5UTpneiIrOgAI2a80pFhfMp3tz4+oSUAWBgtwmACjcP9O
	 XmG5uREy+3q9A0464OUF4yWrIOZtNSJtwpSLhBhME5eey6hJcwff9Ixl0QfAsany2wha4
	 7AuqVoYQWwVeJdGMLdACA14OKa65HIvVlbdS5+DrjHlLi2i+v5GlCZ90PgrAtm8cq4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670501;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4J4SCqjjqhtgMVcCb5tIrEEKZXAGW5gdRwbOYNKvTbw=;
	b=ATCwpJaMkeWsocyNN9S/HxltklsSHCFdBjVJGd/r8mEYI5gx5w6zBFxB7av1/0WL7pBJ
	 h+MBfbl+eWe2QnO84aQT7heVZIRZROoMs8mWDM2QxAzy8zeVeGcj0I9NL/0b/bPPf6WG9
	 Fia1L906X3JS+8EPHi13oaD0XS9jJajeYvBSG4JBDWL/kB1+JkYq9YEmybM9Ec5JCpM8i
	 5swrgmPS1VfnpY0+kFlqdt98AD/AVXVIat0/eq2whhqW73V6qCJuz6lhTdmoJqGmfeEMS
	 9tj/WUYwQFd1kELShdWr9AqiMgQZ4rpe4vvVVFlleB5Gz72m9iaRSCm2nZod7gg8t9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4Q48gX3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB1606A324;
	Tue,  3 Nov 2026 01:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4Q48gX3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3353B1F00A16;
	Tue,  3 Nov 2026 01:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793670501;
	bh=4J4SCqjjqhtgMVcCb5tIrEEKZXAGW5gdRwbOYNKvTbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g4Q48gX30SRkNPUGre+5dGkrJ24cinpNbozRWJmUXMl7z87k5wtfFeaH039EJxhTe
	 aaZXJsTlcmZ0ImrFxNKCW95BLooEnLm8QV7Fyse3ZqAFmSksFHdVNMlG4slV2jAul5
	 lfS6YfFsTAbcFRjhwWcIQE4mYcMXpcLNLeItP+4cEYup5qijComg/m3c2nxhqb1i7D
	 9ht6ELxs+5/qYxMYLZdeIHVIEXQAG3LKGCdbLtCKuHCupm8Bb5Pw8jgdHFM00H32pW
	 F6jqoiilzwUe+xbapP/DfZCUxG6uIBNm6hbCDQ2ETV0lVRwgR+WNo/Yj/7oblUSS1T
	 uY46x8C+IFenQ==
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
Subject: Re: [PATCH 8/8] mm: remove thp_size() and thp_order()
Date: Mon,  2 Nov 2026 17:48:07 -0800
Message-ID: <20261103014808.95273-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102-page-wrappers-v1-8-e7280bdb31f6@columbia.edu>
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

On Mon, 02 Nov 2026 17:54:13 -0500 Tal Zussman <tz2294@columbia.edu> wrote:

> The last callers of thp_size() have been converted to folio_size(), and
> thp_order()'s only remaining user was thp_size() itself, so remove
> both.

Looks clean to me.

> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
