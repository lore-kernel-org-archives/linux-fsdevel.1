Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C9443C1D
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241184; cv=none; b=GTFfy7TJuLFmoYive3+fnBReR+NlVLojEr0zkwrlGU6puo5TYazt0IMbQrDYE9AwjUT/wpkxRxUJujUrdwDxuM7z7f8v9tZLGHi8tuC4rNtpRWYsBktKhK9trxEpeHuCKBHgI6fmlyKzxT/gLcmDH8XWWXYF/fLlNKhVlWFKxa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241184; c=relaxed/simple;
	bh=RYRoyEZy3AZX96/W22uGNOvKvksOSwlIn7uO1WdQA74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CON2SBnxTbbA9fg/G1w4EjhmXtui/YyVQj76iVoq/Tb+7d251GxbZP/CxpKH1pWRl71d6zwj0aYqtyP+IEdRP1mbT0BmVEi55FfGHS7u3Svzn4ZgL++m7/YlFrFfop3MLakm0aDmoIAqpQCCc7Pi5liHDC+rVpMpgrUyKd/BxMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWJgp0cD; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWJgp0cD"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887635e952so25635f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 02:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790241181; x=1790845981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3/GiZQj0CaseyrQZxOd/ioPb55nZ1v2BOlX+DpEu3BI=;
        b=mWJgp0cD0DM87D2738zgSOVYuR5hlg//Uu1mCt4DFc1sNCWyFPabhj8TSsKKcg+9f1
         Cn6RagoOVukVH8bJwQHzu3Zb7vpj4zNXSxWlcP5xUh+B7F+bQdvVi4c3CJ7LAlTIRcch
         vhpAEH9DvQETawOVRa0mhXxkAPUjQqR8s57Ix3z+Y/zp29yX6rm+4yod+sHu5k9l1AKE
         etGCuatNuKciF/FjDiLvPczKZ+Q9MI0M6+AhUdAYn9AVMTWqi1rjEYZs4KhO5JY1weKi
         AI1AapihHnre2QpaWYSd6n5ihPyGGlrt1sRR42XZSEbjFWZmOGyFRuUVqMpAXInq+9Td
         +wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790241181; x=1790845981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3/GiZQj0CaseyrQZxOd/ioPb55nZ1v2BOlX+DpEu3BI=;
        b=H7xTSsf1uq+Sksr7K7gpb/qiN51pLa63AdbbUG1JtYK36tZzqGRzOcx6Qp8yUzhiRv
         ErsuWSqCArezQWHlR+C5vwBxrD8nrFp+mh7u9VQKKB774a/jAo2MgI0MFUb0WGs239Qm
         /cXv3+Ix24X9hy+Q/F4P52PB2JE6TuJiHfVJn47hxJSzeaTGIaeslp2v4FtwRnyhuZ4N
         lWweKmyrPHTuH4AuF05hygWWYWvYmBQDTg1ap1O3aAv8zc6ff7Pu0L5aT2rzpHBAstAD
         UtqNO27twc5j+t0lufmTg5YbJAWo+Dmj6h6fNyyD86T4tgB+aaNBts+M4Sgo3rC24iSv
         uqCw==
X-Forwarded-Encrypted: i=1; AKwUvBwM96tAA+aob5e9oUBj7akCpt1KIoXMBzpxBMOp3fd7HVW2UzQTukhw+hSosrNbCRMSifsi8hWoycOhtWn4@vger.kernel.org
X-Gm-Message-State: AFuF++k9fMXLRGusTCBb2Swh5x/JrC3ein9zrUujuedgV8qi5EIt+a6t
	LRGg2eZkQ2MbTMn3r3igNpGHPQHkTJDqKcN2N3t70x69mYzy5JsCsIWT
X-Gm-Gg: AYBFou2cMGPlGnpN9NxXCC+hc1d6hGr/omqCvY9KawIPiODiKPV5Pj/ahtYL2CA7+e0
	8ghWF6ArDtDgEasCR4lZvYUY1rzuEp3F0/risWZDUXoINgQvajFoN/UWFAGYkAL0UtA2TnGS1zJ
	mRQDUtxoovRLXwNiKZ/ntw3jugpDApY0oopJXP6KQqoPY1O9gHo4gP1ePwpkdNiCH2+HuXvKBrf
	7N7Xo1bXbMLqcK2WzlFyMKL2JU1Btawv2wGd2500/E/OYhJgZSQPr9LTB9g5iuRX+sQFMkB5aXt
	LLr3rQGiFbZJdClz2e1w5pjtR+4egnuoKfn+pQ4HRA3poWxAewzs6m5c+5QFT80dncS1jF3zDZN
	6uQrDFTbKY2Tjev3sZSOPepzvC35cjIvUltrJ1M8Hblh2cbMYn8Rk9mUyOXJnifVE5DBBi9Ycfj
	mRjp1bqTMznwDJh6BhMl0YpaNDyE3oWtLuaBd2JI3uAQiPdnkBvQ3JefmNYiXUJ6CnbwV9tzCp5
	B3OIKMSyg+PeiLt6wSrlGA87X3jV48CnGW5ebU1TbF9HlG/zr7rdkEIE9qnZJN6w1eQoxHTf02F
	f0tl
X-Received: by 2002:a05:6000:41f5:b0:47f:9158:5924 with SMTP id ffacd0b85a97d-4887169cfd7mr3162682f8f.9.1790241180882;
        Thu, 24 Sep 2026 02:13:00 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848636asm12756677f8f.6.2026.09.24.02.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:13:00 -0700 (PDT)
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
Subject: [PATCH v2 3/4] iomap: don't lose a fiemap iteration error when emitting the last extent
Date: Thu, 24 Sep 2026 11:11:53 +0200
Message-ID: <20260924091203.198225-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924091203.198225-1-parri.andrea@gmail.com>
References: <20260924091203.198225-1-parri.andrea@gmail.com>
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

