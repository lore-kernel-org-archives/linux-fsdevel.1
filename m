Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277513F9281
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788039188; cv=none; b=mvc/38/E2KnERjsZaK3SyfSPqaIxakH7sKcDA9k1iSxrR7erwrD87/RrDS24hUSfDCnoYoA4/nIJfYOXCH2eYRyl6A+7oPgLw8qbZmjw8j6R129tzGaDw7LZZqwIQH/ZacAfRJC4UT3xoVgz6GXJuvbWj/4rkvJEzB4GrZefZ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788039188; c=relaxed/simple;
	bh=Zt6xM5ByKMqjss0Ju9Pq8lrUfSmBQl0+BHJmcT0gcU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NlcEKjesz1lPHgovttwlr2tcR5qDpX0Lf3mivH+CVJsWlUSHKGO/QpID6WNpQlkiZeW3CzzjISU+8V1JNe/OEZQUNyJk9cDiOq4UCi3wPSqs4qQNqVK10I87G8/nAzusr0vLi/YNwsiKbY6S4/gw0ezC90eQxVLhFYo/mOpBhOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1pRPMGO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1pRPMGO"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482e067e908so1534328f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788039185; x=1788643985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ucnD2vvZKQodkVcezxvV4KyyS73dxyfqz8xpesSWdQI=;
        b=A1pRPMGONSvtnDEQSeM88hjsR4UhzcAQhj0khTIC7Kcg4ylw7Hs2Pp1ze0Wzml5xEY
         vuEw+SVSZ/VOCZzx44S2OhfeEa97fyg++wvqcJ+h7khmMFjcxME3guYCom6RXQU2XX3v
         TScKUqTfBJVT4IgbmJfe9G5pEfClUwmBXHlXLZTwtgnRhmGsgirYEHf6khLFQR1JnU3g
         9X8Rtk5up1uqY+KmUDI1pXc7QLqp0I+sTCALkRSD3QZPa8kiXhJ3yffXwH06sl93+gcU
         QnU57sOzivcNJ8juYFAMciOxBoJlyzZlFGKYTIrbMvpoq22mHXzt8bYXuIKTF4Zrmqgm
         YgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788039185; x=1788643985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ucnD2vvZKQodkVcezxvV4KyyS73dxyfqz8xpesSWdQI=;
        b=mHr+9MwA3WX9scIA6yh9lhZ/u/NxHrKiSbt4mbTc8J1hOCW3nI6Bdsts/73/GYXA4A
         odOYK4eBDGMVLoCGt9NERedYgKrHd0D//Jj5Q4bbhdRz9+2ZN0M1eAzBYe7ZFQ4JrcYd
         ebBquBRsAQdZtOfLLYgGJVW2qnX19/7+tIImwlAd9C0JySKeSGVzNcG4XrYoPrx+0wO9
         G1MjSpFV7zvl7bbj3aV92w891XhxzActCqKiXN1Qe0QWxXxgtLzKDsl7Tu8T4/5rkrMs
         lmcblSZv9HL4E4wMWqfX0gIp2F8m1uYI12d7fVbw9hm1zE0bkvFT2QIlP5jzU/U7Wdhv
         lJuA==
X-Forwarded-Encrypted: i=1; AKwUvBxGoBDn6YvMoef+vj4YFjQN5gzgXjxXInwFOMlQxgQ2/bx1p40iy5q9zQ9GZlvco6dlibwSwVVI2isBrndX@vger.kernel.org
X-Gm-Message-State: AFuF++mL8A7Kojw0LK3pwlK4QWjyqbnJDvyWJF42lwYOH2UN75y1h0M2
	Y3lYR1zC56ZFQj9rj6QiouvPLFgpHxrWgIErrXBuj0sd2Lup74TXAaZq
