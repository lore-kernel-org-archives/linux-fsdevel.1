Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588535;
	b=r2jYKjf7VbgJszEj2dJqJT+PDlAQ1M6Yp8hb9BTdTLo9+Fs7Wvxpu+jZ42mroZ3MMPBo
	 QcOwFF2GRVwcyY4qJnAeMziWf7Zua9z0nILvmdin/rfc25wpnP+d5Kw51KB8Qmd8kCAwX
	 uaDbefp6GaQ7wYVtigUCq2PpH9drQzpsj8jT8cA4J9NdqvQpELp3mKaMsnvtakCVT8fwO
	 xMh3x4IWWhSGRIrcVWEpi2BK/mhqi7YRSKzQQ1pJ7RC6LDQBELXBLMMjRJWzyZPdU3aj0
	 uEyay+/+th2o351N05jpPw812fvw1Dt3PTJQW3XJZEKg1E/Q4RYANqkTxY7Ao4EQcLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588535;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gSWoXhZunVnIO3QGFIKpMYzRoqD0ZE7bwLRVgFfA9V0=;
	b=4sb+KgBkufWAYyXjiOZlRS+hkXfPg1Esi6O50NswK52CXvFD94YScXGnpjwRE21PlnnQ
	 B62Xb9pVRYofRltr4cMX3AQcXdOet1u//l0cVGELKJU+oaYAcDHaK4PFz7fH8rjt1Zw/r
	 vJp/ojWgKSD5XM86cCz6ElT2+XMQlbU1Ux2UGMVeIueS070klxoiVlRefg4vLvmhc42FD
	 20iRvyIufOwJZV9JYniGmktJ4DHJIEL4aAStddJzVZKxved7hw0zpPbUx9Gcoql4nJB7A
	 tkK2bH1IG2vzoTbsSPIvWtzVGhd8POdIdym0s/hCiFYBMtETEqTxhZiNvADPUVe9Eow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bY/Qhkd2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00552606A325
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bY/Qhkd2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565A11F000C4;
	Wed, 21 Oct 2026 13:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588533;
	bh=gSWoXhZunVnIO3QGFIKpMYzRoqD0ZE7bwLRVgFfA9V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bY/Qhkd2w+v7/NOpaMBB1ZzYM8jU4OaFo+cN347cQH7txw1oXXebMvSOiN7RFfqJ+
	 WMvVjNqLf5/IyZlM5nZ4p71MZOiMIB9SccApWfRzlZNkoVRmV8uj3lDvyihynWusok
	 XggBtWtWme/CTzD+j+lF4Jz4jTrnyJMQFv+O3QlS4tHJleSaPmxNsuBpXjcVe5HOSB
	 QG+6jhTcZaa3kRkHJklQSw+7spVNkM3R+xHE82iXx4i2CnK/xnWu0Y2GpfomqfS8s3
	 nJLDQZcI9yquA+i/sg/jZmLrXjMiccLfTK9xa8LQN36krjxG3UrXfK8KE6SklxPFBv
	 lZXvLv3XX29aw==
Date: Wed, 21 Oct 2026 15:15:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] cells: a container as one kernel object
Message-ID: <20261021-zeitig-niemals-clubmitglieder-b3973fcebd38@brauner>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019-cells-rfc-6f4c85415f29@toxicpanda.com>

On Mon, Oct 19, 2026 at 04:50:47PM +0000, Josef Bacik wrote:
> Hello,
> 
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

In one shape or another I want to merge a variant of this.

> A container isn't a thing in the kernel. It's eight kinds of namespace,
> a cgroup, a seccomp filter and a pile of conventions that the runtime
> holds together. The kernel can't name it, can't kill it in one go, and
> can't tell you what's in it. Privilege inside of it hangs off of uids
> and user namespaces, and a task can be half way between two sets of
> namespaces at any given moment, which is where a depressing number of
> our bugs come from.

Indeed.

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

Yeah, we've discussed a few times. It might make sense to build this on
top of pidfs (someone tried that already for exec and the series should
still be on-list) as it gives you all of the semantics and the state
machinery you need to setup the task for free. So I like this obviously.

