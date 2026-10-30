Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793401116;
	b=ZEiPjKo5ClhHBX7sgE5TqB8Bh3FIFpjahe+JsJ56vn/bpAgi4YeWjUNoyoGWgtHbURrR
	 2fprx+wRh2zpu4rRpxOw27j9eG/iZIJoBLLMdxx4mvQXULlzPB/rPP8oa57+NJIGTRK+C
	 LffjIX3PUOK1jMlZHcJUfh9zJTJwgvSTsoi2FFti932/TzO0Vuv/P/aN5Mqr1naNldEx+
	 UTTjsyaThPg/twFzH+4/XCufaF5JSoZPR8n6DL2bqc0QasTLo02rN5/aiLdjdkUM4W1xY
	 0mvcDz6HBiY5uFqxF25w5lZAV22Mmp+9ZHssV23xjHK4s9aspRTCn0VxcCsJMKVVk+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793401116;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=KgukQ/wRP7mI1K42SYKHq7tAAiyLUSJuhoisQ+rhtUw=;
	b=d5lpp5VAahbKbAUjOntA0mROU+utqqd68Z2lSFWbjvChi7miM9NK7/blB6MzLBYO2hoG
	 33Jc1Sa4aGVbUVXaS3Ku/uuKSVtLO3tCvSbU9Vbu+4bRYIKu/ydBYKRNzpegVLPglr9JG
	 Y/Wae1CHaOZ/KxT8YwOonDTl/hYziTY2psma1hb/N72SsHF1bPd8Y0tYD6t0ZwJfwQyWX
	 RrtgsGtjj2FKer3OT7Amag9X45IILbCFIt2LExQqG4cbKLXi4f/X5a0r9DHoc+mZsfIyB
	 wYageFpuVoaJzVf+FD8KORQJwSlH/SfRPIppcfgeq0pmo8v+TyLdz43kSpC61wO5XiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=c98dhNti;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB32606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 22:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AB32606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=c98dhNti
