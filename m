Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797381;
	b=Cxk5fhq9tVgcm4DDGKYVnJIM5sqKvQw9KzsdvbmmHBzsVvyf8WTewTRmNb2WF3zCzdPg
	 fS3alPPbdSG2m0SmwFQmbNE0Z0TIxHAQNdE570Q3HjXv8Leolb9fFtYuW5ZOIU+LIQPY5
	 KJlFafXWhwLb+MzW4uwknsjTX9Vd3cL3IeFCbfvcLHHTtLzpL6/2sA4NDY+6065Ov1x+z
	 zBoKxr/Em1x+ZtSaexY/RLpzwrd6vy2Ybrxo4Vcm1cwqd32OulGfPbwP2vitDKGbp31Op
	 h6K8ob80Bvn2PaZH4ujWSsyesqLiybW110OElfV1URqE2DGBb3rVHq/UMOFfWPjCxTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797381;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rz5gqclVsI7Nyi3wdIsP2V0gZuIMwOehVRh4pvFPagk=;
	b=2nLG6X5Uu/lHE7Om71FyaoiwYmALEfiQqsrzOR0HdD39yT7yzlR7wuAG6jlnZGrDepEh
	 Xk01jhG/XBI2A+XShCjp6bocbeFQi3Rk+RGNm7Pes927VWH0Eo0YRgNFQ5yJm3dl+1u2c
	 iw0ZJGmJGEhpTi42EfgaoNjhU41aPM5RwzINoIj2ZnVTcr/OlODI55y0GIjAer+ADXQh2
	 7fHu5aYbLwtfGyHb7fu5NUM45nrm8++Fovjgtr7giqzTgyanME7S1mHIyPXf01RD8Jwct
	 KD1D845fwFz3xlL4FQ0ampLwwgAE8bj8MrkS9AYa/XHjvha/ByUIuAUpn9wAJig8n8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcdXsSLP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8A1606D816;
	Wed,  4 Nov 2026 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcdXsSLP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F091F000C1;
	Wed,  4 Nov 2026 13:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797381;
	bh=rz5gqclVsI7Nyi3wdIsP2V0gZuIMwOehVRh4pvFPagk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LcdXsSLPAg5DKaj/aTv9PSu2NP1TfKv/KnATTp80uFZvAj/RMdBW+1ZOPeFrFXIx7
	 C8QG6ERv/NLY32h5WhymVgGeNa+YQYciUPxku0pk8GVL18LnAMrB2tjXMT35BVtc1f
	 RKHAHigPew3UGAZSjvFYrFmd/K1cEReTLTZLPr6jKunichT+DFykWt/XzltrNGwlxj
	 wZP27+w9nPxPszO97Il7WVkaoQE/QEWONuTFLsBkK3oKjpihaYjzEp9BjCpS5snY85
	 FpI1lwH5PeatNZSbHRappTVAIgHvJ3XURdvAarRP31JRYg3s/AIJ3b1+rDwU6eY0Om
	 XcDyC66dIpPig==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id AFE2F1980054;
	Wed,  4 Nov 2026 08:02:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 04 Nov 2026 08:02:57 -0500
X-ME-Sender: <xms:_SzrajjhOxjr2XwmQIqse1UH4LUbP5FMftC_A5W_XWSuGXPGh7Ne8Q>
    <xme:_SzralRIVATV3PkPWnjCM5SvKMZ0McdyzgmUKTIQJtK-L_e3PbBXnMpYJOjbb0UGt
    9u8BTkQyp3pWleC3fWEBloQXw-hlE-bVCkfIqL5wIp8dHO3NAWZouI>
