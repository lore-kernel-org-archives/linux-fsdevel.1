Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890681;
	b=cMzQM9ji+iqgRW2Nkmwm4gGghkZci99PdZu4QKkSn+le0eWwkZlOI1dAdYLaxPpY2JSm
	 SPXM71mr5vhuKrl8QrSbH5YIRxvIUTNKJNLeTSwj6vnGdKIAO93Cwl/SRDyWKxH/Hgv55
	 Kpkfy+ZCIO2+9uwaRhste53y8MXd5M9vvF2eA9EKiOJvXhhGcU+01ywotyvV9B+50NFQB
	 /aTD4O3YfUmm21d7S+CNZEFVP9QYxrzZiA0pk+wwWcwxAhfNqhFT96COtWlxUjokxBnI2
	 P0Zk2nc/UxkQB0k6Un32OVaAmZ6AxUiNEOA0A8kMwmFWEvnr3kVkdJUQ3tiB1LG60wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=nar5EDPeq2WKZA6TfSFQHr48sDvm+ghzMJ7JwHmRHqI=;
	b=ZHJgZGomb2S8JkJgQvlCqshGHCmhcsF5td64dmi2b7eWD+rz23ZYAZNPx5dRPS5pBdih
	 mhUgHY45XOPeip/YupVVIHtNxoRQXPgTYwZ6AhpQUUbHGJd/ErhWV7DTRAn1CRbo+qdL7
	 mdHJG91IGZ+H7P+O954gjUDCA+aibhpDK2Jgb8EE55QVPtlIXrTe4qdaTja1Wwm84HjFY
	 KdwxLDDUdywq4A+uPtYnFQZTR05AnaXnAz2t+x7Tv2GBLG3x7SHOsaeZEk/C6i/tdP7CR
	 rOTYLcC/LOpojiPUs29E5WUPHarI7+VgFOV51Ue0RmAO01MEUzK4iFAPbjvHpxxdsDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ZnLmKzDL;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF486606A333
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF486606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ZnLmKzDL
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-53c156ba662so1010097b6e.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890678; x=1794495478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nar5EDPeq2WKZA6TfSFQHr48sDvm+ghzMJ7JwHmRHqI=;
        b=ZnLmKzDLiQlsF6vCGU1y3PjdET6sJGBV2fOcfOUxFYJLJF4zO7kQ1nnPmkeN5TMQ/J
         CnXAuufdiAOQAcdCGOfk3lUjuhoinm7iHAnoG0aZIqWpTZJcEeY3Afyh5ZSZ9MyxLlko
         tQXrWUYwtosnKi6/1+XAE0vDSdF8lCeNI2g96c7xfuK6nAnlwJfbm7tYUwAT+irTmXq9
         SN2NBY1rXKUxfGtY6tjhjL6k0BhMqXuu8HBr3t4BShyRJ76T7y3AYp9itG0uQOu8HI+7
         gZyYECCkOLIFIbBB8ULBW9aOdJ8UJnciqybJHYuaHSpdDbxo6LUUq6cvOJJ+ya2VkKXB
         T4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890678; x=1794495478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nar5EDPeq2WKZA6TfSFQHr48sDvm+ghzMJ7JwHmRHqI=;
        b=Znk4KoC5y1OTXBNyYeJMENLN0H7pcP1S/T1zf/VpsdrUQ+tC5sVY03uT2EJPILv6Pn
         NymWWkVSQ0A8pTKKb0YM2w8ltQQUSLbtDycskv436I9QOP54GyNcebcfniVdWJnvwmug
         zntKAOwr//YuwcgVEKR5ZSmNVZMlQF1iO+5KLeB0WRIv4Fh0nLx9X42Uf+L4/y65jioI
         NB6pjWWwwEEZwwvysWYUHmJIb+m7DSNT53T6TIuU9tto79B5dGr3W/9hmalrOvjTSn3o
         2N0wLCTTiW8kGlgaywd0Tpz7nsu63YzkhQZL7gFtSsHktWbMsGP77UedHgYAEsM+cEvH
         SQSg==
X-Gm-Message-State: APuU4Z+znHlaehtYylQrrxzeO71pruiUfr+HLJN8RtAm0HiJsecZ+63b
	Vp+OzaCAUoi4CQ9NtCevtvQhGlxoILZwthgaSb8teBn3d9LcPTpTE/LnA6WfFZHsu7wxywbriGC
	e1Fkm0hw=
X-Gm-Gg: AYBFou2OKwv7q+p2IaAKfKnHxT8tP8E7EXGz2UZzW1aw+8U7Qxk+h6X6qklPdn/eRFT
	2rV1cZReMw0zd37diq6jO7arE72g/7Qs6f7ujs0uPWIdUe+g/y4GgkS6xaav++IBEUqyTZhh3eP
	3y2nwBs2wumR6b7O5y8xYi0TZ6WbrXB2e1JVMIEOzNN+jxcY+r4uFmZRT+TI49aJ8DPKEfOJqDa
	gxXwyGmcvuhA2pvOdlFK3mIkDwBWZUUxhSV0WEiREnhRCvUmmAyHp03N1DZNNA0AuxeBhHrKXBz
	zULJmBqESnu5iKWx95IXPNrBBGiG+yhb8zCzKTmzKpdQvl1LaJ/5jWTnU21CzId72j63c3B/xnC
	ZORPXLX5m+ogreOxNuPj231Nz/jWqwTBSrsESNdzCsS6Y7ZchUZf/Brm9WVgPiUSgGCGM9pWvJf
	HSHhz2b1L/XmXvhZF7qAMNzyynApWo1D+EVICAdkI3NrApQwQdfzPd4oNRq8otZhDt03Jzdbef8
	aZsNLiEKQieN6a8yLmxxTdOWEVfEsj9nGaMoXhOuTAfFoNfzRd8tgQfq27wPexogOs0bLYVll9I
	UBtd98Yi1gmn0D9CT8Y63uMX+8/dlqB/h+IuJqoLOEftxfk=
X-Received: by 2002:a05:6808:181a:b0:53c:8f0e:ee21 with SMTP id 5614622812f47-5640ddf9fc5mr13755940b6e.10.1793890677858;
        Thu, 05 Nov 2026 06:57:57 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567ab6a5270sm4309976b6e.0.2026.11.05.06.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:57:57 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:56:52 +0000
