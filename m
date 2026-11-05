Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890681;
	b=1YbbQYad1Yx52D9XZdIeA/zWrSbUJqQ3ndWdcK/ypYpPjzbXnGaVcFwjyNuWMdhGvTG/
	 3ReTUWM87nNNQH5yLYFN3QaZDp0Ny20l5hwimUVGkUSt0d7G9V6Y/7AHF1waYM+rnKuFp
	 zVsHWyYEfFSPDUQVaZ6ug6MACgJiUIGp2H+9xANF8rb6mAK2vMvJBuBlNPvm9ZqCc8H1E
	 hJ/TZfQDK4B20rkAWI9EDwqjCiM6HLjqfsMf28sSi23lPK2BeO02EZfEQ+B2Ir57HeOio
	 7WMwlUigtSM2S8KEAhpNrZH6BvpEBtENIHxXJQz6Cc+cu1iBLwDYQuCl2GA16f8lVag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=vS1hYQjDf7uECmyaS0EpIO4k0JNkxhWN0MNWstfQo8M=;
	b=XED/RxGgojqrdB4SpDC9c6Y3MJRvr4jYN3jpo5niDGEe5IS7mEg22BmcANnT1hHxdrPl
	 M+avZL/ak4pM0niVbwgHKzpseU8XO9po09Y+h7aNrV3JM5VlrYFAhzQ4Bkfhlp5nCCLou
	 4plPR5DeKuvGAYWfkB/3dY19AhP0RzQyZ8EclziAJoL+RXl1t7SLs232tmOrBZk7bvfCu
	 1TdDsRDcSf1BOqx7UYqWmWx4xoyIU401MjGIRBa++Vb70Ac4e0da7rMOyZUh4pQwxrWkG
	 HSFehDkPrn6mdOUFCEKp5hnMPcMdExhtdBCdIXpcifjjJDMD4r1GvGaI2iXV0SWAAsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=UaBY+juw;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AA4606A33F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03AA4606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=UaBY+juw
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-49de8ea072cso780064fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890680; x=1794495480; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vS1hYQjDf7uECmyaS0EpIO4k0JNkxhWN0MNWstfQo8M=;
        b=UaBY+juwZnv3TIDt4STtqHECIr3IwqB5pVFeP3aF8P4E0SEZ8KUvYn/7nhgl/3Lmid
         qHTQq6TCxsJHU1Okxh98irybrjbdhU9e7v9ZdBrSwF5n4esb6PUYNAWE1Yx/qCtzF9eZ
         TdXy3SydynOoe4kp1ksdgzibo+K9EluMzQEowuJ/uMRQUTZ5YPNHhedenr86nFy1uqUT
         WfHEhgFw2uiGJLRf2RUyqUYqSsb7FEb8MmdThLTAnueaa60nsOxZ1zbElRMbK44KIGYO
         e0ACK3Uo/MnWJXf4O9zA62IicYTrKCAai3o/HwHNkm9XOfKx0AOkPdYjKJAdAOJnJSQ7
         l3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890680; x=1794495480;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vS1hYQjDf7uECmyaS0EpIO4k0JNkxhWN0MNWstfQo8M=;
        b=Xl+m5QynqUzkA2s5ofGTivuoCfLWHIeP9We8Sb7d8+9ArqknePIybg5kI6nuda6aia
         JZar5TkfhPtZSvbFZZIT0Og63iRs9yljZFMYDNnc2ZRz6gG3e+2Db1dYDKZr0FuCjIxd
         FnluNN+J74Ov4Fa3vbhPr5wl94+PxfTKch7Fxn1Bavpd0ksMHMAh+pQkpiwQy7dmLghH
         LyLNw8tx44fZQL4FqH3X88cLp1T2rC8mNRuL4Jxfqr6jWYLfAp3WlOmsEVWBu+epc3/a
         1Me9i1E390xksWMaYAF3rE9GD/5XxmoIYMcLZBJWiLxv7F6zba182HZ9m4NosoQ5pwSA
         PbOw==
X-Gm-Message-State: APuU4Z+wnfVanxoy2M6tpYpsPbi215fqg1Xy5WDLwSEm3Z8gkreTEHgV
	//O5J0EmWIH2N8xIabYOqpXjy15rkJRluDAIUkDkOoX4jXFQ1+eU/Z3yShqwr4iv3DE=
