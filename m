Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7727235BDC7
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792045168; cv=none; b=oF/ulvKKVP52V5/LGKX4Wv6j88bBvjV6l5aHOB4+8X5wqnQMRUyANOGb9S45iwab6XX4yoGJGjnTzxZuKgOx/uZ0vMCcg+dxlu4saatGeELapIyK0xjlvoZ7rIjfJ7Nik3hdF+rjIyREPK09jpg83QgNMeUxMkJBaT+8zAQabVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792045168; c=relaxed/simple;
	bh=SnTqnSHnJf1SyEgRppnLJtdvwZ/K9QpTpMoFZTST/So=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cnrYqTPGrID3kvo2qse6+ecIeuYl775HszLnI8k5sYtReipIWmxNgDGP87/SJo6y5VHrATciPd6LmldN99LXo6dLPpLICgsylq1bekAH3pYLKrURSmpuXUz8qK3XymZgGN7lUlQf+V8wj5OeDzuOqzHHvzN4i56QpElT7l5Qcl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMsEg9vs; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMsEg9vs"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so4288522a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 23:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792045164; x=1792649964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LKqK4HrH78W1MTYoSkDNokUsDBo14132TDZJAUlwXh8=;
        b=eMsEg9vsgz4JpZA/dQGmcIu7cuJhRpTt9bfXp/QLtE6wYb3AwFvj5xjTWMPOs90pPc
         jE6uZFmpKp104w+kZDOf7V5ZRLT2gpxeYShesAyn4HMOtY1iyWj3X60jla8tnX/Zy+9A
         1UR4iR8QOfZAmT6e5EXxja16F8HF8rUeJ6/M4OOztB9SNkCXc3CMVGph4MpXZwJ10v1j
         SOa8zryzSZrFcdBgxRsIpOyN9GtV/KNfzEne6ZnZSSJlN0TabAn+Q5nC+ExwBe33LoKW
         dpKAXHFm5eyP0BZv0aA2kmpJOn/vkmq2fvo7ikaX72ed9z4THTsBc2YHQwE4B2y1JeYm
         UhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792045164; x=1792649964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LKqK4HrH78W1MTYoSkDNokUsDBo14132TDZJAUlwXh8=;
        b=fj3jsAt1GE02lu3U7DktW+5N4J86NPR3/RDhYYxT1zQG9QDjfaDF9p+SpgJuYL30FD
         tZycMbQ23G6Nk0PMOgi8sm60G59vGlzy+VZYo6h9fk/u174TbwHoA2YmtolVXkxVql82
         olrvEgvu5jCoxFOuXzvVe7fq5KR7KJZFXowSOtt+4CxjxTWDwNlvAgZKx2gRuEm/NRBj
         QMMsxff6pIIrINWlp5HebgxWC468k/A87IYruADmbAV79fG4QMBu/TlNeYA4HK+Z7aWu
         41sLqYF0He2qTZ13delyeEjhir57w1JVOo+JYibvNDP3h8QEsvhM1v6C5ghr+f2Sp/9W
         R1Sg==
X-Forwarded-Encrypted: i=1; AKwUvBzL6kl0Oeb2RU33MTi2QLszOoL4F+FMElTiS8qvIPyAWoGHZWn7Adfkd2S8MVXEexu+B9WosRAHML5M2IvD@vger.kernel.org
X-Gm-Message-State: AFq9FYIQ5b7IRBTQumCSEKKvgUV6ICiwyMdH6NTLOsHc2Bvjei03XM9m
	j1M3SLxOGqZKMClm5UdS91vp3eXjBoOca8hALYfsh4aYD8yHGSlAdHK4
