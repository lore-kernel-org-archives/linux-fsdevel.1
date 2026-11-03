Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670092;
	b=sZJz+ETzKz7V9ja0OHMUU4yAgGjs6rxo0L1B4hX3wUV5iWsIZ3s3LjvOfl40rmzciB4j
	 5YN5GeVA6g39MSgPHRdfc7qM+pFRyRaDX5eYQHcxRnA06+xFZQPdRjKb0vZHiBmXP42gY
	 YBCBjY8TjqmopUMV9pfwQmsS+yTRna5iErXCxjr0GZjs+eaDjYS0YgUV1ZGOoYs1qArU1
	 2Q7OnJF7XCu/LAds9ApVMn+bEMkIUhoSbI47bDRnG6EOUiuqO81pEmFfmKDqH/gY0QyYi
	 MyBMAH43y8OivZVByj4wNT4Qckj8qsZ8ij8Q7q7VjxGH+tumR2sbAwbam/RuzYeUUDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670092;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EFfsUw24ICsmnAL75V/w1w9LO9fCOi9ofFCSWn0tGhQ=;
	b=DM9Vj/junhxoz2P/Q0Stbbb99xg1TTWBabRLo5hkY8iQ1y8Ece86NI3bdWxKkVHAlBtj
	 uTtAt5sybDeJkL8VT1luuvhuaGJQJ9A1XVGBD5xpoqSNdWlSRh1fG2scpICZbrrezDWMc
	 nF9/AySjSm9NMHqyL2n133fnbQyViV7K08CHmp3uXyl3sfeMWPDNjsXNl9n4RhTSOa1xk
	 IvqhZu52FJDRXogsEytkH76p5bapAB60zwq2fcb5L1dLKq7AipeHVpI6uzQUrg7CqK+1/
	 PvmWS5RhLKlaWu11QKeyUGMfA/Sj87BmevNnHiOUjmH7UuYwCScV4dF1fL/R/yIA6IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxyWOX6X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22B606A339;
	Tue,  3 Nov 2026 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxyWOX6X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FBD1F000C1;
	Tue,  3 Nov 2026 01:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793670091;
	bh=EFfsUw24ICsmnAL75V/w1w9LO9fCOi9ofFCSWn0tGhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bxyWOX6XyQ/qnDucB3bGiC6TJRCggvC87Gb8LL7HDwTOvv6P8UG84knXubYWSvcJ6
	 d1WyQju2KmSIpkWzU1Z5tzLWP84prqOyqR5VYg9Psg19vLZGvGbRQwe3pwJtACet2u
	 qqHgKSGkQun1iXCXQ4knBTmhpZKYp/C7NDS7PSPBtn8plsJ0/uafQJJbmXkcpQLcKT
	 vWKYlo1JlnEUoy8aa4CLUE5BDiU98kYtNGA8hX91ZSgZUmjoiZ5XCjT1nQbD9VBEK5
	 xnt0FrVQ72DuFhGAf0NXmq16ADHmCwJe67+SZodec020ldjJfzG0qZYZyzWK5soaXN
	 FRV7zcEJLck5Q==
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
Subject: Re: [PATCH 5/8] mm: remove find_get_page_flags()
Date: Mon,  2 Nov 2026 17:41:23 -0800
Message-ID: <20261103014124.94701-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102-page-wrappers-v1-5-e7280bdb31f6@columbia.edu>
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

On Mon, 02 Nov 2026 17:54:10 -0500 Tal Zussman <tz2294@columbia.edu> wrote:

> There are no callers left. Remove it.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