X-Gm-Gg: AYBFou27bM3N2I6rYQFhLFo3naodAiP7p0Hy5AQdMBZGG1ygZjQwFFL+CNVzbCpZ2/q
	CZeaucas57xjljj6QBsXDIxpLN3TaoWwjrkdwksaYa7ivU8Q9ZeVYeyjM1Wg3jjEwvznsYhdDaP
	ZOoJLl7GFTI3pjBxAxAeB21leSkavTy3lAxtWIX+1VOZHHg1SAvPVyOVCdqmsnD5Jnx5mPjZSPn
	Lv6+HEYW3sFHUlvyZu2x3y6CVTXGMuLbwKnwnW7t/63FVq91cRgqnhwusdXLU1NuuExlZiyY5tR
	eLg8EoO56OQfsA8mHPI9a0DqWXgdv7Uj9ZE70PJcpqfpnRRYJ/7WhS7C0eqWg8G8Pn8rM3OTy6L
	fbdxCKBqSP9pI1yZyxz+e7v0v2PqpqoF5nik3E+gVQ3bdN09bvE2VeZU5Irl2b3mKFS2RXIUuu9
	T38a+dsF5p0c9t1tS48IaF/xipfIDqAC/J82eSIMPD6YZ4xqSMGKONKRlAkBWJ1q17ziICP/omz
	I1suvgv2ed4DWuEgTwbE/dP3iTL37NHknPdSdjEvAseTxVt/rFB0nPVtv5+VXchFLBvcCTc4LgB
	XiFe+Wu46a8f2EDCKWwbSfB+gzPg9Rx/5kqLRaFIG/zQOWrw1EGD/SICL4Jb/pknQtk=
X-Received: by 2002:a05:6870:6711:b0:4a8:ffd4:9a6c with SMTP id 586e51a60fabf-4a9077a1f74mr12826069fac.45.1793890679300;
        Thu, 05 Nov 2026 06:57:59 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea48fd55sm4873569fac.4.2026.11.05.06.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:57:58 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:56:53 +0000
Subject: [PATCH RFC v3 02/90] Documentation: add examples for cells
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
Message-Id: <20261105-b4-cells-v3-2-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890669; l=27728;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=vre85eT0RC2zcGLdYEmkpJaMHEeFuvcPTHBQUF88o/E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHd7aChLUU61zyeMyfBSFvNXZsqyY2LYbx4VME6y7bC3Q8IYBqHNn9WAmtUYjkDtTzPcx9Chp9t
 WQa63dD0fRQ8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The design document explains what a cell is and why. Add a second page for
people who write a builder. It walks through the common cases: running a
single program, running a service from an image, devices, a network, an
init system, starting another task in a running cell, and containers that
belong together.

A cell only has what it was given, and it sets up nothing by itself.
Software that runs fine in a container often fails at first for that
reason. The most common cause is capabilities, because a cell has none
unless the builder names them. So the page lists a sensible starting set,
says what each capability is for, and shows what the failure looks like
when one is missing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/userspace-api/cells-examples.rst | 551 +++++++++++++++++++++++++
 Documentation/userspace-api/index.rst          |   1 +
 2 files changed, 552 insertions(+)

