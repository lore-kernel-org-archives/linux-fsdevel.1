Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F573A7842
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830695; cv=none; b=WBRwdLBuTuBVWzdbgYHpPpyNTth2sHsUz4IGsRbriU065UK5fMnu5ZZeEt9zJ92Ch8h3IBYBO+0gQZdKuASybvFeMMlFbvW0eDap6ERnOtITBEWupW9Ui8dymxUbytrsn+W1E61D8a9teaUmZwOZB4qSdpeOO3AXqPnEEaXqixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830695; c=relaxed/simple;
	bh=vwSSDV48lvK1pVzYqUZxuczcm79isZ82TfeilXC6nqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pVSO+X/FcjIfypNrIqx7GMktLna4aUmikYZ47ySeBrQvIxfMAJz3G3+vFhploq4WtQ2WlynvOhcDIb6VLVuDLHFHbzUFxdBXbApsTLVJPewMHv6dlD/E6xnCt0tzG2lw83M8uINoVDqYywmEtifM8XzkR3/PUAZp6yiHabUxVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIGxu333; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIGxu333"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4889e045bc6so22405495e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775830692; x=1776435492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDHKKBomISqdt1rBTmKB8dvdSL7Ue9rH4+3TX6FfJzc=;
        b=MIGxu3332SGQKDTMmTUSwaVWruQfm86gWkx4lfqdIZq2UZ5DQ3XuJnU6RhT6OGGKtA
         dUrJ+aJg7a31D2ZtJY/jZrFs7avOkdf9HRc6HQqZxd4GwHKoJ1LRI1otxhPkVjlO6tLE
         8wtXLApQgfRMgxZ59kYKzqEG/O2KmhQASAEb4umuCVlXZG7UWTDKTnWYYgLL8KhhNTMs
         FIEA/7xzeECFlr1kP7entBiXF0duq7ffFatDeEr1RIuzTBYhvuy4XewkDMy6qrv3wDwa
         ouNfLW31Sk4JBALrMiLBCZkAuCA/6P7LO8dlPgMxfhG2JCeQaOKIdzbgDtD0XgC/xGu1
         ITww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830692; x=1776435492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDHKKBomISqdt1rBTmKB8dvdSL7Ue9rH4+3TX6FfJzc=;
        b=HMRZk53ur4Oadbll1LztEC0izC+/Kp1KTsJIRaQmT2L7/knJ8FBNemCXEzlB8jw3LM
         Io321vDybpivTLXzvj+IlNNGtUsbl3frwlBBtwo5FklYVi9womBFtN1EDpMrLYXKDLCN
         Zj2sa9mDBKiASaGVwb+GgQ+uTLqu5yE5dHmsVNaFuDUgupG4r21RsEDdkFdfYT0AtY9Z
         IPBec8IfFdwYGa/44Aekjqr5NuE25kMMrQJ79ZRvF1clSEN2z58H/rSiRUZFzQrN2gov
         gGhGLL6oh/sP9fOtCpZZ8dPgh61GQOiNEijHKkqa7ezyDMrA3nxHNKHGcWjHj1WOTBsx
         WvgQ==
X-Gm-Message-State: AOJu0Yy7mVrXp9xWZMsWQvQzrbUC5rLoM4lgp985xopOAxYMjH+6CxUE
	ZvptGNG54g7oAWTZNN5etaTsCb6kVr1ief9SKC0xuSqJFqJ0mgNJoxueZpYygA==
X-Gm-Gg: AeBDievW8VcPMINuXB9L+wjlXeUyKO8su931SA4OpfG91zf5ylsrLl8L9xrPg0ltXh/
	1r8opqS1sxoD3BArPMOJbrgUqF8XNvUO1h3F9K2DxVRotHY97NmhpBmNlGpyGcSU6UZUx+ffdSk
	CRwDJrDX0Srwy4hVSmt1TAqde4XiRGgsq6IFVOz8t0uzzY5C7LvCsOZYqBZAtwZjMdzuxAQOGxx
	aIZlMzvdLuOEemis0do5Dzat0ROMj+qCR+E2VbKatU/nyStc7IJkdJpd3Q5laH4fDkft7gQAQVA
	33Rm3z3zZcOYV5MHKXFdl/IdQr63bGaFbBBTLUzdZm71xcFqzvpyGlwnV+8Xk5PNcMWLN2LvopA
	XFRJK8vOJf5gZU/tmWCdjX3GE5jrgFCdZJz2NQza5lqGIRmyaAUjj46slOhNy8hCDc62rn6fibs
	OHnR60Zu1C0QpOxUt5vkKpE0sGuEkXV8Wv91MJ+JwVYnA58bpoiWF5YLUHwbYtB428gIMExm1pC
	PYAlaf64eE=
X-Received: by 2002:a05:600c:5299:b0:487:1fb4:7e1 with SMTP id 5b1f17b1804b1-488d6875f3emr41667035e9.22.1775830691768;
        Fri, 10 Apr 2026 07:18:11 -0700 (PDT)
Received: from corblimey.Home ([2a02:c7c:37d6:c100:60ca:408d:517a:4a96])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488d67b4903sm26903785e9.5.2026.04.10.07.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:18:11 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH 0/10] Add support for VMUFAT filesystem
Date: Fri, 10 Apr 2026 15:17:24 +0100
Message-ID: <20260410141723.307925-2-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Visual Memory Unit (VMU) for a Sega Dreamcast includes a small slab
of flash memory which is formatted with a file allocation table (FAT)
based file system. This patch adds support for that file system in a
hardware independent way (ie you can build and mount a VMUFAT filesystem
on other systems than a Dreamcast).

The code supports the Dreamcast factory settings and other volume sizes.

It is neither mtd nor Dreamcast/SH dependent.

The patch set includes new documentation, modifications to Kconfig, the filesystem code (in inode.c and super.c and the vmufat.h) and adds a new 'magic number' based on the VMUFAT format.

The code has been tested on a Dreamcast (and built with a 32 bit
compiler) and on x86_64.

Tools to format a filesystem are available here: https://github.com/mcmenaminadrian/mkfs.vmufat

(Resending after typo in previous subject line)

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>

---
 Documentation/filesystems/index.rst  |    1 +
 Documentation/filesystems/vmufat.rst |  127 ++++
 fs/Kconfig                           |    1 +
 fs/Makefile                          |    1 +
 fs/vmufat/Kconfig                    |   14 +
 fs/vmufat/Makefile                   |    7 +
 fs/vmufat/inode.c                    | 1017 ++++++++++++++++++++++++++
 fs/vmufat/super.c                    |  581 +++++++++++++++
 fs/vmufat/vmufat.h                   |  126 ++++
 include/uapi/linux/magic.h           |    1 +
 10 files changed, 1876 insertions(+)
 create mode 100644 Documentation/filesystems/vmufat.rst
 create mode 100644 fs/vmufat/Kconfig
 create mode 100644 fs/vmufat/Makefile
 create mode 100644 fs/vmufat/inode.c
 create mode 100644 fs/vmufat/super.c
 create mode 100644 fs/vmufat/vmufat.h

