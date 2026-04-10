Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F91C3CC9EB
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831755; cv=none; b=GKFMRlAkyfizfAdbhHpVMWPZQ4Cm6Z+zLf4l/l+Ve+8WuuuzVrcvoJ2YsaAjkUerDBeH2JqXVPE33xzNllPC+gzrp0h7SE9YAgoql2OZrq3JBYiJryX3CLKHYYNVGvtgtxgGsOqhQXeebeupjHp/xQZy2bFWZKWoyxUbN8jjbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831755; c=relaxed/simple;
	bh=5nFnRj4FT6jZjt8sFUab4x48m3ZmNzcQs1yF7dtkLGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlJPS0TH3dFCRbjlOgXmK/+ZhT4dHi6sQhIdjdEGs5uxj23rNUtoSeHb3QptbLyJAPddN8yBVXQNAbPwDJIoxa4olY3NiErgNsDhG13AN0m4BwJIdkSkJLp8CfOimgmFRf+VSM7welVsSyRSYmOLtFsfFWUNK7oVk0UzjtV3qYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isUQSo2i; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isUQSo2i"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso22331045e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775831753; x=1776436553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SE2TYNgoaeP3xAI61Teh47NCLwxtZ/1mLvdibGc6cXw=;
        b=isUQSo2ixm4msDSO4RbDCvEpgYRIov9lPohvV/EqnN7/7CjIGUEllzs5CxK418YM0/
         mxU+WTqWwBP1WChBHpWClehhFA4djKA1r1jAav7lu3PAntmbTh4D1bdV18UzBRCJbwyi
         q2rYfD1IG/jIVvQu0daHkxygnKml3aolrKvChpIMfmpFCdKPHTKSEhngHeY3iB4joQ2d
         +5AcSfaNPhLO3sdBDLQY5NcS3p3IXwu5JqEdEZ4CtIzKkfrNNHbz9apNyOpsmm6ldCFp
         QF3Lbokkp0doVwJiFs9PU1jI0Ie1lXyN0otbRLDfZ7AaHbo/Y9Flon8jCzVaUQwUS6fg
         242A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775831753; x=1776436553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE2TYNgoaeP3xAI61Teh47NCLwxtZ/1mLvdibGc6cXw=;
        b=bFetpMgygtGlVqQJ1+HLR0FzJHYqAjlXBOnoiLvghHA0ZFI9IR3aUYhP/7dd1GTpwW
         qgDgXQ0Bn7i+McSUvZUhUJh3nWVsWoSyNhcubzfzXYGBINGPsG6BBHtp014WOXFTduGs
         4HLk5TaZZ4YleCW8D5fYy+N6CiqzPH1xTGy63nkQaWEGcrCTul5hrYvBdampvN2mUb/o
         15J61mXc86r5wAoGpmz4gYf4RTD30hCGjaS4CsgBFI4Uuk94xD7qrFomiWm8ad0e1sbM
         L68EaovJqU4khLiLfO7RDENujST5/CfAkODzhstqaYAfRCaQEE4dKOTA5hgoqLrQLc2M
         LJLA==
X-Gm-Message-State: AOJu0Yw9x7f2yV+WbbkCy5oyEgsoEVHl8D67RtFhJ68PxHiHCqY5500U
	Be6FHnkx3idGgPfQhEhgXWDbAUPGhlw6h/siej2mE7R/+FZtVTL991+CtObMog==
X-Gm-Gg: AeBDievypyzrZtbIVtgwhy0O0VETiinuvnGVWAgv5K5kQY+e7c/qX6qUhHlKfsC5UWI
	TFQzH9LVUAMOsUPfF5h3dlH9ljS6d8hK1i8eqFu6aiwPj2uS6x2bylYDe+3EYzBarhusBkwfE2U
	zcsRz32yA/MhOYlvB1DjQkDW5S6WMsEqc3EhaDto6OptHUCs2JanDwkax5zB/OFzSK08nRPMv7C
	FGK7DeVS+4MYoYWYIyyvUL9Ln+OHKyjsG36KuEqpmsIV3E+M6TnVvM0tQvuCHmpc/ZAHXjegG7c
	HNHVMVKT9JoBFr9xw1ZtML9eLdQUljYNmVHVTs8NypHCtblVD5UpbcdD/1J5Fv4RyIphSw4OUVN
	IQDX0CG1cEnJGnxXLSsqCZuNHC24/e+TvWSN8iYSDlqPo2KbPViehyUqT43THXGejqI+PiknmOI
	oGsCCj3DIrJ0x8V8Zk6xWl3Fuq5OwZRCUeG4sSy6tYjOsmAuYoR667IzKo2C7AF0xdXwH7pqJRX
	IsNqbVXHlUe8Jli/FGwjg==
X-Received: by 2002:a05:600c:628b:b0:487:1fbf:e0bb with SMTP id 5b1f17b1804b1-488d680851fmr44354185e9.6.1775831752535;
        Fri, 10 Apr 2026 07:35:52 -0700 (PDT)
Received: from corblimey.Home ([2a02:c7c:37d6:c100:60ca:408d:517a:4a96])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488d53807d7sm128938305e9.10.2026.04.10.07.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:35:52 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] Add support for VMUFAT filesystem
Date: Fri, 10 Apr 2026 15:32:20 +0100
Message-ID: <20260410143219.308299-2-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Contents of a new fs/vmufat/Kconfig file that describes reasons to, or not to, include VMUFAT in the build.

Create a new fs/vmufat/Makefile

---


--- /dev/null
+++ b/fs/vmufat/Kconfig
@@ -0,0 +1,14 @@
+config VMUFAT_FS
+	tristate "Dreamcast VMU FAT filesystem"
+	depends on BLOCK
+	help
+	  This implements the simple FAT type filesystem found on SEGA
+	  Dreamcast visual memory units.
+
+	  Dreamcast users who want to mount their VMUs to view the native
+	  filesystem will say 'Y' here. The filesystem is hardware independent
+	  but is not recommended for use in other circumstances, so just about
+	  everyone else should say 'N'.
+
+	  To compile this as a module say 'M' here. The module will be called
+	  vmufat.
diff --git a/fs/vmufat/Makefile b/fs/vmufat/Makefile
new file mode 100644
index 000000000000..da423b0c7eec
