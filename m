Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793855659;
	b=aRifJPjDo/e9L8HWuwBmxuTsQ7q7N6Hz/M7kIh7UPmQG4+7kXASzuSV73LF0axhoFmLz
	 R2WQ+TXhVbY1MgreFqXyeIckfTXtIgXq8fayFAR1m2x+9/2IB10OZhnaMHxrK2aoyjUfF
	 3sMVH+3znhxXzvKJ6a+2pDhiZ4cl0wE3eDzqM3Precv/fhLZlZJ/D8nURZBXxyJu0ij2J
	 iu9A2DWpTt8wNLqHZMOLje+KhPZJAmlO7Kx1H+BFbjrPpwLqFwRn/U8ugtlqWacHbevtC
	 QcPOXdyTxcwy+jFk+ua3OhGvLxK2ijamxYpu6JQFisdM5oTleRLA/umDXWO8XScB0dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l1eSX+6egLtOu1lrQcTgUdiF++U+c2v1MrLX8sa3W1M=;
	b=Eyiv0zYIumqqCh7O+TSCt+N6LQ34uiyr4rV27JusT+ca0yxwEsDLL3pTaRykxggPs7jO
	 LIjHKFw2cXhqwOigyM8cJhVCv7Cyrpq8rjrGDxvPfyOPGRoMKwANQgeroqQErBW3HE+lZ
	 fc1iqm9QbMYVGsy58fHnRRIE07gQfMG6nIo1kRM0MHmIgX9kEyt6fCltNIZazg8IjvLlj
	 XiVh07uEWwiyHrH7NcxQhCXqdoqIkj+wH5T9YgTghb5J6LNC0dYcdDj5brZFZ/0OkrWck
	 k/2PLSQnGEepm98qmNe8STSlHMOpHALyD6X/3WD3Wd0qVgvA7GtQMkhB18fn5/1vqEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+unyceh;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3A606A333
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 05:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2C3A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+unyceh
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36d73027aedso565490eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 21:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793855658; x=1794460458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l1eSX+6egLtOu1lrQcTgUdiF++U+c2v1MrLX8sa3W1M=;
        b=o+unycehWeryTcRSxGc+h2Dc3fEnOliQuiQCdnsHRKUgGjU1AG+VdIjBDc5OJ68/MX
         Fpe/yCBi7FY+2rtIwDbdjpnvg/yefTvvXMgaRYbde75/NERLRS3xGmbER4QvbM/B5oY2
         1+9E0MDBPf48Xeld8f53td+67l3AHv/uaG3r3xbs2idFxelZ9CXTtNwyVtXG70aiK5y/
         ZW8T70W06hrYtvnuE/2WPgATmwaDKoafZjd1AT5DtdEmhZr80Nhf+dct+uOAQLwSkb8A
         g+ujz4/HpokjJTelStEbPwQ2duF7qjhwnyiUs2anNDhl3GIxwMkWB/Fgn894ykyOMDsR
         7Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793855658; x=1794460458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l1eSX+6egLtOu1lrQcTgUdiF++U+c2v1MrLX8sa3W1M=;
        b=cg490JAsY2ZmX9JHx9l5xYaCDtWNLVIurg/v8hQYaoQzULBV0KNOO83LdFIayhvXxA
         oM+l5Ek1zpEtYK8IQzgV/Y/gClQOrBGgCsaro5ILfGuGhx1fkaium/9aVFOV/13E3cdf
         MkIRWpeh3qQMcq4BA17LxiOB3y+bbqXw/ygEaZJt/l59bGWxVNhjfPATyFAT56fyjYOu
         FuZ2n1zAUCsxuHoAauO/P+cJuq2ntjpzbV6Zd6p4j3X48Gt5nH3CmxK6tstuv/SxVXYN
         37MJwQpFjDO4DjdTPIsUG2NRRF1Cks3D+P3hjyuBjA+OCgVrcTBRX7tFAh9QNJTzOVlH
         yvXw==
