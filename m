Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793076188;
	b=XkTm8jiH4R4Y2qHFohxLd4RefkMBAO4hrQXKIp+FCy1lQ+pukzv5JFQ/LLAUaYflsrw8
	 05xyFQo6IRp0swDiGFoyOL7ERHHhdnE0OYN4bIAiG/TCq26BctuaXDLri41A9+9MXsQ8W
	 S7Wgc5tRzYuv14i/ZH+ntIk98VTjNZvrEEWKzR19L2Y80v57jCauNQjT8Uowu/mGyciWW
	 WAv8CzrxyHVlb1htxJ6eA5WXfNXzAf3Vb1vjMtgFA0GMuR+YPJuJKhHr/qo325WLdhFOr
	 vgO7+LrvA0OzhszNncMZg0tOVEx1F3MgY3T1q9f7aR2sfFK0A0ySmbhzvuiNq1ariwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793076188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l493/u62eOFn/ZLxJ8nu4m5zc4vn7EZElFZnKX4PUGE=;
	b=rRe9JL1cEdRT6uW5zGdF2IwVw7CzGUT6wrGjp1CGPfkNDtuEVJTlI9if7tfLUh9WUwDv
	 p50h38CGq5MZtsRT9y3+qg8I9tQ5aT3HbkrGwQGBkiu6sIp6haBptVq0ZGp9+peAUjd7K
	 plc9q1WEAHdMQS/nmE5LrNGqNkej15dERP2Lno2ervc8YFfGEsToGtc300ndfeTGEcaCw
	 vLlJ+Id/lVv88NYXMECYoaWYHhtlB2vfyefVgG8Jb16EgIb408s5rTPqUXrJcagQTO60i
	 4NNeSBUHd0SnjkLVYyU+Z5hAvrD8rwlnBgSqCT0oefiDf5uGIJ0hHrVuB9xsxcHwg3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JeHGCwrF;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF43606A31A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 04:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DF43606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JeHGCwrF
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so2222293eec.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 21:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793076187; x=1793680987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l493/u62eOFn/ZLxJ8nu4m5zc4vn7EZElFZnKX4PUGE=;
        b=JeHGCwrF+fP/PQPoKowlvInB8EI4BT5PYNSRTpXw3tQu3GOsjanJivxZABz3p++Xgy
         ccw5B/LxT/BKW8ngD/AjqXkUFsW82yNgTjw9b2oKmSTQpbVEFDtuBoT5NFOyzrYdZR+j
         JEWNW8XFAoh+jDX1BAm3/vFeneUF72zmmvT2/YX3EONJTJtDidPLeXtrUuQJl8dobOvh
         j/wWBb6see7HEUiCXtZU5J3Rx+uMPQoHn5imgoDCuDjs19HcGH5tMt8dOGmK2PN5vVlk
         P9c5kNaw2A5un93/FDYPgHFKfcdPyH8N6onmLrQBwQDs9s/SzQaAuE4qLtogg3QvCm+5
         Uu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793076187; x=1793680987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l493/u62eOFn/ZLxJ8nu4m5zc4vn7EZElFZnKX4PUGE=;
        b=dlbyV0tELe8e97pHafQs7FyCELmZ7FRYCc/k0Ene90/gQF3my9+LizgcqgxUIMNjUc
         n5Tu417XuR84PSAhi3Yx2Po/tuTKS7ZtBRgp6dgrBxzA/Z5i3mrnS4HeUKvSgTYaCm1r
         mDnX8ejOZhK3Phz92zvrYhDPgWO/ScmZ6EkTls4k7X2vbWWCtXhd/DkbqRnHoiijhrGS
         fMBAf+LIzgOa/L1Oxi796afG9zmbANhae3rALJtaEcpYRJAhU/4rGAsQ4qm9pZ+xEukc
         zPfDYBe9tfbqWZzRcBRgeCFdaAqzccv4jo/P1ySGXw5u6GVqA7YUI+pW8nUaXvOB9+rA
         8yrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwg1golikSlHQC8ssVjQ49/WNrddC2+lO2oPaKXxHCcyGHwCR7KEMBvctbixyAo9f5I3OQ4AD2NF+NTc5kj@vger.kernel.org
X-Gm-Message-State: AFq9FYJn2ZrPVmDG2vY4Xu9LIOvGy+o+RKzXePcQD/ItpSRuJJ4TjZ3a
	x9eHmxV0ILkZIwNFNVq2BuxZL/DCVVbNFIvFItrpE6/X6HZ4D0/DRdyx
X-Gm-Gg: AYBFou22VtSFDjE3jL+s/QDzVP9QyeoM8t58ATP8/dKnUygkmFJUrp10jee3WDCxjJZ
	20sBne1H1VpoiwH5La2J10MJEofndexOy6gqAbbFH/uW5/bBuC/25r09Qm8HpIISRoNlqGf2AWr
	wAZt9d7BsV8wIvpEcotRgZeyKSztfpHeiRVnFIz84OB2/0OBZ16qqorUAaZFBbQSOehKIefrt3q
	4eJr60mZtaCrxVYf+v/kG5s0bM5V16vFR2J7ce/EknYZg8WOw6j65HKNxvN6qHQsuViFUWJ97Fc
	AkCYlyCs4PG8Nn2O4jaNoPTKAccw/e4QOvTs88BtP3fOVPWhnpiLTabsBYgNx0iZRmQkpguIJfa
	tZbhtg3AdViI+HnltiMk1JY2SBiaK6cvk4u5lup6GnORhcVkliMlmAK9/Rc1427HQD+8818PTyf
	nSwoRVoXRBOiIhIdQQPzIf3Why+SJmyFu620GN+a27npypMOmECZqfGjviezpp04cbxTiK/VIaL
	rDUioOlSUl4xOJlaB2pL2I//7C+1+Matl1k39D+qFNUqwVNq+3qOPa3YCffwTyGPwwwgZKh3Y0s
	7VIE4jU=
X-Received: by 2002:a05:693c:408b:b0:35c:ba31:6fef with SMTP id 5a478bee46e88-369e86749a5mr15571826eec.36.1793076187002;
        Mon, 26 Oct 2026 21:43:07 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm55884722eec.23.2026.10.26.21.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:43:06 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] fs: allow sendfile EOF at the file size limit
Date: Tue, 27 Oct 2026 04:42:57 +0000
Message-ID: <20261027044257.90408-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

do_sendfile() returns EOVERFLOW when a positive-count request starts
at the effective file size limit. If the input file ends exactly at
that limit, this rejects the final EOF probe even though no bytes
remain to be copied.

For example, Python 3.12 shutil.copyfile() copies all 4294967295 bytes
of a maximum-size FAT32 file to ext4, then raises EOVERFLOW on its
next sendfile() call instead of completing successfully.

Allow the boundary position when it matches the input file size. The
existing clamp then reduces count to zero and the remaining validation
is retained. Continue to reject positions beyond the limit and boundary
positions with input data still remaining.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/read_write.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 4da846a2bf17..a25e23c6a327 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1347,7 +1347,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		max = min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);
 
 	if (unlikely(pos + count > max)) {
-		if (pos >= max)
+		if (pos > max ||
+		    (pos == max && pos != i_size_read(in_inode)))
 			return -EOVERFLOW;
 		count = max - pos;
 	}
-- 
2.43.0

