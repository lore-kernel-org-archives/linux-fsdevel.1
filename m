Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3487380FDD
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781481083; cv=none; b=LVXHiKxZuuTI389SIlTkSx6L1J0XSrO7/RvWNx93z6XB6ag3jCoMq6T4DhsGVTc2Y4LOPeHwjSa1K+QOayrZaNYVJr9XmBsnSJ6bQ1RhVBA63mtMUVRPWk8jCfqTyouBlJD2FV+D0P4iwwnl97CXnXd2KcaLuoUX20J1iHQdjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781481083; c=relaxed/simple;
	bh=PsGuPFApl2uLrm2OEy+FMZkFyAqsshOQ6i+w3MfznxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buOt1SzMu8FyaC7DxCjDhFAyUDiv7ozDdHNdmldn8OC8bKnWLJPY5bVmXMCFmkpc2+vtxMN7DrNMRT1lD3FZeQfyYNe/gMN6t9T7CkwR1EYAs/Fu/yPKj/AXEmVG1b6Lntm0CWpSspkFfCtPFWl7WXP40SWUF6sEwDu9fuCrJTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApZlvfz4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApZlvfz4"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf3781ca51so23107415ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781481081; x=1782085881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6z2G6Izv8+z2ZU6btEPmjJDYxPH7qSG85DhfG1zhY1k=;
        b=ApZlvfz4sNxDym6bTcLI0XfOY1JKIUXjQo1E7WsrJlEPgGU+CcdWQNXLues/f0qXj5
         WIDNkcJm/joij/lxtrbZKI+AYGmQ2lH+Kvn78WXcxjILI2CiIxbf0igpUiAYdqc6P9zc
         WOmXmw33h8ffnIT2ex3K4+H8ATFpDMMKMgUhu7VnDHYAAPj5uZB1wKnghCYDs27ap6PB
         My7Px+9qaBAtmkuzf2dQK7DmDjZzXYAwiyTjmpq2oBhFfiK/RmpwTq3BLi7T/KIaMAS7
         k+yQnXeLJWD+cRUvha0BxUglJvnH2xcj1Ukbzin3ruHi21qbF7tIstabN9IChaPOYN3C
         brLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781481081; x=1782085881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6z2G6Izv8+z2ZU6btEPmjJDYxPH7qSG85DhfG1zhY1k=;
        b=cdGp8QBdV25eY4SqeuaYW9PIRCncQfwRS394qfMdrFhq5DyZYadD/tn0ZABaZdzpW7
         k/lAEgPl851w8IvG3uhcCAaF+u9/6jZQwdF0yDJyQMOZuRQ9uBU1XNLIT0To3dsuYxMi
         rOzUJknQe5dLC5SYNLjEdWT6NMW+bJhS++OvsWXs3Wz/ZxoA2TozWTBvzBJr6irnAAbU
         L8jSMV4toxwyOxZ32EjsmtS54vztsgaTm3/D575tUHiCYySq7sj3C976dnvUn/TtdtQO
         iV4AQ4AfJ4qXvLDBBEbZsFR4x4sZOzrdrpk2fqNhEAg3RZT0ZFYqahZm1TcDIREmgUdl
         o8tQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WhdQuTc3Cm9NLg5gODhLNZFOYED/ARLjCmhev50rSpM3vgROuJJLTJ/QWRW6Lwph69jk3kqON5v+xlwnU@vger.kernel.org
X-Gm-Message-State: AOJu0YySuay25XOXDAc3isob+8lDMFgRdw6qyKrHM03lRuabCVGNemXt
	96Wbzhjf0sjzaPTlfLDzPSgKBJCwGEiVxZ9sDPseM8kPXiWIva60wIN+
X-Gm-Gg: Acq92OHnE85opIoubEZPrD8DT3HfsKBal7ZEBVCzj2E3EWG+Is7vcHjingWOtulZ0xg
	hZ/9U2LglvnC2kMMCHrHWdz+hjH2SiO7EORxBINu1AijH/1I5JOeV7AFA7f7tMYzZJz8UNyQKo9
	p2azP1urQgQ1zlxbRYTgr+EW7t9nOVGujSh7MLomcv3xadzfkgnUz5syEDLc/Fs48e+N9G+e/mN
	20dcuXxmnMt7/cowvtdgiHvySu93HlganpSrK86zYtqJaCYwuP1DolmXQwH9WSqsXZN4JbIe1Iw
	6Ms71cTbdzZMvtA2L0xEDgEP9BItT9bX3AJqxrbR5HbQuveoUFd9rVKf4UwYTGdavnFgkEQrecd
	vCEBEpyDoGN9SoF1Tb/h4xfP/eEWqBJ9JHuSb37N6TnWeBOWTfZ7slmnF3/EDJe/M1VRB+Ijv5t
	FAdJ1zGvIi7iaZa/7vyMs/S49w+d5KdQ==
