Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892F309EEB
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010888; cv=none; b=cu9NRsH676+Ck3VGM8DBW+7PBRmW485f+Z7czUpeFuv6urgptsKLA+wXFyJATjI8IbAc1SPdK0GRN48wKu/qsFo7NpRmsLaJZDYTBn0Wq0wLN0rh3uu3oZLgQHVElpKYLJu5f9EpNiwUEdW+O6H0tciYhE92GjYPLX5rveP0+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010888; c=relaxed/simple;
	bh=TS8Dc85WxE63l1fC+ndLzdji+MjQJb8aAvvEnwQs6iY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fgPH+ozXJod3BqarSmSffKJe/c2zf73llqXxHeSkHUYkeyzRcGpMPotQbyjZvG45mFcgg25eKSd1cQCjZ956HaUOacfWKDMX2PhPuswkiGMpzFrxm9iiZWjZzaczypWf30nu2Kh7rmODaI1nriXUaNpIWXKM6TNWq3PGO2bp3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=sk+J9cOy; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="sk+J9cOy"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91bbce8b00cso482436d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792010885; x=1792615685; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u7HDvQV4WbPsYHNSCzLHQ76BA99YteqeikoHyasNST4=;
        b=sk+J9cOy/MlUB3pKRcjzHDK1wWccLjcaUn36Y8QmH7OxrwgHOcwDhnW4dbrUGdwryL
         sp0YnYVPruuqzUUpFoz9nqzlH8j+vhnVuPcBUiCRiZIJDwaeJrqSuaSf9XQ+yhULID22
         Sjw8ZPlte6xoxtYYPDyoN8YMvwiJN+UkbD3J4XEUkszEgRbkhhgOrLJrRclDk1+/cm9w
         P4ZeCtRhb4EcLCmKlobahiZ8/LDAZz64q90NEaplyNGhI3ORWZHelIxMS49VR2nOAOfq
         jAZx4VGwiQwdDwj1bbZijuhx7w+JtH+3KYusOql7DV9snVLwKe6GOo5dnDasS51YyxA+
         bOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792010885; x=1792615685;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u7HDvQV4WbPsYHNSCzLHQ76BA99YteqeikoHyasNST4=;
        b=k86ApwxF3Ek2OMalTzBW+BwKJccbFa0MMmgVceECnJOfmAWpBOF4pSH/L69H0GXKlZ
         xzmexrQhUgOdPgZh8GGjPTiZpLsq+L4gJU/l7GbKKqh+DozlE1hmX6eqHAH7Jl7C8p3r
         QuMBZ3fqhUz+n8quIkXuyNgd117p9CSc1YS+SM9FhafFwYNesFfKXS++6ILZAYuDqmI2
         TbD1BHG6YDSYUxjhNlX0MQShTebmn/ZHXw0PdWha6C/nnM8Btihn1BSgvmDIDxDmsUhb
         scvVXz7SiFmjFlsjL6MWJ/iP8HQm7Lh+HWoWYunxtAs+8QNO6CponvwFgjbbhtotIMdN
         Q9Ug==
X-Forwarded-Encrypted: i=1; AKwUvBwejjXzRL9oMOsraCIRnxHlVGiUFUXrdQws8ghI/MqtrSxN6zr9XBQ3z6u/IZjbADaMMT3FvfjCm2Mo8G1c@vger.kernel.org
X-Gm-Message-State: AFq9FYIuIxzgtsHCp5pHhIgOJ+DLl1qsDPQVB+blVw9zASUJR9CRptIA
	PBedClH4uxup6f0B8ffNvXP3NY8aFnapD0f+q/wSqn0uyqKn7tlRGa22TRL0YbLuI3E=
