Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B199D3988E1
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249642; cv=none; b=FmxI7dtzP9yi6gAIdUUyRxEMojGawg83Oz1cd2l2uceYIipRJpUR0pz+EylxQNdo4Jlv4rm5HHQ7hdSd8KEtyTQHS0YozO5i9GimQPJgRFqYy58/1V6N+ej11PCi5EB1+Wr9rLei73N8DFC1sL9bpCk0YxNAvN6axEayuOTQuOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249642; c=relaxed/simple;
	bh=RsuzjeVK5wMRQEobDXrt72MpfCjV1N3XuwLifxRp0PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEHIBZj3/rTGggNnxzyiVamJC8UkGCs7G3YtAEORdIjDDg/PwMsgkH1RF20sgwFfp0VQRyWBPosar2T00ahIvLSmOQbyCeyNdjZ01cwQsyT6gmO0RmZa1ZgMnaABm0HgjmlgNXXKaPJWxbSQHEYZMZTc6saLV0dfaUTFfTyJOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ih2/mojb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih2/mojb"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84231305a80so453194b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249641; x=1781854441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvXgPLhOiWZMaDJ+rY1MoB7jtQwbeV+7PhRopqnn4qE=;
        b=Ih2/mojbJu7giRQOx2ilFcqN7yGolHXHu7drDvmoMcKC4mDbvzYdSMTZ+WXxuB6dAo
         6J/mPHGgCpzAlNZbFebC8pA8qsnyEWp8zw3R/D+OmcsuG9OKPppMNOqJvC4rmZQ1FCoo
         uRfO4VdF/M9I8G9GBp28HfakxHM6Gl21t5W42o5BM25eS2FpsLcRu0vkebc1ExAGZoN/
         WU2gq55FFBSyKqYQ+Nldwko7NUywx/dHmb4T/DgGJIlyBBjeV8/Pr3dITUGOG9EoopGl
         qKKt0xWqN3DWCN72KFnnl6bQv6xtiDkgRhxrAQb7FQspeLGujpE6JfvlxeKVX2Tl0s59
         DZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249641; x=1781854441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JvXgPLhOiWZMaDJ+rY1MoB7jtQwbeV+7PhRopqnn4qE=;
        b=JQD6nLwlUqPCesgHV539vtgZbhXT17LiNhYdmM/2bV0Aty7OiGcqeXAxvG9mvEF1De
         EZJui8SGDVC/VYyHfjv4VvsufNIEZMazi5k4+yQAvgmXP1wKl9hAsTmPPwpXZqTkcm0g
         NDigkoHRLSlIorXg09KsGmqZEdHJHIUYgf7ccyoXq473Cxz1+8nYNy2Ub5xUTYteTCH7
         xXiYsWU0D3BfBdCG4/m2ykl9JoSJEJqaoGa7+I6dBaDeHLruvHjdX5U7guIxh5+HnqT1
         7OGGAb7gR9pcEE2+g++j3kQKUT12ahpzbzN+UKEu71dhuSkI4gQGdEul3KPR9PT12sl9
         0FHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+xFa2vUfBiDMKl3+6kV4mnyU4eNnLrQ4U/w/FoEfWvN1CtA1ikeWxapi3pWI0bs+/Q3MUJT2iLLaNjruMR@vger.kernel.org
X-Gm-Message-State: AOJu0YwvQN4Uk0/7hYT6cs2io8Qm+7IRDNaezM3HF6nX0yMXtNpnMr1j
	dx7SrFNeCnCcDUmykfVjzk7i008kSn2ZOLLGlDzXtxWyMizKVLc9Qyq2qFBL8w==
