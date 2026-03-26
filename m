Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8915B3CA484
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525870; cv=none; b=VYQrE6Omtnh0TnV4kkS+iDN/bZRuc1MCcNd5nR6P0/lMpU6xckc5ZC7vbvDyK6ZkoTLaxynPNfNR/Er45LjW+YLdU0aauMqoUvC2oHvQhhxxj9kbnso/filMJoMwe9GARYSIVneHkhAwB/39UhEtcPku96BHlNYk/chC8K9FcGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525870; c=relaxed/simple;
	bh=iPzl0dekLpdg4KiWYA7mvr8nHwxW8tnhV/yH03RDuhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fwp3s0jelst/dri7xh71iCubHdlZ8IB23moDaxDs3bfRU9MS23CQcjxN9IBBl2cZ8eVQvd0ilqxb5hdtgOuM6YSwb7nEg813qYQcLqkruHR3Wm/WWxKxRJqSJhBeXalmHsebXhYBIEEdM/g/GEuic8WKqU2hZv2y8aV8hTU5Rec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so520250a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 04:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774525867; x=1775130667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zARkMfrQsMLTshrQqnnt8R7FyU3yVdASbOPzW3T2E1I=;
        b=emapqKaEpbYS0maXUqYinPvY/5fISLWktjToPIEPIICrAf+DPBajBe3L6XyMQl0a+s
         Tug8AaqHDxtvgmTNNqI/iKtZUW1WK+wm1uaZZT6OxroJA8ajy6IbXmgZ9ZZ2t5BSuQxg
         lnjBiykaWKx+yX1kPE1JSrNxrU1CC329jff/8CQN0c/JudYTRi445bvBp0APW3l4rKJh
         E5lO42vhXeLjF771gUgQihzQvgO9xqJ1DSqAdJfu1owf/Clznc5HPuTrG4Zg5ssYCytu
         dxg5TuwGGfcO5QWvtKCxSsxDAqNd/A9Fvo65gH1GoV0XEQ7Yrpuc+7E2tQGMFiboXY70
         SXCg==
X-Gm-Message-State: AOJu0YzE5BvsxRvJ3glGXvTo4qu7OQ8HihAFvXIrB547KT/xLgJsAyN+
	CGL3+8tqS0zfxfSz9koSfp22iv6E5Q4Jk131bfmN/C3gz5nu/HnG5Nst
X-Gm-Gg: ATEYQzwEtEC/urfXbbF5jgetESHSg54wE9dX6XAnNaNBZ5FYoLRWl2sXtV4BIA45ect
	QMNpMtBlgB3CYq2qdl/Y2ii+d4skp0bNmwstHA+P3eHv9eSCdGavoS0YPrC/wl0ty4ZFqDv9Lu2
	l3zKIUHumOZ00K9oBY2ny3hwx6PAXl0s0oYFtiHmduSKHxY9uz9q0TtVr+sSgvfOjkFy0nij6/5
	9zv8RIWJMithVil9qNgF/SjzIsq1y8DZIJh43EFCEs/F/1MOk70mjEacQV+FRMH3yxgx8cJ4z1x
	aFbK5aDNvohZZBps3QiE0ktYbNM7d196ElzwsWRK2TcuE6d8qmtqkLr0jEvCcSERzQGoIjCgZG0
	QuN7b7JWSYC2ugWQUBIum33LbBoYVN+KSmSfmm2qZ3iT/KdX3MZDdQYjKpHFaPO0QMwfgcZOTOs
	+YMVMCtxU8CgsPTadxn0kxffoXpPT4fSUay735VA==
X-Received: by 2002:a17:902:da91:b0:2b0:4a1c:b847 with SMTP id d9443c01a7336-2b0b0aff14amr75885825ad.52.1774525866668;
        Thu, 26 Mar 2026 04:51:06 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76ba80sm28425285ad.2.2026.03.26.04.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 04:51:05 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com,
	dxdt@dev.snart.me,
	chizhiling@kylinos.cn,
	hch@lst.de,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 0/5] exfat: convert to iomap
Date: Thu, 26 Mar 2026 20:50:40 +0900
Message-Id: <20260326115045.9525-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series converts the exfat filesystem to the iomap framework for
buffered I/O, direct I/O, and llseek (SEEK_HOLE/SEEK_DATA) support.

Namjae Jeon (5):
  exfat: add iomap support
  exfat: add iomap direct I/O support
  exfat: add iomap buffered I/O support
  exfat: add support for multi-cluster allocation
  exfat: add support for SEEK_HOLE and SEEK_DATA in llseek

 fs/exfat/Makefile   |   2 +-
 fs/exfat/dir.c      |   2 +-
 fs/exfat/exfat_fs.h |  17 ++-
 fs/exfat/fatent.c   |  26 ++--
 fs/exfat/file.c     | 243 ++++++++++++++++++++++---------
 fs/exfat/inode.c    | 341 +++++---------------------------------------
 fs/exfat/iomap.c    | 305 +++++++++++++++++++++++++++++++++++++++
 fs/exfat/iomap.h    |  16 +++
 fs/exfat/namei.c    |   2 +-
 fs/exfat/super.c    |   1 +
 10 files changed, 565 insertions(+), 390 deletions(-)
 create mode 100644 fs/exfat/iomap.c
 create mode 100644 fs/exfat/iomap.h

-- 
2.25.1

