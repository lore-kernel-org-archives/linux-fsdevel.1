Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768745;
	b=VQUPGYenOhSk+uTC0HQb1dwHkN1WBRSmPMbTx9dRhhpZNXfVkr7GFKFTQf3DvEq/8uIe
	 O16rOj//T+KPaLUG/Jsv8ZlIj07u3/3GX2aeR+vIwjKLkJkAZ0q/65edul1Vv7rwP48sg
	 ay+di3VXDMn30TRLCyEo40ZFeXUyje7WL2mC0ZmKv5oza4qx7fPEP8GTGza5GZEhkbiza
	 8SrAC1AWd1qshCY90ZlUvPBkNZXZOMy0bOI/L9mRIn5ULAhJ/twHx1XG8KqB9TeuBNmUB
	 ozvf9WZqf61ABFN0PT2c2dKqrsj2HF9e55/uqG01WnrY/TZ4NPfLo6Ndld7krFe7Xmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=r5fNrV91FJf9Qmtk1w/48jj0AR/BtrB4UlrPJW4rMRE=;
	b=x1SUK5Aq6DcM+QUOnJ498oivuvhMEk5lCA3wQ7XWyQFOSIdDJ5jJYKeD9S5lDVgAkOz9
	 p5xmOFD6VNXYnIRPswvjeWvM25RCAkN1XmUU0yrFkDmbkMfrs5CmJ2Iw3+GtVZ3zlpbFC
	 aXvprlNeLE6cFtY1iUR0JxjeaANIcrrpNC8naFB95Tk88YmQ1GwD4WMGaAdQvG+GHELrB
	 VNdGDj69wzD3VNIgf65VPVEXdlmMgu9YNRK7KoBc+KpGAXKbAts1wl3yaGagwx4RFHRJY
	 VD7VE4U92PY6JVxA3FNG3bCFvXugfVLpdrYWNWblfm/w0WXgb+56mGJiFxGLC8ope8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XkeWrjBq;
	arc=none smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E50606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 15:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37E50606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XkeWrjBq
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so815688241.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792768744; x=1793373544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r5fNrV91FJf9Qmtk1w/48jj0AR/BtrB4UlrPJW4rMRE=;
        b=XkeWrjBq/oeQte8WoGdsjzOJKt05yIYRZpR/ymVWmhKRVT/vAokSRL6gefGK6SbH30
         wPON8Yfiu9pi7Z0XTGlwYvnao59S/7UjK8+MOuhwT4S7HnuHh6X+JCYI7RNLQLJOwpO6
         yjtV/aQEAniws9EZAreu+MSxONgDqkorlvxwYd6ifCxPw/4sZv0uK9jX7pOU9pEKoQDZ
         aIUulY/GW6KxtxAZ29KzTa+NMNhix2yrHHKPDnFTX0Z1Fme8MO3y3RU24v1zS92uheo6
         DXtG3avjs7Jv8Iik4DRdbjEacMolpNx2X8vc3q3rUncbkuD9mdBnGiUoOA4niad5vUPW
         R89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768744; x=1793373544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r5fNrV91FJf9Qmtk1w/48jj0AR/BtrB4UlrPJW4rMRE=;
        b=Zdjv6xK8hjmLKodEKOx5zIGhm/rHAFiSl04JdJF4XrBYiV8EvbiED3or+0NpNoHEz1
         czYaoFbFB4BHjZ/gO6LyoU/IlfwVFPPzwmVUghK7qIRq/HBuw1QQihgtuBom+2Pmrca3
         +ssBwWahf75EZOFMDz79zI29jL3YfY4EEhOu+Ib/Lrsjc3xtvkw4I68Cyxtew0iR+dIt
         TLe2srBSIgqkBYxSDV58birbzm+BOxlHL2AJnGOrwGTcmFCpS6BgrABiPHGaaJqZVVlL
         C9B6FTbLgGCsdmKKZn7AtSnZxWbA1U9qtWqzBDqkd/NS9gcJ0xOzOvKK/pNQhOd+V0Yn
         gs+g==
X-Gm-Message-State: AFq9FYIgk0al6iPcOsmNUD2CIlNAEe0z5AhYcbf6FJfCK9Cyr8D9jacV
	O2cZLGwJIicRk/q2hShRGNn/kHIYexFSIKnQAMqcICjobMF5Ja1fbEIHhTKwhEBE
