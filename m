Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC29401496
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767723; cv=none; b=nheHy/AAMJ1jkkGs+jj6RHFbStt9A/Ewu3hWHEU79KZQrNijGrwnaw+ijc8lAgoyijSLmn8IOuJBFtzlWoWjc3fBBHHK/ooyYkRTgO9cF9S7/X9dokzTbRXGfnDl11g5Kop6GWbfvi8YHbNI97DBhsYc5hjureYWfdkKF2Q4AYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767723; c=relaxed/simple;
	bh=/9VfzpV2H+WPsSxhE+4SCnCxhE3ukDNuaFCEvOKUOkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6en2J4g5je2nmrwB5y++VH3J1fFajtBbAMu+CNJlmTveOzTNY6g+LQpQHGH5coUTpnHZEmH9RQOn7SyDKTMIP4pXpT0Xyb7mD59OiRtPISwk7MW4ui+ktdFSGirUEx0O0J9vg/PceBFutwqace8YhRuQh4FgCPAgdHVZhH18+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Z4YV4v1U; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Z4YV4v1U"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-47c941f7213so4971175b6e.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 07:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778767711; x=1779372511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VdLEtsSXXTD97ARZvp4Fn3QjxPGTsPjgq3lLYXDC9w=;
        b=Z4YV4v1ULnxFXcktTdrKbAqKWnuyZPIkDlBbVm/eeL41FbRmX7kGwS2QcQcdyiI3rD
         3jeb7nW3nPpIvlGaIrDIM3/C+/OtuJ/ebhtB8ddoPm/4o+PJrA5yfRo5Cc6zoKrPPL7j
         Cx2cVNjxQ2ODAPj5Bg2Ux+A9jceE9hnJ7NAxit1zbUGDp1vxjtK6Vw9UsZJUgAathlbS
         jiZEB2kbzomAW4z2RTS7wfWtn38w5MVqIFxSKfGr5Isr/6uYqNUzvoySuNampLFIfCgw
         ErS+QUggYHVmHKTmXisX89rnqBASjQEzwb4giE9iKbQQfI9DjiyR0tBzSV3aY+VAIMDy
         Kh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767711; x=1779372511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2VdLEtsSXXTD97ARZvp4Fn3QjxPGTsPjgq3lLYXDC9w=;
        b=EkM068xVwl051HVwQq2jBHlmAKtoiYhTXGYruscWWqYv+L3VifZuLgUwy01gQ8TMlY
         5NAZaKDvq9FUhVcEioWGIxav6QthWa8KNrLNg6NcCrePRS2btABRuiYb7YMJBryofg2j
         rb5Uh/90iuZ5PmgdbS2TFCkykuTN+jIC7HjVrq0NDh7mTus86T3M7gSRMhoeK3ScUtdu
         zVPOFfXlcVdwgXE1xRDLjDknoizbMgDcb6e0NVNR18QTLVFwmSxs4/cP17Pc8xQMBHYX
         gUiaHZjBUx8uq7UydfmVWd08TBlrjPamMZ7Bmoo5zLkY/NYa5+9x3XIuuCaC0vdG9hxS
         J51A==
X-Gm-Message-State: AOJu0YxD0GqLLflt8Q458ul8axIC09f0vFX+7Ac3rT39uYLVhLhUoqiE
	1WdesPUhQav8LjeGQVCMIKjW6Da56somLNGL5j1K4vSofbiqtVdUDIlR/JZM0OMAuHk=
X-Gm-Gg: Acq92OFPKvuVSNYrpm4CT7ujvofjx8w0KLqMpWiUXsGz6tDtFWNI/oBlJ280JZApknB
	Q6c6WnH0Ot9V0bmCXiivZNtQb8Hq7lXKgyKjOhr9aD6OSPFSTUmKdClv+xoxElg5CO5pr1J2SFW
	/w72JZ8OiK5zljaz4DRPVGgcl2Qqg9y55e0To3Q6zz9EhgqK+EFVbgSoQ0++G0yl3PJg16dIrMC
	9Tv4emKBV2QR9nkoIkNPCcaBaFG8shoQDXLj5B6on2jubbsULL637BBDK6HxMTi1bXuO0d7J1WV
	9BF77Ocm36Ns2LX89ESxYisZNBJh8Orr7JpMYXvX0jp1anebS1U3DHzMTRrbc2d/PiGDokMyYL1
	JDvRT/bT+eeusRSZ3cPWvj8qZfzN31iJOwB2gLbvQLdo0U1sZt1gpVPaFHDvjnd0d3XbpOVNVaw
	EdI4EPmcKXJXe1AYm86jFStwlyCmyjHWP1G6odW8UACnqEeM59smYrZem3PWcurBHWGwU=
X-Received: by 2002:a05:6808:2218:b0:479:f80c:7891 with SMTP id 5614622812f47-482b61c6de2mr4739352b6e.28.1778767710651;
        Thu, 14 May 2026 07:08:30 -0700 (PDT)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482d379f062sm1394956b6e.6.2026.05.14.07.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:08:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6/6] io_uring/epoll: disallow adding an epoll file to an epoll context
Date: Thu, 14 May 2026 08:07:22 -0600
Message-ID: <20260514140817.623026-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514140817.623026-1-axboe@kernel.dk>
References: <20260514140817.623026-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the nastier things about epoll is how it allows adding epoll
files to epoll contexts. This leads to all sorts of loop detection
code, and has been a source of issues in the past.

Arguably adding IORING_EPOLL_CTL is a historical mistake on the
io_uring side, but we're kind of stuck with it now as it does seem
to be in use according to code searches. But we can at least minimize
the damage a bit and just disallow this part of epoll, where nesting
issues can arise.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/epoll.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/io_uring/epoll.c b/io_uring/epoll.c
index b9db8bde27ec..eecd748cad01 100644
--- a/io_uring/epoll.c
+++ b/io_uring/epoll.c
@@ -62,6 +62,9 @@ int io_epoll_ctl(struct io_kiocb *req, unsigned int issue_flags)
 	CLASS(fd, tf)(ie->fd);
 	if (fd_empty(tf))
 		return -EBADF;
+	/* disallow adding an epoll context to another epoll context */
+	if (ie->op == EPOLL_CTL_ADD && is_file_epoll(fd_file(tf)))
+		return -EINVAL;
 
 	key.file = fd_file(tf);
 	key.fd = ie->fd;
-- 
2.53.0

