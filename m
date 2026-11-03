Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793669962;
	b=hGEuhzvUJu2dCsWjO290zT3UHigltmVLivLStwITxKgiV0FZNrm+IAxI4rVCyG3OJJKE
	 lM0q+9FxHas2hjY0rWMsxf0XR+v2uhZ/vgLzPY801IMyqgKi3YpohwYbTPfqp28EoaxJO
	 xwjanYCNVrPr0zqZOCAtxtGVQaMZcd2qzZ0vXtjtjqObfYvf/nFR/7QMeZ5u/rwz6Duxd
	 kzKM2j1oQuN2eyOulK07V2Sv/hgFYTyrqNX/sKtw+5w8RFUqOpnEqNQLwAKBOXgP3+DWE
	 dW0xmAp0WAqVTxevUlTYwZd0Gn3UixpVGfes8n4MF3jxbhe6OHYtWLKkBcvUpUww8xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793669962;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AFhkbJPMzn5U9k5NLHoploMNUzWmmmhDgm1FP2cMeac=;
	b=Jeuf8+/Iop2K86QlwQ64LGkyaV71o3rbpPx4sXhkJs67fP2MiYZe4jCA3rBHTiiQ5YEn
	 y8BpOpLOyPu16CD+PionLHhA9E4uZdn+SjpwvKnP3PDHdqKmaQCqSlMaLuePo4CW0yRV5
	 uCrQGVYIQmIx3cmWq3SnAVAA4U19eXpoMe4m7MXep0k81QBnmigG3VE0KMXMSmDlcTHt3
	 5snWvyZnGQ5PBQHkufS5tz3t8JREwBDuVP7mXfAxqGMA/SI1jr8kPZ43Xa53EzfwXjOnF
	 BKjC4JKh046mkviM5GZlAqZCC7yXyfyMRMQiy5Ql9N8ZQcQcMfzhDfsJnWH3L33NWMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8DeQ3DH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759B0606A324;
	Tue,  3 Nov 2026 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8DeQ3DH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A71C1F00A18;
	Tue,  3 Nov 2026 01:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793669962;
	bh=AFhkbJPMzn5U9k5NLHoploMNUzWmmmhDgm1FP2cMeac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y8DeQ3DHSvYrvKtriFUEeRYjSPgOO/QlouSPNS3ne5GLpGJUyJEvl1fcxUznYmYcX
	 45Ca8tDqNRewgAzscy1SFy/9APiDbUBtCZHjDClrk+okuAVmlGctKzNMp0uM8ecjPF
	 JKMAkZcL2kh6EUyYuD6Q1UjilWNxuTDMFNErEdjm97qM+ojbhnzZLtlQ2b6mypcFjW
	 Bo4jvWkP0wlpX+hiu6/FfrbJ9+HyktJkyF1xaDBdi871mmwZfJLPU7wgWOeP9s6A3M
	 Qw+CvUecPD4Hz9YqutaebRYHeGozC4yXGmmfV9PLKpFnIBKEm8WcukjORQnIZjrPZZ
	 F44DlQzLSmlCg==
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
Subject: Re: [PATCH 3/8] mm: remove clear_page_dirty_for_io()
Date: Mon,  2 Nov 2026 17:39:13 -0800
Message-ID: <20261103013914.94354-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102-page-wrappers-v1-3-e7280bdb31f6@columbia.edu>
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

On Mon, 02 Nov 2026 17:54:08 -0500 Tal Zussman <tz2294@columbia.edu> wrote:

> There are no callers left. Point the comments that named it at
> folio_clear_dirty_for_io() instead.

Looks good to me.

> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
