Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756874657CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383009; cv=none; b=HKiIXBFinpFaBfbEaH506A0yrrE6JXfqotYLS1FMZAp1ZIQ5SM9QSZLcLuBENTYHvxUlsLcbqmJB5DIj8G6upjB4aawpXof3dCXfCh045Qd7ZY7KJc4y7MPfJogBRbZ6ewLLlRkR231Be1bXcXE6Eg2FmyITQYZRt6fLZHpsfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383009; c=relaxed/simple;
	bh=9yK3v9zH8UgDPb53CR/yGT07CWFKeF816m2d6kBsu2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1lgI42nhuQvdPlUNM8Pl37EpoHwkBvCE6iEcd6z60F+4BSzr19X8UeKJ7Qf20wrPT5eTx/hpjF1Mvw9E19L4CiwzedJ0D00x0olLOs422/NJeeNKw+9dLDtxs8p7vFYPlDajsqu55aXPo0zDWb8TQd77T2Wez7dX2/HFWqoMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clZinBi0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clZinBi0"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43fde5b81a1so8537127f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 06:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777383006; x=1777987806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m9lH8xObJRXM9pSjbIssvHMZFWL9qCtbRDK/RF4gDf0=;
        b=clZinBi0YVpj9pN/sFHgKts3T+h6f6q1MLQLnq8Mm2WR6ztd5j4FLpkevRQhDJqq/8
         wVd0lIo0cmGD4FUnWPnKuTgI0Wgynrg0BWhCPfjTWaoV37cXtQu7HXxtYuLlHacYtO/j
         fXBbL/tZkvNmJyaAoX/L3imMDsiTUuABYfRqS+od5AOByVW5StMUuCwn5MzFlkZfwKdr
         D8d5FmibFt7BxQ4H+51z/i5LSzgpd5S+XOERoWxhq5H2i5OGxAyI/ma1uTKNn94T2TN6
         XvtqZkwTzQkivvjUBM9RdM07NahNq7gJ9c25AQ5ZxbBTiULm+EN/mEoSF56EvY2SwVT5
         Kw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383006; x=1777987806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9lH8xObJRXM9pSjbIssvHMZFWL9qCtbRDK/RF4gDf0=;
        b=Pa07hH9xCQgpTrvmT6wqQpau4GRIhJszf0kD7gcbENlqGxjpBJp9Qs2HQEp+UpPmFU
         8rGew8vcR6/4A0QCGvrjkR+qmp9Vd+eN+rhgvkOWyuVgW9bqrQ/uCtViautKspdbWOz4
         wJ1CIFp2gVgy2hs6XO3u6fsPle+AYEc8XLRHJf1SU0Bqv4TQkC8alKDzGIbbm/Kbkcsp
         WqV383+R0ddJx+JaSO2usD797sUOPr2zrTfo90SsphZFuLdEmjVKSkpCH1K42S4Zd5yz
         6NvAfbqUUpBQALH3QQEadBUXLfE1p+HfX4F+StbV4ZAgNJ6DnR8hdxUxIFd9YSnancnb
         7anA==
X-Forwarded-Encrypted: i=1; AFNElJ9vTq/QxA5eobJ4mMiGA7sWc2+WTIvXRseTO6MLceeEU1wxBQBuxYy+9eH3SyEafhXRb5Ylz4eWf4wIzfAx@vger.kernel.org
X-Gm-Message-State: AOJu0YwaEdkNNgDteAamecfsXxZ5E3taqECvlrV+DTwh6F5cZLItwSL+
	1j3uMf2Cyf/Uclmp9cdUZd4JZ/HaCAQ4ZiQSgkXVdqjG3U12wuUKHtS+
X-Gm-Gg: AeBDieuGAtmenCNhwh269PSRGRKclFjKY+xxEb/M9fRrulbG0iP3SqLQAu2HKkaTBJ4
	dTiQQiOELcEQt+PNpH4+TE2puGVmVhMV+b54mFB69dlkNYysoZXcCRejwe/7x+B8q4yqF8g2jz2
	WSZ8biiEMnobJlF6gWQ3pbvZf9cRjFbzpVxwzu9SFSr1JO90p50d8eXhSXav8QuUcFJCgmNS0D/
	UFIURqqBmzkf5FfzmnciSEb/Yf2r2ZBQDhrA0+MT273lezfnXy9a0gv7Il43LOJ+5Je7xhhGOqO
	UjTXYTNCvVTSb1yiJ5b8mF2IGIjrzRyuK5sLV4qdPoMzUwZ8glChBsIJ2+5v6irThQHYwNrJNJ2
	XFvYpNFG3teTF+r0t5xARD77OtT6/VsWtQvbYqZvFgNWOAL8dzRRuyWGUkmo8vNL+Mfl2ZtTM3x
	2adw9nB1djtuT6HyT8t8/Y7vabEID0Q8hdFGDVIKcTlEISUN+ftMKAUVuLcdZfZsbNi5uUzcQXf
	WJhoNMlGsRDcd/hOWSLHoo1lmnM2uQ=
X-Received: by 2002:a5d:5d05:0:b0:43e:a72e:ec5a with SMTP id ffacd0b85a97d-446487770b2mr5966453f8f.20.1777383005423;
        Tue, 28 Apr 2026 06:30:05 -0700 (PDT)
Received: from x250.speedport.ip (p200300c65f496da8f954fc28a74b8004.dip0.t-ipconnect.de. [2003:c6:5f49:6da8:f954:fc28:a74b:8004])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463cb59e5asm6714024f8f.5.2026.04.28.06.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:30:05 -0700 (PDT)
From: Myro <mirademche@gmail.com>
X-Google-Original-From: Myro <myro@myromyro.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Myro Demma <myro@myromyro.com>
Subject: [PATCH] docs: proc: fix minor grammar and formatting issues
Date: Tue, 28 Apr 2026 15:30:01 +0200
Message-ID: <20260428133001.11384-1-myro@myromyro.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myro Demma <myro@myromyro.com>

Fix missing "from" in "prevent <pid> being reused" and
add spacing in vm_area_struct range notation for readability.

No functional changes.

Signed-off-by: Myro Demma <myro@myromyro.com>
---
 Documentation/filesystems/proc.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 873761087f8d..d828006bd91c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -118,7 +118,7 @@ PTRACE_MODE_ATTACH permissions; CAP_PERFMON capability does not grant access
 to /proc/PID/mem for other processes.
 
 Note that an open file descriptor to /proc/<pid> or to any of its
-contained files or subdirectories does not prevent <pid> being reused
+contained files or subdirectories does not prevent <pid> from being reused
 for some other process in the event that <pid> exits. Operations on
 open /proc/<pid> file descriptors corresponding to dead processes
 never act on any new process that the kernel may, through chance, have
@@ -2199,7 +2199,7 @@ the process is maintaining.  Example output::
      | lr-------- 1 root root 64 Jan 27 11:24 400000-41a000 -> /usr/bin/ls
 
 The name of a link represents the virtual memory bounds of a mapping, i.e.
-vm_area_struct::vm_start-vm_area_struct::vm_end.
+vm_area_struct::vm_start - vm_area_struct::vm_end.
 
 The main purpose of the map_files is to retrieve a set of memory mapped
 files in a fast way instead of parsing /proc/<pid>/maps or
-- 
2.54.0

