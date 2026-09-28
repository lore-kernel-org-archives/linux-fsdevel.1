Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8AA48EC65
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585316; cv=none; b=UBjQSc6UsB/qKKkxNoH/yVAqMoh6gUms6kDqTk4BijBjli3bEjrOuZpUfpFRA7w2zr2K2cJXn1CMdQc3LCBk3slxpgtwcNR+DiOZpejMssQcKAk8sObr5Ozwrxh8NfNUhQNEDQ/cWjFxsVXdCUdyvgKkevvdKWqyB0ajwGTc+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585316; c=relaxed/simple;
	bh=RYRoyEZy3AZX96/W22uGNOvKvksOSwlIn7uO1WdQA74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jW4DO/vEJv9Ixlm5GGSabzBGy8nxx6rhFCb60A4Q64u4ySpbDotJvWw8ArzfACuCKne0QG1HPgrewa47J6itgj7FygXy9vqUINUHH66D5S2q0yT3rpXEYuMGrSsfQqNMbBniFj1XHYJzffa49jKvunO7WCVWY++igNyTDgGuPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPoXHJLF; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPoXHJLF"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so15113795e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790585312; x=1791190112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3/GiZQj0CaseyrQZxOd/ioPb55nZ1v2BOlX+DpEu3BI=;
        b=bPoXHJLF+XF7W3GG1m/hUTsZ23MtnLwud/DKjpYqb49jXKOdyE4iLwWWvMiZoXaS6K
         +jC8sz/94dqDUA9Kw9qCGY/xJ6ByGOaWA2hHR7cdybx3iJ14FvGJW0g9A6H2/dc0zsTe
         +MzF9NDzM+/RXhAqP+3x2LktjPAh80pNuoIUk2cQiHjia7gufCy+ygXl40O6asVwpiwF
         jOEHJ/UxnrygMYcQ+1rT/UCg3uJ4GGw0WdUfs7NITbZ0PXJSr/eDpvbN30SyfhfLi5ik
         dhL8AENaQCXI0ohPIEBWM1BtwPzeAl6+YcJEbmKI41YSjtrx1MWUDOctwhywYpGXuh1S
         BmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790585312; x=1791190112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3/GiZQj0CaseyrQZxOd/ioPb55nZ1v2BOlX+DpEu3BI=;
        b=puJo1Ei4g9PmQz9ADxheBRuYCDqRhApziIXATlismWLcvUF1z5WPCY76ZjjuSiHJPS
         Mst40KJ4p48hDzxu9pG9Q8m7L4u0UI17QKcyP9tG+RBoz/k8/lHlQAbwe2u0NE1B7vlJ
         uL8+USCLZVTxAI+EhKzPlUTjNkx3MvcJbqxHobHdC7jnqTF7lpvJFIy84gVh/WXkUiNx
         stROY3ewReBm1ps37mE1BTMMrGyGFdf6YKAz5lQMaM3C4/f8Ge7wBZ8WSW+nYqwF2RZI
         +JOTnW4U9bfSVcCnjuLd26uBXp+TrvZpgv8Ev960Om0pJbZ53q65/cZvtTWxXCYD753a
         dV2g==
X-Forwarded-Encrypted: i=1; AKwUvByjDfoqftSr5F+d45EHuqQ3OJketmJ1EqFbGdmKnhkpHYKd5jevTn8tKxg8NtU9ql3G3wH7GbLcr/YPpwUt@vger.kernel.org
X-Gm-Message-State: AFuF++ncY6IGZE1LHCJVa08ZylnykVypQNTYtvKDKl6xeJfokdSPpxj4
	3/xw7214K6/sRm4/osMw1Hi06BtGukBheU7NgX6zBACZu13CstCPOnJk
X-Gm-Gg: AYBFou1WF+eipzastkqXaJBLaDu6SW+dzJ5ZJeC8+naSYIBa/u8WrJ4brWnTKmysict
	nvghzglokv3HNMjyrNVXEUJN87vBHpqkV4dOvDwvpuP25hgeuVbYtwtbrupwYAaQbSlkEM5ZD86
	zTymauXAWeqvIycYbf5FV+PIGLe+a8662QfqE9GictLIhEjqqrgR9WBCJJBmFtUkKl1CcKMFSeK
	yWOemSgcznOEXUQ17Mg4fGX53ldGPYiDZ/ca/OkUYM4j4pyiaRZ5lzj5D9ZJVURRLDcGU+bj0n3
	R/pVGSa7bpSQ5j+OGJ33GRkihVPUyuWXN3GO0Yvzx6WbK0o71x62uobGBySfsJTQjG7UK4cmyNT
	t3jYZR73VJBwJh35DmwJQSmAKkA/j0I8JFjpQO0oSDdpp3JiOTaW7zXXwqvLZABL3DJB4ySL2ez
	2cF3TNKZWyx0xozpq1WvFVz5MdLShWbfqrEEyGKuY5GNcIk4I08BLslaryeAfW+ePb0m9rYTET3
	EDNcRy+pJmkZnVDQPzdPXVXw3IlfhxfIeBliqPLwVvbjG85qyqof0q60be/KWNCqh3WGuoz9qol
	vxxu
X-Received: by 2002:a05:600c:4f47:b0:49f:c199:e1e2 with SMTP id 5b1f17b1804b1-49ff06ed9c1mr189367295e9.28.1790585312467;
        Mon, 28 Sep 2026 01:48:32 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017652d1sm182584705e9.5.2026.09.28.01.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:48:32 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 3/4] iomap: don't lose a fiemap iteration error when emitting the last extent
Date: Mon, 28 Sep 2026 10:48:08 +0200
Message-ID: <250226e33b3b23c6b1714a45dc3c465c2a45cdc0.1790342457.git.parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790342457.git.parri.andrea@gmail.com>
References: <cover.1790342457.git.parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iomap_fiemap() emits extents one behind: iomap_fiemap_iter() flushes the
previous extent and remembers the current one, and the remembered extent
is written with FIEMAP_EXTENT_LAST after the iteration loop.

That final flush overwrites ret, so when ->iomap_begin() fails partway
through the iteration the error is replaced by the result of
iomap_to_fiemap() (zero on success) and iomap_fiemap() returns success
with a truncated extent list whose last entry is wrongly marked as the
last extent in the file.  The pre-iomap_iter code returned the error
from inside the loop, before flushing the pending extent.

Check for the iteration error before flushing the pending extent, so
that real errors are propagated and only a successful iteration emits
the final FIEMAP_EXTENT_LAST extent.  -ENOENT (no mapping) is still not
an error, and the pending extent is still emitted in that case.

Fixes: 7892386d3571 ("iomap: switch iomap_fiemap to use iomap_iter")
Cc: <stable@vger.kernel.org> # v5.15
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 fs/iomap/fiemap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index d11dadff82865..54b824b7edb5c 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -76,15 +76,15 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_fiemap_iter(&iter, fi, &prev);
 
+	/* inode with no (attribute) mapping will give ENOENT */
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
 	if (prev.type != IOMAP_HOLE) {
 		ret = iomap_to_fiemap(fi, &prev, FIEMAP_EXTENT_LAST);
 		if (ret < 0)
 			return ret;
 	}
-
-	/* inode with no (attribute) mapping will give ENOENT */
-	if (ret < 0 && ret != -ENOENT)
-		return ret;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iomap_fiemap);
-- 
2.53.0

