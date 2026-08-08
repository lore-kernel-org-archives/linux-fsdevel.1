Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFF24052B9
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2026 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786192778; cv=none; b=CV1hDCsemtDJPUTFvA5+Sb1LjRMx3GkBVwv4CEkmiIXk1XQkLcPECGZh4yTs4Ka0sVVJG6vEzpIY60MBEMGFLxQLIxSJCdmLHzHZCtTsWJ2OROqYe1Z6temMb2yrM9xmdE3uGIlQuXye2IOPcyfS2zsSSzkrnJgUD0PiaEU4614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786192778; c=relaxed/simple;
	bh=85srkDPeZbBLcEV4biJz4+YbelRQVTtBPqaA0MiBB1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CHo3Pj8axUbHMYcDDS5u139jiFuBC9FAvDpt1NLCOjSiFeM8IzApe/HBpE4flzjfTN8fn/GpITqeezstEZFmHcztKValz5tlfbfxJTgGnPztpZvcFULJ8pqgvasJbvL+GBBMYLsvrQzp++KZinNdu5NY6TzcEkBWVzIttsJ/RYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIr3H7wT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIr3H7wT"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47de008b020so228630f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Aug 2026 05:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786192765; x=1786797565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hILZct8Q31WMh1Hewr5Ii+nB0Cbikr9Irq+ZzUZUa1E=;
        b=eIr3H7wTkxi7JPnTm4h7G28vpe0GRU7juUrRD8fJiaNJ3tmDrouM+vFXqYHJHuRl4Q
         6l5QPRqYVJKMGINgn/ur5nK2scEBuWzOIvRGyOtTvmnbe/4SchJ88QQ8z8lW44/YfcqS
         o4562c8Errbj6gtO6pv9iwQ5x5jjz8xfd0TqgyPCM/rWJ0xLCSB4YOiH1WEl21v7l1uw
         OI0sfdHagO5R6ZPIE2uZ/cCnvCLDSCMCkDLaZkggtDiys31sLgvSGPEpxaeL7aSgUWVT
         gIpNjUu52BDicmSoMx+kmsIhzGaUsb0s0jajZ87YkOtx9wTAw6q3UqO3R0g80khVVs2l
         Xe9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786192765; x=1786797565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hILZct8Q31WMh1Hewr5Ii+nB0Cbikr9Irq+ZzUZUa1E=;
        b=p+Z5R24wUzR81n2FzeVkdoNVnj/jeTdxWidnDJlAv/87texwiAfaEAQADXUXGXACUw
         MehBFLV+hIWj76tXGg4l7RBOU5MdjPBj6vj25LHRLWDaXzQ0NHavLX7WeMbhMf+qVHPU
         aT+8Ur7+R7mgCC/ui0DLPlbEiqpFbTzd+NPcrVCZHQrWZHfjIx12T98dGO29YYodzppe
         uG7iVNJBqBiRsyPtIkfA8fFr6U9yjr0QDxw8D5agUXKFN9HX+IEyzCEQixERaEq/aEmg
         LgXfD5/jAVuiMbs9ZxWsMi9qfkxbJ7bHRfbY0HkbEcZX0Qx/L57aMrJfDBCOuKTL+EwA
         ruEw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6XybiKBAcZLrHRefglSIMy17pRwkvMv1vtyzRDhBaPQKeKBoBQSp/L/5oPmtpnzvg9Svmv/Fv1hhDEtW/@vger.kernel.org
X-Gm-Message-State: AOJu0YxGLuNqANXZcnp4rAYUjBVUlG8QNYS9oQgxISFlleB2it4/UYmg
	7hPITfnEw+080QO5jdjEgpZa+kp097DnnHxxLE3lcaYyWzLovF+8KqwceBsVVq7m
X-Gm-Gg: AR+sD13E3n23pT5QZp9wwyh1jSYjU0vxgBD5DYyahj38UI07SIsOJMKpTesW+wz9T9p
	Yzw8OU/VQMg8RRDLzCTLzcl3Wj/Mf1W0dlgbqidxCpE2brz2oKw3iWdy3OUYHBVS4o+uHUBDnW5
	7NvITJorycCV51txw1jNgy9BGFhX7WJ363JArgAs8E4AKzUWDs4WHxgjywSs4JuBwts1+++Qs65
	hAYOLvl0WVhry8atqk0IpUecs8qjaMbIUMB7Q2+I3zeVop/Gb+vMfD+hAkD7jisnScrKp8oYv1A
	paAGa7aqJ+VDO0SGX7OFdpyLb1BiRJ5RCsEcq2L01Qtkcv0WP0X1rwpibE9F/58SUQTa+9TQ/q2
	CUd0gECCWZRLge5th12SSWNHVn62cXzZivFlIoI3FexbeQIG9UlDMGVEAUN+zrfMV4wuLeb56ME
	BbfpVHB7rfscmheToJLQRHpi8Pn/5VTKxuM/WvO9rZSaHPwqLHDsKNaKpvDBsSf8t9BZgmJjrNR
	Z70BmuXV5tBQCB+kzHjMQjLc21X1m46UO2TPCqLlg86pqSPOlmahk4qpN1mmMDcJNw6j5yVRzNv
	vJ+MbieyIeSMz6uOeJIs
X-Received: by 2002:a05:6000:609:b0:47f:853c:ad7b with SMTP id ffacd0b85a97d-48131962d3emr6810412f8f.9.1786192765075;
        Sat, 08 Aug 2026 05:39:25 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-004-134.77.7.pool.telefonica.de. [77.7.4.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8c5asm16200335f8f.18.2026.08.08.05.39.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 05:39:24 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] super: fix dying superblock warning messages
Date: Sat,  8 Aug 2026 14:38:02 +0200
Message-Id: <20260808123802.73687-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WARN_ON_ONCE() takes a condition, not a message. The string literals
are always true, so the warnings still trigger but the messages are
never printed.

Use WARN_ONCE(1, ...) instead to print the messages and keep the
once-only behavior.

Found with a Coccinelle script. Clang's -Wstring-conversion also flags
such calls but is not enabled in kernel builds.

Fixes: f0cd988016f6 ("fs: massage locking helpers")
Assisted-by: Claude:claude-fable-5 coccinelle
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index a8fd61136aaf..56efcf1c31da 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2012,7 +2012,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
 	int ret;
 
 	if (!super_lock_excl(sb)) {
-		WARN_ON_ONCE("Dying superblock while freezing!");
+		WARN_ONCE(1, "Dying superblock while freezing!");
 		return -EINVAL;
 	}
 	atomic_inc(&sb->s_active);
@@ -2176,7 +2176,7 @@ int thaw_super(struct super_block *sb, enum freeze_holder who,
 	       const void *freeze_owner)
 {
 	if (!super_lock_excl(sb)) {
-		WARN_ON_ONCE("Dying superblock while thawing!");
+		WARN_ONCE(1, "Dying superblock while thawing!");
 		return -EINVAL;
 	}
 	return thaw_super_locked(sb, who, freeze_owner);
-- 
2.39.5 (Apple Git-154)

