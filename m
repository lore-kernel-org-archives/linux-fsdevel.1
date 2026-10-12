Received: from mail-dy2-f2.google.com (mail-dy2-f2.google.com [74.125.229.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E52497B8B
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816572; cv=none; b=Safm7HVi+BILS4F1c9I4g5ja3bwKviz9+jxOEDWhQq47ktaWQ4DGNI28+HB4wOlKbjGkBeI8aC0i+rEVBftTmXuB91RT23DkHoeoc1aGCTrZrpaG8sCwawy0nNJEkDXMTNvvbSO5ex/mysdy67XOByMuOSBvo23UUf2SyRQUkq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816572; c=relaxed/simple;
	bh=c16ZXWH+GRMU9Gv5D5TMERR/RKlvixHWFMYKRCEvbV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MmQuVSbAti40dDNGQxnOrLK37bzu63sSVN+noy2Q6vwbaof1o+SjmASSazJkGavh/DddbnuA/dTamJ2htuZ0OfyBpXw+GivLfH9GRzb1gb1QMtRbwPRHiG9P3UgAA/adq0kQTspo6I7u3gDa6QehAKUWohBAocGQQhqHI4TG06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjUNRMFE; arc=none smtp.client-ip=74.125.229.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjUNRMFE"
Received: by mail-dy2-f2.google.com with SMTP id 5a478bee46e88-327b1d5824fso2226306eec.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816570; x=1792421370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SNefojtvKaPsWksx1KlDETs9fKwCel6Xh/eUYbsILEo=;
        b=FjUNRMFEC+pDGGGu8b63dqh18hWiqu5fMctk3Z2IyZ2Nr6Ao42/QBQh0xUvFzV5Msm
         FAMZKkpD5pzEYT6ogVyvGuejLAGGRmirA0pCff0245ea1fwpAE+IzX0fnskhqqqwJEHq
         HuIOb2QdL9auLOjXYfT/Guhy63chO03CcQ2mdOZTCNHNEUr2NGwQJi4QmJCJIzZEsS0v
         5eFqEeOpkoPfdUABtGvHvRtqOTU4MKL/H8Q23mUL7ukiZgBJWGdDNsXAZHvzDI0ILMNU
         i394zR2QxRvmAqFkj4nWLafHfJ96uuKLAcMh0Ct18V977s+dTl/VdKjIdGeCjazkCRwN
         f+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816570; x=1792421370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNefojtvKaPsWksx1KlDETs9fKwCel6Xh/eUYbsILEo=;
        b=p+oSRRStVGFSWz1Eexcwi6PYLs0QXoKNqI/iHImAMlJ1SBz3C9WyrrtSsQ4Fy36m8j
         wkdLlbewmyMliHP3idBx0cCRLlYKDqrJDYL1PrHME4mxukjHofUxdKIHF9U8GEQ3sSXo
         Xa0tct2FdgScv34qbqMkICbFC13B76MuBkizBfWwTFT+e3OUnV7DUmpJNsL1rK23NXg/
         027A2591JHs3meRNk314ykdfl0JenZnq+sTjzerJSdY5Hsf4nNiD4yoMOidWy7EM/DGR
         k44W7oWS2KpzaIBzIloeufF3pQLUfoJisqrW5Pu2yCRNdJN0HqephQeRv4xaxOnq5Cr6
         HR9w==
X-Forwarded-Encrypted: i=1; AKwUvBxGtE7nFdXjYGYC0iEW4do57cfzAH1fgTxYmJ0sQ8id0y4ivruekCIfyVinmzp2WRRkmKReHKXZjsWl7eLv@vger.kernel.org
X-Gm-Message-State: AFq9FYKnwBDPmA5Fnbmu3reJWvosODesG5STh2fSlQ9YtV657D2p2D1Z
	iVz3MrHzxRWOXjt5y+qCOYbJOkJidr5Lb0u/erWYpb2sTmjXNaCx7tCHegh/lPu+jv+XNSEj
X-Gm-Gg: AYBFou0XPk8KKfH+92bUtImYWGx0Hav3aHPnAJJb9eoRI8YgpkjmeVczwbG5/rWOWig
	u3D7jFTkPFWopnVgycrqIdOcM61I978a6cGWHAkHW+zulT9Qp6rE8Uzs6GpC3unu0p7YMTBq/yL
	b6U7GWu2X1q8hlNYWw3z41Jmqj7ldPxff3N5H6Dhz2W4i/pQf17xY8ivxjpQvlwqmEJge1CBUT+
	dBBRFqNk495BOetI6z4srqo+i9oB0a+BqpHzN2xjNB811/LzNZOLCwtAbjtkJmbRBoKIuYw9wUT
	rH0uIWFzBhuuy7Wh8jmVJxCBxixE3nL+NDvK7C5jw+a3mUyy/jgUjgLpUA15OrK9vrn7d7KaKfW
	RQ3FseXMhiADQ0PPHLCxgQrxdwMwDChx1wVzXcPd3SOliEOsW1ZZuRFT+wvc+LPWkwuBs/a7AHO
	TmwjUVx+Zxj3xJWaADL44i2WX1n9RMCkr26bUg+HjT3UYsRax51ApAmlgW9M7T9O759lL4/ayyi
	VrIsF6tVj8IT3knbv556Gvc2EoK0sVnNJU+2eUo/NUjfqmSJ+OziHEp52DGwDdoU/Engg==
X-Received: by 2002:a05:7300:a50a:b0:33b:f5b7:f494 with SMTP id 5a478bee46e88-3537df8cf05mr20301538eec.13.1791816569788;
        Mon, 12 Oct 2026 07:49:29 -0700 (PDT)
Received: from localhost (ec2-18-143-158-86.ap-southeast-1.compute.amazonaws.com. [18.143.158.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm11272773eec.11.2026.10.12.07.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:49:29 -0700 (PDT)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEM DIRECT ACCESS (DAX)),
	nvdimm@lists.linux.dev (open list:FILESYSTEM DIRECT ACCESS (DAX))
Subject: [PATCH v2] dax: fix wrong error code returned from dax_dedupe_file_range_compare()
Date: Mon, 12 Oct 2026 22:49:24 +0800
Message-Id: <20261012144925.6728-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyun Gao <jianyungao89@gmail.com>

When dax_range_compare_iter() returns a negative error code (e.g. -EIO),
dax_dedupe_file_range_compare() incorrectly returns 'ret' which holds the
positive return value from iomap_iter() indicating more iterations remain.
This positive value leaks to the caller, where vfs_dedupe_file_range()
interprets it as success (bytes_deduped = len), causing userspace to
incorrectly believe deduplication completed.

Return 'status' instead to propagate the actual error code.

Fixes: 39eb05112987 ("dax: advance the iomap_iter on dedupe range")
Cc: stable@vger.kernel.org
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---

Changes in v2:
- Add Fixes tag and Cc stable
- Add Reviewed-by tag from Jan Kara

v1: Link: https://lore.kernel.org/lkml/20261010021010.19575-1-jianyungao89@gmail.com/

 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6ba50142eeb2..1f6a4fbb97bd 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -2261,7 +2261,7 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		status = dax_range_compare_iter(&src_iter, &dst_iter,
 				min(src_iter.len, dst_iter.len), same);
 		if (status < 0)
-			return ret;
+			return status;
 		src_iter.status = dst_iter.status = status;
 	}
 	return ret;
-- 
2.34.1

