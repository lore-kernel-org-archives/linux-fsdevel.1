Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C326CE05
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831520; cv=none; b=DaXIh41x55CBKturaf3+rl88jR/Y7YDoFr98RxVp1I8FDpBqd+msIfIrEoirobm5fI4X/nPBlFgHgZqT7eqVDKXv+WnPfMS7nlnV4854gvm/qehnHfM80ezOtvAwkWiNaFtVWIcefC6rju10vvH+MQLBJ5acKSAdn8n63Y/W850=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831520; c=relaxed/simple;
	bh=/y4ZCaBykD+34D0JcG0earlcUImWOHCyTDd8jmT5Mso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6gJsDrDDZULFpum1aJfWEFViq7s5APoDgu0/Uzxf8MQWmVyE+3PFK7kDOlocHJ4SSYu9nQmb5ZSvRIz7xrXwI0ZGTUe/V7/duTC8ykyobwJk0cpOeYI4VzziEsgzunDrDFv8vxQhXtBQtKyCls1v4/b+US29w2SpBzYQpr1xo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7OI7DHL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7OI7DHL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488c2690057so20782885e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 07:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775831517; x=1776436317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJL5U5pc2570HoA+McqXqLaLrpAo0lRDsFuxK4mgIP0=;
        b=l7OI7DHLsK/RTN9Dwver8ODPQG9wYRyJmjvRJxp4KqUFLtjPY32K/C71uaI5rlqvxY
         4ac3Ak2qhMVCV30ggxi7/uDykW5QCfyGFQArNZ28t42wVetMrqAxtPdJxQBV874FOEWf
         QYynrCcCDf9vln610KGSrhCk3c3edSMLwknRGuh2jSCVxfImhv7vEmJPrgNMtvyWno7K
         w5Athh6B0ZJ7DAFU8XE6mCdKszGJ8ndd7A8f6lCWY3Ghp4QHCAN6XHGcCi6rPA6rPTe5
         JWIoST38qhfazHipw4BCe3phxNJu5BqF40bfEbrifYew2vUD6RTSgzdwXB+6b53tw+wL
         cV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775831517; x=1776436317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJL5U5pc2570HoA+McqXqLaLrpAo0lRDsFuxK4mgIP0=;
        b=svqd5t7+qsXtSp4SxmxhyqPpklu7DHmt7htu6e11vwlgAVBQcsyFI2vzn3cTYCbtvL
         x0HACA/hpNB8GcmNWYikbNpbjH9JsD/j9aneQyWEbYG/VCYGglNhB6u+96Bw1l0Ipq/V
         F9POB9hbGuyIIBVB9GlyaxwNWVyjstOZuBoegI6Op8tSkZcKYrbw1RCgXSDtR11JWOkK
         BgbEfCJ5DNi4jrg3TaMppbdS3kIRV7fmX3Cyo6MAluyWMa0NdxVW/wEuY7f6ubKzEip4
         +4MVq/rSXcBRwNyHYsnxGYT3UX96awOvtPlA77hAMwlvqeTJc6RzbmE04kTM6NrstAGr
         xizw==
X-Gm-Message-State: AOJu0YyJsz+cbUKNaDnb8voXE2hGcYLOqzIVsd0wOnGjUzHcCmW7aKR8
	QMFyfYeHqLGvnBWGDQHwmegX5I7zPlmyGvc8rdAyEqK59zd2GNZGnrf88w/A/Q==
X-Gm-Gg: AeBDiet4Vx5hRYF+wfYSBDbBbiROWK/5MgwAz5L5Fm5wmxDUBu9yoHPnZLlk6d8NNe0
	ZbGAbde0jXPBhgApacgdUd+QggVmZlIm4m3Yf40gPXGSiYESRPO6yDvBo5reQPGGXfk4/Uc/0Kk
	RaLad4IwcPoPVbCA4/2J0qk6gqF28L53QDeiaHu96YZi6x3oWIwoeS82KovbzKrjBjjP8RXIdTd
	rDuBeYgGar334zSGrF2MXPVFJsaiLer2Sk7JmLfGNuDTKPLr3WH/uYNKqCAdjHGAUgYAmLmlonf
	z2fcKcGCecfULPrZ8bjnh+G6BxAEPJgUJwEroGIHjOSULcJyaq65vGLk+BT8J/Pznq5rdT3RuQ6
	HsYsP865p2XLr1NrVyO6+pmkDhsd2+wfFOuhLWtvPMCuE2g1albBrkHwYTLJImMuX9+V2YPyRMU
	pCrpemKk1bUMlEECKSdAZ++g26CQULudTR+A/aRWLs6f2Yuj0ZH1mcFxIfEDsOFpUSyZ41QRU9z
	bWYY8a5GTA=
X-Received: by 2002:a05:600c:3107:b0:488:8b52:f7de with SMTP id 5b1f17b1804b1-488d6860930mr43216015e9.12.1775831517430;
        Fri, 10 Apr 2026 07:31:57 -0700 (PDT)
Received: from corblimey.Home ([2a02:c7c:37d6:c100:60ca:408d:517a:4a96])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488d5344e28sm82747355e9.7.2026.04.10.07.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:31:56 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH 04/10] Add support for VMUFAT filesystem
Date: Fri, 10 Apr 2026 15:28:59 +0100
Message-ID: <20260410142858.308189-2-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update fs/Makefile to add VMUFAT as an option and create fs/vmufat/Kconfig

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>
---


diff --git a/fs/Makefile b/fs/Makefile
index cf4a745e9679..3cdc3d7b804c 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -129,3 +129,4 @@ obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
 obj-$(CONFIG_BPF_LSM)		+= bpf_fs_kfuncs.o
 obj-$(CONFIG_RESCTRL_FS)	+= resctrl/
+obj-$(CONFIG_VMUFAT_FS)		+= vmufat/
diff --git a/fs/vmufat/Kconfig b/fs/vmufat/Kconfig
new file mode 100644
index 000000000000..92553a246911