Subject: [PATCH RFC v3 01/90] Documentation: add a design document for
 cells
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
Message-Id: <20261105-b4-cells-v3-1-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890669; l=48727;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=9YLbf5BuIpqCf+od4Nq9PGWSUj8h7gHuYjUrs/vFYlc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIwP0yS0OvX0zUnwE4aH44e9fWVwJEOIWi1MFhlHxqDLmiXUSy+iYjqL7qneDbDqilHUDEc3I0G
 wqXRvrQFImgg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A container on Linux is not an object. It is eight kinds of namespace, a
cgroup, a seccomp filter and a set of conventions that a runtime holds
together. The kernel cannot name the result, kill it as a whole or account
for it.

A cell is a container as a single kernel object. A task is born in a cell
and never leaves it, and no existing task can enter one. A cell is built
from the outside: the builder fills named slots from file descriptors that
it holds, seals the cell, and then spawns tasks into it. Holding the
cellfd is the authority to do all of that.

Start the series with the design document. It describes what cells are
for, which invariants they uphold, how they are used, and what this
implementation does not do yet. The following patches refer to it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/userspace-api/cells.rst | 861 ++++++++++++++++++++++++++++++++++
 Documentation/userspace-api/index.rst |   1 +
 2 files changed, 862 insertions(+)

