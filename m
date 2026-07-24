Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08B3448CFD
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913276; cv=none; b=ZwK21y5F3Z5K7Bqwr1ffg8fVj7vQh+YWFNha0XER8eL3qVoWOTGKolYESkOoglaWCnuSakoksNOH5tvN0fr1Xn8iq5kAgNMfQHEDoJkpz3cFteNwErpqeGKMV3G33biIgZoYPs+vqOIsqK3J6hsb751ndvk3w7rsWDTSV6VUIxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913276; c=relaxed/simple;
	bh=PQTuF56R9E8Fq6uXH9NfqYYfrRk9oDvKKbsgTkxpLVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XqY7s2+7FQaet6txh0Mx65LoptCIF7WERYbI1kHI/bDYK6ackd4nbCm6lE5XWNjxtUdozNUkyctqBBeAI4ZYVoy/hYM9eZCAt8l7wcjLABctYQFxJGdhaDHaB+qVTe6iHO2Z7aX2cCh3b8wNZXRo72OpTmsiezPnpmbnCFc9V9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY2sdV/f; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY2sdV/f"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49550ec592cso11649685e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784913273; x=1785518073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uAwPoMhlQ3DcirvEJK7NPBoabed7i/vD6k7f3GHxXjk=;
        b=hY2sdV/fe7hrxZUZ+EAyVJEQtJMjTr00CaT4JndYr+h2j8FyBpEINk6gT8nBroxdtV
         6OsWy4J4itvoGiQ4wIaE2vG/0L3Wba3kMGuBfKQ5GCKvsnDx7zj6tuFgMarcpIdN5SCT
         fMXPqFO6zMXZmHIboyGeWolcU+12thprnAmF7vFBmx2Z9g87EdaHgvof7ux8lbSh6UQk
         qIx6hma/5Q7G6ovolbnIPP6JE7ORkSR+7mw/E27c3pbB/L90Npfnv4336YEMfpMIoGz6
         pgnpTTD7VSOQDPUfnwaI/7hTuoVU90ZBaDSgwCQHFkPcwmS7yvCDHOt8IaR3v1TvaqJ5
         +A0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784913273; x=1785518073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uAwPoMhlQ3DcirvEJK7NPBoabed7i/vD6k7f3GHxXjk=;
        b=gbrJlR5ax2i6W3zAMULh8wtdm2uBPMoRzUNMMC3mbYocTYr7ie6rk30q5ht18rfEGI
         FneMnJkFWwX6o+8xKfR6Z1NMh39E8UJKEtG1q1gtGEaP4M3pi5H1sWgkZ1+nJ5GKh4vo
         WflHkxQ8ak1bPtrCE1dHIE2gom/vAMgg2iswkJzXIeG/akxvmH/xQN3/A4++d3xJhxNd
         eHKV79gaoJInKlxoti5WpfkTcx2L7tAoRyjKiSscLev5yfa0THpxdAQVVok7PFl3MCma
         GIXpykXRMDXCHci4vEZYFHvtuTj2lIj35vXtWLOvAY02XAQMGnUTjyw44fL55IJY5hv6
         VGHw==
X-Forwarded-Encrypted: i=1; AHgh+RrZ/gu4vd1587V3bgBKeEuhJbchVN9i44rFbcSdhA5R6D9zjKadK4Fd+hmEULcEat+JqgyfYc9yyXpE/5ZJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwicFKGz74ICFEWPYAiTnpkcwWPQw9xR/cPevLeJ+1EvmFmqV5a
	oe/O8SH2qUSTgntRKx2DEJCUmmnWmuHO7uw07W9UA8TK+HKhNSBm8/0RdB5vow==
X-Gm-Gg: AR+sD12Ye7+SL/GzlrvUQf5HKF4DCscdD5Z90EdFcKQU/24CfFu0rNs0otNvXtpk4Fa
	741X5i8e57DBnnApur9Zl1y8oR5wjcHdhxXDr2kbo1/I+OS3eXbQl601qQ+urxJF8imKv3kazj8
	mRmX+RlpGrFBdZaQZvq4dQexsn3g2tfPpUBDZgPCiCqQrqJMgd+dhCZLE5it+u8dHIIfRhrRuy/
	tGSRy1uLz+1n6TZbKkUG9scxhY30RwLvdiQjAR2aIh7VQ+2pBuvFCK4J+x1kv2xCxHNZ41h+9HS
	4XwAEQRpH3qLReRrKueuGB7JL2SyTiW3Q1OZi9dEm+MTd7fvWcXBVYb0L4TyaDeT/alwIhAJTSi
	Ms7O3+bH8KKKy5J3o2lnCGpuqOM6agEJ2koLpybE1H1gWT/o7sM5/CLqEl1MfyGvOy8sVZBZWw2
	HdRIzO+smxQqrkhJO5LMTnkw4NwHBAcARYXk5noJQjguLXkwsCX5+J
X-Received: by 2002:a05:600c:474a:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-4969f3d5ad7mr16850005e9.16.1784913272701;
        Fri, 24 Jul 2026 10:14:32 -0700 (PDT)
Received: from f.. (cst-prg-85-255.cust.vodafone.cz. [46.135.85.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b499c473sm4175225e9.11.2026.07.24.10.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 10:14:32 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 0/2] lockref tidy ups + touch ups to it's usage by dcache
Date: Fri, 24 Jul 2026 19:14:20 +0200
Message-ID: <20260724171422.429284-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The open-coded check for < 0 indicating a dead object uses information
it should not know, so to speak.

This is a preliminary clean up for a longer term goal of moving dcache
away from lockref into an approach which can atomic_add both ways
instead of suffering the cmpxchg loop.

Mateusz Guzik (2):
  lockref: tidy up dead count handling
  dcache: use lockref routines for dead count checks

 fs/ceph/dir.c           |  2 +-
 fs/dcache.c             | 16 ++++++++--------
 fs/erofs/zdata.c        |  4 ++--
 fs/gfs2/glock.c         |  6 +++---
 fs/gfs2/lock_dlm.c      |  6 +++---
 fs/gfs2/quota.c         |  4 ++--
 fs/xfs/xfs_buf.c        |  4 ++--
 fs/xfs/xfs_qm.c         |  4 ++--
 include/linux/lockref.h | 12 ++++++++++--
 lib/lockref.c           |  2 +-
 10 files changed, 34 insertions(+), 26 deletions(-)

-- 
2.48.1