X-Received: by 2002:a17:903:40cf:b0:2bf:160f:7043 with SMTP id d9443c01a7336-2c664294e67mr91836445ad.34.1781481081184;
        Sun, 14 Jun 2026 16:51:21 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm86651425ad.38.2026.06.14.16.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 16:51:20 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] docs/fs/ntfs: add mount options to support Windows native symbolic links
Date: Mon, 15 Jun 2026 08:49:58 +0900
Message-ID: <20260615-topic-symlink-v2-7-648a769d01f8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615-topic-symlink-v2-0-648a769d01f8@gmail.com>
References: <20260615-topic-symlink-v2-0-648a769d01f8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=PsGuPFApl2uLrm2OEy+FMZkFyAqsshOQ6i+w3MfznxQ=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqLz3RgAiqFXo6mxtjCUrIkaouaHMMkCh6CGCn1
 Epxa4Wdv3uJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCai890QAKCRA08jD6945I
 04hoEACKE75Q6+tEliMctOaGKxW1/x+y67jeOz6euhsWn5E1FCaGUcEv7CCvr1eP4JqDKjJfi6y
 VJOnR/ZTyvqHFBzkxpsCy54+SgPo1K4RfDS2VQ3aN5Huo1+M7s0GACwVqTRlHVU8PpzBBWvnqWo
 30SftDlOnXgxg4w85DcB3Nb/+R/j6mZoct8HEOAiW9yaHXtr3Di94yjsC+UaBZ3mwzuJWoU/QFr
 PdOac1Lrf1T/Bo+UPVTjNSjsm/fHSa6fM9kA+PZl/aHfJUDgZLXbfPHxqbn/SDxiLVmfAtnVd6i
 7oPUrDD9wWGMfreuyZA4j06+eFAfyI6ItqwwQDtHKDR181ZtRzGF83Pv7Y4QVa8T/YbK7kytc++
 vFMY6PV06heIN38952rsfmpZuB01AwLXVS2c3nqhnn/CIGqvcfhAH2FJAfQo2SnxD7iPgwyyFgJ
 bz7knee8h60ydSRgs+zKBxWhBLHLIZPPss0we0KTWxjBSX5WqzO0XhrApM9Wf++rXDJzJSD46PP
 dCiiOPmxSi6zv0w/EWjwrXkVdPdHUgAX2Jgmq0QGwUiQ3b3L5zTd38u0KfiRvo9Ps7brQSclBnn
 oGufJz+OAJkUwdE4gKQakoqeOq1lL8rmvXQnVfgIsnWUKXR8Jx9DBRErok4uavyhbFBJDSAlbTn FcJseOFIci56Y9g==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

Introduce the "symlink=<value>" and the "native_symlink=<value>" mount
options to configure the creation behavior of symbolic links and support
creating Windows native symbolic links (reparse points with the
IO_REPARSE_TAG_SYMLINK tag).

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 Documentation/filesystems/ntfs.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/filesystems/ntfs.rst b/Documentation/filesystems/ntfs.rst
index 5c96b04a4d7a..4bfa392daec6 100644
--- a/Documentation/filesystems/ntfs.rst
+++ b/Documentation/filesystems/ntfs.rst
@@ -156,4 +156,17 @@ windows_names=<BOOL>    Refuse creation/rename of files with characters or
 discard=<BOOL>          Issue block device discard for clusters freed on
                         file deletion/truncation to inform underlying
                         storage.
+
+native_symlink=raw|rel  Configure how absolute symbolic links and mount
+                        points (junctions) are handled. Under "raw"
+                        (default), the absolute target path is returned
+                        as-is without translation. Under "rel", it is
+                        rewritten as a relative path anchored at
+                        the volume root.
+
+symlink=wsl|native      Configure how symbolic links are created. Under
+                        "wsl" (default), WSL (Windows Subsystem for
+                        Linux) compatible symlinks are created. Under
+                        "native", Windows native symbolic links are
+                        created.
 ======================= ====================================================

-- 
2.43.0

