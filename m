Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D553B0586
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814828; cv=none; b=cZrHUbarBVAxPSgdckR/IWBY2yeFak56blpZ2FVtzHGPgGilwY3f8RiafzdR7Bx5jSYwpa+HSIWqM2x9u3gE/0tw1ZKiEA2CLaAxghmy9UR1mbx1jrxOm2U5VQSa5ZBdKkeBlZO9Zy0TVrB1+2V28Hhzi8uaEQ9Y9oBf1P3vPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814828; c=relaxed/simple;
	bh=/o20sFF/mtTU8L5mYAb/n1KYsEh2ORlv2YG9SP+nOdE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bexzxths0uTN59C4r5atOi7rPB4E36ULc7eHzsZ3TTTN++4zm5M1LT5wR5fxJFjCcQIP7CtSTewpAeu0p86kVSRyKCBl3SkHuDVf/Xot4e5TmAU6gEs29qKj+/TZUJRm9s1kyQgSffnQNBABn/x06IRB4VjSiThQyDI/MhmmWkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j8G97Q/Y; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8G97Q/Y"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3bc34cso83705e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788814825; x=1789419625; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D+b4993ZhKzGPpJvQnPmdXZLIrwAdhGEw0qUUSYMGJs=;
        b=j8G97Q/Yun04nv+mVy9UmI4y4g6OFoQnGAPup0fZ972NWDE5hVU3KHEO0D9QIDZ6dH
         uG/1x1gKrjpWYSbSRlAq+hOX3YhYHzntDhMft8TUMO1jqyy+zlhGXgCdx50rXSrqiN1W
         4Qp0rUCvkCsFF1qUqrz+LFsCkyWEs2IVLg4b2OrjStMSGmIqSuN8TBFMhB0Z1irfmBCW
         HrS2AaxMeNy2PtaCbuL7SKrbI0RfBwRjNHG1E7Tb4Bf+XHXJNsXihml5lbDpEaSL/5zF
         tkzIhf/ADIOyT5AjkrfXx0YPO7gGWBlIA9oKE0U/EosSYuQcz4zCRuvn+zs7nTiJrxJm
         /ZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814825; x=1789419625;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D+b4993ZhKzGPpJvQnPmdXZLIrwAdhGEw0qUUSYMGJs=;
        b=OT7SGHAuz5v/ypCRtSitjpkUw7Ch9YwkJ+8qu04UYlcJ/lgpwL3jc2k9cKwa1vC2gs
         qpAfr0477ROel90M2M8w/Te4J9NByVvF1x6q4M6x9qhDrw6y8jsEgZMv2D1DQhbRd+yl
         sdnXdJrbj062wPKLFM5PoA4zzs+l/SF2hTm++PSGyQ+jmcfEP1N1Wbwip5ijawJ7EP1O
         y2TwGNcTXXeBDTAcTkDa6cPPjFNn2JwA/9vQUp1nMpFBlcjVrNYgrjVY8TMDKLheenmq
         74IJpWf5WcfyEdcLKpRt0ijp8bSp8wstUQ9iBvMTN/YyMP6omtf1h115fZmJroGy1Bnf
         PcSA==
X-Forwarded-Encrypted: i=1; AKwUvBwmqgJWnDPgDq5WtMr6JK7tZPArl7eSrj8Q5CfJJB3N1n7/e7ey1HhMinc1XoIXo3AM/RoguhFnxA3BwTM5@vger.kernel.org
X-Gm-Message-State: AFuF++lka4lfjJ+7IOriiEE5HAPTbt0sRPNaQvss47X9lxrLpdQFra0g
	iqXIu9NS+K20DfD3toJmc8z62tsXDt1PDtJNVxvaIgpEzH0qfan5IGEsAd4Zqbe7Bg==
X-Gm-Gg: AYBFou2K93mCSVVw2uLt6cAonH14s0MjZH8AXzKpswS9genB+AAzTniWWXF+d/ED2YE
	L07yNpFQdu5SriGFrlYVyW137LYo5OMa59Cz0WYVlkqBYI+dhTdf1WLTDz9q2CDtT0tmGkL9I1m
	Qs2/v65WNXsoshXdgpStCMX5e/qdgtBY7YKDgiQoTRN78Qftj8GeN9hCjNlzAHl+7CMLM/PmISR
	tXkD7PuD3o8UWewd8W40lVjt+bSF2xh96+pu1aPh4TKcN/GgYbswBMK37RLe6CM56lLeWXIdkxF
	F44qjhcqykkebZEzGJF7kCCB2jq1v4D5pctgrJlE9YFuclT0hdM/YN+r4WCS7X8XGIj2iu811tS
	7NACvdlDY4HqIPUiJxqBU1BCCTQpBgmiutbDRySd75oDnAWjcMKe5nPSuSYFiK8Aw0Zl8B6iXnI
	gkRJdtyDGrm8d1gIwfWwoEYDtVzT+7oak8OqueOwtbh0H0r6Y3PS7pkZGBIQ+T/bIY9lBHcNhki
	RUuhATkpl7BX4OvSFkI4C0JD1HdA+m3T1GuURhzkkk7D5IT
