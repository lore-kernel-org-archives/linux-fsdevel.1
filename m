Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4EB2FDC30
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311006; cv=none; b=rhQmFocmuV634hGRHIrUFIcc+ysRjhETfHKvN+2ZCGS5YEtQoZFfOBsyiRdYAJSb2GIPkgrp6XXK/WYg7KTPo+gATiPuwDSy5g+x9/GLh2aHlhkce/xlKf4nSJYo4Y+oUikoEtnBkjAhumztse5dLcOOABeMC70BC2ADYDuwcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311006; c=relaxed/simple;
	bh=K+PLmOasqiFz49SkYI5ZQC8ph7i9n+Ko+tC6kFac36M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmuMWaSwOMOCi95V7V8m/PBznY7XbZpU2ZpFlzI6qE9C2kuZ2XqU6BSufZoZc61AmyOnEt6MQyDhbwPcPKBBTw4t2qggh7ALh7TuI3RteMkoO3VUgg+QVZOnPALF8ur376TeNGaNmJ9bVowIjsjuQh+NKuqlSS6uqjWe+bqHdXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue86N306; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue86N306"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so17356815e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311001; x=1789915801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lYu04XwjPKA7ypsZV/R/wfXfVMywl2LPILiCNN7k2X0=;
        b=Ue86N306bpHMXOd9Thm4wxf8hgGgCAN9galG+qJ2pJ7CkAziCtvZgpiBf5RJH8Os6t
         a33BOJYTIfu++pQQQ7r5jEtFxZWd0PL2B2Wvro4mA80Q4SxZcFTlZEzn70GTnSH11QfF
         Hu1/ZWnEeit8wpAorqdBq0VHfzeAXm4xesBUVIsZEeUd69lW6uxUDI9sYC0HWcZL8UOE
         SSw0JxxuoAxpt5WQrWKGtVe1bS/31iJogWmnkOQyNw+MeS+GpIV3hRSf99+gOG3F0Hid
         YRIR/Fu7OFrCU53BruiNSLL7b+re3dJLgo8M+mYG5NmtZZzdo6x6a8jVlvq4+GNgHGur
         9GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311001; x=1789915801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lYu04XwjPKA7ypsZV/R/wfXfVMywl2LPILiCNN7k2X0=;
        b=ROJ3qSrKfHXT6X10+oXqOzNNtW9FzShIFUW9mhDm8CkDXEe3UssVh/LvWjTCGORaFN
         Kk90oo0T03PjdTVMCMB505kHRAJOCZDZt9oPHujoy3nfmv7JIgbckDPec3JWvYu0vHmx
         d/f6cirV/+WlZQU9gN2wtVKVQmlcnTcAISLBplahTr7oI9hmQxYAu1gjRBqIpiPNNfxX
         a+ioaV8+z0eUZtTpYJfn2DDkrccEPFoL7fld3aVlLY23bQFieUKO33sogKkG2PQYM89A
         mUR2wKxXvKIdYDLgubx+uGw3VBERbaI3InN8jt1RB8lLzVz1XaFdIeKmhUhwN/Nw/4Mp
         5Q9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxu/B0ZI2wo1kAdtaGngmC//0o/jPjeDGcURXTTFfBVSz3Et95OG+A0c2tbM/mZsWNJ9cnF0LACy5e5Ki5J@vger.kernel.org
X-Gm-Message-State: AFuF++kOPe+fE8J0LkVRWGCATz/oWiR2/kQ3wuxtNnAw7x0YhxjJqFex
	cTjUG8+kfQJzJzEcn9PAPaFdMLfSR2J3P4+hN8oIt6qHg6fP0WbQ0Fnw
X-Gm-Gg: AYBFou35hSB/L7a2hnM8xS7BGBhGOdtE7tX2hlCdvdYtRiSlQ3PfjN58ydZopZ6uHx6
	67u9lzAYaWGhXDtUi8JUqUwCaeWoBtDn1ozLwrbjtI3IOjVmEB7phCjqb2xUcPKF8vI/hjpGmqe
	nqfexAY+AW5LadN+BBKFBAuSaNpmoBDyrg5SzVy3D+iaYYA0axm9kc5bod1iwX337AeqKVYqFlN
	E7fo65Xm+97H4Jh7uscxMtyjimyKk9i60oLymUuFkD0W2/DUu+eUq338LaqWuXwdsSu0WVS2ton
	ylpUCvzN8pvFydvMZYvH4Wrlmu9pGbb2FWeb2QIqe+ACzK3CGF1aguE66kIglaaYbCuphvweDs1
	2oL2TbNds9E8NfAE/i1Waq1jUJkZ2GBr+UpCGNz82cGhyXUz5iBxOfSdrkQLbbMU75KulbQdWXu
	zXnYE47nLVaVOCntoNqI4ah2/iwhiZYDb2zj76VtgtbOR5rJ46zOypgcXX1j+YZquGTYAbHq8r4
	di0jE0WAqr3Pj0nqygU3+9p68Pgmtl8f1Z4IOVAWF0=
X-Received: by 2002:a05:600c:620b:b0:49e:6bce:b0f9 with SMTP id 5b1f17b1804b1-49e6bceb168mr77747365e9.16.1789311001488;
        Sun, 13 Sep 2026 07:50:01 -0700 (PDT)
Received: from f.. (cst-prg-84-1.cust.vodafone.cz. [46.135.84.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6420de77sm109534235e9.3.2026.09.13.07.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:50:01 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 07/10] autofs: use path_create()
Date: Sun, 13 Sep 2026 16:49:14 +0200
Message-ID: <20260913144918.1606123-8-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913144918.1606123-1-mjguzik@gmail.com>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/autofs/expire.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 5c2d459e1e48..9d19c47dc3cc 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -30,12 +30,12 @@ static int autofs_mount_busy(struct vfsmount *mnt,
 			     struct dentry *dentry, unsigned int how)
 {
 	struct dentry *top = dentry;
-	struct path path = {.mnt = mnt, .dentry = dentry};
+	struct path path;
 	int status = 1;
 
 	pr_debug("dentry %p %pd\n", dentry, dentry);
 
-	path_get(&path);
+	path_create(&path, mnt, dentry);
 
 	if (!follow_down_one(&path))
 		goto done;
-- 
2.53.0

