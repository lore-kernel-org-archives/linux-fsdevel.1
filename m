Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D43D648A
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249634; cv=none; b=H8egKNNWncxySIUWk4verKsMQx0+ifR6H8NNJ/iCs8rt1P04KDg5N56tpbFJWJHfXO8NoC+G66VhpQQ+02nHMnC/XO0KJUCJqRoTW/LERSdkiwK2YT+VC4253uYe52T+zEOQY+W30LZccHrufuQXrMFWzzIkfD/68u6huZyX/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249634; c=relaxed/simple;
	bh=LnKPVXBGAitI0r33j1zUNsKKqO1qF1XAZay1hYAywRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JHiLk4Ao2WAaxN0ymELAKpYYK4nhmBB4g3pSYsOVvz/R2A0MlAhFLLQzlx+SLfCmNDip6Xy9uGt90NTuZ86HGirRV3qLBy/bhT5/WzMz35XwyTr3Xjku1LqpA+5h4cPSYUZb5/cxtd+qFOjz2SXSV8KjATn/g3LQfDOcbalCcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quCNtRbG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quCNtRbG"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8423f52af13so553016b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 00:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249633; x=1781854433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=86sYJl6zSWkXQZAp85YZmKqpMyYH2o2O7c4YC8f8h8c=;
        b=quCNtRbG9wVj27bjsv0pzoXM7kyY5Q3A3pg2yqMeVZ4ohpOWQKrX2csEs6+u/buqff
         WjNrx40phpSRayV0UjgD/D0Zzp+EBiGaydwbEMpVEnIB/pO77x5hCvjhNwp+5+UlmvVd
         U/b7r0yjVbo9lGFVUeK/p0MM4KgBjc+pbtQzbgUOUv5aILcVcbXbyTbpsp0NHFhyDmcp
         tq4qHTVXrrSpXLCaDpk9pxvlNWMzf4H0GSwbEDkp2AUs5Qi+JAzmcWQc+6dNcv+ceCAu
         hLcY9mxUEUIWsGwa66NO/UKyERBwaUba44Bf8K3JkwOfd+vCg3LlcRtZnhTop4luEuPd
         JX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249633; x=1781854433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86sYJl6zSWkXQZAp85YZmKqpMyYH2o2O7c4YC8f8h8c=;
        b=ZYTYCdt6j/HV9DNlDPTddIXxHXMvGHPLgSuDNSlV8nqLo9vN5oiAwYJ5Fn1dyTAzpA
         EkuWXZsenB6b0+6EptMVwAvW174zCqW51uc5VunxaCQEyyu1ZZ3Xrr/XQFvKqj0UG82T
         ktJmVKzU/eNzjEjgSc7JiqZ547QPNLkUwK4JOvoMW8qfgF7FMxFVJOw2YIu6ep0vANnO
         wel9Vi+Y/a0pKh3C9No+9/HbSq96J31RgtAvbrlz/5wR8hfz9eWosneZ8LKUbwGbNDQ6
         XRvh6SpWr2IfRamEPHlw3fod+vcStD+2tts10vfxkZ9xz7a03yX4ABo2xTf24BHoVlkg
         8Ipw==
X-Forwarded-Encrypted: i=1; AFNElJ/r1VbmU3vvmbkGSkkP+a9dO1SswF24ifFy639skEtYPl8GDSgM5+R62enBUkGJnsQnhhwcCSX9RI/IqW9d@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBARMLOEZtJhnXXDc2D3BUnT+zLX+rMZz0mF/aPxcEoXYZSKb
	hjR3R8U6PMrhkvU1dPNCV/MdEfznhMk0Qr1ZNwG5TWJbRL7f+SW+s7w9
X-Gm-Gg: Acq92OHRNqdCkLa3kfbKybnWs8WQL+K1ZCSGhRDuxGrlbhjOXq3P6KqoYrgrOUagd3k
	6BTbogFWFkV64GgSkqWdL346iyPRu3s0TSv5ffDYixJLoL7x8NILjUnKBSbrL/4B1yhN+o5iRbl
	CChBqMDkN703gReW5mS8X3ht15BVvQt9SFk79C2RBt6IMaOmbHLRIm721mifmsKzq4JSuU0tCpY
	A8rDOT+H76Mt1ao7Rxl2JWfSWwhPREdkI3l1oTbZ8IWyDa77EcFuxm6VKMES6lMkGpBiRB0b73b
	s1NpMaU0lKfZa/m4lsFnuhaIo7DRZ3fiPei4WTtdJiVf8g5Lb4l+49aQB76mkQ42q9Cz1QVanal
	WiNAoVBfft8kDAD2L3w8Ady8sQWubFcb4206bEuIUjIS0AlSAU6ICZ5muGOG/fXJj4/zVYVobUb
	i1kpaFjUFx30tfkzI4bkXjqourKTNa8IOkNSoQK93L