X-ME-Received: <xmr:_SzraluTmjoqOwcQy9e6ka_pj-2Ujp5hVDTOHn6Ct-5eQUDjaP9sMcvxvkM>
X-ME-Proxy-Cause: dmFkZTFyj9iBgTb70dT7Nrskf29uuOyI8LMvpppsr+ztaR0SBDghph+zBPTBpK5ZS8w9Hs
    ZfoFoa0Z54ye4qFPVN9z+iBcUmGJLuDx+F5E+GwM0Yai8h0Kc4rjSxG6WPfOH2iKPLuf3P
    s2X5S/AicHnwf5qqVsIRpEEeMef/YyNBtQ+L8UUZ6s+iWkyfT6d384myBgsvxs/VTn39m/
    MUnuiW24J8M/zjUd3ANt41C4Bw9zgbZVxkihnU4ozkl0ylLdfdgBXUdCPFEeO2l/cn91tf
    naFqCjfGvhGtglGyOuDPbmSg5ttJSGEvGw0VM28OvYSuugU2nbyQInHmfNiv9aGwbOcLH4
    On74nzUC3nPKqfDN/sMhYaGYO1MhljVDfGE2vC9FhLtaOGURgAAOil+k7jNMbJdmEX0NvH
    swNaHl/JaFLs6rjXZGOyd5xvwPmbfq1hTp5NWLUbQ12f+BXP5EvzTG4tMGeerrxcrufkjh
    EzwpMH60K5EW6Z37zOiO9WWgNGElXeReO7uYKlOLtTpSMyfzof0LBZaT33gmHu1A7UQtNY
    npzMWa+RFPD0Yae0NV8sWf7t87X19860EPPgf/BtLIW4Vsla8t/wiVOklLjsi1yFPg05B2
    P13+BfYZVFRbqLI4WVn7+IhSyz5k7yg8mJzNRGz+x/GOLEdoSNUNQCEsYylg
X-ME-Proxy: <xmx:_Szrav-b31d6zMJAwAENaJdU8AZEIB2CijIOzOdlc-_ugaDjKdk7Hw>
    <xmx:_SzrahYUifZzOGQwa65MAOu6uQsW36D4cuUMV9Bs5zReC8nLjx-3AQ>
    <xmx:_SzrauNjCv6ipufU8vee145tFV4L_LJ8ioWtu4UN3clsM2caO2UP1w>
    <xmx:_SzrapSz7raAMh0YiZbyG2yxTyALTmGivrf6UazVsdQ5EDkaFvVucg>
    <xmx:_Szrap-zRACVOvdl3tdSQLZ_LHA2ubYpNiblmBUTaBM0i1IvgdP3_fM6>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:02:52 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Harry Yoo <harry@kernel.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ilya Gladyshev <ilya.gladyshev@linux.dev>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kernel-team@meta.com
Subject: [RFC PATCH v2 15/18] mm/filemap: don't store f_ra.prev_pos for FMODE_RANDOM files
Date: Wed,  4 Nov 2026 13:01:11 +0000
Message-ID: <20261104130118.2507513-16-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104130118.2507513-1-kas@kernel.org>
References: <20261104130118.2507513-1-kas@kernel.org>
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

filemap_read() writes the end of every read to file->f_ra.prev_pos, in
the cache line that fdget() and fdput() write when threads share the
file table.

Applications that read a file at random offsets from many threads, such
as RocksDB, set POSIX_FADV_RANDOM on it.  Readahead then never reads
prev_pos: page_cache_sync_ra() forces the read first.

Skip the store for such files after a read that filemap_read_rcu() did
in full: without folio references, the file's line is what the threads
contend on.  Keep it on the slow path, which takes folio references:
skipping it there made reads slower in my testing.

filemap_read() compares the start of a read with prev_pos, to tell a
read that goes on in the same folio from another access to it.  On an
FMODE_RANDOM file it can now be stale; with many threads on one file it
was another thread's read already.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/filemap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 182ae7d5db56..5998de3d6697 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3078,8 +3078,13 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	if (fast_read) {
 		already_read += fast_read;
 		last_pos = iocb->ki_pos;
-		if (!iov_iter_count(iter))
-			goto out;
+		if (!iov_iter_count(iter)) {
+			file_accessed(filp);
+			/* Readahead of a random file ignores it: skip the shared store */
+			if (!(filp->f_mode & FMODE_RANDOM))
+				ra->prev_pos = last_pos;
+			return already_read;
+		}
 	}
 
 	do {
@@ -3161,7 +3166,6 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		}
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
-out:
 	file_accessed(filp);
 	ra->prev_pos = last_pos;
 	return already_read ? already_read : error;
-- 
2.54.0

