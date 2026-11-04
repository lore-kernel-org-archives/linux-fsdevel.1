Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802285;
	b=eKtg6yFVxegj+Y/bWYuFawuGgWiVkjlDTwRTxR7lm0ZB1aTXf841R6ryN8mGOSWbXeqR
	 gucDbVRS7qzZNKzd6D6WTfnaf3vjVfudCiw287QV+NjyqkL+P7GmZFze1DTaz8XlQcC1Z
	 7vRsPhPlvJPy5Or3QhM6/KCuhTFzv4VuqkSPYCOVJBFE44ThuAWnf19yP0PuOTwZ4cGjw
	 aUAQkpERCHj9I7ZNyai5Pkwfr5HPeQGVftFDZHUXGTngUpHw34eqRvMOpd88MJutOsalL
	 iupd2GkuQMg2bkvIPdnyPrXv0tLVeDGwYDKHQTlQsLQSrkRJv11pk+Fo18bS0tmWMVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WcIigLb1pFNCZqMfxlwoFOwCJSqFocR8G/Ezr9o8tZY=;
	b=Ju5JJyj+QH5cqogQfqByVhvP7Tv1v3ykjrlIf+bdaDLAXBVgGfodGaLI9SqwjAhy1aID
	 EiVJPa0lv+v6pZJZNezKBjOtwjmH8LGecrpQmqGEpfxq/lXrZPEnEJMqOnC2rPJdxeeAb
	 /vUVnYhUHIqHc8Mlmk6P4IKc0kRHgG2vKhJekwRlgMdFjM26vsbo4rvNkPmKS3ocq9PWL
	 BBicCzi2HPTaluYajCCm+zzIzi6ixR7BzXbl1EdKzET3ACKsuYrWNYe4mfUqLCLXILono
	 8AssLMU5bTTvMq84LpTOEV6diE9RSTFkOgtGG8eF4eF4z+2GW+GitVrVQZfdqzq0Opg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mullxlSc;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FDC606A328
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42FDC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mullxlSc
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7cc53938a8fso402350137.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 06:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802284; x=1794407084; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WcIigLb1pFNCZqMfxlwoFOwCJSqFocR8G/Ezr9o8tZY=;
        b=mullxlScGzRvw6CksgxAYaXxTMP1uliThqCz3mKu71K8ASaX6dqX54BWPqSxR4LwvW
         oMQRjr6/hmbQOI4FPwH5Whx0KeBfJxVP6PEnpQRraswXR8OKAabC8XCUx4gAkw8FCaUG
         yprOVLxfWAalBKHlBYXWYcZdRt9urtBcQ0n1M8fjl41bZw+wW8vQSBPUoNrZqX45hBqt
         sPK/zUYlC8nf/gftMzBOMu9F8rPxGPhZQYOTFt/QC1hhheMk+P2pnjCXJo/E08e8mhTp
         kuF23U48517x7H6IYsn21D6+jnhBF3EHQ+cy+zx8s27f7LmIsl/QSE3LCkPNg/0SFEZ6
         8HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802284; x=1794407084;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WcIigLb1pFNCZqMfxlwoFOwCJSqFocR8G/Ezr9o8tZY=;
        b=M18yGq1fAjbKWAMWMiB/IAai0LvBOfQuFMgkD9MBmGH0jTL1jX+6WsRTc7hSse52/j
         JVfTVHhU1MUSWEaVFxanHNXUym5xiSLYmyIaDdZIOjEAbL0/qTn+vv7AVCLJme7KOJPI
         qlY1hS8ySiY07T/gvtexd88LQkkvzOocSvIQo/hO9CpKhqgLefXBRARf0sBRPEkYIdCT
         8FvV7C7vMhlzg3hBo32iX3bgyoUwDm4/f1RSdRleU4Xh+uL6zoRkvx+NuShG1oUJN8eN
         ySHsEEYxF0qJfdpyDEgQUPsv17ffgWKZEY4/mq1Aby6vT2+Y9l0Ss0gnA7UKYHCawM7t
         waTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxo07d2SeJ/4H9N2YOPmdRaWPaw+JZQowjeG1GqFg1MeIsvgCiq9WNDtnu3OspJynAaREAqO8Rwu6Tt5beH@vger.kernel.org
