Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615061;
	b=Y3wlVEpS6v4Fn9ghwgxrQdLgJPR9y+SrX7vW2F/Gnx90qOyCHZZbSj9hrscEU5mGFJpv
	 031ubNgichblHmjqEjoaPVlt1tYBmgm/t9CArJLaiNwC9QGPq1cq5JR2tI06Nz365I8DG
	 PsrqqCDr+7Ck0g5tecXR4N/DwUvK3TyX2nHUo6nbmxFWKUwVcW6dMgJzMBuFBlY2yfoor
	 pdTbGwl+NrmkP4WgwXNW28yMh8JHv9//sRjYs1uvFvMm8LESIhVn4QumxXjzM0U4s8xJ0
	 9ngIfZ4Lk6XOGmcX6wCgJxE6VcQyNjFupxoGDD2jw7/TofATFThNQ7hOnjK8TVOEfDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WaACaV6xM9a84qy7Jy4prPJeYb/jLSX2Z3z8XfcFBlc=;
	b=0VRU+n9OowaEpVGgiAh0AEvC82naAWaeLCj4QrNpkh9xWaA4oKciZk7SAVcZZ9sFDMsK
	 pHo7vR+p5qXsugB/Id1pPPl6B7rGwGLDJwtynMkkXWVvQnK/p7aKV9z6dL0wvw/S7amn0
	 i4g06bVjJa2tOMwhYirPUjNttXkA2h+/PbEYDcBWPfMZnUtXwpSLjcU+7Xp0xZ4Eyuwvo
	 xiPBvM4aP51D0AN/oekW40BXHOBp+4pMoyNZneq45CvYqcTPZoOOnck/87glEjpFSFHco
	 +Qp2XG0vD+I+YiNvGRo2y4cjyB5NJvTYXWW+a79qxytU0gsZGFkdEVE2tFoIhXZK6AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=BdEWvEeF;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89D606A31B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 20:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF89D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=BdEWvEeF
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-917b78dfe30so16082576d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 13:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792615060; x=1793219860; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WaACaV6xM9a84qy7Jy4prPJeYb/jLSX2Z3z8XfcFBlc=;
        b=BdEWvEeF/KXNOjM/q4vl2QvLIso3Ex+jXS8GKRDdEAZNl8KdXk0SDTeRc/HUTFa8XM
         p4zBGFvXqBNdB4JYBSH5N4qIJnggTFeYBzJSKF+7nR2YTQN4OVEUXfoAYPSEbTidBg+I
         4IUALp5I3F4nKlC1gT5aDM5b5sFThR+/hloIp1B1ZxTLYscLgW82wg+V0x5X5piCvqPY
         /HCH491sH7XhQRteYqMKnA4Fb56Y9mHvbEkb1Ljd3EKZbef5mlz1xnp84OyIEm4iIvxO
         W7YvTu9zqBillaQLCsn4OOXGynhEzghSV/kV+6L5NeZ5wF4LHfaryLI88cUIUtkk1SFG
         NcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792615060; x=1793219860;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WaACaV6xM9a84qy7Jy4prPJeYb/jLSX2Z3z8XfcFBlc=;
        b=xLAOIoXq/bIBd242ajs0EssxsusBtMSJdWgepD9F+v4z5az15xHyfP0/6oETJmJQYG
         emWsrioNDsytI1zyeKYp3qCFgJ3KBKneZi93LiBUyY1BFSxdEBACLXmPmFDQbvR1GcX7
         5BWqy4fghnvICYvtWNCuYnwzh74aBwRTYoYDlSTACtvO+Cg9cEp/HMjUwtOLXYFgCFRQ
         Ty0CNFLvPO5UiDhTD3Q49CUbsyzyL3Nkp8Un7DmFgZ2jkD/KglTKyfaUu8TUSRTqJDJM
         veUi+89QGnzHxKAgAKP0BYYyXndpQ/vDxTKW9vrjuHSDWKYfKSEN7MsBGkIftjD1zeHS
         urKw==
X-Forwarded-Encrypted: i=1; AKwUvByHAX+Xu9OP9uucd2iVN+YQ2pIuWF7GzDLa7zRtatgFkn7ECsxOi6ssatrQnozofJI4ibe5p0+HJvFfXmle@vger.kernel.org
X-Gm-Message-State: AFq9FYJOqFWceK/1vY+QgiCWbCWnSrkpgUtgqMzx3ohPfvli50bPWkk5
	t7qk2L12Fp1eQWHKWnlOysA6OF+U/I0J6puGBCkvYDgbmC7N5/JNnJfNAK85a1sE0y4=
X-Gm-Gg: AYBFou1UvGbctPZI8sOXVtgHoKIH6FFF/ORHXfbeMZoaJ2fzYxYUYnfLcGWduvCy68b
	/Us7l9nmwGvVsrBPJSo+pgSlufV1H31QJq81vwOBDyJhs+HfwesSIq3rbUwojjvvxD23f1N+vSY
	SF5V1nBfWFhHP1UUMbOD8/FpSPvXcuSE6cq10oUY3aVGbPz8S1kUbOeHtX0q2APgT1tNSbkUG83
	qNPCp7IrEW8t1kT4h3h5PTFq0++rTMYDGlwzrbQkSOCVQXljwTYEX4ksS/hqHnzEkEl6oFovj2v
	/Hb74XXbY+RyDrnznKMHqir0a2+sD6wls2Ytx8jViR7ejusONIi5fXTFQdDGzGs2WmUkcZ9IUe0
	YgCDbyCq29W+wcVWeUegJ5C4ylKCoUS2D88aCVSKOt3QWayfcFgdzhRrUsRkPMGWFqFryXJYR5v
	1YocOXJTmykWr5c380kUBRPVgbWDhhju1UVxQCM0CTEXHDShastvht9P6txAHRyAqogXecqs87Q
	TmvmppdSJqRMwFKaxZsbpn+RwnUpH4A4ReG4D74M83Kr1EVhtB7jZphXUTpnlf1+Ir4Y2KF