diff --git a/Documentation/userspace-api/cells.rst b/Documentation/userspace-api/cells.rst
new file mode 100644
index 000000000000..76ce5267fdb6
--- /dev/null
+++ b/Documentation/userspace-api/cells.rst
@@ -0,0 +1,861 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====
+Cells
+=====
+
+A cell is a container as one kernel object.  A task is born in a cell and never
+leaves it, and nothing can enter one.  A cell is built from the outside: the
+builder fills named slots from file descriptors it holds, seals the cell, and
+spawns tasks into it.  Holding the file descriptor of the cell, the *cellfd*, is
+the authority to do all of that.
+
+This document explains why cells exist, what they promise, how they are used and
+what the first implementation does not do yet.
+
+.. contents:: :local:
+
+
+Why
+===
+
+A container on Linux is not an object.  It is eight kinds of namespace, a cgroup,
+a seccomp filter and a set of conventions that a runtime holds together.  A number
+of problems follow from that, and they do not go away by fixing bugs one at a
+time.
+
+There is nothing to name.
+  The kernel cannot say which container a task is in, cannot kill a container in
+  one operation and cannot tell what a container has access to.
+
+Membership is a property of a task at a moment.
+  ``setns()`` and ``unshare()`` let a task change one namespace at a time.  A task
+  that is half way between two sets of namespaces, holding file descriptors, a
+  working directory or a memory map from one side and credentials from the other,
+  has been the source of many bugs.
+
+Setup runs on the inside.
+  A runtime forks, and the child sheds, one call at a time, what it inherited and
+  should not have.  What it forgets to shed leaks into the container.
+
+Privilege hangs off ids.
+  A user namespace gives its creator a full set of capabilities over everything
+  the namespace owns, which puts a large amount of code that was written for root
+  within reach of every user.  Who may do what to whom is decided by comparing
+  uids, and whether two uids are the same depends on how several runtimes agreed
+  to carve up ``/etc/subuid``.
+
+Hiding is done by mounting over.
+  What a container must not see is commonly covered by a mount.  ``MNT_LOCKED``
+  exists to keep such mounts in place, and a way to remove one, or to copy the tree
+  without it, reveals what it covered.
+
+A cell turns this around.  There is one object with one lifetime.  What it holds
+was put there explicitly, by somebody who held it.  What was not put there is not
+there.
+
+
+The model
+=========
+
+Invariants
+----------
+
+The implementation is meant to uphold the following.  A way to break one of them
+from the inside of a cell, or as an unprivileged user outside, is a bug.
+
+#. **A task never changes cell.**  There is no way to enter a cell and no way to
+   leave one.  The namespaces of a cell belong to the cell and not to its tasks.
+#. **A cell holds what it was given.**  Slots are filled from file descriptors the
+   builder holds.  Filling a slot takes what using the object would take.
+#. **Authority over a cell is the cellfd.**  No uid and no capability is compared
+   when a cell is configured, spawned into or killed.  There is no cell without
+   somebody who holds one: it dies with the last.
+#. **Nothing is inherited that gives access to anything.**  A task that is spawned
+   into a cell starts with no memory map and no open files.  What it can reach is
+   what it was given.  `Spawning: empty pidfds`_ lists what it does inherit.
+#. **After that nothing crosses.**  Once a task has started, no file descriptor and
+   no identity crosses the boundary of its cell.  A cell that was given a network
+   namespace to share is an exception, see `Not there yet`_.
+#. **A cell starts nothing it was not allowed to.**  Making a cell and starting a
+   task in one is a slot like any other, ``spawn``.  It cannot be filled yet, so what
+   runs in a cell comes from a ``fork()`` and ``execve()`` of what was spawned into
+   it, or from outside.
+#. **A uid means nothing across cells.**  Not an equal one, and not 0.
+#. **Files impart no privilege.**  Nothing a cell runs can gain privilege from a
+   file, and nothing a cell writes can give privilege to anybody else.
+#. **Nothing is hidden by a mount.**  Whatever is in the tree of a cell, the cell
+   may see all of it, including what lies under every mount point.
+#. **Ids are lent.**  The kernel chooses the kuids and kgids of a block, nobody else
+   can hold one of them while the cell does, and nothing the cell made may still be
+   owned by one when they are lent again.
+#. **DEAD means gone.**  When a cell reports that it is dead, no task of it is left,
+   not even one that is on its way out, and the cell has dropped every reference it
+   held.  What that sets off, such as the release of mounts, of the network
+   namespace and of the block of ids, completes on its own time.
+
+Life of a cell
+--------------
+
+A cell only ever moves down this list.
+
+=================  =============================================================
+``CELL_BUILDING``  Slots may be filled.  Nothing runs.
+``CELL_SEALED``    Immutable.  Nothing has been spawned yet.
+``CELL_RUNNING``   Has, or had, its first task.
+``CELL_DYING``     Was killed, or its first task has exited.
+``CELL_DEAD``      Nothing is left.  The exit status can be read.
+=================  =============================================================
+
+The first task that is spawned is the init of the pid namespace of the cell.  When
+it exits the kernel kills everything else in that namespace, as it does for any pid
+namespace, and the cell dies.
+
+A cell can be killed in every state.
+
+**A cell lives for as long as somebody holds a cellfd on it, and no longer.**  When the
+last one is closed, be it because whoever held it was killed, the cell is killed.  A
+cellfd can be passed on, so a cell can be handed to a supervisor, but a cell that nobody
+holds is a cell that nobody could kill, spawn into or wait for.
+
+Slots
+-----
+
+==============  =======================================  =======================
+Slot            Filled with                              If it is left empty
+==============  =======================================  =======================
+``ids``         a count: 1 or 65536                      1; refused for root
+``caps``        a set of capabilities                    no task has any
+``root``        a mount namespace nobody has entered     the seal fails
+``budget``      a cgroup v2 directory                    the seal fails
+``net``         a network namespace, or ``"new"``        no network
+``net-rights``  what the cell may do to its network      it changes nothing about
+                                                         it
+``hostname``    a string                                 ``(none)``
+``spawn``       nothing yet, the name is reserved        no task of the cell can
+                                                         make a cell or start a
+                                                         task in one
+==============  =======================================  =======================
+
+The pid, ipc, uts and cgroup namespaces of a cell are always new.  The cgroup
+namespace is rooted at the budget.  The time namespace is that of the builder.
+
+See `The network`_ for what goes into ``net`` and `Capabilities`_ for ``caps``.
+
+A file descriptor on a namespace is no authority over it, since anybody who can see a
+task can open one.  So filling ``root`` or ``net`` from one takes ``CAP_SYS_ADMIN`` over
+the user namespace that owns the namespace.  That is about what goes into the slot and
+not about the cell.  It is half of what ``setns(2)`` asks for: the other half is about
+the namespaces of the caller, which do not change.
+
+
+Ids
+===
+
+Every consumer of a kuid in the kernel knows how to deal with a user namespace, so
+a cell has one.  The kernel makes it together with the cell, and it differs from a
+legacy user namespace in the ways that make a legacy one hard to reason about:
+
+* Nobody can ``setns()`` into it.
+* The uid that created it has no capability over it.
+* Its map is set once, by the kernel, to ids the kernel chose.
+
+All translation between the ids a cell sees and the ids on disk stays in the VFS,
+in the idmapping of each mount of the tree.  See
+Documentation/filesystems/idmappings.rst.
+
+A cell comes in two shapes.
+
+One id
+  The cell runs on the uid and gid of whoever made it, under their own numbers, with
+  the supplementary groups of its maker and without capabilities.  It cannot be given
+  any: who is not uid 0 loses them with the first program it runs.  ``setgroups()`` is
+  denied.  The groups are kept because a group can be there to deny something.  This
+  shape is refused to root, since too much goes by the bare value of kuid 0, and to
+  an id that lies in the window described below.
+
+A block
+  The cell sees uids and gids 0 to 65535.  They map to a block of 65536 kuids and
+  kgids that the kernel allocates.  **The builder never picks a kuid.**  It takes no
+  privilege: a block that nobody holds gives access to nothing.  A user can hold
+  ``user.max_cell_id_blocks`` of them.  ``cell_info()`` tells which block it was, for
+  where something outside of the cell goes by an id: uid and gid N of the cell are
+  ``ids_first`` + N to the caller.
+
+Capabilities
+------------
+
+A legacy user namespace hands its first task every capability there is.  A cell hands
+out none.  **Being uid 0 of a cell comes with nothing**: it is one id of 65536, which
+cannot become another, give a file away or signal a task that runs under another id.
+
+What the tasks of a cell are to have, the builder names in the ``caps`` slot: a ``__u64``
+with a bit for each capability, by its number in ``<linux/capability.h>``.  Every task
+that is started in the cell has them permitted and effective.  They are its bounding set
+too, so that is all anything in the cell will ever have:
+
+* Every task has ``no_new_privs``.  It gains nothing from a file, or from being uid 0
+  when it runs one.
+* No task of a cell can make a user namespace, to have a full set in.
+* A capability that a task has let go of is gone for that task and its children.
+
+Letting go works as ever.  ``capset(2)`` takes nothing, leaving uid 0 behind with
+``setuid()`` costs all of them, and ``PR_CAPBSET_DROP`` does not take ``CAP_SETPCAP`` in
+a cell.  It does elsewhere lest a program that gains from its file runs with less than it
+counts on, and in a cell there is no such program.
+
+The capabilities are over the user namespace of the cell.  They are good for the ids of
+the cell, for the files that belong to those in a tree that is mapped for the cell, for
+its tasks, and for what else that user namespace owns: its uts, ipc and pid namespace.
+They are good for nothing else, which is why naming them takes no privilege.  The mount
+namespace is not the cell's, so no capability lets a cell mount.  Nor is the network
+namespace, see `Rights over the network`_.
+
+``CAP_SETFCAP`` cannot be named, see `Files`_.
+
+Most software that starts as root expects a few.
+Documentation/userspace-api/cells-examples.rst says which, and what it looks like when
+one is missing.
+
+The window
+----------
+
+Blocks come out of a window, the upper half of the id space less its last block:
+2147483648 to 4294901759.
+
+"Nobody else holds an id of this block" stands in for the privilege check that a
+legacy user namespace needs before it may map a range.  So it is enforced rather
+than assumed:
+
+* A legacy user namespace cannot map into the window.
+* **No create, chown or ACL stores an id of the window in a filesystem that the
+  cell does not own.**  Creating a file and ``chown()`` fail with ``EOVERFLOW``,
+  setting an ACL with ``EINVAL``.  Through a mount that is idmapped for the cell the
+  id has become the on-disk id before the check is made, so that works.  The check
+  goes by the value of the id and not by who is asking, because a stacking
+  filesystem may create files with the credentials of whoever mounted it.
+* A mount option that is read with ``fsparam_uid()`` or ``fsparam_gid()``, as most
+  are, takes no id of the window: ``uid=`` and the like fail with ``EINVAL``.
+* The one filesystem of the host's that holds ids of the window is cgroupfs, below the
+  budget of the cell they were lent to, and only a task of that cell puts them there.
+  See `The budget`_.
+* A block lives as long as the user namespace object it was lent to, not as long as
+  the cell.  Every credential, and every object that the namespace owns, pins the
+  namespace.  That covers the inodes which the kernel makes on filesystems of its
+  own and gives to the caller without asking: pipes, sockets, memfds, the slave of
+  a pty.  Each lives no longer than a file that is open on it, and the file pins the
+  credentials it was opened with.
+* The idmapping of a mount holds a copy of the maps.  One that was made for a cell
+  pins the user namespace as well, so a mount that is kept beyond the life of the
+  cell keeps the block from being lent again.
+* What the cell made below its budget is removed when the cell dies, and the budget
+  returns to its owner.  If that fails the block is never lent again.
+* Some tables are keyed by a bare kuid and pin nothing: ``struct user_struct`` and
+  the quota records of keys.  A released block is quarantined until they hold
+  nothing in its range, and a block is checked the same way before it is lent.
+
+Blocks are handed out round robin, so that reuse comes as late as it can.  A block in
+quarantine counts as used.  A leak therefore shows up as ``ENOSPC`` and never as one
+tenant owning what another left behind.
+
+.. warning::
+
+   With ``CONFIG_CELLS`` enabled the host itself cannot ``chown()`` a file to an id
+   of the window, or mount a filesystem with one for an option.  This is a change of
+   behaviour for a system that uses such ids.
+   Files that already belong to one, seen through a mount that is not idmapped,
+   look as if they belonged to whichever cell is lent that block.
+
+What the allocator does not cover is the ids on disk.  Through a mount that is
+idmapped for it, a cell with a block always uses on-disk ids 0 to 65535, so two cells
+that are given the same storage see each other's files.  That is sometimes intended,
+as with shared images, and remains the responsibility of the builder.
+
+
+The tree
+========
+
+The tree of a cell is built from scratch, one mount at a time, in a mount namespace
+that nobody has entered: see ``fsmount(2)`` with ``FSMOUNT_NAMESPACE`` and
+``open_tree(2)`` with ``OPEN_TREE_NAMESPACE``.  Sealing the cell makes that namespace
+the cell's, or fails without having changed anything about it:
+
+* No mount may be ``MNT_LOCKED``, since a locked mount hides what it covers.  The
+  tree itself may be: it sits on the root of the namespace, which is empty, and the
+  kernel locks it there for a builder that works in a user namespace of its own.
+* Nobody is in the namespace, or on the way in.
+* Every mount is made private.  Nothing propagates into a cell.
+* In a cell with a block of ids, a writable mount of a filesystem that can be
+  idmapped must be idmapped for the cell, or belong to a superblock the cell owns.
+  This is only the early and readable form of the ``EOVERFLOW`` above.
+
+To idmap a mount for a cell, pass the cellfd in ``mount_attr.userns_fd``.  On-disk
+ids 0 to 65535 then belong to the ids of the cell, or the one id to itself.
+
+It is the overlay that is idmapped for the cell, and not what it is made of.  An
+overlay writes to its upper layer with the credentials of whoever mounted it, and
+through a mount that is idmapped for the cell those have no id.
+
+A device is its number, and not the node in ``/dev`` of the host.  Whoever builds a cell
+makes a node for it in the tree of the cell, and who in the cell may open that goes by
+the owner, group and mode on disk, which the idmapping makes ids of the cell.  Several
+cells use one device that way, ``/dev/kvm`` say, each by a node of its own with a group
+of its own, and no id of the host is mapped into any of them.  Or the builder opens the
+device and hands the file to a new task.  The node of the host itself can be bound into
+the tree, but it belongs to ids of the host, which nobody in a cell has, its root
+included, so all that counts is what the mode has for everybody.  devtmpfs cannot be
+idmapped, and as a whole it should not be: every node that belongs to root would belong
+to the root of the cell.
+
+A seal that fails leaves the cell ``CELL_BUILDING``.  What it had filled in for slots
+that were left empty by then stays filled in.
+
+The mount namespace stays owned by the user namespace of the builder.  That is what
+keeps a task of the cell from mounting anything.
+
+
+The network
+===========
+
+The network of a cell is set up from the outside and handed to the cell, as the tree
+is.  A task of a cell uses it.  It does not configure it: a capability over a network
+namespace is one in the user namespace that owns it, and **a cell never owns a network
+namespace**.  This goes for ``CAP_NET_ADMIN``, ``CAP_NET_RAW`` and
+``CAP_NET_BIND_SERVICE`` alike, and for the root of the cell as for anybody else in it.
+What a cell is to do to its network all the same, the builder names, see `Rights over the
+network`_.
+
+What the builder puts into the slot decides what the cell gets:
+
+Nothing
+  No network.  ``socket()`` and ``socketpair()`` fail with ``EAFNOSUPPORT`` for every
+  family but ``AF_UNIX``, as in a kernel that was built without the rest.  An ``ioctl()``
+  that is about the network a socket is in and not about the socket, its devices,
+  addresses and routes, fails with ``ENODEV`` on any socket, and so do those that a
+  protocol keeps to itself, ``SIOCPROTOPRIVATE``.  A socket that is handed
+  to the cell works, and so does what ``accept()`` makes of it: it is the authority to
+  use it, and the only network such a cell has.
+
+A network namespace
+  That one, the way the builder has set it up: one it made for the purpose, one that
+  several cells share, or that of the host.
+
+``"new"``
+  One that is made for the cell, for the builder to set up.  ``cell_open()`` returns a
+  file descriptor on it, to enter it or to move a device there.  Until then there is a
+  loopback device in it, which is down.
+
+Nothing is done for the builder.  Whatever is not set up is not there, the address of
+the loopback device included.
+
+The network namespace belongs to the user namespace the cell was made in, or to whoever
+made it.  Who has ``CAP_SYS_ADMIN`` there can enter it whatever state the cell is in, so a
+network can be changed while the cell is running.
+
+**A cell that dies takes its network along.**  It lets go of the namespace, and unless
+somebody else holds that, it is the end of whatever is in there.  There is no cleaning up
+in there after the fact.  Nor is the namespace to be had from the cell once it is sealed:
+sealed is sealed.  Whoever wants to take the network apart in an orderly way keeps the
+file that ``cell_open()`` returned while the cell was built.  The namespace is there for
+as long as that file is, with all that is in it, and once the cell is dead with nobody
+left to use it.
+
+Some of what a container commonly has a capability for is a setting of the network
+namespace as well, and the builder can make it: ``net.ipv4.ip_unprivileged_port_start``
+for listening on port 80, ``net.ipv4.ping_group_range`` for ``ping``.
+
+Rights over the network
+-----------------------
+
+``CAP_NET_ADMIN`` over a network namespace is one capability for well over a hundred
+checks: devices, addresses, routes, the packet filter, queueing, tunnels, IPsec and more.
+A container that needs one of them gets all of them, and to have any it has to own the
+namespace, or to hold the capability on the host.
+
+A cell is given what it needs by name.  The ``net-rights`` slot takes a ``__u64`` with a
+bit for each thing that the tasks of the cell may do **to the network namespace in the**
+``net`` **slot**:
+
+======================  ==========================================================
+``CELL_NET_LINK``       change a device: up and down, mtu, name, address
+``CELL_NET_LINK_NEW``   make and remove devices
+``CELL_NET_ADDR``       addresses
+``CELL_NET_ROUTE``      routes, routing rules, neighbours, nexthops
+``CELL_NET_FILTER``     netfilter: nftables, the iptables family, ipset, conntrack
+``CELL_NET_TC``         queueing disciplines, classes, filters, actions
+``CELL_NET_TUN``        make tun and tap devices, attach to those of others
+``CELL_NET_SYSCTL``     write what is below ``/proc/sys/net``
+``CELL_NET_SOCKOPT``    ``SO_MARK``, ``SO_PRIORITY``, ``IP_TRANSPARENT`` and the like
+``CELL_NET_RAW``        IPv4 and IPv6 raw sockets, packet sockets, some IP options
+======================  ==========================================================
+
+The namespace stays the builder's.  It sets it up, with the tools it has always used, it
+can enter it at any time, and the cell does on top of that what it was given the right
+to.
+
+* **What is not in the table a cell cannot do.**  A check in the kernel that has not been
+  taught to say what it is for goes on asking for the capability over the owner of the
+  namespace, which no task of a cell has: IPsec, IPVS, whatever is configured by generic
+  netlink, such as ``ethtool`` settings and the keys and peers of a WireGuard device, the
+  ``ioctl()`` interfaces of bridges, VLANs and tunnels, and of what takes ``CAP_NET_RAW``
+  the sockets of ``AF_XDP``, LLC, NFC and IEEE 802.15.4.
+* **The right says what, a capability says who.**  Of the tasks of the cell, those may use
+  a right that have the capability it takes anywhere else, ``CAP_NET_RAW`` for
+  ``CELL_NET_RAW`` and ``CAP_NET_ADMIN`` for the rest, in the user namespace of the cell.
+  So it takes both slots.  An init can set up a packet filter and let go of the capability
+  before it runs anything else, and somebody who is not root in the cell cannot undo it.
+* **They are rights over that one network namespace.**  A socket that was made in another
+  and handed to the cell comes with none.  No device leaves for another, is made in
+  another or is linked to one in another, whichever way the other is named.
+* **Nobody hands out what is not theirs to do.**  Whoever fills the slot has to be able to
+  do all of it to that network namespace itself.  So the ``net`` slot is filled first.
+* A right is as wide as the subsystem behind it.  ``CELL_NET_FILTER`` is all of netfilter
+  as far as it is per network namespace, which is a lot of code.  No module is loaded
+  because a cell asked, so it is what is built in or loaded already.
+
+There is no right for ports below ``ip_unprivileged_port_start``, which is a setting of the
+network namespace.
+
+
+Spawning: empty pidfds
+======================
+
+``pidfd_open()`` with ``PIDFD_EMPTY`` takes a cellfd where it otherwise takes a pid,
+and returns a pidfd that no task is attached to yet.  Whoever has it says with
+``pidfd_configure()`` what the task is to be like, and starts it.  Only then is there
+a task.  It never runs an instruction of its creator's, and execs.  The creator does
+not fork.  This is ``fsopen()`` for tasks.
+
+A cell can be spawned into for as long as it is sealed or running, not only to get it
+going.  **This is what takes the place of entering a container**: no task that exists
+moves in, but whoever holds the cellfd can start a new one in there at any time.
+
+An empty pidfd is a pidfd like any other, and stays the same pidfd once there is a
+task.  Until then whatever it is passed to finds no task, which is ``ESRCH``, or
+``ECHILD`` from ``waitid(2)``.  No task yet is not the same as no task any more: it does
+not poll readable, ``PIDFD_GET_INFO`` has no exit to report, and its ``fdinfo`` says
+``Pid: 0`` and not ``-1``.
+
+It reserves nothing in the cell, not even a pid: whichever task is started first is the
+init of the cell, one that is closed without having been started leaves no trace, and
+one that is left empty keeps no cell from dying.
+
+The new task has
+
+* no memory map, from the start,
+* an empty file table,
+* the root of the tree of the cell as its root and working directory,
+* the credentials of the root of the cell, or of its one id,
+* default signal dispositions, nothing blocked and nothing pending,
+* its own session and no controlling terminal,
+* ``no_new_privs``,
+* none of its creator's registers.
+
+It still inherits attributes of whoever started it, as any new task does.  Among them are
+resource limits, nice value, scheduling policy and affinity, the core scheduling
+cookie, ``oom_score_adj``, I/O priority, memory policy, timer slack, the speculation
+controls of ``prctl(2)``, perf events that are marked for inheritance, membership in
+cgroup v1 hierarchies, the audit ids, **seccomp filters and LSM state**.  The list is
+not complete.  The last two are deliberate: what a confined task spawns is confined as
+it is itself.
+
+For LSMs that covers the start as well.  The hooks for receiving a file, for changing
+ids and for every step of an exec are called in the context of the new task, with the
+state it inherited.
+
+.. warning::
+
+   For seccomp it does not.  The filters apply to every system call the new program
+   makes.  They are **not** consulted for what ``PIDFD_CMD_START`` does on the way
+   there, since the new session, the files, the credentials and the exec are not
+   system calls of the new task.  A filter that denies ``execve()`` and ``execveat()``
+   to keep a task from running another program does not keep it from starting one in
+   a cell.  Such a filter has to deny ``pidfd_configure()`` too, without which there
+   never is a task, as it once had to learn about ``execveat()``.
+
+   This is about a task of the host.  A task of a cell cannot open an empty pidfd at
+   all, see the ``spawn`` slot.  Evaluating the filters at the start may be added later.
+
+The listener of a filter with ``SECCOMP_RET_USER_NOTIF`` stays behind, outside of the
+cell.  It goes on answering for the system calls of what was spawned.  It cannot put a
+file into it: ``SECCOMP_IOCTL_NOTIF_ADDFD`` fails with ``EPERM`` across cells.
+
+Only the file that ``pidfd_open()`` returned for ``PIDFD_EMPTY`` can configure.
+Another pidfd on the same task cannot.  From when the task is made until its exec has
+succeeded nobody can ptrace it, or read the files in its ``/proc`` directory that are
+gated by ptrace access.
+
+====================  ==================  =======================================
+Command               Key                 Value
+====================  ==================  =======================================
+``PIDFD_SET_STRING``  ``exec``            the path to execute, in the cell's tree
+``PIDFD_SET_BINARY``  ``argv``, ``envp``  NUL terminated strings, back to back
+``PIDFD_SET_BINARY``  ``cred``            ``struct pidfd_cred``, in the cell's ids
+``PIDFD_SET_FD``      a decimal number    the file to have at that number
+``PIDFD_SET_FD``      ``cgroup``          the cgroup to start in, within the budget
+``PIDFD_CMD_START``   none                make the task, apply everything and exec
+====================  ==================  =======================================
+
+The file table of the new task is exactly what was put there.  io_uring files,
+cellfds, namespace files and what ``pidfd_open()`` returned for ``PIDFD_EMPTY`` are
+refused.  What was configured is let go of once it has been used, however long the
+pidfd is kept.
+
+A task starts in the budget of the cell, or in the cgroup that was named, which has to
+be the budget or lie below it.  An init that manages cgroups moves out of the budget and
+enables controllers there, and from then on the budget holds no task, by the rule that a
+cgroup which passes a controller on has none of its own: ``PIDFD_CMD_START`` fails with
+``EBUSY``.  Whoever spawns then names a cgroup that can hold a task, the one that the
+init is in for one.  Whether it is within the budget, ``EPERM``, still there, ``ENODEV``,
+and can hold a task, ``EBUSY``, is decided when the task is made, since what is below
+the budget is the cell's to change at any time.  It takes no permission on the cgroup.
+Whoever holds the cellfd can do anything to the cell, and what the cell made in there
+belongs to ids that nobody outside of it has.
+
+Whatever goes wrong is returned by ``PIDFD_CMD_START``, which can be tried only once.
+If there was a task by then it is killed, which is what the pidfd reports, and if it was
+the first task of the cell, the cell dies with it.
+
+The pid namespace of the spawner must be an ancestor of that of the cell.  Nobody has to
+wait for the task: it is reaped on its own, and the pidfd tells how it ended.  For now
+there is no empty pidfd without a cell.  ``-EBADF`` in place of the cellfd is set aside
+for that, and fails with ``EOPNOTSUPP``.
+
+
+The boundary
+============
+
+Namespaces
+----------
+
+For a task of a cell ``setns()``, ``unshare()`` and ``clone()`` with any
+``CLONE_NEW*`` flag fail with ``EPERM``, as do ``OPEN_TREE_NAMESPACE`` and
+``FSMOUNT_NAMESPACE``.
+
+That is on purpose.  ``unshare(CLONE_NEWUSER | CLONE_NEWNET)`` hands whoever calls it
+every capability over a network stack of its own, and with that a large amount of code
+that was written for root.  A cell is there to keep such code out of reach, so it does
+not come back by default.
+
+The direction is a slot for the builder to fill: which kinds of namespace the tasks of
+the cell may make, which capabilities a user namespace of theirs confers at most, and
+which filesystems they may mount.  Whatever they make belongs to the cell, nobody
+enters or leaves any more than before, and an empty slot is what is described above.
+
+From the outside ``setns()`` into a namespace that a cell owns fails with ``EPERM``,
+and not only once the cell is sealed.  Whoever got into the pid namespace while the cell
+was being built could become its init, with the credentials of the host.
+
+Tasks
+-----
+
+A one-id cell runs on the kuid of its maker, and the pids of a cell are visible from
+above.  So wherever one task acts on another and an equal uid is enough, the same
+cell is required as well: signals, ptrace, scheduling attributes, priorities, I/O
+priorities, resource limits, ``SIGIO``, moving a task between cgroup v1 or resctrl
+groups, and ``KEYCTL_SESSION_TO_PARENT``.
+
+There used to be a copy of such a check wherever one was needed, and a copy that is
+overlooked is a way out of a cell.  They have been gathered in one place, see
+"Comparing the Ids of Two Tasks" in Documentation/security/credentials.rst, and the
+rule about cells is applied there, once, ahead of every one of them.  That includes
+the two that let euid 0 act on anybody: root on the host can neither have ``SIGIO``
+sent to a task of a cell nor move one between cgroup v1 or resctrl groups.  This is a
+hard boundary.  A cell that is not as it should be is killed and built again.
+
+The owner and group permissions of a key likewise only count within the cell the key
+was made in.
+
+``PTRACE_TRACEME`` fails across cells.  The parent of a task that was spawned into a
+cell is the spawner, outside.
+
+The capability branch of each of these checks is unchanged for now.  See
+`Not there yet`_.
+
+Files
+-----
+
+A file can hand a process privilege at exec, by its set-id bits or by its file
+capabilities.  In a cell both are impossible.
+
+*Running.*  Every task of a cell has ``no_new_privs``, which cannot be unset and is
+inherited.  The file capabilities of a program are not even looked at, as on a mount with
+``nosuid``.  If they were, a program that insists on a capability which is not in the
+bounding set would not run at all.
+
+*Writing.*  The ids of a cell commonly map to on-disk ids from 0 up, because that is
+how images are stored.  A set-uid bit that the root of a cell sets would make a
+set-uid root file for whoever else looks at that filesystem.  So:
+
+* No task of a cell ever has ``CAP_SETFCAP``, which the ``caps`` slot refuses, so it
+  cannot write a file capability.
+* ``S_ISUID``, and ``S_ISGID`` on anything but a directory, are silently dropped from
+  the mode of what a task of a cell creates and from the mode it sets.  They are
+  dropped and not refused so that unpacking an archive keeps working.
+* The set-id bits and file capabilities of an existing file are dropped as soon as a
+  task of a cell opens it for writing, or is given it open for writing.  A
+  ``write()`` drops them, a store through a shared mapping does not.
+
+``sudo``, ``su`` run by anybody but root, ``pkexec``, and tools that rely on a set-gid
+bit or a file capability run, and gain nothing.  A daemon that starts as root and drops
+privileges with ``setuid()`` works as ever, given ``CAP_SETUID`` and ``CAP_SETGID``.
+
+Programs that the kernel runs
+-----------------------------
+
+There are things a task can do that make the kernel run a program: ``modprobe`` for a
+protocol, a cipher or a line discipline that is not there yet, ``/sbin/request-key`` for a
+key that is not there yet, whatever ``kernel.core_pattern`` pipes a core dump to.  Such a
+program runs as root, on the host, in no namespace but the first, with arguments or input
+that the task had a say in.
+
+None is run for a task of a cell, and what was asked for fails: ``socket()`` for a
+protocol whose module is not loaded with ``EAFNOSUPPORT``, ``request_key()`` for a key
+that somebody would have to make with ``EPERM``.  **No module is loaded because a cell
+asked.**  What a cell is to use has to be there already.
+
+A core dump is written if ``kernel.core_pattern`` names a file, which is then made where
+the task is, as the task.  If it names a pipe or a socket there is none.
+
+Unix sockets
+------------
+
+A unix socket can span two cells, because both can see the tree it is bound in or
+because one end was given to a new task.  **Between cells it carries bytes and nothing
+else.**
+
+* Ancillary data is delivered only within a cell.  Every message records the cell it
+  was sent from, and whoever receives it gets the files, the credentials, the pidfd
+  and the security label only if that is its own cell.  This covers a file that was
+  queued on a socket before the socket was given away.
+* Sending control data to a socket that another cell holds fails with ``EPERM``, where
+  that can be known at the time.
+* ``SO_PEERCRED``, ``SO_PEERGROUPS``, ``SO_PEERPIDFD`` and ``SO_PEERSEC`` fail with
+  ``ENODATA`` if the peer is in another cell.  They fail rather than report the
+  overflow ids: 65534 is a uid like any other inside a cell, and a server that lets
+  in whoever has its own uid may well be running as it.  In a cell ``SO_PEERSEC`` also
+  fails for a socket that has no peer credentials, such as a TCP connection.
+
+Peer credentials are not a way to authorise anything between cells.  Protocols that
+pass file descriptors to a service in another cell do not work.
+
+The budget
+----------
+
+The budget of a cell bounds what the cell can use and is how the kernel finds every
+task in it.  It belongs to one cell: when the slot is filled the cgroup must be empty,
+have no children, and neither be nor lie within the budget of another cell.  Whoever
+fills the slot needs everything that moving a task of its own there would take, and
+must own the directory.
+
+A task of a cell stays within the budget, whoever asks.  Nothing but a spawn gets a
+task into one, kernel threads included.
+
+A task of a cell changes nothing in cgroupfs outside of the budget, whatever the modes
+say, whoever owns the cgroup and whoever opened the file.  It writes to no file, makes,
+removes and renames no cgroup, and sets no mode, owner, time or extended attribute.  No
+cgroup of a v1 hierarchy is within a budget.  Nor is anything in resctrl, where the same
+goes.
+
+On a cgroup v1 hierarchy a task of a cell is where its spawner was, and no request
+moves it.  The kernel itself may: out of a cpuset that lost its last cpu, to the
+nearest ancestor that has one.
+
+Sealing hands the directory, ``cgroup.procs``, ``cgroup.threads`` and
+``cgroup.subtree_control`` to the root of the cell.  The limits stay with whoever is
+above.
+
+Below the budget the cell does as it likes, the way an init that manages cgroups does:
+it makes and removes cgroups, moves its tasks between them, enables controllers, sets
+limits, and hands a cgroup to one of its ids.  So does whoever built the cell, from the
+outside, once the slot is filled.  What is below the budget belongs to the ids of the
+cell as far as the cell made it, and all of it goes with the cell, whoever made it.
+
+The budget itself is what bounds the cell.  There a task of the cell makes and removes
+cgroups and writes to what is written to across a delegation boundary, which is the
+three files above and what else the kernel marks so.  It writes to nothing else, not to
+a limit, ``cgroup.freeze`` or ``cgroup.kill``, and sets no mode, owner, time or extended
+attribute on the directory or on any file in it.  This is the rule of the ``nsdelegate``
+mount option, whether cgroupfs is mounted with it or not, and it goes by who is asking:
+a cell of one id owns what its maker owns, limits included, and a file may have been
+opened by somebody else.
+
+
+The system calls
+================
+
+They are split by what they do, as the mount API is, so that "may look but not touch"
+is a system call number: ``cell_info()`` changes nothing.  So is "may kill".
+
+.. code-block:: c
+
+   int cell_create(int parent, unsigned int flags);
+   int cell_configure(int cfd, unsigned int cmd, const char *key,
+                      const void *value, int aux);
+   int cell_info(int cfd, struct cell_info *info, size_t size,
+                 unsigned int flags);
+   int cell_open(int cfd, unsigned int what, const char *key, const void *arg,
+                 unsigned int flags);
+   int cell_kill(int cfd, unsigned int flags);
+   int pidfd_open(int cfd, unsigned int flags);    /* with PIDFD_EMPTY */
+   int pidfd_configure(int pidfd, unsigned int cmd, const char *key,
+                       const void *value, int aux);
+
+``cell_create()``
+  makes a new, empty cell and returns a cellfd, which is always close-on-exec.
+  ``parent`` is ``CELL_SELF``.  It takes no privilege, but it makes a user namespace,
+  and what applies to those applies here: ``user.max_user_namespaces``, the LSM hook,
+  and no chrooted caller.
+
+``cell_configure()``
+  fills the slots of a cell that is being built, and seals it.  It is shaped like
+  ``fsconfig(2)`` and data only goes in.
+
+``cell_info()``
+  reads from a cell.  The struct can grow: the caller says in ``mask`` what it wants,
+  the kernel says there what it filled in, and in ``supported_mask`` what it knows of.
+  With ``CELL_SELF`` for a cellfd it tells a task the id of its own cell.
+
+``cell_open()``
+  gets another file descriptor from a cell.  For now that is an nsfs file descriptor
+  on the network (``"net"``) or pid (``"pids"``) namespace of a cell that is being
+  built.  The namespace is made if the cell does not have it yet, which fills the
+  slot.
+
+``cell_kill()``
+  kills a cell and everything in it, whatever state it is in.  It does not wait.
+
+``pidfd_open()`` with ``PIDFD_EMPTY``
+  returns a pidfd for a task that is yet to be, in the cell.
+
+``pidfd_configure()``
+  says what that task is to be like, and starts it.
+
+A cellfd polls readable once the cell is dead, and ``read(2)`` then returns the wait
+status of its first task as an ``int``, any number of times.  A cellfd can be passed on
+but cannot be opened again through ``/proc/<pid>/fd``.
+
+Every cell has a 64 bit id that is never reused.  It is the inode number of the
+cellfd.
+
+Example
+-------
+
+Error handling is left out.  There is more of this in
+Documentation/userspace-api/cells-examples.rst.
+
+.. code-block:: c
+
+   unsigned int ids = 65536;
+   __u64 caps = 1ULL << CAP_SETUID | 1ULL << CAP_SETGID;  /* it becomes www-data */
+   int cfd, tree, pidns, fs, proc, ns, pidfd, status;
+
+   cfd = cell_create(CELL_SELF, 0);
+   cell_configure(cfd, CELL_SET_BINARY, "ids", &ids, sizeof(ids));
+   cell_configure(cfd, CELL_SET_BINARY, "caps", &caps, sizeof(caps));
+
+   /* The tree, from scratch.  The image becomes "/", for this cell. */
+   struct mount_attr attr = {
+           .attr_set  = MOUNT_ATTR_IDMAP,
+           .userns_fd = cfd,
+   };
+   tree = open_tree_attr(AT_FDCWD, "/images/web", OPEN_TREE_CLONE,
+                         &attr, sizeof(attr));
+
+   /* A procfs for the pid namespace of the cell. */
+   pidns = cell_open(cfd, CELL_OPEN_SLOT, "pids", NULL, 0);
+   fs = fsopen("proc", 0);
+   fsconfig(fs, FSCONFIG_SET_FD, "pidns", NULL, pidns);
+   fsconfig(fs, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+   proc = fsmount(fs, 0, 0);
+   move_mount(proc, "", tree, "proc", MOVE_MOUNT_F_EMPTY_PATH);
+
+   ns = open_tree(tree, "", AT_EMPTY_PATH | AT_RECURSIVE | OPEN_TREE_NAMESPACE);
+
+   cell_configure(cfd, CELL_SET_FD, "root", NULL, ns);
+   cell_configure(cfd, CELL_SET_FD, "budget", NULL, cgroup_dirfd);
+   cell_configure(cfd, CELL_SET_STRING, "hostname", "web-1", 0);
+   cell_configure(cfd, CELL_CMD_SEAL, NULL, NULL, 0);
+
+   pidfd = pidfd_open(cfd, PIDFD_EMPTY);   /* no task yet, the caller does not fork */
+
+   pidfd_configure(pidfd, PIDFD_SET_STRING, "exec", "/usr/sbin/nginx", 0);
+   pidfd_configure(pidfd, PIDFD_SET_BINARY, "argv", "nginx\0-g\0daemon off;", 21);
+   pidfd_configure(pidfd, PIDFD_SET_FD, "1", NULL, log_fd);
+   pidfd_configure(pidfd, PIDFD_SET_FD, "2", NULL, log_fd);
+   pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0);
+
+   read(cfd, &status, sizeof(status));     /* until the cell is dead */
+
+
+Not there yet
+=============
+
+The first implementation is deliberately small.  It exists so that there is code to
+argue about.
+
+What a builder can still get wrong
+----------------------------------
+
+These are mistakes of a privileged builder, of the kind a container runtime can make
+today.  None of them can be reached from the inside.
+
+* There are no per-cell instances of procfs, sysfs, devtmpfs and cgroupfs.  The
+  builder assembles those with what exists today, and can mount a procfs that shows
+  the whole host, or a sysfs that shows the network devices of the host.  The direction is for each of the four to take the cell as a mount
+  parameter, show only what the cell holds, and be refused to a task of any other
+  cell.
+* There is no table of devices a cell may use.  The builder can put any device node
+  into the tree.  Devices that create devices, such as ``loop-control``, must not be
+  given to a cell.
+* The list of files for a new task is only lightly filtered.  The builder can pass a
+  plain directory of the host.
+* A cellfd that sits in a message on a unix socket counts as held.  A builder that
+  queues the cellfd of a cell on a socket, gives the other end to a task of that cell
+  and closes the rest is left with a cell that nobody can reach.  It is killed when
+  the message is read, since the file does not cross, or when the socket goes.
+
+What does not work yet
+----------------------
+
+* ``EBUSY`` **once the cell has enabled
+  controllers on its budget**, by the rule that a cgroup with controllers enabled for
+  its children has no tasks of its own.  An init that manages cgroups does that right
+  away.  It needs a leaf below the budget for spawns to land in.
+* ``RLIMIT_NPROC`` is not applied to the uid that is set with ``cred``.
+* The seccomp filters of a new task are not consulted for its first exec, see
+  `Spawning: empty pidfds`_.
+* There are no rights on a cellfd.  Every cellfd can do everything.
+* Cells do not nest, since the ``spawn`` slot cannot be filled.
+* Software that sandboxes itself with namespaces does not work in a cell, see
+  `Namespaces`_.  What does it with seccomp or Landlock works.
+* **Every task of a cell starts at the root of the cell.**  Containers that trust each
+  other, as those of a pod do, belong in one cell: they share a pid namespace, can signal
+  each other and pass each other files.  Each can have a cgroup of its own.  For each to
+  have a root of its own as well, a spawn has to be able to name that too.
+* **What is counted per user is charged to whoever made the cell as well**, as with
+  any user namespace.  One cell can use up the inotify instances of its maker, and
+  with them those of every other cell that has the same maker.
+* A cell cannot outlive its last cellfd, and there is no way to find one again by its
+  id.  What is to run for long needs somebody who holds on to it for as long.
+* Only x86 and the architectures that use the generic system call table are wired up.
+* There are no LSM hooks for the new operations, other than those that come with the
+  user namespace, the exec and the files.
+* **A network namespace that is shared with a cell carries identities.**  Only unix
+  sockets know about cells.  ``SCM_CREDENTIALS`` on a netlink socket says who sent a
+  message, and ``NETLINK_USERSOCK`` lets any two tasks of a network namespace talk.
+
+What is still decided the old way
+---------------------------------
+
+* **A capability in an ancestor user namespace still applies to what a cell owns.**
+  Root on the host can signal and ptrace the tasks of a cell by pid.  Only the branch of
+  each check that goes by a uid has been closed.
+* Files in ``/proc/<pid>`` that are protected by nothing but their owner, such as
+  ``oom_score_adj``, still go by the bare uid.
+* A one-id cell shares the ``struct user_struct`` and the key quota of its maker.
+* Nothing keeps root on the host from calling ``setresuid()`` with an id of a block
+  that has been lent.  Nor from naming one where a filesystem reads its ids by itself
+  and not with ``fsparam_uid()`` and ``fsparam_gid()``, such as udf, ntfs, zonefs,
+  functionfs, hypfs and spufs, ``access=`` of 9p, or the anonymous ids of an nfsd
+  export.
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index a68b1bea57a8..b9d2e4bef24c 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -17,6 +17,7 @@ System calls
    :maxdepth: 1
 
    unshare
+   cells
    futex2
    ebpf/index
    ioctl/index

-- 
2.55.0

