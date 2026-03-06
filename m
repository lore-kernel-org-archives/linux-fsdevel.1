Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915D2FF65F
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759186; cv=none; b=kc/DsVrTTE+eUeA0CYkUvhMjNLP9m3qbsnEElz/9kgI24KrH2VfVKqNmZ6p4U3FL9Y3xZBfv/6ctQQpGkBo8iMjz9+kuoKiMTIaDqUXBHbLTjnsi65W8h83CdxQzb+Orm+53U8Y1nQ2Cpxey3m3UtBtrob8Z8aaIkY2oFGWK7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759186; c=relaxed/simple;
	bh=EgYkzhPOC15Eim+iEQSC41uCdsZQXJuE7efPqDA7d5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9cTB98XeIi7OUgoUXF1xK4l3KJ7QhEuQjfgtEfVaRZqAbx0Fr2vpkI6eOIWcyYPiog32d1Y3eVw2GzFwL1Bs5iNkEE52UewtexOPiBQe+15M9+trQsMRM7xgTNlcrp8dgrGWDfhqEDT0//uKBy8zIGjLA+Pa27RoDPIz6vYgBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaN+VKg5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaN+VKg5"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-826c49b7628so5495594b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 17:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772759185; x=1773363985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDArlaFXG+z8j7ceHYDzQte8EnhFXl2/AKPC0NzLM10=;
        b=TaN+VKg5OfGLioZgVdTpGiYLkSDiHvBLBeunZqQPdqV+pZ8/F5CtH1+5km/4KNlNCy
         lW1R4FwBBnNNQbcwJuLYp/K3pjkIcnTTN3ngxFDaWxN6eCDZsqzOch682AXtK99gz5fk
         HLTpgfuFe7c4MgblyX8j0anrr7M3O3wl5rSvGVDK4bMbUpeB0MFoWe4ktrvQIXqFkNJc
         K1xfdt4Ew7tgjqHHaPMgMHN2ez5/jU78fR6EHwyMGxG40TbTadqvqftGvDN/8xMMv/0Q
         jEkMmmm/ZANhubwy4BLoTAnlRvDL55ZXPLoz7uris9N7UtF03YNQfeEqBSdzebgEWGfx
         jGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772759185; x=1773363985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDArlaFXG+z8j7ceHYDzQte8EnhFXl2/AKPC0NzLM10=;
        b=HuWuvd+pwLUwk45g+aHFJvTEXYH6ndlzOIurTFcGTwpJbsWf97n+p0UIcJFcMM5yZb
         StgC8Grdn3tuiTZ2KJI4LdYUTLUBcst/+omcrhe9k7QVNWvOlpXPlDnZ8fJSlwXvG6e7
         BRTaoyFFVBNmohrVa6K8RsnJEtqMjR1RDjNWPZkH2sAtXHtfdg8tY9xhIon8bNt3/E8w
         HpOkjPrDXbJ8yvbcBK2CZ/bDnkRUdSwOS3J3JKLgntzmO40HP1vVY0LPWp6BJ1tFFZS4
         fED4+v4VPgUi2vrMDCa4/nP/7FEKBTrFYky8iGLLdC2QkyywXWBLVkqmjRfnclVud+HU
         9tDw==
X-Gm-Message-State: AOJu0YxaLeBOxlX3SA72EACQn6RChx9IN8brC/XyHMQAoMdmHlTiGSlw
	5DziXr/kV3hI02i0jm87TuXfysOJre+7ovhTjteFQ9Xbbz3lKT3imyqeHBAIOQ==
X-Gm-Gg: ATEYQzylKtpKGbNYonsLDCQ1Z5+37SoPx3Gm2KjodJNKFVdTjNQ1vt9q6mnzt9hvSoN
	ZODesje/tp9dDJEJGtjuBsUXvwTACDNGNlo+l13bloAxCcgHT0MmX0OiLgPr1VbeBSy/9E2ztPS
	1oYqCwgJIg/byppwKbbU3uyNNhYHZxjhvaofo4UocR+BkByl42Dy7+fHMY2Qr2k2wqCxu01kI+6
	2F+2v2m+Y5YpX85FkqPtyPp80itfobAkxzbQgnovX6OeHoWpYJqPOJ6B3HZ5xslEZqyw4AadIE5
	VPVrUTKNlDtS5p/tL2/RfbazIEMkDmOhzTh4h28pisOFAzVaqZfpbeoTTNJcKnjAvbDdX80aaYu
	CorRAVF4M0+XCHctVHVSXn8eohfSqBE21xklhdXkCFCbOz7yXeKA5g/qdqSomXkSkRT7MLNN+Wo
	gTluhzmlWy9DmuMFA/
X-Received: by 2002:a05:6a00:3c8a:b0:829:8aa3:2ebf with SMTP id d2e1a72fcca58-829a2d924b0mr301025b3a.2.1772759185223;
        Thu, 05 Mar 2026 17:06:25 -0800 (PST)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82982de473fsm4075428b3a.9.2026.03.05.17.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 17:06:24 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 3/4] fuse: remove stray newline in fuse_dev_do_read()
Date: Thu,  5 Mar 2026 17:05:24 -0800
Message-ID: <20260306010525.4105958-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306010525.4105958-1-joannelkoong@gmail.com>
References: <20260306010525.4105958-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove stray newline that shouldn't be there.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8a0a541f3fba..585677dfc82c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1481,7 +1481,6 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	if (!fpq->connected) {
 		req->out.h.error = err = -ECONNABORTED;
 		goto out_end;
-
 	}
 	list_add(&req->list, &fpq->io);
 	spin_unlock(&fpq->lock);
-- 
2.47.3