X-Received: by 2002:a05:6a00:1ace:b0:842:708f:39a0 with SMTP id d2e1a72fcca58-8434cae9ab7mr1861809b3a.8.1781249632737;
        Fri, 12 Jun 2026 00:33:52 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05d7d7sm1374014b3a.60.2026.06.12.00.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:33:52 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] ntfs: Support Windows native symbolic links
Date: Fri, 12 Jun 2026 16:33:30 +0900
Message-ID: <20260612-topic-symlink-v1-0-cc1ebf9528e1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2286; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=LnKPVXBGAitI0r33j1zUNsKKqO1qF1XAZay1hYAywRI=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqK7Xu5gZwV3ZP4du5wEEHvVlYcACwrWxgTRnRc
 Yy7p6Kk6xyJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCaiu17gAKCRA08jD6945I
 0xPbEACSppGD2ZnZy4EhBH7ztcJ4TmIx1iIBCIif4osuNKxhUedtGOkBSluAr20gy6xsKbAzA0W
 JcaSHOOeOnbP87FsG+cj9ZqLpahD/d6AMcRT4zOceWB57ovgJW9GMi/q+PQmc5+zH+LNDRX+Mzc
 h+RF0uut+BXA+2yX/j5HUy+6aKi8DlL5IfPMUuzh925citzHeSOR/vDo0XhB0F2ACXKBrfUyLdm
 esGncSjOT1gN1u5+jjisynrnB9ttxCotaXcHjBUHSd50325nw+UIPD+7azQXCO7w8xhuf7yw+eY
 l0nA6DOR1swSRsoMjdVYdNrYiOqXOI+eBKHX5pPFRGZhgAtYb1sNCIJhEjNWmCyghrdVH+o+cv3
 lLYSxwPAvE1Rz+xIsLgJLBk3u3KLfhQHoYXaQP4UrZtUZZ5m9PxAdNcFKLu6BfVYz212Inncdt1
 ULs7X+4BvstNRGNMUH7V3raOMoGPqeeMmcgUvPX6FzOMGeLbBDMJIf2uxc3WTs9h2YNMcZ31sMV
 LoC/QLkx0Ryjn4onafoxvQUj+OGUZV/AGr9k+Gw1qVuLL2oUZrTk9PTPriDPJKRfgC7SsvRamtF
 Um6jTmHJohG99rguABKasunURLyd7XFqgfEr8wm/xczrVoOmIfh+0mJc1DAh5JLK3TjR5OSvL7s EwyU0FV18do3JYg==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

This patch series adds support for Windows native symbolic links and
introduces mount options to configure how symbolic links are resolved
and created.

Currently, the NTFS driver creates WSL-compatible symbolic links and
has limited support for native Windows symbolic links. This series
addresses these limitations.

1. Following/Resolving Symlinks & Junctions:
  - Add support for parsing and following Windows native symbolic links.
  - Introduce the "native_symlink=raw|rel" mount option to configure
    absolute target resolution.

2. Creating Symlinks:
  - Introduce the "symlink=wsl|native" mount option to choose the
    creation behavior of symlinks. Under "native", Windows native
    symbolic links are created by converting the target path to UTF-16
    Windows format.

3. Fixes & Cleanups:
  - Fix an issue where the size of symbolic links is reported as 0.
  - Clean up target name conversion for WSL symlinks by avoiding
    redundant conversion.

4. Documentation:
  - Document the newly introduced mount options in ntfs.rst.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
Hyunchul Lee (7):
      ntfs: fix incorrect size of symbolic link
      ntfs: support following Windows native symlink with relative paths
      ntfs: support following Windows native symlink with absolute paths
      ntfs: add native_symlink mount option
      ntfs: clean up target name conversion for WSL symlinks
      ntfs: support creating Windows native symlinks
      docs/fs/ntfs: add mount options to support Windows native symbolic links

 Documentation/filesystems/ntfs.rst |  13 ++
 fs/ntfs/file.c                     |  24 +-
 fs/ntfs/inode.c                    |  49 ++--
 fs/ntfs/inode.h                    |   2 +
 fs/ntfs/layout.h                   |  19 ++
 fs/ntfs/namei.c                    |  22 +-
 fs/ntfs/reparse.c                  | 461 +++++++++++++++++++++++++++++++++----
 fs/ntfs/reparse.h                  |   6 +-
 fs/ntfs/super.c                    |  38 +++
 fs/ntfs/volume.h                   |   5 +
 10 files changed, 563 insertions(+), 76 deletions(-)
---
base-commit: 5aec1efb11ab2a87d1e4be063830268f7980ec4a
change-id: 20260612-topic-symlink-d70873e4721e

Best regards,
-- 
Thanks,
Hyunchul