X-Gm-Message-State: APuU4Z8oQL/VGEdJiik00sL2aUTt/UbJx+LMoEaMLkGMTZkv4QTkhSG+
	emYHp9MDhyjVAq81NPXFqvKup7CPGmr5sJTBjo0ji9f32mU3wOD8X5AybGwNqqDJkKk=
X-Gm-Gg: AYBFou0u+XAZzaGwreXxQ6i3mg201l5YpTys+y8Vy0EyLk438mt8Hs/fXP5O3ELv5Ar
	GrmLSvyn+oFXWvXgshNIxp8G7teZebgImdVayZEvG14yMmWqqep2sZbIIh54LOHjVXK1p6OiPzh
	JxXaPtCSn1V4SdZVegRkF+ckjKy7Tsy4EPbMsaxzxtL4itSp8WW5zmBS4kM92RWzbezWkezThqK
	32iY50JnAAl4xREegTz6r/qvKhtTEHtad13BKuK3QyGRn30p4Df9aqQjG2VnAEVzWF6FRJFUB38
	M0YR1Mg+2wMYGilwImXJ5whe7xauvxCefHTQoEZ2xx0+h+dfW/fyoK9I0G5ye7QjQ+cHGiMdk9i
	Imm8tMGOiJHCtO+KvvTqQ2huphv1fwuhLPDphKsxASvvVawg1gNK6ub6kTichiWhAHqS6p72F4Z
	/+ZBo+cOJDj4jmNrv68KPwlnG+hrJyPE1RUqx+o3urUSoomPm03eI3qFsPWUU5FoFeyJwn5ugBc
	ven5MPzsQbvpgJEbOA3Bhc/olsZKuXCfsPg8MdOJVi9k/VxG6X6rad7GjSEcyj6SGEQ/endLtUS
	UqumTGnFdHtFxEAow4rbSWZ11u4s5FvTwR0AOADjmAQKIg==
X-Received: by 2002:a05:6102:14a3:b0:7a1:f951:664f with SMTP id ada2fe7eead31-7d072ca34famr6612993137.22.1793802284101;
        Wed, 04 Nov 2026 06:24:44 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d8afd707sm1890331241.5.2026.11.04.06.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:24:41 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 00/13] cred: gather the "same uid" checks between tasks
 in one place
Date: Wed, 04 Nov 2026 14:24:27 +0000
Message-Id: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1A62oC/22OQQ7CIBBFr9KwFguIWl15D9MFA1OLUSBQm5qmd
 xdq3Ln8L/+/mZkkjBYTOVcziTjaZL3LQWwqonvlbkityZkIJg6c8YaCpDqiyThRBMZBwK7ZC0n
 yIkTs7LTaru03pxfcUQ9FURqgElKIyum+oEeoQdYr/ElLq7dp8PG9PjXyYvt/f+SU0SOYThiQq
 E7dZfCT1UE5o7baP0m7LMsHbZvRkOMAAAA=
X-Change-ID: 20261018-b4-cred-ids-eb01b2b38524
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=4635;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=RtFbXTsb4ax6Tfp/6eLFbfuJmJqCalBfXAjUg8YECpE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDM8d9MBAwfPTbfEuQbbEiQjUIX6mCag8h5NnpfzRPDG6SR+CM8QKQozuO2uDZzUZ8FWgjlLzIA
 fNdnZpDTihgo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com/

v1->v2:
- Rebased onto v7.4-rc1, patch 1 didn't apply any more.
- Patch 1: VFS_WARN_ON_ONCE() in the default case of
  cred_ids_allow_control() instead of failing silently (Serge).
