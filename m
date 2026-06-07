Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0107316199
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855126; cv=none; b=PRMe6mU10r0YLZD3qXdJukp9eF0p2Oh39wn8EeLZTk7yb6HNj5d/p+7MMD7Qxi8jiXiXdBNZd1VJ6AigM1b5xZPVl89hv1Kec4Vitp0dvlZFy6pVr6NB4shQuwsGuNhIyoyuo5hQR5I/7lq1mMcj7ynPx2SNrwbvvNjSKgtqEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855126; c=relaxed/simple;
	bh=OxzWpDgTbn1TElNKYFKrRTdAxDZ3awLsdwSVIUMnol8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVfi6x6TVpp1lpqUoBhipNhUJTpFCdsw97O5fszyHFTnhbYYQGSVbJ8rMxSfcVvaJAT1l70BpJjZtT7UpMZh1E4vPt+FdT2CKlbUWGgfEzgYjFZIL4TbjqPHFIQV7/sSRms4zrPN31ZvYoAnGzFr6qBONGtoVK+gyeECN688m+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebxl2oAr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebxl2oAr"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490a765d410so37528275e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2026 10:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780855123; x=1781459923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0/0Irc20jwBOe73u4JSV1lZu4bujVVeUgp0O8Yx5xso=;
        b=ebxl2oAribtW5yH6xB0pAv+In0AO9JPRtS144KZR9DqujiWklvzhV+6bxi2+iVZzJi
         a2wPnngQE0vSm+7DgCsbxnJDzrE99E5jjzInFGnyTAStSv3dyhC1LxGwn6I4v78m3zM5
         Gf/c0LmaSPcxA/Fqc/yyU04pU/PoBAdgf4UzwDKqgjWJ5YNpX5u5c5qIZDz4ioKHxE7a
         P5oZGD98G6hsCmmXiK8rW65OZNMmIwBnfqP+3zwA/da9HtzyoAux6rj8My0IWYW9UmI9
         1jl8RdM6b588tjmbnOnTEdlL2COtArbFWyVtm/tDjeL8sJS3QTbIlJQMYT5o1c0aYBgA
         +0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780855123; x=1781459923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/0Irc20jwBOe73u4JSV1lZu4bujVVeUgp0O8Yx5xso=;
        b=YItmvcK1n4gVtWGuUxXS8bRdCwPLavnajxtp3JXFChK2Kjdo+txM40tSyu605LMtYs
         9P9CteKtyWszL6SLA1dwNTqYd5SPw6BZlUFVfFSAnbFJDhORN07I9FPSVq1KxMTuDvjv
         oEjhlIHpq0h6KQw6erbGiu3FSFVYr9R7tHdNujP+BovnlIAmKntG75qxI4kDMLRe2uID
         sExkOJ7GTrRsut1aYmRNeROvj/MjOmakh+F8URBc8lX230Imq4YbihU8A3WNKAgeC9YR
         mk8AiyGD4ZWFhCOyATQ/zGSOlzkiuhnkJAVCNGx5KxUiqrv+rFyhRYGgEyfSP0v/MBLp
         VjtA==
X-Gm-Message-State: AOJu0YwIugYbyCEycY8ecN0glSlSxCsWY2nVMYdJnaJykZ+Ob52bIa7Y
	nraJDlpL8BEna3IW7FhYXjzzYD5BY+L9r9XmihHZo7vHXQW2nEzJ1/j/
X-Gm-Gg: Acq92OGYuTVSGJ1owNtFGS3HVpdHnONSZ/iAA03OC6fObHK022yDC7F9rmpadLLpaEw
	/VP2+aAQ3xj+aKIXxLoW2kFrgeCASE65X+q7n+WidaBXbWeaA7nOBTN5WZ5NNQMx6dBTJathn/h
	d+Qt2umMtEeNzIjyCIvXerHoL8yGYUf7a7Qqe3rxTLsa/WOCtu4jkB9LBO0Oi8TQZ8f3ZBurkoW
	PEGV3Zdud6VSriMhmTmzGHpPmRXaeo4w86D2TGxtg745j0tzu2B5iskvo3ssoUk10Hd/ghY916T
	I0xat6Qanwf7fHftJKox4yNKTyONpbJuBmap9Ajl2gtQSw44I1N7LznCm6CNtMJBH6J448QIm0t
	G+sB4eWXbbpxM/DdbuuUL9vBUMGvREeSSgaf5y6/49lSoYuB8jPMl15TzaAzcmvGveP/SM8hPo4
	Xurb6zil7gLTzjgvm/QCwjtqB1/qxCej6ONcmMkWW40bdzZyoyOxOLe+pasaM=
X-Received: by 2002:a05:600c:674f:b0:490:b4bc:4f3d with SMTP id 5b1f17b1804b1-490c25b06a1mr197238395e9.18.1780855122914;
        Sun, 07 Jun 2026 10:58:42 -0700 (PDT)
Received: from localhost.localdomain ([2400:adc1:447:6d00:1c1a:7818:23f6:aae1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm379740795e9.1.2026.06.07.10.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:58:42 -0700 (PDT)
From: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
Subject: [PATCH] fuse: use min_t() instead of ternary operator
Date: Sun,  7 Jun 2026 22:58:32 +0500
Message-ID: <20260607175832.14378-1-mahad.ibrahim.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace existing ternary operators for finding minimum value with min_t
macro to adhere to kernel coding standards and improve readability.

Fix coccinelle warning:
  WARNING opportunity for min()

Testing: Tested at runtime via sshfs with file creation, appendating
and reading.

Signed-off-by: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
---
 fs/fuse/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f94f3dc082c6..67bab59bc6a7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
 #include <linux/module.h>
+#include <linux/minmax.h>
 #include <linux/swap.h>
 #include <linux/falloc.h>
 #include <linux/uio.h>
@@ -1066,7 +1067,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
 			return;
 	} else {
 		res = fuse_simple_request(fm, &ap->args);
-		err = res < 0 ? res : 0;
+		err = min_t(int, res, 0);
 	}
 	fuse_readpages_end(fm, &ap->args, err);
 }
@@ -2895,7 +2896,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (io->async) {
 		bool blocking = io->blocking;
 
-		fuse_aio_complete(io, ret < 0 ? ret : 0, -1);
+		fuse_aio_complete(io, min_t(int, ret, 0), -1);
 
 		/* we have a non-extending, async request, so return */
 		if (!blocking)
-- 
2.47.3