X-Gm-Gg: AYBFou2EUGTHyrjNEQrbuV3VbtlS0QKaOt1++TJxkAjQZZTOoTu/g6e1MokOsiupxKX
	Buwh8rhyouKCuArBwg/Sv1iOcbUJwxbfk2A96jEpxfe+N0gYNcKoFHUZR7z1Z1HBfl5/K3B0jk+
	Ui9mnCqCYoo1VZu3MjwWixYrHfMY5JbzoDpwa2FFU1trtiL8rJisAIFQbyQ49vKqnwn5jV50h2X
	/bAEbZZeuwtghu9sM+CTJ6quE0DdqpqicG6feT0WVXTVN35EaaNjKbssw7PUaszVcqi87t1yzZA
	W+PsppyZsSWR6z2HIXUyWm5Rl9rKM3kyvXB4z2Uwt/YAQ5TbiDKCM6NBGUNXkf9RdYy0LQQQfL7
	tHeMTQUrqYmFlATyk6fUdt+XX3woTsvDqSlm8jd8k3QqSY/XdJHv/X2o0n5grJ26VduKd9pbXxN
	N6W1Ws401Tlw4C6AWNj1WSosl8XJdvl6J9mRs11HnGfEsdyMX6d5hg1yzxfoxOUNcC0GT6NILPu
	hG/SI6s3iA/kTtjUUV8TkBG71+m7r6AzrVkokRz7QNFHQjqvpowa9WUxog10xUuCe0lzcCSwpYa
	67Mj0D3n41Ve1I072ESHNF7mUmsaUpb56QHRGzDtJ+zK
X-Received: by 2002:a05:6102:1487:b0:7be:25d4:7ff0 with SMTP id ada2fe7eead31-7ccc308886dmr1098358137.4.1792768744042;
        Fri, 23 Oct 2026 08:19:04 -0700 (PDT)
Received: from Biostar-A520MT ([187.94.15.233])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910c006d21sm601040241.7.2026.10.23.08.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:19:03 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Breno Rodrigues Alves <breno3011alves@gmail.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 0/1] fs: remove hpfs filesystem
Date: Fri, 23 Oct 2026 12:18:47 -0300
Message-ID: <20261023151850.96475-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.56.0
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


The HPFS filesystem driver has been orphaned and unmaintained for a
long time.  An RFC on linux-fsdevel stated that HPFS is about to be
removed as it has no remaining users and is no longer supported on
SMP or PREEMPT kernels.  Recent vulnerabilities (e.g.,
CVE-2026-97486) further highlight the lack of maintenance.

This patch removes the driver along with its Kconfig entry,
documentation, and CREDITS entries.  The HPFS_SUPER_MAGIC value in
include/uapi/linux/magic.h is kept for userspace ABI compatibility,
and defconfig cleanups will be sent separately to the respective
architecture maintainers.

Breno Rodrigues Alves (1):
  fs: remove hpfs filesystem

 CREDITS                             |    2 -
 Documentation/filesystems/hpfs.rst  |  353 ---------
 Documentation/filesystems/index.rst |    1 -
 MAINTAINERS                         |    6 -
 fs/Kconfig                          |    1 -
 fs/Makefile                         |    1 -
 fs/hpfs/Kconfig                     |   17 -
 fs/hpfs/Makefile                    |    9 -
 fs/hpfs/alloc.c                     |  582 --------------
 fs/hpfs/anode.c                     |  498 ------------
 fs/hpfs/buffer.c                    |  232 ------
 fs/hpfs/dentry.c                    |   62 --
 fs/hpfs/dir.c                       |  331 --------
 fs/hpfs/dnode.c                     | 1095 ---------------------------
 fs/hpfs/ea.c                        |  368 ---------
 fs/hpfs/file.c                      |  276 -------
 fs/hpfs/hpfs.h                      |  579 --------------
 fs/hpfs/hpfs_fn.h                   |  379 ---------
 fs/hpfs/inode.c                     |  318 --------
 fs/hpfs/map.c                       |  335 --------
 fs/hpfs/name.c                      |  114 ---
 fs/hpfs/namei.c                     |  621 ---------------
 fs/hpfs/super.c                     |  789 -------------------
 23 files changed, 6969 deletions(-)
 delete mode 100644 Documentation/filesystems/hpfs.rst
 delete mode 100644 fs/hpfs/Kconfig
 delete mode 100644 fs/hpfs/Makefile
 delete mode 100644 fs/hpfs/alloc.c
 delete mode 100644 fs/hpfs/anode.c
 delete mode 100644 fs/hpfs/buffer.c
 delete mode 100644 fs/hpfs/dentry.c
 delete mode 100644 fs/hpfs/dir.c
 delete mode 100644 fs/hpfs/dnode.c
 delete mode 100644 fs/hpfs/ea.c
 delete mode 100644 fs/hpfs/file.c
 delete mode 100644 fs/hpfs/hpfs.h
 delete mode 100644 fs/hpfs/hpfs_fn.h
 delete mode 100644 fs/hpfs/inode.c
 delete mode 100644 fs/hpfs/map.c
 delete mode 100644 fs/hpfs/name.c
 delete mode 100644 fs/hpfs/namei.c
 delete mode 100644 fs/hpfs/super.c

-- 
2.56.0