X-Gm-Gg: AYBFou3Nb1ghR+rbxgSb2kfqu4TmTSrclTVYurSxM6mm4q0mI8DtinopmMQwr5NNYsi
	zYR+hOJRWCLNLiCEsplKB0/foNFy0v0toqo3APLnZkbxkOcM/yVjj2Y1m8ELMREYrtBVvsrCdow
	+YzTTfwEKxDKvHZnT0Jq/+m+/4lxmKGW1/DXmeR7/horoDyhbgK0PuQU3kJShKrYczPUeM+oUGk
	7+Eh0FOiD7ld6nopsMAaKgut6o8bDtwN5IbNgpAvr84wzMao+1rpdlcIc339tkCvJqcNIozk6PB
	cjugPT+EYjpyNQQtB1OQyCt/CChaI4h1upvMOj3eKKpI1c/LFJDxhFEwkntv6dqOd9HEjmYsaOz
	RdeThc1H+xcSXnBnyEWEXBOZLUxEVELdkUP+ffWK+B9zKtfunqPZIDX4AW+uIbNSWQHWOKCXhyS
	t3EhJB8xliqL/BX1iEVdsTGRYS4mBziOPeL+w19x0Fc+lJiiAgt2hJlBN1aEXzN2tvhztEPgSoD
	r4DCQejtgmpZO8=
X-Received: by 2002:a05:620a:400a:b0:939:944b:2814 with SMTP id af79cd13be357-93ec14759a0mr2598662685a.19.1792010885237;
        Wed, 14 Oct 2026 13:48:05 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f0cfac145sm67856485a.31.2026.10.14.13.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 13:48:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Date: Wed, 14 Oct 2026 20:47:45 +0000
Message-Id: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHPqz2oC/32OTQ7CIBhEr9KwFgu0UuPKe5gu+PlqMQoEaFPT9
 O5CXblx+SYzL7OiCMFARJdqRQFmE42zGdihQmoU9g7Y6MyIEcYpIRzLFkdIgxIeT3lrI9a8oee
 TaKiCBuWdDzCYZXfe+i/HST5ApSIqDSkiYBmEVWOJnr6Wbb2Hv+rSHU1MLrz3gzMtzn9fZooJH
 toOOtCck45dk1uM8sJqcVTuhfpt2z7LwHt29QAAAA==
X-Change-ID: 20261006-b4-setfcap-userns-d63185a31ce3
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792010880; l=6145;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=TS8Dc85WxE63l1fC+ndLzdji+MjQJb8aAvvEnwQs6iY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE2SU/Q0vePomAlebGv+f2r9J7b7zxI401k9d5BnBBLxpUlCRXFj/YsGMY511woRQtVLiS/yO6y
 vXMNmmYH9qQg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com/

v1->v2:
- The state lives on the user namespace now: ns->setfcap_level replaces
  ns->parent_could_setfcap, and cred->setfcap_level is gone (Serge,
  Christian).
- New 2/5: setns() refuses a task whose CAP_SETFCAP doesn't reach as far
  up as the namespace's setfcap_level.  It applies to every user
  namespace, not only to those that map the parent's uid 0, because of
  idmapped mounts (Serge, Christian).
- 5/5 asks a tracer for what setns() asks for, also when the namespace
  doesn't map an ancestor's root user, again because of idmapped mounts.
- Dropped "userns: don't let setns() lend the right to map uid 0", the
  setns() check covers it.  Its nested case moved into 3/5, which checks
  the opener and the writer.
- set_cred_user_ns() isn't touched anymore, so the put-before-use in
  userns_install() is gone (Sashiko).
- Rebased onto current vfs.all.

What it does now:

Every user namespace gets a setfcap_level when it's created, which is
how far up the creator's CAP_SETFCAP counted.  setns() only lets in
tasks whose own CAP_SETFCAP reaches at least that far, so everybody
inside a namespace is entitled to the same thing, and the checks go by
the namespace instead of the cred.  The checks are in the same places as
v1: a uid_map write that maps the parent's uid 0 (opener and writer),
setting security.capability (both the root user seen through the mount
and the one stored on disk, for idmapped mounts), and PTRACE_MODE_ATTACH
and PTRACE_TRACEME.