X-Received: by 2002:a05:600c:4907:b0:499:c3da:6f40 with SMTP id 5b1f17b1804b1-49d010d5333mr1538805e9.4.1788814824871;
        Mon, 07 Sep 2026 14:00:24 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:437c:9ac6:4a41:e58b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c81c3sm31385050f8f.26.2026.09.07.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:00:23 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH v3 0/3] proc,security,selinux: let SELinux block FOLL_FORCE
 for /proc/self/mem
Date: Mon, 07 Sep 2026 23:00:15 +0200
Message-Id: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN8ln2oC/2XN0Q6CIBTG8VdxXEdDBNSueo/WRcJJKRUHymzOd
 w9sbTUv/9t3fmdBDqwGh07Jgix47bTpQ2SHBMnm1teAtQqNKKGCFCnDDlrdTzMezBM66DBjgnL
 Oc8kUQ+FqsHDX8yZerp92U/UAOUYmLhrtRmNf20ufxt1XL3a6TzHBJZGKZjwHIPxcG1O3cJSmQ
 5H39AegfA/QAFRMVFKwMhWq+APWdX0D0PGq6AIBAAA=
X-Change-ID: 20260814-selinux-pokemem-44625557c4d4
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jeff Xu <jeffxu@google.com>, 
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788814820; l=2679;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=/o20sFF/mtTU8L5mYAb/n1KYsEh2ORlv2YG9SP+nOdE=;
 b=ZmXwRrsF/uOMvXyg2m7GmtJZlNUc+YLd2/rhXAsPu69kHUhI7vrs5qtb/BA9P/iraL5bnyjG/
 PNa4GM+tlO1A+/0obRL7/8fzwsyCzvQVSba93+vtc8dnC/hvGRcnTz5
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The goal of this series is to let SELinux prevent the use of FOLL_FORCE
when a process writes into /proc/self/mem and the system is configured
with PROC_MEM_FORCE_ALWAYS (which used to be the default behavior, and
is still used by current Android devices).

Android has SELinux policy that attempts to ensure that only trusted
code can be mapped as executable in several system processes, but this
protection can currently be bypassed by writing into /proc/self/mem.

I wrote this series after discussion with Android security folks about
the state of proc_mem_foll_force() restrictions on Android.

I'm sending this to:

 - maintainers for LSM hooks
 - maintainers for SELinux
 - maintainers for VFS (because I think they generally own procfs?)
 - some MM folks just as FYI since this touches GUP usage
 - the Android folks I talked to about this

I think this should probably go through either the VFS tree or the
LSM tree.

The motivation for this series is that Project Zero managed to write a
remote exploit for Google Pixel partly because of /proc/self/mem, see
<https://projectzero.google/2026/01/pixel-0-click-part-1.html#whats-the-plan-seth-and-jann>.

Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v3:
- pass opened_by_owner as boolean flag (Christian, Paul)
- call security hook independent of kernel config
- documentation changes (mainly to adjust for changes above or suggested by Paul)
- add acks
- Link to v2: https://patch.msgid.link/20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com

Changes in v2:
- change SELinux hook to only check PROCESS__PTRACE (Stephen Smalley)
- rename ->introspection to ->opened_by_owner (David Hildenbrand)
- rename introspect_mem_foll_force hook to mem_foll_force_opened_by_owner
- improve comments
- add ack/review trailers
- Link to v1: https://patch.msgid.link/20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com

---
Jann Horn (3):
      proc: refactor /proc/$pid/mem to use struct as private_data
      proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
      selinux: require PROCESS__PTRACE for FOLL_FORCE introspection

 fs/proc/base.c                | 43 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  7 +++++++
 security/security.c           | 25 +++++++++++++++++++++++++
 security/selinux/hooks.c      | 31 +++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 5 deletions(-)
---
base-commit: 2f1baf1fc8929e6c48370be543ad028ac7ad4131
change-id: 20260814-selinux-pokemem-44625557c4d4

Best regards,
--  
Jann Horn <jannh@google.com>

