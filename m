Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D96D3CF68E
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074873; cv=none; b=Yw4aCR9qse6G2l3hZgZMTF58Zc1UH+0OaQMPU4TQrJwAzooZDuomnixsVxe704mnfppvjGbqXFESqVwZbHcRifFag1FffOFwf6Ply6P/wMP4A1QlQlU7Y20EPIObPOBcvz9msI0YZSeGEw3PQsvnP42CFJqNMBy+T6afpQ7ITcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074873; c=relaxed/simple;
	bh=CQ4xayDEoFvr1jT9OHWxpjAmKzgZYc3hdWOA8DdGpNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ux9XBNcJxfnw0FOx2Xj2s3HLp7sYPI3ZGE9F4fWUzY5T1Ge+RARelaEnr7dfzfoTj+SpsZPajt5RmWdgMepeJZ8NP1ViSDhAC8DFJPsvqYhH8XBWLzfCIXO2JpcOjhRfT9psZy3rnSqkC0nFj1zhrigzHUqcZTIHvik0vQ+uObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeWsgo6W; arc=none smtp.client-ip=74.125.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeWsgo6W"
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso1630602eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074871; x=1792679671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8neBvXrJ3PxtaBrYkVCU0EsbaYcYW7zqj6dnSnPhyTE=;
        b=UeWsgo6W8k3ihlyGUhMs/xIqPgvrEsbgmJjvEprAtB05UFaqyjeswMdWjZOoug+3YR
         fFbf3v+UZDECbEn/SHBg3LCqWIDS1PVcDEy/30thn8bNiRENpP3o2jKzNoMRWg3U65kL
         OpQs2FJzjnpEuZ0BhH1UFT2ymANbco05SjB3FsnBUJJtGK/WrzU2Wud4PrDlNqHs16wt
         OJbnPSILL27mY358jus398kfBHj+HyqZ31AjjR0QJ9y1ykAkWiDsgmQGb1fwtTJi4eVI
         cu8JkaKUxyDhsBtcPb53zpSboVxtUL9lHhrGFZbygcVF9idYNNKWNS96pKraC5ZY5clR
         Yc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074871; x=1792679671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8neBvXrJ3PxtaBrYkVCU0EsbaYcYW7zqj6dnSnPhyTE=;
        b=SkYD6eQKnHLEmAJr610TqeeGw91ZvoGEyAsdk6MNnpoX5gMeGAcaXhTCDjX8MGYmEj
         DZ5oUfnAqPqRT1QHwXDoqdL4IDeGe6vcBwzJ7KbzVW6/+ZuYFPLBQ9jd3oYDanuKuQAg
         /OsiIzNlyrMTEYOyY2d/2bv9KPsa795xWCk0iaJuME68+tnyhhrY5bF5KcwZK3SdSzRY
         2N7Zs5kQvUpfr8F5OTibqh6+M+auCGpLJQF1uzWnyBhKRV65R4uTYdXALqTnZLGEXE1U
         Q32P7w0icTMzHFAwLYLIzPk4TBz47eHL+qJNvGr7q7zKmsPVQqIDtXVuc7dVSSIjKQtv
         dS1g==
X-Forwarded-Encrypted: i=1; AKwUvBwSFGviCddmeCY4kbFyX2sBo8YRq6nx9G7KlNqJDY6KGqQoYM/yoKkcIq1MmFTV5EZpnccAiQI4O1zHwPvz@vger.kernel.org
X-Gm-Message-State: AFq9FYIaB6Fi5R87jyHja6HPrVGHRKnphn9T7GZWTuJGdn/KA6y8kgX0
	lo9e2GKaukYDUARbKEtN9w3mmvk04407yJal9J0y40fudKKHcPbKT3Dv
X-Gm-Gg: AYBFou1vuFIBDOyULD+Rk1LBClXut44oURCBpk1sxDwtfXrK2YINw0V4Zw0z61QQsMq
	retLH4wVkbYLJn5Tv5ElwXL+TuBzYjmI1vkUytga8AeIi9rKuRJ4dbJn7c6tPXutAedsP65aug6
	tQniKptsKSzjMm0Ylse2RUm45IKhFwF7KJBOE8wtzKxGTz46cZgUUjhUM/6RYkvrjgR3R9Or3pg
	wOjUpxn8rRzWW5DWSchMHV4w383uTz0i3q4LcbsIpKTd34S5agOzjflBoGhjHrlNMraIFic49No
	DhtD6BY8IkehZbF/UAvlMariVKn710lBtW0AsUtVR+FC8O/W7tzVKgIDowVuV7Cbm+9S3dZO8JP
	GYhm87zhOLHDCSD2nQHBUDSiFfwnYSDqqifnC0OIhXnE93uKM7upHynrx3A0wxuuk8hzP0q7K3t
	MGyeVMlKHftSM1rrXbMTywGWfX5nWZ3b1MxNSuMgsiJ3dbs/KvrfTYRZ+gIgoyz36BElDzkHArl
	L3KRGd7haRkTa3KfCtBgi7Ciw0f/kJTGslAdkLAQdx3IQMI5GK7EDBOco7oMwoWAKLa8g+W4qFj
	/G5+y6HrxXHTDodMfNOLnXdZ9tYg/mWPiA==
X-Received: by 2002:a05:7301:1a05:b0:358:eccb:af7c with SMTP id 5a478bee46e88-358eccbc89dmr21550282eec.33.1792074871413;
        Thu, 15 Oct 2026 07:34:31 -0700 (PDT)
Received: from localhost (ec2-18-163-127-16.ap-east-1.compute.amazonaws.com. [18.163.127.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca6d202sm61569751eec.13.2026.10.15.07.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:34:31 -0700 (PDT)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shiyang Ruan <ruansy.fnst@fujitsu.com>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	nvdimm@lists.linux.dev (open list:FILESYSTEM DIRECT ACCESS (DAX))
Subject: [PATCH v3] dax: fix wrong error code returned from dax_dedupe_file_range_compare()
Date: Thu, 15 Oct 2026 22:34:25 +0800
Message-Id: <20261015143426.17620-1-jianyungao89@gmail.com>
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

Fixes: 0e79e3736d54 ("fsdax: dedupe: iter two files at the same time")
Cc: stable@vger.kernel.org
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
Changes in v3:
- Fix the Fixes tag to point to the commit that actually introduced
  the bug (0e79e3736d54), not the one that renamed the variable
- Add Reviewed-by from Darrick J. Wong

Link: https://lore.kernel.org/lkml/20261012144925.6728-1-jianyungao89@gmail.com/ # v2
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