The visible difference from v1 is the setns() restriction.  A task
without CAP_SETFCAP can't join a namespace created by a task that had
it, including an ordinary "0 100000" container, where in v1 it could
join and was only refused the map, fscaps and ptrace.  PTRACE_ATTACH
follows the same rule, so it can't attach to the tasks inside either.
A task that joins takes on the namespace's reach, so a privileged task
that joins a namespace created without CAP_SETFCAP can't write fscaps
for a root user above it either.  Unprivileged users joining their own
namespaces, and anything with CAP_SETFCAP, aren't affected.

Testing: the v1 flows plus the new setns() and ptrace cases, 41 in
all, on vfs.all with and without the series, and every one comes out as
expected, including the idmapped mount ones.  The pidfd, namespaces,
mount_setattr and ptrace selftests give identical results with and
without.  We also redid the TLA+ model the series came out of with the
state on the namespace.  Without the setns() check it finds a joiner
writing "0 0 1" through the creator's uid_map fd, with it there's no
violation.

--- Original email (v1) ---

Hello,

Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
stops a root task that has given up CAP_SETFCAP from creating a user
namespace that maps uid 0 and then writing file capabilities in it that
the initial namespace honours.  The check only looks at the task that
creates the namespace, so if somebody who did have CAP_SETFCAP created
one, there are still several ways around it:

- setns() into their namespace and write uid_map from inside (patch 2)
- write "0 0 1" through a uid_map fd that they opened (patch 3)
- setns() into a namespace of theirs that already maps uid 0 and set
  security.capability there, no map write needed (patch 4)
- ptrace one of their tasks and have it do any of the above (patch 5)

On an unmodified kernel we took a uid 0 task with CAP_SETFCAP dropped
from its permitted, effective and bounding sets and, through each of
these, ended up with a file that a uid 1000 user execs with
CAP_SYS_ADMIN in its effective set.

Patch 1 adds cred->setfcap_level, which records how far up the
namespace tree a task's CAP_SETFCAP reached when it entered its
namespace, and patches 2-5 check it.  Patch 4 is the check that closes
the class, the map patches make the uid 0 map rule mean what
db2e718a4798 meant it to, and patch 5 keeps ptrace from borrowing what
the target is entitled to.

This does change behaviour.  Everything new is -EPERM:

- a task that entered a namespace without CAP_SETFCAP outside can't map
  uid 0 of the outside or write fscaps for that root user anymore
- a uid_map fd opened by a task with CAP_SETFCAP can't be used by a
  task without it to map uid 0
- if a privileged task maps "0 0 1" from the parent for a namespace
  created by a task without CAP_SETFCAP, that namespace can no longer
  write fscaps honoured outside
- PTRACE_ATTACH and PTRACE_TRACEME fail when the tracer gave up
  CAP_SETFCAP and CAP_SYS_PTRACE, the target didn't, and they share a
  root user

Rootless containers, privileged runtimes writing the map from the
parent, nested unprivileged namespaces and containers that don't map
host uid 0 aren't affected.  The ptrace check is one compare for
targets in the initial namespace and in namespaces entered without
the capability.

Testing: a set of flows run on the base and patched kernels, every
bypass route above gets -EPERM with the series and the 16 legitimate
flows behave the same.  The capabilities, namespaces, ptrace, pidfd and
proc selftests give the same results before and after. Thanks,

Josef

---
Changes in v2:
- Link to v1: https://patch.msgid.link/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com

---
Josef Bacik (5):
      userns: record how far up CAP_SETFCAP reaches
      userns: don't let setns() lend CAP_SETFCAP
      userns: check the opener and the writer before mapping uid 0
      capabilities: limit fscaps to where CAP_SETFCAP reaches
      capabilities: don't let ptrace borrow CAP_SETFCAP

 include/linux/capability.h     |   4 ++
 include/linux/user_namespace.h |   7 +--
 kernel/user_namespace.c        |  38 ++++++++++----
 security/commoncap.c           | 115 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 148 insertions(+), 16 deletions(-)
---
base-commit: ac311bf4f20e614d8e94cae4c62f075f2e5ef16c
change-id: 20261006-b4-setfcap-userns-d63185a31ce3