X-Forwarded-Encrypted: i=1; AKwUvBzqdGPE9NQQjWbrvkFvN3zTXqB2YWIOSzOoWqCGgjQgSMPyhohnQlr7gpa3r0a3I9oOe6R/FHQCZ+l4h1Ho@vger.kernel.org
X-Gm-Message-State: APuU4Z/AthKCXqthtjskBXwvWSbob/Ufc26U/J4F4yBVHvgAzn46J64v
	bBX0dJ6ex2Yk0U1d/CgXGu2Vij1vvEYX2SENSDRi8Donk+aoZn+zvtSg
X-Gm-Gg: AYBFou3W5Md716huw5MkvTGFTjc7aadAgFic5YNIrRO/Yx4Zx4JIW/EiQWXFhhTer4+
	YXmyqgYzU9lIq9I3LMhWhG01PWtPd4CzI6g9yAHTyiICi4BGHPuxSg6l6ezQob89whshPbyENFT
	BhhTFliQkYEYIRhaMTJcSreQFD05im0V7+RO/hVbj8L3c99LaoAZoO3qFmwU7MQcLrzaHwkf82q
	2FWXmKVSHopWahX5kEIXHVsyf/I+TzUHy8CVA+F9h2oAcYn+171Nwn+UHaF+8mS0r00hJc/Jo6Z
	zQGl/WqBrfLp4ofjhkunIrvor05QkqY/bO0KrS+HMLfisMOhGnKGUPQlyu2aYNaUOQ8OpnV1Vgy
	baNe3BfBOXN+QyEtnC/N+nM+QFz+DjoLRCM8BT5XiUHxzay+Xuoqbtz9aAMvqsUR1UVsT5OE1XG
	Y2sEmHDzx1i8uHPYiZWe0CMLyQsElLz1e6nKqYDVVoUiKaRhKxNznTuiYvY8kPTzGOfW79Atyp4
	VF2yTqEBq18GWv0XPDJqgWNHDHkI4HcWmcG1fyIQDpaYaznEaAIsjWkG54yHMnUEVAFAYp45/59
	r8FZJVgJYX50GFDyfY+SW162BhCvlpJVclXUtg7OdElqj8NeuC911OlOEEQ2+IpDfPstwqkK1vy
	CrQ1U5fSHuslRn+1LR5uPtmLfb+KiwmrsbiwUfw==
X-Received: by 2002:a05:693c:6087:b0:369:f420:8679 with SMTP id 5a478bee46e88-36a42440304mr29748490eec.38.1793855657614;
        Wed, 04 Nov 2026 21:14:17 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36db94376b1sm6079160eec.10.2026.11.04.21.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:14:17 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaharkes@cs.cmu.edu
Cc: coda@cs.cmu.edu,
	codalist@coda.cs.cmu.edu,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2] coda: honor the append state of each write
Date: Thu,  5 Nov 2026 05:14:06 +0000
Message-ID: <20261105051406.52442-1-dennylin0707@gmail.com>
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

coda_open() adds O_APPEND to the container file's f_flags after it has
been opened, without updating its cached f_iocb_flags. An O_APPEND write
can therefore overwrite existing data instead of appending. For example,
writing "Z" to a file containing "abc" produces "Zbc" rather than "abcZ".

Pass RWF_APPEND or RWF_NOAPPEND to vfs_iter_write() according to the
incoming IOCB_APPEND state. This also honors changes made with F_SETFL
and per-write append overrides instead of relying on the container's
open-time flags.

Fixes: 164f4064ca81 ("keep iocb_flags() result cached in struct file")
Cc: stable@vger.kernel.org # 6.9+
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Keep cfi->cfi_container as the vfs_iter_write() argument.

 fs/coda/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/coda/file.c b/fs/coda/file.c
index 6ca8bfcb58f2..c9fba41f7cea 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -71,6 +71,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *host_file = cfi->cfi_container;
 	loff_t ki_pos = iocb->ki_pos;
 	size_t count = iov_iter_count(to);
+	rwf_t flags = (iocb->ki_flags & IOCB_APPEND) ? RWF_APPEND : RWF_NOAPPEND;
 	ssize_t ret;
 
 	ret = venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
@@ -80,7 +81,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 		goto finish_write;
 
 	inode_lock(coda_inode);
-	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
+	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, flags);
 	coda_inode->i_size = file_inode(host_file)->i_size;
 	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
 	inode_set_mtime_to_ts(coda_inode, inode_set_ctime_current(coda_inode));

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

