Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31337CD45
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2026 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786213736; cv=none; b=Ip341Y/FEI1CopcxuyOiAYlC9vAKT3VAiA8CzLHEhyPSNLfNsVDBqvJshqT77xBkUfJkBPBOKSzftIaShAFnCccMUApVp0XK8HnjAbqheJ992uqxKSJds7Z0GWVehbEpl0sJsbAnDm2bZT3Jwc6PCgQ4fA0bGfriXEuITBFi7nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786213736; c=relaxed/simple;
	bh=eHXYGuFJH0DpTFMSO0VJyJ/iNMrIg/3ibPIgg1QuJAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSnCpRrqhcQxG8y2b2MmOZoVbQr7lSFPO0QYRG3M3HeoSBZSugGpiP2wvYuRcQUBq6+xgU9tn8ZZxE9xB7VcV7OvXshiH0q1bnle+qUvrU00vwN7T+cRNo+Ae4A90J+Z/MCpaN2C112OHlcGPJX4+hznXGxvVfRmDUvFaixVp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ34Ih5g; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ34Ih5g"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38759bcd877so556651a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Aug 2026 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786213735; x=1786818535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qOy23ipwxODGlIWxGKXfEWrENnwVdZPAyIj7wHd89uI=;
        b=cJ34Ih5gOT+D/gppC8YnFhPFJa4ZpnJudnSa0LjmzUudUc0ms3XjVqzwFDQSQSsYSx
         QSkwEPK8aRLEE0R4lgc/8MLxTlpQf8DXDbKUQEamFbgywVdHyBkAo+pziq40E8tp348o
         d1lA6couZoiFJM4FJ9TUv22jfN9axQz92GElK5amRCm7QTkXAm8JGjmD7z2DLFnZ91hf
         MrjCJ5ShJGVp4RgbOOP47EM2Ibn2YD/qAksKtwVMboWhujYCwNRwqG81bQONu1wxLYsA
         kVNetEY/oNLFLA+FL9w1F+9H1IMOYxlfH4lOqI0o/vg0vOzCKca9dU+YFtMlv/2keINv
         mqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786213735; x=1786818535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qOy23ipwxODGlIWxGKXfEWrENnwVdZPAyIj7wHd89uI=;
        b=dFDHLPWiHgdcG64wplvU3dS6LKFO+BliKT6PZ/VMDScTJ4FPv4f2NoquZRW+as+r4h
         4XW2Rsj4XfeH1OpjxURECR0MRIZLMfJ9+KbFNNsI5Ne/9AOpVgCRO/eaddKRghwkCMuu
         Ii4pYYejXZGdeK1LqXL7GMcELjCaDcJDTS0PMU1N1Fv+NATb0LmX4RVdrEHP10ZrNf90
         u9NmMut3BFbrFgOjw0sYuI45CMe5DfUXzc1ZG+jNqRAQSwSfZH6DAXwr4A8b/x45Y0Rl
         50ivwTbFT5OnpVUg+oH+PnYFonrIps52RuVHkll7fE8ShD1o/gTIYhMDBJ9O61htlCZL
         GxNQ==
X-Forwarded-Encrypted: i=1; AHgh+RoQJPkiEdovNwq3Q9snxOkFURWgaDdi/9RltWxDreo0943X0hMmOWerbBgd1nxNhY0oIpuGb/06F5ga6q19@vger.kernel.org
X-Gm-Message-State: AOJu0YyidD8VxnP/h8iyc383r8G6F1X1hsI9bBa6m8lraDMNV7sWgO2k
	52Pyb2l254jmqoFDCySd+8Bq6PsHr6B8HwEqCPyStXLJwF6cbquo6+Cb
X-Gm-Gg: AR+sD106ThFx95tJcK8c3us4cC/qEi2lCQzKjX/uYZw8YaQKT9K+FYyHRQW0mrZ2WJc
	AlRIAe64HnLkYyQxuqqIuqOQ91hZAEHGG8/f0tGZZV1oOSMIL8dUy4DpVP5G1ZS5/BdgL4xvRPg
	It+xDWsOHXhguRvUFiKA9Xuaz7T7bnE4cianLqysCvmTJFWt3e8j+p8wEIMuvr7Ywa6sSl7WoXJ
	vgNIEnxpODzaKan/2sz96rlyrocwiKkOEqsNPuFq/luhIh45PYIEObqTMl4z4NcmStrd2OG4wcp
	dvU0QdwpF5IYQL+YaXjc18cEzC3XFyRuz8ja3gw8tTDCABM133CgDetvhFv3Ae5MXCaE7hQ4gxk
	WwKAA0kx6QSZWC/7gU5d6pQX7yAWrNohxx/Pohtck1kJVGVYGDdMtV03DmsOEv39YRYIo007dSL
	gi5hiPvzsaKy7KScwzbwJSrKLj/NcVFpBtynW9aAJa02/Z+6VICn+gO+m5Xb9UOZK94GAlcRUQ4
	KzzROu0ZQt1Y44WVyj68RdiDQ2u00pk5MfKdhvbUbKZhocHZa/ZPUh+0pB7MeHwemkTgXztSCNf
	oQ==
X-Received: by 2002:a17:90b:3a81:b0:37f:f8c5:93c2 with SMTP id 98e67ed59e1d1-3903c634c04mr25674878a91.21.1786213734579;
        Sat, 08 Aug 2026 11:28:54 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:94:ab62:887d:e555:df21:3318])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b41d9sm17941665c88.5.2026.08.08.11.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 11:28:54 -0700 (PDT)
From: Manush Prajwal <manushprajwal555@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manush Prajwal <manushprajwal555@gmail.com>
Subject: [PATCH] fs: fix switch/case indentation in sysfs() syscall
Date: Sat,  8 Aug 2026 23:58:16 +0530
Message-ID: <20260808182816.2399-1-manushprajwal555@gmail.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The case labels in the sysfs(2) syscall implementation are indented
one level deeper than the switch statement itself, which does not
match the kernel coding style (switch and case should be at the same
indentation level). Fix the indentation; no functional change.

Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
---
 fs/filesystems.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 673a03b5f..3083d904d 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -201,17 +201,17 @@ SYSCALL_DEFINE3(sysfs, int, option, unsigned long, arg1, unsigned long, arg2)
 	int retval = -EINVAL;
 
 	switch (option) {
-		case 1:
-			retval = fs_index((const char __user *) arg1);
-			break;
+	case 1:
+		retval = fs_index((const char __user *) arg1);
+		break;
 
-		case 2:
-			retval = fs_name(arg1, (char __user *) arg2);
-			break;
+	case 2:
+		retval = fs_name(arg1, (char __user *) arg2);
+		break;
 
-		case 3:
-			retval = fs_maxindex();
-			break;
+	case 3:
+		retval = fs_maxindex();
+		break;
 	}
 	return retval;
 }
-- 
2.46.2.windows.1

