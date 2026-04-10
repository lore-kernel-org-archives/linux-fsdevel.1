Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E793C2791
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775832112; cv=none; b=ctWyneG9y63O+Et/BGb2favc4B0C2tpG9l01fv9jkwTT4LNkkwWvbBMUdnaXKoDASetnRsVcbv9kaGwxgzESD+iofAis2UYbm8ZYObReZ7IG328HEtdePTrkbBF0SfoRRyCTjiL5cqxg4ux3VvuAemLhWc1yZd4dt9UiroqYOI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775832112; c=relaxed/simple;
	bh=fRAUg1P7Rh2AymjFa1nxhidaGggEURGu+gDeknUJgHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=avcXruilXt0qxoEf074m4opWBYsicXqIgf5qL6HeT8tpPuVP9wEtIEEmoqiwfPlUWNWI5fQXTvKFrjPszHYEhC2xtDd3D81lIsa+DJCe1Yg27XExe/4UzrOHECuFzdyV0vfhsqssUBkqEqEXPokJ+za62Ya1YDpmIg+hU8ebkSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/NeZp9P; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/NeZp9P"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488afb0427eso27209545e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 07:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775832109; x=1776436909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fRAUg1P7Rh2AymjFa1nxhidaGggEURGu+gDeknUJgHA=;
        b=p/NeZp9PJ1cFEIV0mEQfhS+H4bitV0UBSXOute2YutZNdkSSk45QdkgGh1uI5DJKOD
         a4UT65F15Qua49OcV3q8xjWPvE6T/0IPWj9reMH7gviUUEDtnaq7GdqWPqZZS/apQxp1
         2q1GBKflwdhA/wVe8lIXBVtHOnZyEmEnYVC/PVdWwTDLRNGIMB99HiOLK10AhAPHriq0
         TBFD3V/TNaxCQwu16dmDrO47k8ob49nhRCZm4HUopsTtSgL8ALDizfyvVNRgjNtRnaN+
         5ss1TDhJRyNuUw3rnnxwb9llUgoD1RU4m+kBWVcpxGDz3FB5dgias+GSx4Y1MTVPZzZe
         fu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775832109; x=1776436909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRAUg1P7Rh2AymjFa1nxhidaGggEURGu+gDeknUJgHA=;
        b=dS/J+fj2k13PKPm6/H2rDH3mQobVeQhXv50+T9V0xGaTR09pRREStzQdD7ZLT7gUv5
         cxVDV2+02Nka+Gu6aOavhU2yUMDdzrPEOGE5/t0hjONlNYlrhZwdKHis7wY0lZqjUdEa
         pCEumJgH5TTHk8pCDFuLk0nAZnKEPqgtFeom7q1+QAnYiwgDAHIMrxtPGhaGoZ/909if
         XXZqiHjbKxzkoBw3PI53y8v4wC59PJUVH7gFB4J8j3Nm0unZEyzWYyh6OaUWYAkVMDpT
         cOt2Ba5h1cyD5xKT8R6SDTX+IGMTjXDqcRfyAZ8AaeQZ6AKqXsYApwkaV2fW83cwZVNb
         XLtQ==
X-Gm-Message-State: AOJu0YyjmITVfnZhOQG0Nds6nnM1dK46LeNH3v1E5VtoNonW+NnQXrqM
	2XvVkIi5lOY5UXoGSXGFiTZngqemeCEasfhWexO/P/zuLHMjqk3NUXIEP1ns9g==
X-Gm-Gg: AeBDietzLO7lpfctOCBSQAQ/LNaeLNCUB78u1ygWYUcRwdcDgjVAXg9ZLF09xP3/tMU
	rfhrxTFE53lMP8v6MUyzzzq6/sfdegDcmCBGj6COV5WCnrnqM34A7qoqKC8BQjxq5BSnoScn899
	6RnGBckWP+NacQMC0CsSpOlNRfTfZzWD+W36yJsilCdDLqZ8NGaMmvpTIwOUnnnlpYdfGZLH++z
	wqNjbf30doxdd5pP12d0MuUngupSdEq3BPOZvCg5j+KextxATRdXpVwteb9OzjOewdkU52LNpUC
	ycMfQcj8abFs/lTTpU7YXI+dK/gV5Pyb+k56am6zPwyY1+Ut+jrGdUkFT8A/jVGCrvfqjMDeGF3
	Zu4qcq/TlaOjYPTGYYRyahUoTBT9atCqB01+J3G4Up2PlQOrwC4VeaEdTCKYnLCLYgMvWtTGcPb
	L9XCtn6ml+s/r8p467AnixCdk+N3Wo3RJW2CG8Atq3xaXSXhS7r74KuC2Djj33JeBMWAKvepcdc
	M/EIYxWfqo=
X-Received: by 2002:a5d:5d0b:0:b0:43b:5231:e94a with SMTP id ffacd0b85a97d-43d642da716mr5555277f8f.30.1775832109296;
        Fri, 10 Apr 2026 07:41:49 -0700 (PDT)
Received: from corblimey.Home ([2a02:c7c:37d6:c100:60ca:408d:517a:4a96])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43d63deb904sm8713338f8f.9.2026.04.10.07.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:41:48 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH 06/10] Add support for VMUFAT filesystem
Date: Fri, 10 Apr 2026 15:37:42 +0100
Message-ID: <20260410143741.308424-2-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Populate fs/vmufat/Makefile
Create fs/vmufat/inode.c

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>
---


--- /dev/null
+++ b/fs/vmufat/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for VMUFAT filesystem
+#
+
+obj-$(CONFIG_VMUFAT_FS) += vmufat.o
+
+vmufat-y := inode.o super.o
diff --git a/fs/vmufat/inode.c b/fs/vmufat/inode.c
new file mode 100644
index 000000000000..62f3e371393e
