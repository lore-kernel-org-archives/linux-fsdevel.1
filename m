Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F296438BF6D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335921; cv=none; b=jFeJ+KYF8CLtsNYAhFY54PbMCla2wRB3KY+8LIPXD/+BEorxVIVWvEb/YFV6n3+y8z5iVA9l4w6cw2BYeJoMbwlPS7YzyE/PFjiTYnoQWDfBRH74fVMrZVpgkTomW4UfW9+qlay1fAkCFRm+eaSCaqoJRiFreqS7Wkj2rxmjvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335921; c=relaxed/simple;
	bh=QTXPd1hB5OoBOqzEGV6o8+Re6iD4o1doyu99EdaafYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eSl5wwm/9t2V2GxLWAe5wydU6StIUBJXvQ5punFrhHz55m6S6LXz4Pm9OW51l/SsTtn6HovGs7pD1SJ6fHAGO+0GwqObv8OZ80eGs/Z/QiykpoQjPnBX84wGUMrmxSJCkyyxbq64Qk5nfU7oWWbVvlugzCyft9+xWh+pguZAW1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvj4zvN5; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvj4zvN5"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so1843337e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773335917; x=1773940717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a56UvS1s4hV4Kk+HM4JSgbIdUK40Wcvh+zEE5FW6h90=;
        b=cvj4zvN52PE3wQt9D4r8wt8984WTs/gJZrzVHns8atoqpsbqIDqyEDHxN6lE1Xgt0N
         UuFkq2zn36EvDvjV1KbOlI0IP8AAy/LAFWt7irC7SFj/R01nKftSQBa2tZQpjcMrelUN
         sX8+fDZMS8CkyN/JEL/wZjHcTChDdlQFHV23nDLc53mHo8C0sCnAmVNR6m66wuOI1SRl
         H9emxLuDXEdNeSU3WxQRcdU0OiLdAmQl2x7GCKjIOB3jTljFGj40YoPSDxskK2DZJFLI
         bmqcunVl7f3gFD6MYOQ3j29bDVp6L0vL1t3Nf4MtqvjJ7nqOtHpU4/OPOxJE+uxj/Eee
         cl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335917; x=1773940717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a56UvS1s4hV4Kk+HM4JSgbIdUK40Wcvh+zEE5FW6h90=;
        b=BuSsVQleynJJfuqZ12X6oRqgt61axwMV+Jeueug9upy5xsgMwvMlUlmog0hpt/6Wsu
         r/P+cjFruQdDNvLxTYK0ZvonRrreKPVSpvD3OB8tSKV6uM1dYrFwJN+2mmFdzc8lIrpV
         f4c8qFJvVrsbGOkM+PGyyPa7APsd+gWjCSHn19zBzRiU/aQoFd+uNjAbPB+p9Sh+Frk3
         CnamMEsMz9qwmHo9aFL4UhCzvGNXJZbWvKLBBkM3ND3snHjVROObGDDWnfs1k2NH2Jf9
         hxODPUBS5zBSXVUOoAJKb0q6ZcWepO1PwGZ89U1ul5QmHLmHQ0UZ298gvKkh7sM92uC8
         81OA==
X-Gm-Message-State: AOJu0YzGINHa01ul1hvMJsNO8t68WEr8NmCGsrEHEDMjFIrKhOapA4d9
	rTWA1ldqKpCwhRQV0e7khvO2PLDBnZNoOj3tpI4Vto6rbhbnneRNY2JAnbzX4fYF
X-Gm-Gg: ATEYQzzi7jQ4WbSdloL6qV477YVY0uIOU8nzgQYY3gZlCRk7/HMPEVkpVvpaf+0dA9E
	xRRvmkIDqr8SIMwwtx1tVgfPgPKkp6G+ONcY/aXttjgDXImj1hn3+N7wZxspMNIWIx+XjKxWLqW
	L/6VtNtQsw4QUmaF58uAYy1NxYN1cDeAjZGdqgN3x23XfICgxcbP3Kj6c2XUi6sAQlvGwyLZuW/
	jx32z0A90Y5cUQBFWOtEJ2ieUNUYl2DUkDd1ovDfEgTO/wrIxQtJXV7YE9DSg4Lpwb6dM293lxr
	E/Md3jWMV8/wHZMNYK6lhuQtGTD5gKSXRMAkeVFHwQKCcnPbUcbLp99ohJEfckNJOkHL7vQENFA
	YvADz61ut7No4+SNzSVFtCr228UMON/64JNhVIi1rx0zcgaNv316lqmgMaqLnqZISd8TVsPZBXU
	hSyOzULEDcHCqeC6KoEF65vSdtkpRU9NaIlQLgfzOMuPpFAD6swAo1KYavtv6GZ70IpdM0fwo=
X-Received: by 2002:ac2:53bb:0:b0:5a1:3e55:8990 with SMTP id 2adb3069b0e04-5a1626ffcadmr86207e87.15.1773335916871;
        Thu, 12 Mar 2026 10:18:36 -0700 (PDT)
Received: from ubuntu.. (static.159.107.27.37.clients.your-server.de. [37.27.107.159])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156373888sm1036829e87.86.2026.03.12.10.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:18:35 -0700 (PDT)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH] lib/idr: fix memory leak in ida_alloc_range() error path
Date: Thu, 12 Mar 2026 17:18:34 +0000
Message-Id: <20260312171834.8837-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ida_alloc_range(), if the XArray operation encounters an error
(e.g., -ENOSPC) during allocation, the function exits early via
return xas_error(&xas). However, if an intermediate `alloc` bitmap
was allocated via kzalloc() earlier in the function but the XArray
insertion failed, the error path returns without freeing `alloc`.

Reorder the error handling to ensure `alloc` is properly freed when
an XArray error occurs.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/idr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/idr.c b/lib/idr.c
index 07098eb4ddc3..2ad96befa17a 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -460,10 +460,12 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 		bit = min % IDA_BITMAP_BITS;
 		goto retry;
 	}
-	if (bitmap != alloc)
+	if (xas_error(&xas)) {
 		kfree(alloc);
-	if (xas_error(&xas))
 		return xas_error(&xas);
+	}
+	if (bitmap != alloc)
+		kfree(alloc);
 	return xas.xa_index * IDA_BITMAP_BITS + bit;
 alloc:
 	xas_unlock_irqrestore(&xas, flags);
-- 
2.34.1