X-Gm-Gg: AYBFou1eQWwlMdsrAZTMprpTr1uLM9AikxQH6Zp5hQMsH5vO7oil4BGYeeHvHSaolnK
	A58GUmMS7X1FlVhnPSFKAD7HGLIqXia5KgbzV9Ll4CV2Pj2WGsLmVNMepM+s7Pla3U3dmk1WbXT
	djMSLRnz+Ygchps1vhVre+lfxrfUCSGMd0a8y9+qhEiENgfjJhDOp810Md4JPMeppH08N+rT89S
	zu4sNJopKbAQWppBsmoJAQFAXRdf+mji+Dmr2Tj4JG3F47EginNwD1uJgHZ8DtwCN2BLlp9D0xV
	X8dnw8l3MBV0Htz4KQUrZLR0mfjlGdTu9qcTfF6Rj2aOjFTDqWO5kjidcfUcdxIr1Y3jXwr5/em
	D/C6Hvo92mlE4X12XwrsEGyTzG1xOyHQXMDeRI8U0vMdHwYB2MFmbbeiXVw6VgLFCMUChZCNrLD
	uBsYhMRKAqXTdgeQlFR2GXQp3SIGlL5wC/vC2EAh1Mt3jRMtMyRFDLLYR9Nzt/wCPXruzmASg+Z
	QYDkcBax8FJ
X-Received: by 2002:a17:90b:4b:b0:3a7:96d:feaf with SMTP id 98e67ed59e1d1-3ab3a9a0c59mr9385893a91.16.1792045163419;
        Wed, 14 Oct 2026 23:19:23 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9461d71esm2669111a91.7.2026.10.14.23.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:19:22 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@kernel.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH v2] iov_iter: validate extracted segment for bvec alignment
Date: Thu, 15 Oct 2026 15:19:07 +0900
Message-ID: <20261015061907.2713943-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iov_iter_extract_bvecs() validates iter_iov_addr() and iter_iov_len()
before iov_iter_extract_pages() selects the first nonempty segment and
limits it by iter->count.  The checks can therefore cover a different range
after a leading empty segment or iov_iter_truncate().

An unprivileged O_DIRECT preadv() reproduced the empty-segment case: an
aligned empty segment followed by a misaligned one completed 4096 bytes
instead of returning -EINVAL.  A truncated iterator has the same mismatch
when its full segment length is aligned but its remaining count is not.

Bound the normal fast-path length by iter->count.  Keep
first_iovec_segment() for leading empty segments so validation covers the
remaining portion of the segment available for extraction.

Closes: https://lore.kernel.org/r/20261012065520.1089147-1-4ncienth@gmail.com
Fixes: 14b007e17881 ("block: validate user space vectors during extraction")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v2:
- Bound the normal fast-path length by iter->count while retaining
  first_iovec_segment() for leading empty segments.
- Cover the truncated-iterator case raised by Andrew Morton and Sashiko.

v1: https://lore.kernel.org/r/20261012065520.1089147-1-4ncienth@gmail.com

 lib/iov_iter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 2072c04e99d052..d21082fb251bf7 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1022,7 +1022,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	return maxsize;
 }
 
-/* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
+/* must be used on a non-empty ITER_UBUF, ITER_IOVEC or ITER_KVEC */
 static unsigned long first_iovec_segment(const struct iov_iter *i, size_t *size)
 {
 	size_t skip;
@@ -1938,8 +1938,13 @@ ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
 		   iter_is_iovec(iter) ||
 		   iov_iter_is_kvec(iter))) {
 		unsigned long start = (unsigned long)iter_iov_addr(iter);
+		size_t seg_size = min(iter_iov_len(iter), iter->count);
 
-		if ((start | iter_iov_len(iter)) & mem_align_mask)
+		if (unlikely(!seg_size && iter->count)) {
+			seg_size = iter->count;
+			start = first_iovec_segment(iter, &seg_size);
+		}
+		if ((start | seg_size) & mem_align_mask)
 			return -EINVAL;
 	} else if (iov_iter_alignment(iter) & mem_align_mask) {
 		return -EINVAL;

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0

