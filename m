Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943A393DC0
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850892; cv=none; b=OYojgRM516Q8gBDv0OJ56L9eF5qXEvQzyVtZ/UGos1SoDNO2Ph25gczBg2QqIlHmXXbndg5PqtXILnOtD0wdNBNWBmBpHI6z56iIws9oktz6LBH7JjGAXnCG+/HBnITg01oyHyo6q1kiJuaw9jTb0Avse24rsowb66VBAOlT7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850892; c=relaxed/simple;
	bh=WHFKCdJIxJZts25V574gufTxt/e+kvWyiWNqWg4+FaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jku2IwFysjhDc5R7EahepfT6b2W1r24RWlwg/0i+b06M5u3zP0PtXWDRjYacW3dNfaVYkB4CIIUlz9a0F6LxHKHMCd9kPrc++EjnJWv448DOpizyAfJVK69YDbTGP+zdg+L9vOFSE9DZr9alCzqs9LVAOJ9/V3lMo/jCjHTxpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cb0SpgOk; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb0SpgOk"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso1647084a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789850890; x=1790455690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UklQyeMvhqLuej0je0ggi0hTj3VJTG/i2EoA/FxL8jY=;
        b=cb0SpgOkmSpx4HbI+vXW9P+Sy8sbUPwjOyXOs8dOCOqmceKIRpPDLumdTUjeuMK/Lo
         EDPOvc2eISYzH0sl8SQ35AGjeSqBz6FIbbKf9xh+Otc5xr7tqoo+HtTtIPIDM2LxK4Ct
         +J9kLPVG2pOyxFnD8hWZtW3JtY1Wo6t/oddpt2SJJUEWTAko0MKS3KStTcf0mNe4aP3O
         HHKeAFE+1/3Elb3vT05k0XiHZYHZ568cbiHHPOQER4GljuNlvNPSJEBjSVMktkz2EqjI
         FVOTyOrTImqq6fUvwB9vTHudhQvhBV+xTJ7sShb0/VrG0pkD1j9n2acXsX6E/tH18XRW
         e4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789850890; x=1790455690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UklQyeMvhqLuej0je0ggi0hTj3VJTG/i2EoA/FxL8jY=;
        b=HoeoISCiweIymVG8q1N9/hqdPyIn3bwq8XaII6K34CLmda4TmKYi2bznnXBpwWy0fs
         acKGSNZE0tYmiaoHerkooLgcAtzWWKqiOKvXOw5ummAZIErJews2rK+T+cOfexCfUOBn
         EP6zro2nTKhAkmdpGx3vFYm9qd7BzsiDp547xjKqC/tRMVAPIOfNd9r9yLAjqwzkzHnP
         w3M7+0aT48RykCsiulsMBPR29weN8XAboIQVBmxhxZC6j+PQWKRNaW8W1g0IGuREw40/
         nWmPQBKBG+v6jQ0qFH3FfLSaXIn6c1LfApzM9JCOkErvJ2VJCwPRpyeLNJ6DJjeXKwmj
         GT8g==
X-Forwarded-Encrypted: i=1; AKwUvByIPLI3xXe7fGM55Qxs8t9XIhiVJ2MqWyLQTlINNsFfztH7BqXZgIyzekgwQQMfMSNugIvlbuEelnmm1Hkc@vger.kernel.org
X-Gm-Message-State: AFuF++n/kIjcW/Udvc8YUbYTXQUG7RPrRGVoJW9J5KLRs9GaQMtsj3UQ
	ihkkabPV7vqmVy2uIvfXBSqwsJa3wQKfhaVepyJODMYKmKvXxuNun8jG
X-Gm-Gg: AYBFou3QVWICvYDmLC4yDgjrEYmb6W68wchRmq85FWapQUwlwaQRG7PukE/nOGt3pVc
	aJi8MAzpUddD1ZJgY6LN+WhiS9c7flAXCsKHFJU7vb7t/N/k13KguRxk4Z/OIQncarA1D43WNn8
	QfAx9nTpDd8cq+iO9JywA+ZAVFupmeAGwAaqU8sxX5fuVNRjgF5lxD3F6ooCby2l5+BuwC6vwS+
	yjNU3RCftHcfZ+qGc5CW/2GmbR7Mh9vhKo2mLAVECsIQcFX/VFHwoipPUbsMIgr73EHNIGl63wI
	Z73kHFP6NR6iahSAr3dlT2DtPiTaUYlc2CH20qMqPPWhZ9ipdomk9dAjnSKtvF+52v1r9eifc9+
	iPl0gHJ2bsoK51wkkSiHH+GWnSroDpvOHfw0BGJyY4lFDyXVX7li4zrtm1zdhmRXo04liRbfAX+
	W673Dv8Pn6J0Gg964adMTKvpj9rI4WiE31lTdLxeS09z8ICPFqxNMYKbEdd3Q4cd2X2kX7Gfi4Q
	S6HmqGBeprYGgYILQDx4N/7m+KgddXOrxXAOKiKZvssd+dtTA2QVUHmhzBJMlGwLDHZ12eREnTt
	OQ6PbLUjUFORZ3DdMGOW
X-Received: by 2002:a17:90b:4b45:b0:39d:f7dc:61e4 with SMTP id 98e67ed59e1d1-39e54b204c5mr10849177a91.9.1789850890079;
        Sat, 19 Sep 2026 13:48:10 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca50694sm6848858a91.2.2026.09.19.13.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 13:48:09 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] autofs: fix sbi->pipe file reference leak in autofs_kill_sb()
Date: Sat, 19 Sep 2026 20:48:08 +0000
Message-ID: <20260919204808.2812930-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When autofs_fill_super() fails before clearing AUTOFS_SBI_CATATONIC (for
example, when find_get_pid() fails on an invalid pgrp mount option, or
when an fs_context is closed before mounting), deactivate_locked_super()
invokes autofs_kill_sb() -> autofs_catatonic_mode(sbi).

Because AUTOFS_SBI_CATATONIC is still set in sbi->flags,
autofs_catatonic_mode() returns early without calling fput(sbi->pipe),
permanently leaking the pipe struct file reference.

Explicitly release sbi->pipe in autofs_kill_sb() if it is still non-NULL
after autofs_catatonic_mode().

Fixes: ebc921ca9b92 ("autofs: copy autofs4 to autofs")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -51,6 +51,10 @@ void autofs_kill_sb(struct super_block *sb)
 	if (sbi) {
 		/* Free wait queues, close pipe */
 		autofs_catatonic_mode(sbi);
+		if (sbi->pipe) {
+			fput(sbi->pipe);
+			sbi->pipe = NULL;
+		}
 		put_pid(sbi->oz_pgrp);
 	}
 
-- 
2.43.0