X-Received: by 2002:a05:6214:2261:b0:91b:5d39:e12c with SMTP id 6a1803df08f44-91c12f38a88mr54818826d6.53.1792615059560;
        Wed, 21 Oct 2026 13:37:39 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10cf9f32sm33269736d6.45.2026.10.21.13.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:37:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Date: Wed, 21 Oct 2026 20:37:24 +0000
Message-Id: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
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
X-B4-Tracking: v=1; b=H4sIAIUi2WoC/33OTQ6CMBAF4KuQrq20pRZ05T2Mi/4MUqMtaYFgC
 HeX4kajcfkm8768CUUIFiI6ZBMKMNhovVtCscmQbqS7ALZmyYgRJighAiuOI3S1li3ul66L2Ii
 CVjtZUA0FWnptgNqOq3k6v3Ls1RV0l6D0oWQErIJ0ukmnW5srnq/HTzr9NjZ2PjzWgQNN5r8tA
 8UE17yEEowQpGTHzo9Wt9IZudX+jtKggb0xlP9iWGKk5obuWUVN+cXM8/wE4BaoqTwBAAA=
X-Change-ID: 20261006-b4-setfcap-userns-d63185a31ce3
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792615055; l=6973;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=OCTzCzF6xbrNeax8f+4+604UcNM0s0xpehQTENXnCsU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCBIqv0Oyyt/6cABl719ndFj9zZPh6GDediulNkL7LmlncdSow5CWRyMHCHYuT9QLzYUPMWsOcr
 IZfnmHDdNvgg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com/
v2: https://lore.kernel.org/all/20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com/

v2->v3:
- The setns() check in 2/5 and the ptrace check in 5/5 only apply to
  namespaces that map the root user of an ancestor within the creator's
  CAP_SETFCAP, or that have no uid_map yet.  Root users stored through
  an idmapped mount are left to whoever sets up the mount, so a root
  task without CAP_SETFCAP can join an ordinary "0 100000" container
  again (Serge, Christian).
- 2/5 adds cred_may_setfcap_userns() for those two checks and
  cred_setfcap_reaches() for the uid_map check; nothing outside
  create_user_ns() calls cap_setfcap_level() directly (Serge).
- Fixed the cap_setfcap_level() kernel-doc, @ns doesn't have to be the
  cred's namespace or below; cap_capable() is compared with != 0
  (Serge).
- Picked up Bradley's Reviewed-by on 1/5 and 3/5, not on 2/5, which
  changed.
- Rebased onto current vfs.all.

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
how far up the creator's CAP_SETFCAP counted.  If its tasks can write
file capabilities for the root user of an ancestor, because the
namespace maps that root user or can still map it, setns() only lets in
tasks whose own CAP_SETFCAP reaches that far, and PTRACE_ATTACH asks the
tracer for the same.  The checks on the way to file capabilities then go
by the namespace instead of the cred: a uid_map write that maps the
parent's uid 0 (opener and writer), and setting security.capability.

The visible difference from v1 is the setns() restriction.  A task
without CAP_SETFCAP can't join, or attach to tasks in, a namespace that
maps the root user of an ancestor, such as host uid 0, and was created
by a task that had it.  A task that joins takes on the namespace's
reach.  Containers that don't map host uid 0, unprivileged users and
anything with CAP_SETFCAP aren't affected.

Testing: the v1 flows plus the setns() and ptrace cases, 41 in all, on
vfs.all with and without the series.  Every flow gives what's expected,
and the only ones that changed from v2 are the five idmapped mount and
"0 100000" container cases, which are allowed again.  The pidfd,
namespaces, mount_setattr and ptrace selftests give identical results
with and without.  The TLA+ model, which has no idmapped mounts, finds
no violation with the narrower checks, and still finds the setns()
bypass when the check is taken out.

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
Changes in v3:
- Link to v2: https://patch.msgid.link/20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com

Changes in v2:
- Link to v1: https://patch.msgid.link/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com

---
Josef Bacik (5):
      userns: record how far up CAP_SETFCAP reaches
      userns: don't let setns() lend CAP_SETFCAP
      userns: check the opener and the writer before mapping uid 0
      capabilities: limit fscaps to where CAP_SETFCAP reaches
      capabilities: don't let ptrace borrow CAP_SETFCAP

 include/linux/capability.h     |   7 ++
 include/linux/user_namespace.h |   7 +-
 kernel/user_namespace.c        |  37 ++++++---
 security/commoncap.c           | 167 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 202 insertions(+), 16 deletions(-)
---
base-commit: 2c3ba1f1cb416b81d617b92a24a4bcaa48d574e3
change-id: 20261006-b4-setfcap-userns-d63185a31ce3