IOW, I think the idea is great but I don't think the entrypoint should
be clone3(CLONE_EMBRYO). I always thought it should be
pidfd_open(-EBADF, PIDFD_EMPTY).

It would give you back an actual pidfd that is not usable, i.e., no task
attached to it and so passing it to the kernel would -ESRCH you
everywhere. You then configure the pidfd and start it via pidfd_config()
or an ioctl().

Alternatively it could me modelled after fsopen() and give you back a
separate fd-type that then gets swapped for an actual pidfd. I don't
think that's needed for pidfds though as we have a well-defined "not
active" state. So letting the actual pidfd itself be the setup sentinel
seems fine to me.

> A few rules fall out of wanting the boundary to actually mean something.
> The kernel allocates the kuids for a cell out of a reserved window, the
> builder never names one, and those ids can never be stored on a
> filesystem the cell doesn't own. A uid means nothing across cells, not

Yep, that's very close to the 64-bit k*id_t patchset we've been tossing
around quite a few times. The latest version is at:

https://github.com/mihalicyn/linux/commits/isolated_userns

Maybe take a look at that and see whether that helps us here (Note the
cgroupfs hackiness that we will have to address anyway.).

> an equal one and not 0. Files impart no privilege, every task has
> no_new_privs, and set-id bits get dropped on anything a cell creates,
> chmods or opens for writing. Unix sockets carry bytes between cells and
> nothing else, no SCM_RIGHTS and no peer credentials. The mount tree is
> built from scratch, nothing in it hides anything, and nothing propagates
> into it.

Perfect, no notes on the empty mount namespace and the propagation. I
love it. My dislike of mount propagation and overmount protection is
well-known.

> 
> What I would like opinions on
> -----------------------------
> 
> 1. The shape. One object, born in it and never leaves, nothing enters,
>    built from the outside out of fds, authority is the fd. If you think
>    this is the wrong shape then the rest doesn't matter, so start here.

fds or bust

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

Since a task never leaves a cell couldn't the seccomp or a seccomp like
profile be a property of the cell itself and not the task? IOW, should
we really reuse seccomps old semantics for this?

We could just build a native filtering mechanism into the cell and
seccomp is an orthogonal mechanism within the cell.

> 6. Lifetime. A cell dies with its last cellfd, there is no opt out and

You might want to look at CLONE_PIDFD_AUTOKILL it's the exact same
semantics implemented for pidfds. It's opt-in for historical reasons but
I like the concept of things that die when the handle for it dies.

If we wanted persistency we could allow for cellfds to be bind-mountable
but that opens a whole can of worms so best not to think about that at
all for now.

Userspace can just use systemd's fdstore or similar mechanism to make
cells survive.

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

I'm not sure how compatible it is for the kernel to create the leaf
automatically as userspace might need control over how it is named? I
think the builder needs to do this. I have no clear vision of this part
yet though. I need to think a bit about this.

> 
> 8. procfs, sysfs, devtmpfs and cgroupfs. There are no per-cell instances
>    yet, the builder assembles those with what exists today and can get
>    it wrong the same way a runtime can today. Where I want to go is each
>    of the four taking the cell as a mount parameter and showing only
>    what the cell holds. That's a lot of work and I wanted this out
>    first, but I would like to know if anybody hates the direction.

Let's punt on that for now.

My main goal is that we don't just reimplement containers but in a
struct container. That has been attempted a lot of times and I really
dislike it because we just glue together the same horrendous pile of
spaghetti we already do in userspace. Nothing will be one apart from
getting to claim that this is container object. That's not interesting
at all.

So imho it's fine if we have payloads that cannot run in cells
unmodified. I think one of the worst outcomes of the traditional
container thing was that it tried to make the workload not care that it
was in a container. That just never worked fully. It worked enough but
now well.

The whole locked mount disaster exists because containers masked off
paths in procfs to "hide" wrong resource information. That's just one
tiny instance. This approach caused us to pile on endless hacks in the
kernel to make this work or even build really convoluted mechanisms such
as the system call interceptions stuff. Let's not repeat that and let's
not just carry over all the old fs system interfaces we have into cells.

> 9. The API. Five system calls, cell_create(), cell_configure(),
>    cell_info(), cell_open() and task_configure(), no ioctls, with string

