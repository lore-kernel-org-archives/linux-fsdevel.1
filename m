Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670223;
	b=2pe2nCNqS0cpEnFnnnCkSimdhqhxfjU7C2K6yVIiq5ZFqAzC3mSmgJVjAnRTcjgJBiIu
	 4KWO1CeoV6WClfrb++IIlZnAOpBVgfSwmUvn2RMIaV2XsD7KCRHSCxXR+ahLiuv/coFEP
	 tdR1uWdH6g3hLWdzVARw3cQqpXKY0n5Ks13muS/g8CUTJx73OcR3by2S/1DDCTYksKZhQ
	 EAO5i17rsTG1eg/GRlh3wI25RCIde6JoDc4Okswh9f4PRkeGmFE6rDvez9S3luxIajZhH
	 kpQiVedksVeL3+Pas8M3qvzTYmzE3AcxI5TiYYP88uDeUO6N1FI2dAKUCpKibH+RFsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670223;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4kniJNifKCcuuGOg4oonNj+llyeJgvvjLzYbyLbb6wM=;
	b=YeryRtHr7U8auVDRGTaL1jDkebtg/b97ZGdWM0D8GpkfNE2bM6ppkwTsqt/SddjNYheI
	 S9YhE6pGykMpIEGZcoQS8VMfM9OGFP3ICUQMdAdRaAH2qgJDjHrJQ6pHsDirrnJBuglx+
	 fU1+9gqz2oJUM2mHMQfkQxR4VT8gqw3UMU3x/ehEmYilS4T8EDLWF/dxSiAYE/VqU8IyU
	 6LRdecwlA3NV/DALDsEaTMd+HNw/0K/t6Cb3uArXki/DfRdvn9I1FwS5GJKjx+riuYdB3
	 OSXjJV7aGH/CSp0NIyhETWV+Cg3kyixxP4gQ+vzQhhT+7ngKk/3AmYNajWwSh+OM5fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F3yly/uT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F643606A32E;
	Tue,  3 Nov 2026 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3yly/uT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE1C1F000C1;
	Tue,  3 Nov 2026 01:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793670223;
	bh=4kniJNifKCcuuGOg4oonNj+llyeJgvvjLzYbyLbb6wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F3yly/uT4qmFRgXh1ssn5lW3nMStihnIt1vuNOiyH/h1wLmci+mZmNQPnPKu1y9ML
	 tOlNk2GfCS7IEHxT9jmQzA0sAqBfbZEht4LYUZxABS3IkMhvqzqyAPBK3qfKT+K3iT
	 HHrKvYbLvX+9Pv2DhN5XHkzhow6YuiMoK7FuRbn1lmyoq+czheusOll0aQXuHki13P
	 4NwJirF2GEYOLHRALbT85GFMiTAS+0EJrfaWyZUpV7rG+VCO8m8ZXIqFoQ5ZWIwcHz
	 rnPTDRQNHBagZhjBB6O2QGy8KJHEDyCALkex//7zVRZvykjkCpKVqaeRPUCwsOtkia
	 ux9vyx/UbUd/Q==
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
Subject: Re: [PATCH 6/8] mm: remove find_lock_page()
Date: Mon,  2 Nov 2026 17:43:34 -0800
Message-ID: <20261103014335.94889-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102-page-wrappers-v1-6-e7280bdb31f6@columbia.edu>
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

On Mon, 02 Nov 2026 17:54:11 -0500 Tal Zussman <tz2294@columbia.edu> wrote:

> There are no callers left. Remove it. The name still appears in a
> sample function graph trace in Documentation/trace/ftrace.rst, which
> is recorded output and is left as it is.

Makes sense to me, the example could be updated later in my opinion.

> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