Received: from vm-dev.d0aziqou4eyuzblxqhi51nu2sc.xx.internal.cloudapp.net (unknown [4.246.87.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3476920B7166;
	Fri, 30 Oct 2026 15:58:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3476920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793401095;
	bh=KgukQ/wRP7mI1K42SYKHq7tAAiyLUSJuhoisQ+rhtUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c98dhNtiriXGm5xAlsofNF0wyLnGotGn+3THxc6a9egX6cXtcJSY6nPEdaP5mrV4M
	 oNSHYYRCnvVlFt9M2/4qzfyD+2odcHPtMzc0JqYlnEO82lFIRNDgcmALtznpBhXIqT
	 8kfHKsbyQP3b1tIInTtAypUzYVe3IVsaykI26KEM=
Date: Fri, 30 Oct 2026 15:58:14 -0700
From: Tahera Fahimi <taherafahimi@linux.microsoft.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] cells: a container as one kernel object
Message-ID: <auUhBi6e8Wl1SFVr@vm-dev.d0aziqou4eyuzblxqhi51nu2sc.xx.internal.cloudapp.net>
References: <20261019-cells-rfc-6f4c85415f29@toxicpanda.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-cells-rfc-6f4c85415f29@toxicpanda.com>

On Mon, Oct 19, 2026 at 04:50:47PM +0000, Josef Bacik wrote:
> Hello,
Hi Josef, Thanks for the detailed proposal.

> This is the thing Christian and I and a few others have been going back
> and forth on, a container as one kernel object instead of a pile of
> namespaces that userspace holds together. I have a barebones
> implementation of it. It's 62 patches on top of the 13 patch cred series
> [1], and I don't think anybody wants that in their inbox for what is at
> this point a design discussion, so the code is in a branch, and what's
> in this email is the pitch, the things I would like opinions on, and the
> design document from the branch in full at the bottom so you can quote
> it and yell at specific lines.
> 
>   https://github.com/josefbacik/linux/commits/cells/
>   git fetch https://github.com/josefbacik/linux.git cells
> 
> That's 6cbfd1952c30 as I write this, based on vfs.all. "Cell" is a
> placeholder name, I don't love it, suggestions welcome.
> 
> The pitch
> ---------
> 
> A container isn't a thing in the kernel. It's eight kinds of namespace,
> a cgroup, a seccomp filter and a pile of conventions that the runtime
> holds together. The kernel can't name it, can't kill it in one go, and
> can't tell you what's in it. Privilege inside of it hangs off of uids
> and user namespaces, and a task can be half way between two sets of
> namespaces at any given moment, which is where a depressing number of
> our bugs come from.
> 
> A cell is a container as one object. A task is born in a cell and never
> leaves it, and nothing can enter one, so there is no setns() and no
> unshare(). You build it from the outside by filling named slots from
> file descriptors you already hold, you seal it, and then you spawn tasks
> into it. Holding the cellfd is the authority to do all of that, there is
> no uid or capability check on it, and making one takes no privilege. The
> cell lives exactly as long as somebody holds the cellfd, when the last
> one goes the cell is killed.
> 
> Spawning is the other half. clone3(CLONE_EMBRYO) gives you a pidfd on a
> task that exists but has never run anything, you set it up with
> task_configure() the way you would set up a mount with fsconfig(), and
> then you start it and it execs. It starts with no mm and no files, so
> what it has is what you gave it. I think this is useful without cells at
> all and would like to send it on its own eventually.
> 
> A few rules fall out of wanting the boundary to actually mean something.
> The kernel allocates the kuids for a cell out of a reserved window, the
> builder never names one, and those ids can never be stored on a
> filesystem the cell doesn't own. A uid means nothing across cells, not
> an equal one and not 0. Files impart no privilege, every task has
> no_new_privs, and set-id bits get dropped on anything a cell creates,
> chmods or opens for writing. Unix sockets carry bytes between cells and
> nothing else, no SCM_RIGHTS and no peer credentials. The mount tree is
> built from scratch, nothing in it hides anything, and nothing propagates
> into it.
> 
> What I would like opinions on
> -----------------------------
> 
> 1. The shape. One object, born in it and never leaves, nothing enters,
>    built from the outside out of fds, authority is the fd. If you think
>    this is the wrong shape then the rest doesn't matter, so start here.
> 
> 2. The id window. Blocks of 65536 kuids come out of the upper half of
>    the id space, and "nobody else holds an id of this block" is what
>    replaces the privilege check for mapping a range, so it has to be
>    enforced. With CONFIG_CELLS on the host can't chown a file to an id
>    of 2^31 or above anymore, because the check has to go by value. This
>    is the one I expect to get yelled at for, and I'm open to better
>    ideas.
> 
> 3. Capabilities. A capability held in an ancestor user namespace still
>    applies to what a cell owns, so root on the host can still signal and
>    ptrace by pid. In the checks that let one task act on another I
>    closed the branch that goes by a uid, euid 0 included, and left the
>    capability branch alone. I would like the boundary to be hard in both
>    directions, you hold the cellfd or you have nothing, but that is a
>    much bigger conversation. How far do we want to go?
> 
> 4. MNT_LOCKED (Christian, this one is for you). The seal refuses a tree
>    with a locked mount in it, since a locked mount hides what it covers.
>    But for a builder that works in a user namespace of its own, the
>    kernel locks the tree itself onto the empty root of a namespace made
>    with FSMOUNT_NAMESPACE or OPEN_TREE_NAMESPACE, so an unprivileged
>    builder could never seal anything. I exempted exactly that mount, on
>    the grounds that there is nothing under it to hide. Is that right, or
>    should it not be locked there to begin with?
> 
> 5. seccomp. An embryo inherits the filters of whoever made it and they
>    apply to everything the new program does, but they are not consulted
>    for what TASK_CMD_START does on the way there, because the exec isn't
>    a system call of the embryo. So a filter that denies execve() and
>    execveat() to keep a task from running another program has to learn
>    about task_configure() as well, same as it once had to learn about
>    execveat(). This is only about tasks of the host, a task of a cell
>    can't spawn at all. Documented for now. Good enough, or do we run the
>    filters at the start?
> 
> 6. Lifetime. A cell dies with its last cellfd, there is no opt out and
>    no way to look one up by id. An earlier version had this as a flag,
>    and without it you ended up with a running cell that nobody held, so
>    nothing could spawn into it or wait for it, and killing it meant
>    going around it by pid or cgroup. You can pass the fd to a
>    supervisor. I would rather add the foot gun later if somebody really
>    needs it.
> 
> 7. The budget. Spawning from the outside fails with EBUSY once the cell
>    enables controllers on its own cgroup, which systemd does right away.
>    It needs a leaf below the budget for spawns to land in. Does the
>    kernel make that leaf, or is it a convention for the builder? Also a
>    cell with a block of ids can't mkdir in cgroupfs until cgroupfs can
>    be idmapped.
> 
> 8. procfs, sysfs, devtmpfs and cgroupfs. There are no per-cell instances
>    yet, the builder assembles those with what exists today and can get
>    it wrong the same way a runtime can today. Where I want to go is each
>    of the four taking the cell as a mount parameter and showing only
>    what the cell holds. That's a lot of work and I wanted this out
>    first, but I would like to know if anybody hates the direction.
> 
> 9. The API. Five system calls, cell_create(), cell_configure(),
>    cell_info(), cell_open() and task_configure(), no ioctls, with string
>    keys in the style of fsconfig(). The right to spawn is a slot as
>    well, reserved and always empty for now, which is why cells don't
>    nest. We do want unprivileged things to be able to build smaller
>    cells out of what they hold eventually, but it touches ids, cgroups
>    and mounts all at once and I left it out.
> 
> How to read the branch
> ----------------------
> 
> It's one logical thing per patch and more than half of them are 50 lines
> or less, so it is less than it sounds like. The first 13 are the cred
> series [1]. Read the document, then these are the ones with the design
> in them:
> 
>   3c1f5defa226 user_namespace: let a cell own a user namespace
>   380bd1bf37a7 fs: seal a mount namespace for a cell
>   0837cfd6d117 cells: add the cell object and cell_create()
>   1c42ab4f15a9 cells: add cell_configure()
>   cef86b491459 cells: lend a cell a block of ids
>   253d7f9627c0 fork: let copy_process() place a task in a cell
>   424a90b3e37a fork: add CLONE_EMBRYO
>   8bef8549476e fork: add task_configure()
> 
> The rest are helpers in cgroup, fs and nsproxy ahead of those, and the
> rules of the boundary after them, one rule per patch. The uid rule is
> the reason for the cred series: with the dozen hand rolled copies of
> "the uids match so you can mess with that task" in one place, it is one
> small patch,
> 
>   5372a6763133 cred: let no id count across cells
> 
> CONFIG_CELLS doesn't exist until near the end, so everything before that
> builds as stubs, and every commit builds on its own. The last patch is
> the selftests, 47 of them.
> 
> State
> -----
> 
> I've run the selftests under KASAN, lockdep and DEBUG_VFS in qemu, on
> tmpfs, ext4 and 9p, and built it with gcc and clang and with the option
> off. It has not been near real hardware, a real runtime or a benchmark.
> Only x86 and the generic syscall table are wired up. There are no rights
> on the cellfd and no LSM hooks of our own. "Not there yet" at the end of
> the document is the full list, and I tried to be honest in it. This is
> an RFC in the truest sense, the point is to have code to argue about, so
> please argue. Thanks,
> 
> Josef
> 
> [1] https://patch.msgid.link/20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com
> 
> -- >8 -- Documentation/userspace-api/cells.rst -- >8 --
> 
> .. SPDX-License-Identifier: GPL-2.0
> 
> =====
> Cells
> =====
> 
> A cell is a container as one kernel object.  A task is born in a cell and never
> leaves it, and nothing can enter one.  A cell is built from the outside: the
> builder fills named slots from file descriptors it holds, seals the cell, and
> spawns tasks into it.  Holding the file descriptor of the cell, the *cellfd*, is
> the authority to do all of that.
> 
> This document explains why cells exist, what they promise, how they are used and
> what the first implementation does not do yet.  "Cell" is a working name.
> 
> .. contents:: :local:
> 
> 
> Why
> ===
> 
> A container on Linux is not an object.  It is eight kinds of namespace, a cgroup,
> a seccomp filter and a set of conventions that a runtime holds together.  A number
> of problems follow from that, and they do not go away by fixing bugs one at a
> time.
> 
> There is nothing to name.
>   The kernel cannot say which container a task is in, cannot kill a container in
>   one operation and cannot tell what a container has access to.
> 
> Membership is a property of a task at a moment.
>   ``setns()`` and ``unshare()`` let a task change one namespace at a time.  A task
>   that is half way between two sets of namespaces, holding file descriptors, a
>   working directory or a memory map from one side and credentials from the other,
>   has been the source of many bugs.
> 
> Setup runs on the inside.
>   A runtime forks, and the child sheds, one call at a time, what it inherited and
>   should not have.  What it forgets to shed leaks into the container.
> 
> Privilege hangs off ids.
>   A user namespace gives its creator a full set of capabilities over everything
>   the namespace owns, which puts a large amount of code that was written for root
>   within reach of every user.  Who may do what to whom is decided by comparing
>   uids, and whether two uids are the same depends on how several runtimes agreed
>   to carve up ``/etc/subuid``.
> 
> Hiding is done by mounting over.
>   What a container must not see is commonly covered by a mount.  ``MNT_LOCKED``
>   exists to keep such mounts in place, and a way to remove one, or to copy the tree
>   without it, reveals what it covered.
> 
> A cell turns this around.  There is one object with one lifetime.  What it holds
> was put there explicitly, by somebody who held it.  What was not put there is not
> there.
> 
...
> The tree
> ========
> 
> The tree of a cell is built from scratch, one mount at a time, in a mount namespace
> that nobody has entered: see ``fsmount(2)`` with ``FSMOUNT_NAMESPACE`` and
> ``open_tree(2)`` with ``OPEN_TREE_NAMESPACE``.  Sealing the cell makes that namespace
> the cell's, or fails without having changed anything about it:
> 
> * No mount may be ``MNT_LOCKED``, since a locked mount hides what it covers.  The
>   tree itself may be: it sits on the root of the namespace, which is empty, and the
>   kernel locks it there for a builder that works in a user namespace of its own.
> * Nobody is in the namespace, or on the way in.
> * Every mount is made private.  Nothing propagates into a cell.
> * In a cell with a block of ids, a writable mount of a filesystem that can be
>   idmapped must be idmapped for the cell, or belong to a superblock the cell owns.
>   This is only the early and readable form of the ``EOVERFLOW`` above.
> 
> To idmap a mount for a cell, pass the cellfd in ``mount_attr.userns_fd``.  On-disk
> ids 0 to 65535 then belong to the ids of the cell, or the one id to itself.
> 
> A seal that fails leaves the cell ``CELL_BUILDING``.  What it had filled in for slots
> that were left empty by then stays filled in.
Apologies if this is covered somewhere I overlooked. If seal changes budget ownership and
subsequently fails, must ownership be fully restored before returning? If restoration itself fails,
how is that condition reported and safely cleaned up?

> The mount namespace stays owned by the user namespace of the builder.  That is what
> keeps a task of the cell from mounting anything.
> 
> 
> Spawning: embryo tasks
> ======================
> 
> ``clone3()`` with ``CLONE_EMBRYO`` returns a pidfd on a task that exists but has
> never run an instruction of user code, and never runs any of its creator's.  The
> creator sets it up with ``task_configure()`` and starts it, at which point it execs.
> The creator does not fork.  This is ``fsopen()`` for tasks.
> 
...
> The budget
> ----------
> 
> The budget of a cell bounds what the cell can use and is how the kernel finds every
> task in it.  It belongs to one cell: when the slot is filled the cgroup must be empty,
> have no children, and neither be nor lie within the budget of another cell.  Whoever
> fills the slot needs everything that moving a task of its own there would take, and
> must own the directory.
> 
> A task of a cell stays within the budget, whoever asks.  Nothing but a spawn gets a
> task into one, kernel threads included.
> 
> On a cgroup v1 hierarchy a task of a cell is where its spawner was, and no request
> moves it.  The kernel itself may: out of a cpuset that lost its last cpu, to the
> nearest ancestor that has one.
> 
> Sealing hands the directory, ``cgroup.procs``, ``cgroup.threads`` and
> ``cgroup.subtree_control`` to the root of the cell.  The limits stay with whoever is
> above.
> 
... 
> Not there yet
> =============
> 
> The first implementation is deliberately small.  It exists so that there is code to
> argue about.
> 
> What a builder can still get wrong
> ----------------------------------
> 
> These are mistakes of a privileged builder, of the kind a container runtime can make
> today.  None of them can be reached from the inside.
> 
> * There are no per-cell instances of procfs, sysfs, devtmpfs and cgroupfs.  The
>   builder assembles those with what exists today, and can mount a procfs that shows
>   the whole host.  The direction is for each of the four to take the cell as a mount
>   parameter, show only what the cell holds, and be refused to a task of any other
>   cell.
> * There is no table of devices a cell may use.  The builder can put any device node
>   into the tree.  Devices that create devices, such as ``loop-control``, must not be
>   given to a cell.
> * The list of files for a new task is only lightly filtered.  The builder can pass a
>   plain directory of the host.
> * A cellfd that sits in a message on a unix socket counts as held.  A builder that
>   queues the cellfd of a cell on a socket, gives the other end to a task of that cell
>   and closes the rest is left with a cell that nobody can reach.  It is killed when
>   the message is read, since the file does not cross, or when the socket goes.
> 
> What does not work yet
> ----------------------
> 
> * **Spawning from the outside fails with** ``EBUSY`` **once the cell has enabled
>   controllers on its budget**, by the rule that a cgroup with controllers enabled for
>   its children has no tasks of its own.  An init that manages cgroups does that right
>   away.  It needs a leaf below the budget for spawns to land in.
> * **A cell with a block of ids cannot create a cgroup.**  The superblock of cgroupfs
>   belongs to the host, so the ids of the cell cannot be stored there.  It needs
>   cgroupfs to be idmappable.
> * The cgroup v2 freezer does not report a budget as frozen while an embryo in it has
>   not been started.
> * ``RLIMIT_NPROC`` is not applied to the uid that is set with ``cred``.
> * The seccomp filters of an embryo are not consulted for its exec, see
>   `Spawning: embryo tasks`_.
> * There are no rights on a cellfd.  Every cellfd can do everything.
> * Cells do not nest, since the ``spawn`` slot cannot be filled, and a task of a cell
>   cannot create any kind of namespace, so
>   software that sandboxes itself with namespaces does not work in a cell.
> * A cell cannot outlive its last cellfd, and there is no way to find one again by its
>   id.  What is to run for long needs somebody who holds on to it for as long.
> * Only x86 and the architectures that use the generic system call table are wired up.
> * There are no LSM hooks for the new operations, other than those that come with the
>   user namespace, the exec and the files.
> * **A network namespace that is shared with a cell carries identities.**  Only unix
>   sockets know about cells.  ``SCM_CREDENTIALS`` on a netlink socket says who sent a
>   message, and ``NETLINK_USERSOCK`` lets any two tasks of a network namespace talk.
> 
> What is still decided the old way
> ---------------------------------
> 
> * **A capability in an ancestor user namespace still applies to what a cell owns.**
>   Root on the host can signal and ptrace the tasks of a cell by pid and configure its
>   network namespace.  Only the branch of each check that goes by a uid has been
>   closed.
> * Files in ``/proc/<pid>`` that are protected by nothing but their owner, such as
>   ``oom_score_adj``, still go by the bare uid.
> * A one-id cell shares the ``struct user_struct`` and the key quota of its maker.
> * Nothing keeps root on the host from calling ``setresuid()`` with an id of a block
>   that has been lent, or from mounting a filesystem with such an id for an option.