X-Gm-Gg: AYBFou3og6MX6UuMwXw04SW6V0oXJRnChMeCdKpIw0SnM0fr+Pd0dT80fQlRfszM7m8
	SyyCWvp608qgZZwyVucwS9J7WDiKzqUpAkbCB1R10Ko4lyXe9Yo6RdCab8plMQ8UYDQe1bWmqJE
	Fk2MrNww4OlwmH4ZWT7BQMpNMDw7kt/nmO3Prv2djlsDeygRJi9wtxE4axH8f0IUQincq1CDexS
	feQM5slvKkJjmnnmeR3aIqDjEB8gOqERntRFhNolzyrBdFZNgX2w1ewcQWeUuQJNQ6+z3krojDE
	ynP0ww8DxTZMaNmFF5ChoUrheXQ/3+44nyZHc+qgmGnawLJ3f371XEoc+UlRlik4gGGYCKf6mD+
	FYn0FcMjkCPXpqfm6+TjfIpXhPLsAEaFlB4VyJG+BvziB+mld5IcVYInlY0UW/ebWt58Dqyhw9w
	YlxmYvGxE0v7FlMpjrQt0w/M1K9w7DJLitBbNNv319QSwOHwX5C+a5cScgODeenHKjJHnpHW6zU
	ov8sdSW/CCmsSpg2rGXQA714CT/npFxEIgASpzfdf+QAz9gV2PpjsW5+41CeFbfPc/FSCJ42Ka2
	enYm7vwFULcypaFx2xo0+e2hBKTCRRb2iKkHanmvLwZKQu2vOHlDsEmDFteGEWEFs/RmW7NBFAq
	fWw==
X-Received: by 2002:a05:6000:38f:b0:484:3315:1a38 with SMTP id ffacd0b85a97d-48433152785mr8141778f8f.28.1788039184984;
        Sat, 29 Aug 2026 14:33:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae86-1b01-80e2-8851-4221-68d8.310.pool.telefonica.de. [2a02:3100:ae86:1b01:80e2:8851:4221:68d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb33070sm12540616f8f.36.2026.08.29.14.33.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 14:33:03 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: selinux@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 0/2] selinux: fix nested backing-file mprotect checks
Date: Sat, 29 Aug 2026 23:32:54 +0200
Message-Id: <20260829213256.51527-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 preserves the top-level user file SID across nested backing files.
Patch 2 preserves and rechecks each intermediate path, mounter SID, and
file-description SID during mprotect(), including execmod checks.

The series is based on cf72cbb39da8, which contains
commit f2381b546e7e ("fs: fix user path of nested backing files"). Neither
patch needs that fix to apply or build, but without it the top-level check
still resolves to the intermediate inode. It is already marked for stable.

The intermediate list is allocated only for nested backing files. It is
captured at backing-file allocation time and remains immutable afterwards.
Capturing it in the mmap hook would require synchronization between
concurrent mappings of the same file.

Tested on arm64 QEMU with a small BusyBox initramfs, SELinux enforcing, and
two nested overlayfs mounts. The original SID propagation test passes.
Direct mmap(PROT_EXEC) and mmap(PROT_NONE) followed by mprotect(PROT_EXEC)
are both denied against the intermediate inode when that permission is
omitted. /proc/self/maps reports the top-level path.

Changes in v3:
- Add the intermediate-mounter fix as patch 2.
- Allocate intermediate state only for nested backing files.
- Rebase and retest on mainline containing f2381b546e7e.
- Document the BusyBox test environment.

Changes in v2:
- Add selinux_file_user_sid() instead of open-coding the lookup (Amir).

v2: https://lore.kernel.org/selinux/20260820175832.44512-1-kmehltretter@gmail.com/

Karl Mehltretter (2):
  selinux: preserve user SID across nested backing files
  selinux: recheck intermediate backing files on mprotect

 security/selinux/hooks.c          | 150 ++++++++++++++++++++++++++----
 security/selinux/include/objsec.h |  10 +-
 2 files changed, 142 insertions(+), 18 deletions(-)


base-commit: cf72cbb39da84b6f02f90c07f33b102fc10b16f0
-- 
2.53.0