diff --git a/Documentation/userspace-api/cells-examples.rst b/Documentation/userspace-api/cells-examples.rst
new file mode 100644
index 000000000000..2c0c64dca906
--- /dev/null
+++ b/Documentation/userspace-api/cells-examples.rst
@@ -0,0 +1,551 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========
+Using cells
+===========
+
+Documentation/userspace-api/cells.rst says what a cell is and why it is the way it is.
+This page is for whoever writes a builder: a container runtime, a sandbox, a test
+harness.  It goes through what a builder commonly wants, and through what commonly goes
+wrong the first time.
+
+One rule explains most of it.  **A cell has what it was given, and it sets up nothing by
+itself.**  It mounts nothing, it configures no network, and being its root comes with no
+capability.  What a container today does for itself on its way up, the builder of a cell
+does from the outside, before the first task runs.
+
+Error handling is left out of the examples.  There are no wrappers for the system calls
+in the C library yet, so ``cell_create()`` and the others stand for ``syscall(2)``.
+
+.. contents:: :local:
+
+
+A program and nothing else
+==========================
+
+The smallest cell takes no privilege.  It runs one program as the user who builds it,
+which can see the tree it was given and reach nothing else: no network, no other task,
+no capability.
+
+.. code-block:: c
+
+   int cfd, tree, ns, pidfd, status;
+
+   cfd = cell_create(CELL_SELF, 0);
+
+   tree = open_tree(AT_FDCWD, "/home/me/sandbox", OPEN_TREE_CLONE);
+   ns = open_tree(tree, "", AT_EMPTY_PATH | AT_RECURSIVE | OPEN_TREE_NAMESPACE);
+   cell_configure(cfd, CELL_SET_FD, "root", NULL, ns);
+   cell_configure(cfd, CELL_SET_FD, "budget", NULL, cgroup_dirfd);
+   cell_configure(cfd, CELL_CMD_SEAL, NULL, NULL, 0);
+
+   pidfd = pidfd_open(cfd, PIDFD_EMPTY);
+   pidfd_configure(pidfd, PIDFD_SET_STRING, "exec", "/bin/convert", 0);
+   pidfd_configure(pidfd, PIDFD_SET_BINARY, "argv", "convert\0-\0png:-", 16);
+   pidfd_configure(pidfd, PIDFD_SET_FD, "0", NULL, in_fd);
+   pidfd_configure(pidfd, PIDFD_SET_FD, "1", NULL, out_fd);
+   pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0);
+
+   read(cfd, &status, sizeof(status));
+
+The ``ids`` slot was left empty, so this is a one-id cell.  A builder without privilege
+does the mounting in a user and mount namespace of its own, since ``open_tree()`` with
+``OPEN_TREE_CLONE`` takes ``CAP_SYS_ADMIN`` over the mount namespace of the caller.  The
+cgroup has to be one that it owns and could move itself into, such as one that
+``systemd --user`` has delegated to it.
+
+The new task has the three files it was given and no others.  There is nothing to close
+and nothing to forget.
+
+
+Which capabilities
+==================
+
+.. note::
+
+   If software that runs fine in a container fails in a cell with ``EPERM``, this is the
+   first place to look.
+
+A container runtime starts from everything and takes away.  Docker leaves fourteen
+capabilities by default.  A cell starts from nothing, and **uid 0 of a cell is an id like
+any other** until the builder says otherwise:
+
+.. code-block:: c
+
+   __u64 caps = 1ULL << CAP_CHOWN | 1ULL << CAP_DAC_OVERRIDE | 1ULL << CAP_FOWNER |
+                1ULL << CAP_SETUID | 1ULL << CAP_SETGID | 1ULL << CAP_KILL;
+
+   cell_configure(cfd, CELL_SET_BINARY, "caps", &caps, sizeof(caps));
+
+Those six are what it takes to be root over the ids of the cell, and they are a good
+place to start for anything that expects to be started as root: an init system, a
+package manager, a daemon that drops privileges.  All of them are about the cell's own
+ids, files and tasks.  None of them reaches anything else.
+
+======================  ==========================================================
+Capability              What stops working without it
+======================  ==========================================================
+``CAP_SETUID``,         Becoming another user: ``setuid()``, ``setgid()``,
+``CAP_SETGID``          ``setgroups()``.  A daemon that drops privileges, ``su``
+                        and ``runuser`` run by root, ``User=`` in a unit.
+``CAP_CHOWN``           Giving a file to another id: unpacking an archive with its
+                        owners, ``install -o``, ``systemd-tmpfiles``, delegating a
+                        cgroup.
+``CAP_FOWNER``          ``chmod()``, ``utimes()`` and the like on a file that
+                        belongs to another id, including one that was just given
+                        away.
+``CAP_DAC_OVERRIDE``    Reading, writing and creating where the mode says no to
+                        uid 0, such as in the home or the state directory of
+                        another id.
+``CAP_KILL``            Signalling a task that runs under another id.  An init
+                        cannot stop such a service.
+======================  ==========================================================
+
+A program that runs as one id from start to end needs none of them.  That is the common
+case for a single service, and the best one: start it as the id it is to run as, with the
+``cred`` key of ``pidfd_configure()``, and leave the slot empty.
+
+.. code-block:: c
+
+   struct pidfd_cred cred = { .uid = 33, .gid = 33 };      /* ids of the cell */
+
+   pidfd_configure(pidfd, PIDFD_SET_BINARY, "cred", &cred, sizeof(cred));
+
+Others that come up:
+
+``CAP_NET_ADMIN``, ``CAP_NET_RAW``
+  Good for nothing by themselves.  They say who in the cell may use the rights over its
+  network that the builder has named, see `A network`_.  Listening on port 80 and ``ping``
+  do not take a capability at all.
+
+``CAP_SYS_CHROOT``
+  For ``chroot()``, which some daemons use on themselves.
+
+``CAP_SYS_PTRACE``
+  For debugging, and reading ``/proc/<pid>`` of, a task that runs under another id.
+
+``CAP_SYS_ADMIN``
+  Over a cell this is far less than the name suggests.  It does not let a cell mount or
+  make a namespace.  It is for ``sethostname()`` and a few more.  Give it only to what
+  asks for it, see `An init system`_.
+
+``CAP_SETPCAP``
+  Not needed to shrink the bounding set, which in a cell takes nothing.
+
+``CAP_SETFCAP``
+  Refused.  Nothing that a cell writes imparts privilege.
+
+``CAP_MKNOD``, ``CAP_SYS_MODULE``, ``CAP_SYS_RAWIO``, ``CAP_SYS_TIME`` ...
+  Can be named and do nothing.  What they guard asks for them over the user namespace of
+  the host.
+
+What it looks like when one is missing:
+
+=====================================================  ========================
+Seen                                                   Wants
+=====================================================  ========================
+``setgroups: Operation not permitted``,                ``CAP_SETGID``,
+systemd: ``status=216/GROUP``                          ``CAP_SETUID``
+``chown: Operation not permitted``,                    ``CAP_CHOWN``
+``fchownat() of ... failed``
+``fchmod() of ... failed: Operation not permitted``    ``CAP_FOWNER``
+right after a ``chown``
+``Permission denied`` for root                         ``CAP_DAC_OVERRIDE``
+systemd: ``Failed to kill main process``               ``CAP_KILL``
+systemd: ``status=217/USER`` for a unit with           ``CAP_SYS_ADMIN``, or
+``PrivateTmp=`` and the like                           drop the options
+=====================================================  ========================
+
+``grep Cap /proc/self/status`` in the cell and ``cell_info()`` with ``CELL_INFO_CAPS``
+outside of it tell what there is.
+
+The slot is for the whole cell, and it is an upper limit.  A task can let go of what it
+does not need, for itself and for what it starts, and nothing brings it back.
+
+
+A service from an image
+=======================
+
+An image is stored with on-disk ids from 0 up.  A block of ids and an idmapped mount make
+those the ids of the cell, for this cell and for as long as it lives.  Several cells can
+use one image at a time.  None of them sees the ids of another, and nothing is written to
+the image that says which cell wrote it.
+
+.. code-block:: c
+
+   unsigned int ids = 65536;
+   struct mount_attr attr = { .attr_set = MOUNT_ATTR_IDMAP };
+
+   cfd = cell_create(CELL_SELF, 0);
+   cell_configure(cfd, CELL_SET_BINARY, "ids", &ids, sizeof(ids));
+
+   attr.userns_fd = cfd;           /* a cellfd stands for the ids of the cell */
+   tree = open_tree_attr(AT_FDCWD, "/images/web", OPEN_TREE_CLONE, &attr, sizeof(attr));
+
+The ``ids`` slot has to be filled before a mount can be mapped for the cell.  Every
+writable mount of a filesystem that can be idmapped has to be, or the seal fails.
+
+For a read-only image with a writable layer, idmap the overlay and leave the layers as
+they are.
+
+What else goes into the tree is mounted on it before it becomes a mount namespace.  A
+filesystem for the cell to write to is mapped in the same way:
+
+.. code-block:: c
+
+   fs = fsopen("tmpfs", 0);
+   fsconfig(fs, FSCONFIG_SET_STRING, "mode", "1777", 0);
+   fsconfig(fs, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+   mnt = fsmount(fs, 0, MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV);
+   mount_setattr(mnt, "", AT_EMPTY_PATH, &attr, sizeof(attr));
+   move_mount(mnt, "", tree, "tmp", MOVE_MOUNT_F_EMPTY_PATH);
+
+``/proc`` is one for the pid namespace of the cell, which the builder gets from the cell
+while it is being built:
+
+.. code-block:: c
+
+   pidns = cell_open(cfd, CELL_OPEN_SLOT, "pids", NULL, 0);
+   fs = fsopen("proc", 0);
+   fsconfig(fs, FSCONFIG_SET_FD, "pidns", NULL, pidns);
+   fsconfig(fs, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+   mnt = fsmount(fs, 0, MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV | MOUNT_ATTR_NOEXEC);
+   move_mount(mnt, "", tree, "proc", MOVE_MOUNT_F_EMPTY_PATH);
+
+.. warning::
+
+   A procfs that is mounted the plain way shows the tasks of the builder's pid namespace,
+   and a sysfs the network devices of the network namespace it was mounted from.  See
+   `An init system`_ for sysfs.
+
+
+Devices
+=======
+
+A device is its number.  The builder makes a node in a filesystem that is mapped for the
+cell, and who in the cell may open it is a matter of the owner, group and mode of that
+node, in the ids of the cell.
+
+.. code-block:: c
+
+   dev = fsmount(fs, 0, MOUNT_ATTR_NOSUID);        /* a tmpfs, not yet mapped */
+   mknodat(dev, "null", S_IFCHR | 0666, makedev(1, 3));
+   fchmodat(dev, "null", 0666, 0);                 /* mknod() goes by the umask */
+   mknodat(dev, "kvm", S_IFCHR | 0660, makedev(10, 232));
+   fchownat(dev, "kvm", 0, 36, 0);                 /* group kvm of the image */
+   mount_setattr(dev, "", AT_EMPTY_PATH, &attr, sizeof(attr));
+   move_mount(dev, "", tree, "dev", MOVE_MOUNT_F_EMPTY_PATH);
+
+Binding the node of the host's ``/dev`` does not do it.  That one belongs to ids of the
+host, which nobody in a cell has, its root included, so what is left is what the mode has
+for everybody.  A device can also be handed over open, as a file of a new task.
+
+A cell makes no device nodes, whatever its capabilities.
+
+
+A network
+=========
+
+What is in the ``net`` slot decides, see "The network" in
+Documentation/userspace-api/cells.rst.  Most builders want ``"new"``: a network namespace
+that is made for the cell, belongs to the builder, and is set up by the builder.
+
+.. code-block:: c
+
+   cell_configure(cfd, CELL_SET_STRING, "net", "new", 0);
+   net = cell_open(cfd, CELL_OPEN_SLOT, "net", NULL, 0);
+
+   /*
+    * Move one end of a veth pair there, by IFLA_NET_NS_FD.  Then, in a helper that
+    * has called setns(net, CLONE_NEWNET): addresses, routes, and the links up.
+    */
+
+Nothing is done for the builder.  Until it brings ``lo`` up, connecting to 127.0.0.1 fails
+with ``ENETUNREACH``.
+
+No module is loaded because a cell asked for it.  A protocol, a tunnel or a packet filter
+that the cell is to use and that is built as a module has to be loaded on the host
+beforehand, or ``socket()`` fails with ``EAFNOSUPPORT`` in the cell where it works outside.
+
+What a container commonly has a capability for is a setting of the namespace here, which
+the helper makes while it is in there:
+
+.. code-block:: sh
+
+   sysctl -w net.ipv4.ip_unprivileged_port_start=80     # instead of CAP_NET_BIND_SERVICE
+   sysctl -w net.ipv4.ping_group_range="0 4294967294"   # instead of CAP_NET_RAW, for ping
+
+.. note::
+
+   The range is in the gids of whoever writes it, and the gids of a cell are those of its
+   block, from 2147483648 up.  The customary ``0 2147483647`` ends one short of the first
+   of them, and ``ping`` does not work.  Read from inside of the cell the setting
+   shows as ``65534 65534`` either way.
+
+The builder can go back in at any time, so the network can change while the cell runs:
+devices come and go, addresses and routes change.  Once the cell is sealed the way in is
+the file that ``cell_open()`` returned, or ``/proc/<pid>/ns/net`` of any of its tasks.
+
+**CNI plugins** work as they are.  They take a path for the namespace, and either will do:
+
+.. code-block:: sh
+
+   # a namespace that was made and pinned beforehand, as container runtimes do
+   ip netns add cni-1234
+   CNI_COMMAND=ADD CNI_NETNS=/run/netns/cni-1234 CNI_IFNAME=eth0 ... ptp < conf
+   # then: cell_configure(cfd, CELL_SET_FD, "net", NULL, open("/run/netns/cni-1234"))
+
+   # or the one of the cell, "new", by way of the file that cell_open() returned
+   CNI_COMMAND=ADD CNI_NETNS=/proc/$builder/fd/$net CNI_IFNAME=eth0 ... ptp < conf
+
+The second needs no pin, so nothing is left behind if the runtime goes away.  **Keep that
+file.**  ``cell_open()`` returns it only while the cell is being built, and a cell that dies
+takes its network along.  With the file the network comes down in the customary order,
+tasks first:
+
+.. code-block:: c
+
+   cell_kill(cfd, 0);
+   poll(&(struct pollfd){ .fd = cfd, .events = POLLIN }, 1, -1);
+   /* CNI_COMMAND=DEL CNI_NETNS=/proc/$builder/fd/$net ...: all there, nobody in it */
+   close(net);
+
+Without it the namespace is gone by the time anybody notices that the init of the cell has
+exited, and a plugin can undo only what it finds without.  ``ptp`` then still succeeds and
+gives the address back, and the veth pair went with the namespace, but the masquerading
+rules that it made on the host stay behind.
+
+A rule that goes by a uid or a gid means the ids of whoever owns the network namespace, and
+that is the builder.  To it, uid 1337 of the cell is not 1337.  ``cell_info()`` tells what
+it is, from when the ``ids`` slot is filled:
+
+.. code-block:: c
+
+   struct cell_info info = { .mask = CELL_INFO_IDS_FIRST };
+
+   cell_info(cfd, &info, sizeof(info), 0);
+   /* nft add rule ... meta skuid (info.ids_first + 1337) ...
+    * ip rule add uidrange ..., iptables -m owner --uid-owner ... */
+
+The bit is not set in ``mask`` on return if the caller has no name for those ids, as in a
+user namespace that maps nothing but the caller.  To such a builder everybody in the cell
+is the overflow uid, and it cannot tell them apart in a rule.
+
+What a dataplane hangs on the outside applies to a cell as to any container, and the cell
+can neither see nor undo it: filters on the host's end of a veth or netkit pair, and BPF
+programs on a cgroup.  One that is attached to the budget holds for every cgroup that the
+cell makes below.
+
+A device of the host's can be moved in as well, a NIC for one.  It goes back to the host
+when the namespace goes.  With ``"new"`` that is when the cell is dead, provided that
+nobody else holds the namespace: no file, no bind mount.  A pinned namespace keeps what was
+moved there until it is unpinned, whatever has become of the cell.
+
+A cell that is to change something about its network is given the right to, by name.  The
+namespace stays the builder's: a CNI plugin sets it up as ever, and the cell does what it
+was given the right to on top of that.
+
+.. code-block:: c
+
+   /* It adds rules to the packet filter, and nothing else. */
+   __u64 rights = CELL_NET_FILTER;
+   __u64 caps = 1ULL << CAP_NET_ADMIN;
+
+   cell_configure(cfd, CELL_SET_STRING, "net", "new", 0);        /* first */
+   cell_configure(cfd, CELL_SET_BINARY, "net-rights", &rights, sizeof(rights));
+   cell_configure(cfd, CELL_SET_BINARY, "caps", &caps, sizeof(caps));
+
+It takes both.  The right says what the cell may do to its network, and the capability says
+who in the cell may do it: ``CAP_NET_RAW`` for ``CELL_NET_RAW``, ``CAP_NET_ADMIN`` for all
+others.  What sets up the rules can let go of the capability before it runs the rest.
+
+===============================================  ====================================
+What runs in the cell                            Rights
+===============================================  ====================================
+``iptables``, ``nft``                            ``FILTER``; ``iptables-legacy`` also
+                                                 ``RAW``, for the socket it uses
+a VPN client                                     ``TUN``, ``LINK``, ``ADDR``, ``ROUTE``
+a VMM with a TAP device and a bridge             ``TUN``, ``LINK``, ``LINK_NEW``
+``tcpdump``, ``ping`` the old way                ``RAW``
+a transparent proxy                              ``SOCKOPT``, with rules and routes that
+                                                 the builder can just as well make
+a DHCP client                                    ``RAW``, ``ADDR``, ``ROUTE``
+what runs the network of the host, given that    what it does there, and the builder
+for a ``net`` slot                               needs to be able to do that itself
+===============================================  ====================================
+
+A request that takes a right which the cell does not have fails as it does for anybody
+without the capability, with ``EPERM``, or ``EACCES`` below ``/proc/sys/net``.
+
+A cell that was given the network namespace of the host can use the network of the host, and
+listen on a port from ``ip_unprivileged_port_start`` up.
+
+A program that wants a TAP device, a VMM for one, needs ``/dev/net/tun`` in its tree and
+one of these:
+
+* ``CELL_NET_TUN``, and it makes the device, or attaches to one that the builder has made;
+* the device already open, as a file of the new task.
+
+Naming an owner for the device does not do it.  The owner and the group of a tun device
+count in the cell that named them and in no other, so what the builder sets with
+``TUNSETOWNER`` means nothing in the cell, whichever id it is.  Within the cell they work as
+ever: a task that has the right can make a device for another that has not.
+
+
+An init system
+==============
+
+An init expects to find a system, or to put one together.  In a cell it cannot do the
+latter, so the builder does.  This is what systemd 255 takes to boot to
+``multi-user.target``, run units under other users with limits of their own, and shut
+down in order.
+
+Mounted on the tree, besides the root itself:
+
+=====================  ===============================================================
+Where                  What
+=====================  ===============================================================
+``/proc``              procfs for the pid namespace of the cell
+``/sys``               sysfs, read-only, see below
+``/sys/fs/cgroup``     the budget: ``open_tree(AT_FDCWD, budget, OPEN_TREE_CLONE)``
+``/dev``               a tmpfs that is mapped for the cell, with ``null``, ``zero``,
+                       ``full``, ``random``, ``urandom``, ``tty`` and ``console``, and
+                       the links ``fd``, ``stdin``, ``stdout``, ``stderr``, ``ptmx``
+``/dev/pts``           devpts with ``newinstance,ptmxmode=0666``
+``/dev/shm``,          a tmpfs each, mapped for the cell
+``/run``, ``/tmp``
+``/run/lock``          likewise.  Debian and Ubuntu do not boot without it
+=====================  ===============================================================
+
+systemd leaves alone what is mounted already.  What is not, it tries to mount, and gives
+up with "Failed to mount API filesystems".
+
+A sysfs shows the network devices of the network namespace that its mounter was in.  For
+``"new"`` the builder mounts it from in there:
+
+.. code-block:: c
+
+   old = open("/proc/self/ns/net", O_RDONLY);
+   setns(net, CLONE_NEWNET);
+   fs = fsopen("sysfs", 0);
+   fsconfig(fs, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+   mnt = fsmount(fs, 0, MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV |
+                        MOUNT_ATTR_NOEXEC);
+   setns(old, CLONE_NEWNET);
+
+Without a network, ``unshare(CLONE_NEWNET)`` in place of the first ``setns()`` makes for an
+empty one.
+
+The environment says that this is a container, which keeps systemd from what is only for
+real hardware:
+
+.. code-block:: c
+
+   pidfd_configure(pidfd, PIDFD_SET_STRING, "exec", "/usr/lib/systemd/systemd", 0);
+   pidfd_configure(pidfd, PIDFD_SET_BINARY, "argv", "systemd", 8);
+   pidfd_configure(pidfd, PIDFD_SET_BINARY, "envp", "container=cell", 15);
+
+The six capabilities of `Which capabilities`_ are enough.  systemd goes by the bounding set
+of pid 1 to tell what is worth trying, so it skips debugfs, tracefs and the mqueue
+filesystem by itself.
+
+It manages the cgroups below the budget as it does anywhere: it moves itself to
+``init.scope``, enables controllers, and makes a cgroup with limits for every unit.  The
+limits of the budget itself are not the cell's to change.
+
+When pid 1 exits, by ``SuccessAction=exit`` of a unit for one, its wait status is what
+``read()`` on the cellfd returns.
+
+.. note::
+
+   ``PrivateTmp=``, ``ProtectSystem=``, ``ProtectHome=``, ``PrivateDevices=`` and the other
+   options that are done with a mount namespace do not work, since a cell makes no
+   namespaces.  What systemd makes of that depends on ``CAP_SYS_ADMIN``.  With it, it tries,
+   fails, and **starts the unit without them**, which it logs at debug level only.  Without
+   it, it tries a user namespace first, and the unit fails with ``status=217/USER``.
+   ``NoNewPrivileges=``, ``SystemCallFilter=`` and what else is done with seccomp work.
+   The cell is the sandbox.  What needs to be kept apart goes into cells of its own.
+
+
+Another task in a running cell
+==============================
+
+There is no entering a cell.  What takes the place of ``nsenter`` and ``docker exec`` is
+another spawn, by whoever holds the cellfd:
+
+.. code-block:: c
+
+   pidfd = pidfd_open(cfd, PIDFD_EMPTY);
+   pidfd_configure(pidfd, PIDFD_SET_STRING, "exec", "/bin/sh", 0);
+   pidfd_configure(pidfd, PIDFD_SET_FD, "0", NULL, pty);
+   pidfd_configure(pidfd, PIDFD_SET_FD, "1", NULL, pty);
+   pidfd_configure(pidfd, PIDFD_SET_FD, "2", NULL, pty);
+   ret = pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0);
+
+The task starts in the budget.  If the init of the cell manages cgroups that fails with
+``EBUSY``: it has enabled controllers on the budget, and a cgroup that passes a controller
+on holds no task.  The builder then says where, and the cgroup that the init is in will
+always do.  A start can be tried only once, so this takes a new pidfd:
+
+.. code-block:: c
+
+   /* "0::/cell0/init.scope", as the host sees it */
+   snprintf(path, sizeof(path), "/proc/%d/cgroup", init_pid);
+   ...
+   cg = open("/sys/fs/cgroup/cell0/init.scope", O_RDONLY | O_DIRECTORY);
+   pidfd_configure(pidfd, PIDFD_SET_FD, "cgroup", NULL, cg);
+
+It has to be the budget or lie below it.  It takes no permission on the cgroup, which
+belongs to ids that nobody outside of the cell has.  Should the cell have removed it in
+the meantime the start fails, with ``ENODEV``, and the builder looks again.
+
+The new task has the capabilities in the ``caps`` slot, as every task that is started in
+the cell.  Its parent is the spawner, but nobody has to wait for it: the pidfd tells how it
+ended.
+
+
+Containers that belong together
+===============================
+
+Containers that trust each other, as those of a pod do, are tasks of one cell.  They share
+its pid namespace and network, can signal each other and pass each other files.  The
+builder makes a cgroup below the budget for each, sets its limits, and starts each where
+it belongs:
+
+.. code-block:: c
+
+   mkdirat(budget, "pause", 0755);
+   mkdirat(budget, "app", 0755);
+   mkdirat(budget, "sidecar", 0755);
+   /* the first task is the init of the cell: when it exits, so does the cell */
+   start(cfd, "/pause", openat(budget, "pause", O_RDONLY | O_DIRECTORY));
+   write_at(budget, "cgroup.subtree_control", "+memory +pids");
+   write_at(budget, "app/memory.max", "1G");
+   write_at(budget, "sidecar/memory.max", "128M");
+   start(cfd, "/app/run", openat(budget, "app", O_RDONLY | O_DIRECTORY));
+   start(cfd, "/sidecar/run", openat(budget, "sidecar", O_RDONLY | O_DIRECTORY));
+
+The seal hands the budget to the ids of the cell, so from then on this takes a builder that
+is not held back by the owner of a file.  They all start at the root of the cell for now.
+What does not trust each other goes into cells of its own.
+
+
+The end
+=======
+
+A cell is dead when its first task has exited and everything else in it is gone.  The
+cellfd then polls readable, and ``read()`` returns the wait status of the first task.
+
+.. code-block:: c
+
+   struct pollfd p = { .fd = cfd, .events = POLLIN };
+
+   if (!poll(&p, 1, 30000))
+           cell_kill(cfd, 0);      /* everything in it, wherever it has got to */
+   read(cfd, &status, sizeof(status));
+
+``cell_kill()`` does not wait, the ``read()`` does.  Closing the last cellfd kills the cell
+too, so a builder that dies takes its cells along.
+
+The cgroups that the cell made below the budget are removed with it, and the budget is
+given back to whoever owned it.
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index b9d2e4bef24c..f11307aa8970 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -18,6 +18,7 @@ System calls
 
    unshare
    cells
+   cells-examples
    futex2
    ebpf/index
    ioctl/index

-- 
2.55.0