Sounds fine, you don't need task_configure() just expand pidfd_open()
and add pidfd_configure().

>    keys in the style of fsconfig(). The right to spawn is a slot as
>    well, reserved and always empty for now, which is why cells don't

Great.

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
> 
> The model
> =========
> 
> Invariants
> ----------
> 
> The implementation is meant to uphold the following.  A way to break one of them
> from the inside of a cell, or as an unprivileged user outside, is a bug.
> 
> #. **A task never changes cell.**  There is no way to enter a cell and no way to
>    leave one.  The namespaces of a cell belong to the cell and not to its tasks.
> #. **A cell holds what it was given.**  Slots are filled from file descriptors the
>    builder holds.  Filling a slot takes what using the object would take.
> #. **Authority over a cell is the cellfd.**  No uid and no capability is compared
>    when a cell is configured, spawned into or killed.  There is no cell without
>    somebody who holds one: it dies with the last.
> #. **Nothing is inherited that gives access to anything.**  A task that is spawned
>    into a cell starts with no memory map and no open files.  What it can reach is
>    what it was given.  `Spawning: embryo tasks`_ lists what it does inherit.
> #. **After that nothing crosses.**  Once a task has started, no file descriptor and
>    no identity crosses the boundary of its cell.  A cell that was given a network
>    namespace to share is an exception, see `Not there yet`_.
> #. **A cell starts nothing it was not allowed to.**  Making a cell and starting a
>    task in one is a slot like any other, ``spawn``.  It cannot be filled yet, so what
>    runs in a cell comes from a ``fork()`` and ``execve()`` of what was spawned into
>    it, or from outside.
> #. **A uid means nothing across cells.**  Not an equal one, and not 0.
> #. **Files impart no privilege.**  Nothing a cell runs can gain privilege from a
>    file, and nothing a cell writes can give privilege to anybody else.
> #. **Nothing is hidden by a mount.**  Whatever is in the tree of a cell, the cell
>    may see all of it, including what lies under every mount point.
> #. **Ids are lent.**  The kernel chooses the kuids and kgids of a block, nobody else
>    can hold one of them while the cell does, and nothing the cell made may still be
>    owned by one when they are lent again.
> #. **DEAD means gone.**  When a cell reports that it is dead, no task of it is left,
>    not even one that is on its way out, and the cell has dropped every reference it
>    held.  What that sets off, such as the release of mounts, of the network
>    namespace and of the block of ids, completes on its own time.
> 
> Life of a cell
> --------------
> 
> A cell only ever moves down this list.
> 
> =================  =============================================================
> ``CELL_BUILDING``  Slots may be filled.  Nothing runs.
> ``CELL_SEALED``    Immutable.  Nothing has been spawned yet.
> ``CELL_RUNNING``   Has, or had, its first task.
> ``CELL_DYING``     Was killed, or its first task has exited.
> ``CELL_DEAD``      Nothing is left.  The exit status can be read.
> =================  =============================================================
> 
> The first task that is spawned is the init of the pid namespace of the cell.  When
> it exits the kernel kills everything else in that namespace, as it does for any pid
> namespace, and the cell dies.
> 
> A cell can be killed in every state.
> 
> **A cell lives for as long as somebody holds a cellfd on it, and no longer.**  When the
> last one is closed, be it because whoever held it was killed, the cell is killed.  A
> cellfd can be passed on, so a cell can be handed to a supervisor, but a cell that nobody
> holds is a cell that nobody could kill, spawn into or wait for.
> 
> Slots
> -----
> 
> ============  =========================================  =======================
> Slot          Filled with                                If it is left empty
> ============  =========================================  =======================
> ``ids``       a count: 1 or 65536                        1; refused for root
> ``root``      a mount namespace nobody has entered       the seal fails
> ``budget``    a cgroup v2 directory                      the seal fails
> ``net``       the string ``"new"``, or a network         a new, empty one
>               namespace to share
> ``hostname``  a string                                   ``(none)``
> ``spawn``     nothing yet, the name is reserved          no task of the cell can
>                                                          make a cell or start a
>                                                          task in one
> ============  =========================================  =======================
> 
> The pid, ipc, uts and cgroup namespaces of a cell are always new.  The cgroup
> namespace is rooted at the budget.  The time namespace is that of the builder.
> 
> The network namespace of one cell cannot be shared with another, in whatever state
> either is.  The tasks of the cell that owns it have every capability over it.
> 
> 
> Ids
> ===
> 
> Every consumer of a kuid in the kernel knows how to deal with a user namespace, so
> a cell has one.  The kernel makes it together with the cell, and it differs from a
> legacy user namespace in the ways that make a legacy one hard to reason about:
> 
> * Nobody can ``setns()`` into it.
> * The uid that created it has no capability over it.
> * Its map is set once, by the kernel, to ids the kernel chose.
> 
> All translation between the ids a cell sees and the ids on disk stays in the VFS,
> in the idmapping of each mount of the tree.  See
> Documentation/filesystems/idmappings.rst.
> 
> A cell comes in two shapes.
> 
> One id
>   The cell runs on the uid and gid of whoever made it, under their own numbers, with
>   the supplementary groups of its maker and without capabilities.  ``setgroups()`` is
>   denied.  The groups are kept because a group can be there to deny something.  This
>   shape is refused to root, since too much goes by the bare value of kuid 0, and to
>   an id that lies in the window described below.
> 
> A block
>   The cell sees uids and gids 0 to 65535.  They map to a block of 65536 kuids and
>   kgids that the kernel allocates.  **The builder never names a kuid.**  It takes no
>   privilege: a block that nobody holds gives access to nothing.  A user can hold
>   ``user.max_cell_id_blocks`` of them.
> 
> The window
> ----------
> 
> Blocks come out of a window, the upper half of the id space less its last block:
> 2147483648 to 4294901759.
> 
> "Nobody else holds an id of this block" stands in for the privilege check that a
> legacy user namespace needs before it may map a range.  So it is enforced rather
> than assumed:
> 
> * A legacy user namespace cannot map into the window.
> * **No create, chown or ACL stores an id of the window in a filesystem that the
>   cell does not own.**  Creating a file and ``chown()`` fail with ``EOVERFLOW``,
>   setting an ACL with ``EINVAL``.  Through a mount that is idmapped for the cell the
>   id has become the on-disk id before the check is made, so that works.  The check
>   goes by the value of the id and not by who is asking, because a stacking
>   filesystem may create files with the credentials of whoever mounted it.
> * A block lives as long as the user namespace object it was lent to, not as long as
>   the cell.  Every credential, and every object that the namespace owns, pins the
>   namespace.  That covers the inodes which the kernel makes on filesystems of its
>   own and gives to the caller without asking: pipes, sockets, memfds, the slave of
>   a pty.  Each lives no longer than a file that is open on it, and the file pins the
>   credentials it was opened with.
> * The idmapping of a mount holds a copy of the maps.  One that was made for a cell
>   pins the user namespace as well, so a mount that is kept beyond the life of the
>   cell keeps the block from being lent again.
> * What the cell made below its budget is removed when the cell dies, and the budget
>   returns to its owner.  If that fails the block is never lent again.
> * Some tables are keyed by a bare kuid and pin nothing: ``struct user_struct`` and
>   the quota records of keys.  A released block is quarantined until they hold
>   nothing in its range, and a block is checked the same way before it is lent.
> 
> Blocks are handed out round robin, so that reuse comes as late as it can.  A block in
> quarantine counts as used.  A leak therefore shows up as ``ENOSPC`` and never as one
> tenant owning what another left behind.
> 
> .. warning::
> 
>    With ``CONFIG_CELLS`` enabled the host itself cannot ``chown()`` a file to an id
>    of the window.  This is a change of behaviour for a system that uses such ids.
>    Files that already belong to one, seen through a mount that is not idmapped,
>    look as if they belonged to whichever cell is lent that block.
> 
> What the allocator does not cover is the ids on disk.  Through a mount that is
> idmapped for it, a cell with a block always uses on-disk ids 0 to 65535, so two cells
> that are given the same storage see each other's files.  That is sometimes intended,
> as with shared images, and remains the responsibility of the builder.
> 
> 
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
> 
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
> An embryo has
> 
> * no memory map, from the start,
> * an empty file table,
> * the root of the tree of the cell as its root and working directory,
> * the credentials of the root of the cell, or of its one id,
> * default signal dispositions, nothing blocked and nothing pending,
> * its own session and no controlling terminal,
> * ``no_new_privs``,
> * none of its creator's registers.
> 
> It still inherits attributes of its creator, as any new task does.  Among them are
> resource limits, nice value, scheduling policy and affinity, the core scheduling
> cookie, ``oom_score_adj``, I/O priority, memory policy, timer slack, the speculation
> controls of ``prctl(2)``, perf events that are marked for inheritance, membership in
> cgroup v1 hierarchies, the audit ids, **seccomp filters and LSM state**.  The list is
> not complete.  The last two are deliberate: what a confined task spawns is confined as
> it is itself.
> 
> For LSMs that covers the start as well.  The hooks for receiving a file, for changing
> ids and for every step of an exec are called in the context of the embryo, with the
> state it inherited.
> 
> .. warning::
> 
>    For seccomp it does not.  The filters apply to every system call the new program
>    makes.  They are **not** consulted for what ``TASK_CMD_START`` does on the way
>    there, since the new session, the files, the credentials and the exec are not
>    system calls of the embryo.  A filter that denies ``execve()`` and ``execveat()``
>    to keep a task from running another program does not keep it from starting one in
>    a cell.  Such a filter has to deny ``task_configure()`` too, without which an embryo
>    never runs, as it once had to learn about ``execveat()``.
> 
>    This is about a task of the host.  A task of a cell cannot start an embryo at all,
>    see the ``spawn`` slot.  Evaluating the filters at the start may be added later.
> 
> The listener of a filter with ``SECCOMP_RET_USER_NOTIF`` stays behind, outside of the
> cell.  It goes on answering for the system calls of what was spawned.  It cannot put a
> file into it: ``SECCOMP_IOCTL_NOTIF_ADDFD`` fails with ``EPERM`` across cells.
> 
> Only the file that ``clone3()`` returned can configure an embryo.  Another pidfd on
> the same task cannot.  An embryo whose file is closed before it was started is
> killed.  Nobody can ptrace an embryo, or read the files in its ``/proc`` directory
> that are gated by ptrace access.
> 
> ===================  ==================  ========================================
> Command              Key                 Value
> ===================  ==================  ========================================
> ``TASK_SET_STRING``  ``exec``            the path to execute, in the cell's tree
> ``TASK_SET_BINARY``  ``argv``, ``envp``  NUL terminated strings, back to back
> ``TASK_SET_BINARY``  ``cred``            ``struct task_cred``, in the cell's ids
> ``TASK_SET_FD``      a decimal number    the file to have at that number
> ``TASK_CMD_START``   none                apply everything and exec
> ===================  ==================  ========================================
> 
> The file table of the new task is exactly what was put there.  io_uring files,
> cellfds, namespace files and the pidfd of an embryo are refused.
> 
> Whatever goes wrong is returned by ``TASK_CMD_START``, and the embryo is killed, which
> is what the pidfd reports.  If it was to be the first task of the cell, the cell dies
> with it.
> 
> The pid namespace of the spawner must be an ancestor of that of the cell.  For now
> ``CLONE_EMBRYO`` and ``CLONE_INTO_CELL`` need each other, ``CLONE_PIDFD`` and
> ``CLONE_AUTOREAP``.
> 
> 
> The boundary
> ============
> 
> Namespaces
> ----------
> 
> For a task of a cell ``setns()``, ``unshare()`` and ``clone()`` with any
> ``CLONE_NEW*`` flag fail with ``EPERM``, as do ``OPEN_TREE_NAMESPACE`` and
> ``FSMOUNT_NAMESPACE``.
> 
> From the outside ``setns()`` into a namespace of a cell fails with ``EPERM``.  The one
> exception is the network namespace of a cell that is still being built, which is how
> the tools that configure networks work today.  Whoever is in there when the cell is
> sealed stays there, so it is for the builder to see that nobody is.  The pid namespace
> is no exception: whoever got in there could become the init of the cell with the
> credentials of the host.
> 
> Tasks
> -----
> 
> A one-id cell runs on the kuid of its maker, and the pids of a cell are visible from
> above.  So wherever one task acts on another and an equal uid is enough, the same
> cell is required as well: signals, ptrace, scheduling attributes, priorities, I/O
> priorities, resource limits, ``SIGIO``, moving a task between cgroup v1 or resctrl
> groups, and ``KEYCTL_SESSION_TO_PARENT``.
> 
> There used to be a copy of such a check wherever one was needed, and a copy that is
> overlooked is a way out of a cell.  They have been gathered in one place, see
> "Comparing the Ids of Two Tasks" in Documentation/security/credentials.rst, and the
> rule about cells is applied there, once, ahead of every one of them.  That includes
> the two that let euid 0 act on anybody: root on the host can neither have ``SIGIO``
> sent to a task of a cell nor move one between cgroup v1 or resctrl groups.  This is a
> hard boundary.  A cell that is not as it should be is killed and built again.
> 
> The owner and group permissions of a key likewise only count within the cell the key
> was made in.
> 
> ``PTRACE_TRACEME`` fails across cells.  The parent of a task that was spawned into a
> cell is the spawner, outside.
> 
> The capability branch of each of these checks is unchanged for now.  See
> `Not there yet`_.
> 
> Files
> -----
> 
> A file can hand a process privilege at exec, by its set-id bits or by its file
> capabilities.  In a cell both are impossible.
> 
> *Running.*  Every task of a cell has ``no_new_privs``, which cannot be unset and is
> inherited.
> 
> *Writing.*  The ids of a cell commonly map to on-disk ids from 0 up, because that is
> how images are stored.  A set-uid bit that the root of a cell sets would make a
> set-uid root file for whoever else looks at that filesystem.  So:
> 
> * No task of a cell ever has ``CAP_SETFCAP``, not even in its bounding set, so it
>   cannot write a file capability.
> * ``S_ISUID``, and ``S_ISGID`` on anything but a directory, are silently dropped from
>   the mode of what a task of a cell creates and from the mode it sets.  They are
>   dropped and not refused so that unpacking an archive keeps working.
> * The set-id bits and file capabilities of an existing file are dropped as soon as a
>   task of a cell opens it for writing, or is given it open for writing.  A
>   ``write()`` drops them, a store through a shared mapping does not.
> 
> ``sudo``, ``su`` run by anybody but root, ``pkexec``, and tools that rely on a set-gid
> bit or a file capability do not work in a cell.  A daemon that starts as root and
> drops privileges with ``setuid()`` works as ever.
> 
> Unix sockets
> ------------
> 
> A unix socket can span two cells, because both can see the tree it is bound in or
> because one end was given to a new task.  **Between cells it carries bytes and nothing
> else.**
> 
> * Ancillary data is delivered only within a cell.  Every message records the cell it
>   was sent from, and whoever receives it gets the files, the credentials, the pidfd
>   and the security label only if that is its own cell.  This covers a file that was
>   queued on a socket before the socket was given away.
> * Sending control data to a socket that another cell holds fails with ``EPERM``, where
>   that can be known at the time.
> * ``SO_PEERCRED``, ``SO_PEERGROUPS``, ``SO_PEERPIDFD`` and ``SO_PEERSEC`` fail with
>   ``ENODATA`` if the peer is in another cell.  They fail rather than report the
>   overflow ids: 65534 is a uid like any other inside a cell, and a server that lets
>   in whoever has its own uid may well be running as it.
> 
> Peer credentials are not a way to authorise anything between cells.  Protocols that
> pass file descriptors to a service in another cell do not work.
> 
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
> 
> The system calls
> ================
> 
> They are split by what they do, as the mount API is, so that "may look but not touch"
> is a system call number: ``cell_info()`` changes nothing.
> 
> .. code-block:: c
> 
>    int cell_create(int parent, unsigned int flags);
>    int cell_configure(int cfd, unsigned int cmd, const char *key,
>                       const void *value, int aux);
>    int cell_info(int cfd, struct cell_info *info, size_t size,
>                  unsigned int flags);
>    int cell_open(int cfd, unsigned int what, const char *key, const void *arg,
>                  unsigned int flags);
>    int task_configure(int pidfd, unsigned int cmd, const char *key,
>                       const void *value, int aux);
> 
> ``cell_create()``
>   makes a new, empty cell and returns a cellfd, which is always close-on-exec.
>   ``parent`` is ``CELL_SELF``.  It takes no privilege, but it makes a user namespace,
>   and what applies to those applies here: ``user.max_user_namespaces``, the LSM hook,
>   and no chrooted caller.
> 
> ``cell_configure()``
>   changes a cell.  It is shaped like ``fsconfig(2)`` and data only goes in.
> 
> ``cell_info()``
>   reads from a cell.  The struct can grow: the caller says in ``mask`` what it wants,
>   the kernel says there what it filled in, and in ``supported_mask`` what it knows of.
>   With ``CELL_SELF`` for a cellfd it tells a task the id of its own cell.
> 
> ``cell_open()``
>   gets another file descriptor from a cell.  For now that is an nsfs file descriptor
>   on the network (``"net"``) or pid (``"pids"``) namespace of a cell that is being
>   built.  The namespace is made if the cell does not have it yet, which fills the
>   slot.
> 
> ``task_configure()``
>   sets up and starts an embryo.
> 
> A cellfd polls readable once the cell is dead, and ``read(2)`` then returns the wait
> status of its first task as an ``int``, any number of times.  A cellfd can be passed on
> but cannot be opened again through ``/proc/<pid>/fd``.
> 
> Every cell has a 64 bit id that is never reused.  It is the inode number of the
> cellfd.
> 
> Example
> -------
> 
> Error handling is left out.
> 
> .. code-block:: c
> 
>    unsigned int ids = 65536;
>    int cfd, tree, pidns, fs, proc, ns, pidfd, status;
> 
>    cfd = cell_create(CELL_SELF, 0);
>    cell_configure(cfd, CELL_SET_BINARY, "ids", &ids, sizeof(ids));
> 
>    /* The tree, from scratch.  The image becomes "/", for this cell. */
>    struct mount_attr attr = {
>            .attr_set  = MOUNT_ATTR_IDMAP,
>            .userns_fd = cfd,
>    };
>    tree = open_tree_attr(AT_FDCWD, "/images/web", OPEN_TREE_CLONE,
>                          &attr, sizeof(attr));
> 
>    /* A procfs for the pid namespace of the cell. */
>    pidns = cell_open(cfd, CELL_OPEN_SLOT, "pids", NULL, 0);
>    fs = fsopen("proc", 0);
>    fsconfig(fs, FSCONFIG_SET_FD, "pidns", NULL, pidns);
>    fsconfig(fs, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
>    proc = fsmount(fs, 0, 0);
>    move_mount(proc, "", tree, "proc", MOVE_MOUNT_F_EMPTY_PATH);
> 
>    ns = open_tree(tree, "", AT_EMPTY_PATH | AT_RECURSIVE | OPEN_TREE_NAMESPACE);
> 
>    cell_configure(cfd, CELL_SET_FD, "root", NULL, ns);
>    cell_configure(cfd, CELL_SET_FD, "budget", NULL, cgroup_dirfd);
>    cell_configure(cfd, CELL_SET_STRING, "hostname", "web-1", 0);
>    cell_configure(cfd, CELL_CMD_SEAL, NULL, NULL, 0);
> 
>    struct clone_args ca = {
>            .flags = CLONE_PIDFD | CLONE_EMBRYO | CLONE_INTO_CELL | CLONE_AUTOREAP,
>            .pidfd = (uintptr_t)&pidfd,
>            .cell  = cfd,
>    };
>    clone3(&ca, sizeof(ca));        /* the caller does not fork */
> 
>    task_configure(pidfd, TASK_SET_STRING, "exec", "/usr/sbin/nginx", 0);
>    task_configure(pidfd, TASK_SET_BINARY, "argv", "nginx\0-g\0daemon off;", 21);
>    task_configure(pidfd, TASK_SET_FD, "1", NULL, log_fd);
>    task_configure(pidfd, TASK_SET_FD, "2", NULL, log_fd);
>    task_configure(pidfd, TASK_CMD_START, NULL, NULL, 0);
> 
>    read(cfd, &status, sizeof(status));     /* until the cell is dead */
> 
> 
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

-- 