- Dropped the Assisted-by trailers, see 1e035297ffda ("docs: remove
  Assisted-by references").

--- Original email (v1) ---

Hello,

We have a dozen places in the kernel that let one task mess with another
because they belong to the same user: kill(), SIGIO, the scheduler
syscalls, setpriority(), ioprio_set(), prlimit(), ptrace, moving a task
around in cgroup v1 and resctrl, and KEYCTL_SESSION_TO_PARENT.  Every
one of them open codes a handful of uid_eq() calls on the two creds.
They come in six flavors that differ in which of the real, effective and
saved ids they look at, and in whether euid 0 gets a pass, and there is
nothing that tells you whether two of them differ on purpose or by
accident.

I tripped over this working on something else that needs to change what
"the same user" means.  I kept finding another copy I had missed, and
for this kind of check a copy you missed is a hole.  So this pulls all
of them into kernel/cred.c, side by side, with a table that says which
rule looks at what, and converts the callers one at a time.

Nothing is supposed to change.  What each of these means by "the same
user" is ABI at this point, so every rule is kept exactly as it was,
warts and all, I have not tried to unify them.  The capability checks
and the LSM hooks stay with the callers.

The one patch that isn't a straight substitution is the fcntl one.
F_SETOWN copies the uid and euid of the caller into the fown_struct, and
the helpers take creds, so it holds a reference on the cred instead, the
same way struct file does for the opener.  That means the cred sticks
around until the owner is set again or the file goes away.

For testing, patch 2 is a KUnit test that holds each helper against the
expression it replaces, verbatim, over every combination of a few ids. I
also ran kill, setpriority, ioprio_set, sched_setaffinity,
sched_setscheduler, prlimit, a cgroup v1 move, SIGIO and PTRACE_SEIZE
for all 64 combinations of real, effective and saved uid of the two
tasks, on a kernel with and without the series under KASAN and lockdep.
All 576 results are the same on both, and they match what the table
says.  The resctrl and usbdevfs (kill_pid_usb_asyncio) callers I have no
way to exercise, and the MIPS patch is compile tested only.

This is based on vfs.all only because that's what the other work sits
on. Thanks,

Josef

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Changes in v2:
- Link to v1: https://patch.msgid.link/20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com

---
Josef Bacik (13):
      cred: gather the rules for acting on a task by uid
      cred: add KUnit tests for the id rules
      signal: use cred_ids_allow_signal()
      fcntl: use cred_ids_allow_sigio()
      sched: use cred_ids_allow_sched()
      MIPS: use cred_ids_allow_sched()
      sys: use cred_ids_allow_sched() for setpriority()
      sys: use cred_ids_allow_control() for prlimit()
      block: use cred_ids_allow_ioprio()
      cgroup/v1: use cred_ids_allow_move()
      fs/resctrl: use cred_ids_allow_move()
      ptrace: use cred_ids_allow_control()
      keys: use cred_ids_allow_control()

 Documentation/security/credentials.rst |  19 +++
 MAINTAINERS                            |   1 +
 arch/mips/kernel/mips-mt-fpaff.c       |   3 +-
 block/blk-ioc.c                        |   3 +-
 fs/fcntl.c                             |  19 +--
 fs/resctrl/rdtgroup.c                  |   4 +-
 include/linux/cred.h                   |  20 +++
 include/linux/fs.h                     |   4 +-
 kernel/Makefile                        |   1 +
 kernel/cgroup/cgroup-v1.c              |   4 +-
 kernel/cred.c                          | 162 ++++++++++++++++++++++++
 kernel/cred_kunit.c                    | 218 +++++++++++++++++++++++++++++++++
 kernel/ptrace.c                        |  16 +--
 kernel/sched/syscalls.c                |   3 +-
 kernel/signal.c                        |  10 +-
 kernel/sys.c                           |  10 +-
 lib/Kconfig.debug                      |  13 ++
 security/keys/keyctl.c                 |   7 +-
 security/landlock/fs.h                 |   3 +-
 19 files changed, 461 insertions(+), 59 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261018-b4-cred-ids-eb01b2b38524

