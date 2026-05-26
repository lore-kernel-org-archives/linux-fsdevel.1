Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25EA3CC7CD
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796729; cv=none; b=cdWbvY3tJKQoztiAOWMJ3gGQwxGOAzgd2rxkLNgK+7yi3qvKrP6uoec2jhaDNrR9PWakr/k8fK4abmopycHz19V1HKDETOXGKW1sSx4q5EXnVO/Q6fg5/uu3eea0rqSDTuZEauk/BubJ9UACr+gDSD/9J6aWPObqrtD/hwAZcuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796729; c=relaxed/simple;
	bh=OI9vadjmrpnSOjQp7MM/N/xIkJIrZmhrPPwgWO9imU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPARUYSWClMGK9gWhyafps+hDwsUF5Gc9EloFwrvwXgA69Mh95lmVk68mm982p7AmR6AP3/wHvYBiMn9YzQaxdi8k1wbPYYiUf0L/Vb8UO8A900gwTBbRlrcQb78KG2TgVc96R/Vp3OSvjhSyRU5jvYvPUMVs/QvuhNhSIkPmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8FSCcO8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FLLdsPMt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8FSCcO8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLLdsPMt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779796720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sRBmHOp/Al1wa4/wsfR64tjuTAw7wufZULw8KgXYJhU=;
	b=C8FSCcO8ky1x9IHFUYdr4CFT4v+HFlOeFj3feE4wweQsiRk31N7fGjqJqk1dckJ3ZLHJ4X
	k7dO0OenwI4DHXF2b7qhcBrCZ/gAgGwRUvIssQ6aGnDrovu6WknIPpGKxeyI/+ObTMiA6K
	K9FTMp5ybFsoa83ktF2BTk87RAN+FFE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-q9pZ7UDfM1mpL1IeDzjbQQ-1; Tue, 26 May 2026 07:58:36 -0400
X-MC-Unique: q9pZ7UDfM1mpL1IeDzjbQQ-1
X-Mimecast-MFC-AGG-ID: q9pZ7UDfM1mpL1IeDzjbQQ_1779796714
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43fe791a398so8019061f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 04:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779796714; x=1780401514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sRBmHOp/Al1wa4/wsfR64tjuTAw7wufZULw8KgXYJhU=;
        b=FLLdsPMteewadhUizocxDf020LpzSDz9ixN/CB4aeTo0Rfgjkm0Le99Hi4y6w6bWFy
         CpbQV3fviHiK+1XY2URLjfnUV39qEc2weWgLIIqez4PXTSv1sbglX8qEPLh1midnO4cq
         cZ9ldrLz3GTlKMYSvpxk8OR/nDmzx9zCecxbXQXk1gQzx0NxD9YkXQGe7CYj4UTDqD+F
         bOJfIbbeYP693PDcxoJp499o3kbO8hyyfCuPT67EjDEuQwy80p1tSsgeNK/0Qf5wqejn
         4sBeT577emA7pFgsyQyvp+vceO1vA+sCvbJqFoXEcfXp9gkhJb4eaqXCMUQl/IR0P99N
         bh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796714; x=1780401514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRBmHOp/Al1wa4/wsfR64tjuTAw7wufZULw8KgXYJhU=;
        b=ZBLqUpyCDJ7FgeoDSjjgKDgXQQrzSYxrd6VDlaPrxwK9vHnJD0zfNs5snBQqw3V+63
         u5OkwuO9vRuvUlXowf9WhW1QBBN3c9HvqhrKk3rmeIMBteNtUk0OR1cQm9hKABxtjssi
         XzXhFynrh6dtLdeoJuuBLEqnoSXNz+QNiX1BGkzVtzLTZM/11JaE9FdafUroYkxb8+zn
         sAuo0yJhPK5AQ63BPvmmyZJ39PfAUgq5+sXvEU/vUEwLVST+C7MsemqOrqH5/cLvHvgj
         anzxe+soP+suh4O7k10kF9ohznqJ7qHI8XVgiEUe9NmFSivbEofhOdLAYllE/zaWUeaZ
         MYqQ==
X-Gm-Message-State: AOJu0YxQ24hnmjlv19RJVlWLzJENvu7QAoqY2feiTrQ+tzELzI2L32iX
	AyJjRoIEDDC5E2alrfVzTFlf8lT6b4hdWAsmFTO8PiPpg1CU5A+V6ud9NIK1b+NS7CQquGDwahE
	huhcy1THc+S6qzyKpAqUj9kJC5AUfb1g6qR0E52VO+hntHbKdZI2LqEZjuaNvaEXMTj2Fbn6VW0
	9l9ffZ3vt4gYM8cdzmmzqJh37IghKuoYwHPSgNrDDd10fk4PG0GYA=
X-Gm-Gg: Acq92OF0Bq0lV/jpDt6hTqFVpMTzWKPKTE8wyTmiOBbmIz8uOqCkq5ve6EZJLq9k+mH
	lQ6nekYnDWhzvVlcslG3tRYD4JtnDv08UpuvDdCWFTz16jM/dqZi2GBPzZRwxHaM4wsA6Ea2O80
	9J5X+mTShCYs1YuIdxDs/FtZoZPzHI2+aG+rlC/FDRnyYJ9G4QbZ13cU/lCfEFxiM1bChtwfey3
	fHJmQn3SZF+JemQEu6+6x4aOHdAmfDDdgpSgzK5h1WQcKzDg/zfxQOEGjLx+FIfgAbTkCmdXD0D
	3KAxg/3foWaXXeMi4TdAyOBlBLH7DZ1XGAuuHiCpSnSjGRgl0SAMd13cO8AHyY3uF2wjYv52URD
	o6ohPm+GP17XrMagth8C2Co3NlsfrT+bQGynt2cX0AOlBpklBS5mCIfqaD9pmzvdcNb6B877/7r
	3/
X-Received: by 2002:a05:600c:4511:b0:490:6869:46c3 with SMTP id 5b1f17b1804b1-490686947bemr112003525e9.30.1779796714400;
        Tue, 26 May 2026 04:58:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4511:b0:490:6869:46c3 with SMTP id 5b1f17b1804b1-490686947bemr112003005e9.30.1779796713890;
        Tue, 26 May 2026 04:58:33 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (78-131-46-194.pool.digikabel.hu. [78.131.46.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d4d8asm110335325e9.16.2026.05.26.04.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:58:33 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] simpe_xattr: fixes for per-sb cache
Date: Tue, 26 May 2026 13:58:28 +0200
Message-ID: <20260526115832.1294821-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two issues in commit 12e9e3cd03b5 ("simpe_xattr: use per-sb cache").

Please feel free to fold this (with updated memory use numbers).

---
Miklos Szeredi (2):
  simpe_xattr: fix rcu'd union in struct simple_xattr
  simpe_xattr: fix racing lazy allocation

 fs/xattr.c            | 19 ++++++++++++++-----
 include/linux/xattr.h |  6 ++----
 2 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.54.0

