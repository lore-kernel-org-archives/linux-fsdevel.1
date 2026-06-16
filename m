Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322BA37C0E5
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574269; cv=none; b=D+UDPfzYnRz4r9/j5mgvbFU27JsJMnsZHU3VGhj4WfiIMr9HfGCbH6sLCR8uDr+mwVOU+AEdSNo/fcj9/gFODX8UYVIeYMu0fCUuD9j0ycQ1V0l9FgfTewSXZ55oOv3U0IlLQS/H+BMVmlFuy5RE+HZUNPH3vbJjFVmiu3m8UAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574269; c=relaxed/simple;
	bh=j9Odu66lZt7PcnJ5WT6Gll+t3YwuMxXF3z8qxx3vhWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqDJevf/lIQYa+ACBgGN6hATDSx3PKL2PUSgEl+czZTmPo2mOt2335zlEns9gvej2hIAI3hWoOu4s3YGAUV/SdiSrvrtS4OA6fq1Ez0BVH9X3f27oNTbgmIX3BIgIvQJKx44JbOyi44ih+oJ/EnWAkgwCwBXgk1ABIbdAI+eC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O98uU8IN; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O98uU8IN"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-43d08bc82deso3882351fac.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 18:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781574267; x=1782179067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rowMkOrmg67Cdi/fThqMQCof2a6yJIMp5/xtZueyJc=;
        b=O98uU8INVseKE9OtEGzr1SHGthmaRzW0La1FstLIHbc13G20kX1UAa5mJEGIXzpmSY
         pq3DANXRXu4qiM6Yv0XQG1Ry/vBAXcIk0pn4l11qVbitV/QWMaVWYaCGsQYc4VC+kFhs
         nxcHMb9sTh7R+uAE/Fh8HkVVzRpNUpjdlQoUYmOQujVfSqh0zRht0QPQMjOkV+2xobLY
         mdNcvbLPXcdunz4xyOR+QKfariZCpfqhi/iuRhBp1ge8wR1VvXxqbw9loKktI/grqFTB
         T2fNeAMKIbokRCh/i3/UzKYwtECh/4mzZOPRsvNl+rR6yegfPGr7uFatoPQEGK8zg/Rr
         kOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781574267; x=1782179067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0rowMkOrmg67Cdi/fThqMQCof2a6yJIMp5/xtZueyJc=;
        b=oAgT5BfVXPKkeVt25yna+LzHyq5qlkLL2dWLKOcz+2hAM5E5gC8mqFVEqhp3nSKSAg
         V85/+HAWczcUeqnGe8ySi0PdE0KFUUbpB2DO4qtP9RqtgDqZX6/C+zT2VYCQGVoLpoN+
         F6bIMZO4CZARV8hYkgGQh3ILPgZgooa/ekbGbf7uQsumbXJa+0ZDcUHm/Z9r8H6/ZLZO
         WrRd5gjwUmx0IYRf0WMq3sz7tv++RIMWNExKLwXDbxjRrCzypc66TWK1/simGi+7fzQg
         98ABFl9b71AzbVQZY7fgHiemgYqPyDYKb1kvgyvtDEARxLOEkQx1GSrW8ydA4zzntpG8
         y+sg==
X-Forwarded-Encrypted: i=1; AFNElJ94rCJb00z8pstZZmcyA8J9XrrAGBGMo1gRMznQS9PzyNYgJOZsg+KZNO3K8wPFimkgJMauprZMgI1JjKxM@vger.kernel.org
X-Gm-Message-State: AOJu0YwaVQvX6GPjwAU6Fw5x2vlAKBLxNESrVq0jYUwxawoyCp5KeEBl
	6UQgif+VFgS4/ySMkbQwMPmkNF//SOmZyBl1LoSw35k5gi7xWkt4r5kj
