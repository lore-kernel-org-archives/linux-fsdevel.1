Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D33DEAE6
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969631; cv=none; b=doyfgVPUOvr0oGfca4vzRx5Zk2ijGVcYoic/r/swZG6YRtHaVdkovnuE+KOcwPFM975Pu7VnRL8u1gsBPSJ4s95v1WxEKLNNW8c2+2XumVp4OD1qcT8Am0ce/Usvnn8N8Vz6LYIS+H1ahYwRUse3PHqlSxP0oMKxRuxsmtcOong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969631; c=relaxed/simple;
	bh=sIq+HA1bMYdqH2Erp3qSFPRM2QQJsMwhWFNyPrpPIs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IdeKQtOvgm8Yzd/Uo920jG7h6k/KQUKBWdpQReXXJNRxLm6yFW8J1+QCRGrOYwp1uKMjMLPnAAiGoGTcPqbbAP5682Ax117f6Ec3uh8xdzq6QqH4JsKCAzNmCKTKxHvmnmQcSPzj0eUtzGVo1tjI5P0THxdkmo8cZG+9qjvMbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PubqxeHm; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PubqxeHm"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b9144790dso3209916f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774969628; x=1775574428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QP1+m9jjLQoVTaKevZQc6+yN+9p/W/azRVm4avbLCr4=;
        b=PubqxeHm3vMgGIoLSR3va5Y2X3G6N+VIJWE369wABM6hdb7iNOL5EBTnSAHEae4di4
         OU77f+FKF4KGuHj8UJvlor6tX4pKwVi1HRMoCxy7Wgu8BzP48q7OF5DcJoNGoWQoygjj
         HIH72Yp7ROOqJjDk7z9JpJTD0A9J+VlwOcXh1HHnWv9wqm2fC8BjZzR4sRSDLlGPexBB
         wC/61LLF9wqLWGjrbAg0j5VnzdFM3xQjRqT5hPuCAe9vR4IIsk4jFkCP85nQiWghBFr0
         c65aNwx6EXqluKKDAIvHqVtznVZYpFiWngwSWdKGsBdaQ6S/BrFxNgrYJY3spgcXWega
         VqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774969628; x=1775574428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP1+m9jjLQoVTaKevZQc6+yN+9p/W/azRVm4avbLCr4=;
        b=gBE2bpJ1ppuLanJUq3XmBAuuDipc3cJVP2kVQfmPFqEYGsvUBZGCiLUekwW9PXbKvE
         aGOk9RCRLCQuzXoDyK6C9mqBwzcFB78AF1Xaf3HuRQqi4QiBGLliI+uZzK5x0sr9d9FX
         wfODVCNFGTGA5dSgpvSxbR4smQJtQtUT6XM4ekvGz3loIMN06MBr0ulv4lcY/GxRhhoR
         8Dra7KDGWwwSl7dn5FR1jTh8Xrcz2wH3mna3UzIEVcKSPEw9j1jC3aSX6RXy27C63XxQ
         3Sx3+W+YqSvqPcPMz8AXZBThQgPpJVYY4zNDKOCe2f5y0nMebso9mjYJzAgnJuRBDlwj
         KzDA==
X-Forwarded-Encrypted: i=1; AJvYcCXem8Z8Ke4uFqzI9g5UP32uQ74MW4IGghy8Rv+BZ8lktibne9FYdk2tjgwD6SL8caQDN65tcW2GEMQUkBGB@vger.kernel.org
X-Gm-Message-State: AOJu0YxbFzn3ejq48h+x1Z8CrRZxIcaBir5LbpqP8hsSY2qT0BlsHcTd
	+fuYvnQp9MIuzTFtzBT5gb1VB1xzAPPTxpuqgIGo3QYGvrGKjM0lGIh9
X-Gm-Gg: ATEYQzw0XK6ZuQPJSR+5/Mon/raNmhanjPTp4XVw4kkQarOBdqtFZAO8TlbdIYbYEk1
	e6okc/m+5wMkau+ThAzmQKTfzC4AKNEnWunrz//ZAnJMt8I8r8ORXG5R7JIwIUZo0qHGnWVL9Ji
	DCYuyzHmjmnhR/LaMY2FCyMHae896M7jNNXoSwvD2H92CM2cccu074N1SAzSH5461RLu87n3GgP
	SB1lKm2QByaz36T9npJmT4lNMSDzyu2OmUq8HS7OLmijcBlL1uyRxBjpztmcC9c7mGyBML5Bkd1
	jG6QGOIyLCCoKgujwN1W1MwGXZj33pMVWFA+DcYYRI4IyLjm6HQtwQMT8Pr9CQL+JT3n8KeivnF
	vPjR4F5aWnzy/n3/Inr4uOLHc6fyrHW3AAiHqsLpAoITI0wfZjr6uWKZpWOsuxcRbW/2Fb6XRHD
	fJJFZLtoFLdx/pOOoTVxzh1ixlLWvOlzNwOOUyaxYGj0/92sQUck+gdxkSGNO97JNIiTPFBcwbG
	A==
X-Received: by 2002:a05:6000:184d:b0:43b:4469:d106 with SMTP id ffacd0b85a97d-43b9e9fa20fmr28599844f8f.40.1774969628281;
        Tue, 31 Mar 2026 08:07:08 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e9e24sm26882128f8f.10.2026.03.31.08.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:07:07 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: add back TODO concerning printed info to dump_inode() and expand it
Date: Tue, 31 Mar 2026 17:07:01 +0200
Message-ID: <20260331150701.3844815-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I failed to notice the change which added get_kernel_nofault() usage
removed it. It very much is still applicable.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 5e5cddd76a9d..912831645f38 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -3100,6 +3100,12 @@ EXPORT_SYMBOL(mode_strip_sgid);
  *
  * If inode is an invalid pointer, we don't want to crash accessing it,
  * so probe everything depending on it carefully with get_kernel_nofault().
+ *
+ * TODO:
+ * - add more fields
+ * - pretty print flags instead of merely showing numerical values
+ * - consider extending inode ops with a ->dump_inode func so that filesystems
+ *   can print additional information
  */
 void dump_inode(struct inode *inode, const char *reason)
 {
-- 
2.48.1

