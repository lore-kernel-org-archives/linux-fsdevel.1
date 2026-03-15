Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6643612F6
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773588918; cv=none; b=s+Eq7rjuKI8YRmf3PMLsuKcKxK5Ds45jlRfCSkXKrT0rPsIoE0+IRDTUBAWSKdgEtUflNuGNulwR9mhDXVTz/91+1asRvMgX8R0MgDanUopiSG0Cw14hWRJrZENxUH2uLRX9QI/NezhbBjRvyb93RF3OIt8WBZ/i+YlLDOvLzF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773588918; c=relaxed/simple;
	bh=mO13BHrKKr0NkSktX3fCkaYeb2tYhxBtLjWuzMRubho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dg9oz9T75Zmoy7E5EqYmeV2/py/w8pvFXy8PVoc5rvVODANaH/BUMkz0t4HvALx47VX0DymeAN3QX7K7ymgaBquu0OocKhC9oLXpn3zw0CeGHLP9rM0rIGZuUMu6U+tMrktTHLz9qlslvxLLxheazvwwG9EXdXvvG5Ix86UqJXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRRHzx8N; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRRHzx8N"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so40204365e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773588915; x=1774193715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilCE33luO5zcSw6pvT/x0TwGa05o3OBgHkATYEmMYB8=;
        b=eRRHzx8NBng8WL8NHa40yFyP0aaOA7OtKiyr2w82L/jusiGSGR5M9ABkFdSxP4gvpZ
         JX70AfyBEGxD/A2KeECRh4ttUdmGSLiNgGXIX9sKsjTgIUal6b39sva9odTaKrTmnfSo
         wlHEBElAJdZs/CiUk/3VXzneBAbNI51dMZKhiHhcGy0u56B8x+Ti2rrI/PbsnvxqnxzO
         6X0ut7e6GPxnIOICekLjCPIEOH5c1E/jo4RfVTAgI75EbtEwqSBD8Rs9a/F39KRgz/FO
         Tg2VWc0ymRgeG+ykUtvczS+Zh337WtVmfetFiSdH9Jx/BuSWKU5/tTyYCx794JkdW4SB
         Vhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773588915; x=1774193715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilCE33luO5zcSw6pvT/x0TwGa05o3OBgHkATYEmMYB8=;
        b=NkqfZZNQ3YyyWVZehSnrParuN2fd1Vsn6fs5om2//r9ZmVmvp946YXHb9kIj3efRZN
         PghkRs+taihFAWiPwCd/66YP5VUWzptQEbWjEWSthqhIhIch1QOY5t3F03D6lTe82m9B
         /IlwC2RbmloCnzdQmRd53+ncUSr+lDKf81UyR0yW3do9zw41cOzYCcsWyvrRHNvWsx5Q
         +qFLCpHpZCOTb2a9jFodstJMaG4wutIJuE0E3hPhJXHTS0WI+hVuUvvmUAqZAksSokAL
         5i21uvoad7vbUleNKiKM7v96U2GYJ6RK6kY1WGufKFnhDoOPtSsvre3WTzreK7zEjC6P
         nVIA==
X-Gm-Message-State: AOJu0YyQy2C7TStCu5UAUXyN9S2HVaqlVe2KGRpaHCDUwlnMhEEhgZJi
	y60S3EV++ELOKB3Fh4CqvK+KLvMO688k5xGai1uYl9bXveg0G2FQkXKu
X-Gm-Gg: ATEYQzwNb1CzCr2TptLKw6c8LR4Y4kX+lpF8RZ7tioRo6c9nzq2AzwOyYQQPHprK1Yy
	7fASOtiSFz+efhE1T9d4JRHZeBedaYbbreZFc28LYDmIXO1sYSkKYLsiX1qOMcF7DQzu7ASASfB
	DpSFYK207yxkqH9xQIOMR7QB9VLoobjNqAFOgxu3i8F5HilUP89vUvBLRUTodRID2QV6WIZPMtl
	0m0Hmqt8jBH1eAsCHpl3Rv+Eq+bs07mi3R1X5/9vm5utwmBegRVURJ9qzp7aezD+OzNmQywJPU/
	zdnPcaq0ob/Ez2nna1BTe8XJoOrR4IhyGKeiPnwnijS9L7bzLBc+n+SOCT63Mgy76IlrepybQOC
	PmEj9jXx2yjTQXg07VJlp9qcQxhLVhaxegqn2ULkm1gdrHmiknwc2T7lltA/9Cn5cE6mzaPz+hI
	9t5focJTPObkNrRZuMHSfn9R26pmtZlF+91zXHcMUx0RXmxwVxmf46ZO/oVXaSNhpxZdIQmmGDL
	bri6tQjWAY0S4/pHM3qKIiGyz7ncABtPvWYtXO7
X-Received: by 2002:a05:600c:1d1a:b0:485:2ce2:4c8a with SMTP id 5b1f17b1804b1-485566cfb00mr164141025e9.1.1773588915111;
        Sun, 15 Mar 2026 08:35:15 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b65fe27sm374102765e9.9.2026.03.15.08.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 08:35:14 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kit Dallege <xaum.io@gmail.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 6/9] writeback: fix kernel-doc function name mismatch for wb_put_many()
Date: Sun, 15 Mar 2026 16:35:03 +0100
Message-ID: <20260315153503.48583-1-xaum.io@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc comment says wb_put but the actual function is
wb_put_many. Fix the name to match.

Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Kit Dallege <xaum.io@gmail.com>
---
 include/linux/backing-dev-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index c88fd4d37d1f..a06b93446d10 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -237,7 +237,7 @@ static inline void wb_get(struct bdi_writeback *wb)
 }
 
 /**
- * wb_put - decrement a wb's refcount
+ * wb_put_many - decrement a wb's refcount
  * @wb: bdi_writeback to put
  * @nr: number of references to put
  */
-- 
2.53.0