X-Gm-Gg: Acq92OEtOPdbny9Ed8sqnGVOvUa/I3GxzK9/XKuCNET2kF66HCeTvyU07zF7t6uqsW1
	ClMApeO4zRuXFdJEYysuI+WoDPGfyLaDqY/v7+/jGGO7tNFXOqsPJCjcPLolAyMkNdoXyYdgJBQ
	Zu6OyfPdsHakqJHAs+ybH+jEMDp+6ZUYXtcku+c1TeTnt12egR0c3ZahnM8FFtRqKmzlIDBge2o
	UJnCoPYudmAePJitf3PxOsVCXVVcRG586hF/QuC++anvfGZpI7W71RyprdFAo5ZXjSRp0Np9AdP
	EBFm6u+KkrJr5UuRBgDqwugZkkByGj/XTjnepHpLWjZQMXU8ugxmjDuB5O5sKMtwrGbncMdx8CU
	AyLYKf+6lpPxK1ELuU4cTjFRGXePNMXcksVyizILGw7UctKMiqBm/x1/3KK5xRTZbX6kWbVYfWP
	0Kx5DmeEtScOnYbfPgzvuM54UDXSuh8SOlYARLaVVblFOm9Mn8luwVQXW3XtZHSY18g/ImMyK8G
	1oMz42+xZ/JzftcukVpVpZ+dhPmyCa0t5KFkUIc4iCrC1h0LGbKBCE=
X-Received: by 2002:a05:6820:2005:b0:69d:e555:2246 with SMTP id 006d021491bc7-6a0a40439aemr1269105eaf.32.1781574267105;
        Mon, 15 Jun 2026 18:44:27 -0700 (PDT)
Received: from rdf-gcp2.us-central1-b.c.storage-xlrait-66065.internal (163.80.112.136.bc.googleusercontent.com. [136.112.80.163])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00b41ed1sm4093011eaf.0.2026.06.15.18.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 18:44:26 -0700 (PDT)
From: Russ Fellows <russ.fellows@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amir73il@gmail.com,
	Russ Fellows <rfellows@xlrait.dev>
Subject: [PATCH v2 1/2] fuse: preserve FOPEN_PARALLEL_DIRECT_WRITES for passthrough opens
Date: Tue, 16 Jun 2026 01:44:18 +0000
Message-ID: <20260616014419.7913-2-russ.fellows@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260616014419.7913-1-russ.fellows@gmail.com>
References: <20260529031918.7361-1-russ.fellows@gmail.com>
 <20260616014419.7913-1-russ.fellows@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Russ Fellows <rfellows@xlrait.dev>

fuse_file_io_open() currently strips FOPEN_PARALLEL_DIRECT_WRITES whenever FOPEN_DIRECT_IO is absent. That rule is correct for the regular direct-IO path, but it is too strict for passthrough opens.

Passthrough I/O already bypasses the page cache through the backing file, so it does not need FOPEN_DIRECT_IO to preserve direct-I/O semantics. Clearing the parallel-write flag for passthrough opens causes the kernel to drop the server's request for parallel direct writes before the passthrough write path ever sees it.

Keep FOPEN_PARALLEL_DIRECT_WRITES for opens that also carry FOPEN_PASSTHROUGH, and continue to clear it for non-passthrough opens that lack FOPEN_DIRECT_IO.

This is a prerequisite for passthrough write parallelism: without it, the subsequent shared-lock path never activates.

Signed-off-by: Russ Fellows <rfellows@xlrait.dev>
---
 fs/fuse/iomode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index c99e285f3..0301a48d8 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -216,9 +216,12 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
		goto fail;
 
	/*
-	 * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
+	 * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO, except for
+	 * passthrough opens which bypass the page cache regardless and do not
+	 * need FOPEN_DIRECT_IO to guarantee direct I/O semantics.
	 */
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (!(ff->open_flags & FOPEN_DIRECT_IO) &&
+	    !(ff->open_flags & FOPEN_PASSTHROUGH))
		ff->open_flags &= ~FOPEN_PARALLEL_DIRECT_WRITES;
 
	/*
-- 
2.51.0