X-Gm-Gg: Acq92OG5qvfm8BAL0Xxj7cCR+4KSXcby34tdI4evZMXaWEN4ExH3eoR39SZbvUe9Xs2
	ZXCPZX2Z1lJSoslqpA8QNk0VYQ2cScbPhv6kQQxeCmEwsYAkYoLOpPTEDm4/xPnAN93CD79KofN
	jMsUajO32GYYgEcLMTtWFZp59DG0ey4CYWMugqGMmtUOCXnlqdIbdZzP2KSgwugKRoLcRaxTSDx
	aQ0MjR5Aw61j5wK17ggUs0LuyEs9Rldv8zi2Aj9Pkr/7BV6t2Byz1VPc2Q4wXTFd8H3tFO871IO
	zckVe3FG51THrvFsjMYf6CLHZEPPrK/5ECzZJKCDwSXEUBihTfLP52whxjds44ePnPyXY2NAYeV
	2/8YHa3N4U/t3g+TD48c7ys6Vv4H2GY2UI+sRRzWO+SXFTUXOczT9TFEmY8owHTSf7XjRwiS293
	txSOyZ7KKfXEpgR9mlwQW+i/X4BqLINQ==
X-Received: by 2002:a05:6a00:464f:b0:82c:d986:e917 with SMTP id d2e1a72fcca58-8434cdebec1mr1796949b3a.22.1781249640994;
        Fri, 12 Jun 2026 00:34:00 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05d7d7sm1374014b3a.60.2026.06.12.00.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:34:00 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] ntfs: fix incorrect size of symbolic link
Date: Fri, 12 Jun 2026 16:33:31 +0900
Message-ID: <20260612-topic-symlink-v1-1-cc1ebf9528e1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612-topic-symlink-v1-0-cc1ebf9528e1@gmail.com>
References: <20260612-topic-symlink-v1-0-cc1ebf9528e1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=606; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=RsuzjeVK5wMRQEobDXrt72MpfCjV1N3XuwLifxRp0PM=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqK7XunwflCJATcHMHeki4Qr2kha8Qn7JHj9Kzy
 udev4AKlouJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCaiu17gAKCRA08jD6945I
 00p8D/9yXW/CXhV69uiCabEvJpMwqWhzSfvyyqEK9tWH30ibB1zD/5CyMPtIDf3rx0kv6jgHBH2
 0lbywAaH1bcjLn7PLFLq75vFQXDkhq/bhxRp/yN3Lf3xuSNJ1R9vWgC5KoFVMJAeDj8WDxY9U+T
 ct2BBGl/py7DMHovc1ujI0anMbRBbqouUW0pIfDI4olTwrxsMLyNFa0feIA3UENnbNgugqxMRgN
 KVhwuT8tg+flTsbjMuHKvlLJxiZMYnEwRrnOptjY8w8WkGhUhOZymNA9VTQQDruG+/2CxOoybzj
 +3jXByZ9uJQmjPudtDQUhG4uok3+vVRxnaj70G5OvH5bbLyHuBH2/+8bfLasv1PjcrRBDmlNU3t
 8aJr0CbwtcLjMCA2gxasVxl3p/vW3mrSJy2BMMyJhAN8GQ47hP99eamtiQ/I5c8Ci6LBWbiAoLs
 hMOIulHid2xatHtT6am4nAv/a5QfwhfMVenHkzEV08mU0cnkpYmXZ0iSoCfbCFZ16qHzQbsx1xT
 UtpLNC59EtlpdknORSUm5qjTw7rkRbyNpVAdZmtrzUvWhWsOo64VNp1FdBNAqLeyE4lyqOQtm5d
 qrxKJyPmmv0xiJjmsMkxLu3oZPKPzbOm3jmCn2FriTN/ovx0MFhpbrO9FtyT0keLp3Plwyazxoo UAxMlolRdFjUqZA==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

This patch fixes the issue where a symbolic link size is displayed as 0.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 2f2634baa285..efb34a5e94d9 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1199,6 +1199,9 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	else
 		vi->i_blocks = ni->allocated_size >> 9;
 
+	if (S_ISLNK(vi->i_mode) && ni->target)
+		vi->i_size = strlen(ni->target);
+
 	ntfs_debug("Done.");
 	return 0;
 unm_err_out:

-- 
2.43.0

