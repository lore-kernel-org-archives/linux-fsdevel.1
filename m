Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030702;
	b=ocFLwxLjCQfC0N1OZxW9WtqJYWDMqXsY/sHt6uNWVJktS4jEaR/EpZ8BWKt8PswRmRPd
	 iERj3Z4ANe7DrO4yEz99tabR24aJ4Mq/fSnb2E76eST24QzmYDVxYbiMTXQReNFC7d+am
	 IXE9vBqBKI7ZwlcwWgmkE3TZRy97ogC0o8NPr+EuDHmZPRd08pPqBX2VB0nb2VUUn9+XM
	 rCtPz3PU/Xu4D4N1NhnI+RAD7mUieYr5jfXWhchvWVJdQ3JleoT+Uvenesan7r2O3bXYL
	 xWPom5M4cF8NsqTr3F/RpiTJuG3YFGNcfavCmEjvXogkwCwGq4zf5J/ffWO7ymfV8Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qLvYVi1pRNALOCVfth5oN0f4wUkUUumZIivB2TFVTBU=;
	b=gVbE9293yCyqc8gONorhsFHVK0pCyjuIjN+iHJJ2DbUrqa91LtRVHgwZHPluZReqamps
	 Ag4AKjMk4A1nfdJOY2K3tUJUjVk1H/QpfO2WwtNyTHsfBO1KNv0XGtBtwp2xNpFMp5x1J
	 c1FXEi4jdvFP9beSESHp5d4viumxgJQSGYu73XFrU1vSgrx+h7/GQoH5biwdJpah/e6nx
	 eozSTvTvzTNsDa26f/ArR2rXDxSOgH5UgAZnd+3H6h+mhWLqfvohlxCPU195TYRLr4oUT
	 Bedwq6c6j/FO6JP5rg/rko94kTYn427lkDgCeFzw++fTBkukcECwrln3+gD3YCuhPcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=dcw8h3Bz;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26463606A31E
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 16:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26463606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=dcw8h3Bz
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b0f59a5fdeso25247607b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793030700; x=1793635500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qLvYVi1pRNALOCVfth5oN0f4wUkUUumZIivB2TFVTBU=;
        b=dcw8h3Bzq13LW+lvfSD1LHd+93lheSSKbQsSEo4zS0EbClWQrlxZIfcRneFTKyDJyp
         SSvvyZuPaQCfEChYS/dNJV50snAmvROoncTnz/zS13vt7uyODfab1yTzb1S4uJtFx4T2
         DIklXhUXxqKnYoVBTsuji6XJ9LGI8e4EiQtDPxmwIkCYmg4rEekC02tMc5xUxVw6VVPu
         WUYz9idOBADZtYa7Nle52NkO9QZFGQwFcpij3mFYa3BEORmSou8cbYKxWPE800SzfaaT
         Vevdn+zgr8u9gJpFlVGucbV+PqdN7aX7rkjMBEbvhRLcN7zPvs+gEXQEJotmP8oBmkMq
         VWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030700; x=1793635500;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qLvYVi1pRNALOCVfth5oN0f4wUkUUumZIivB2TFVTBU=;
        b=aIjCoUDM2nCoLMMYmxoJBLg9VhyzEo6PjOR2Jtu4E9TPajUeqpfDBfSLnOtAaFrW6B
         fwP1nrFyF6NU6VDHXJGAj959FDl6f+aBkFxwRb+C+PbaFLw5WODTCQVm8s3wK2Ogz8bP
         cXa69tZSW/y7bkghj5IQzOgsgls5PWhkH5mTm3FESxvFwnohuXE6xyg1Gx/K0vUjuyTh
         XB0tIQa5y4yi187aFBhYAUxw92TMZwMi+eDYU8VXsZqKZvu7GuXXO5+95Lf1IjWfTHKK
         C67TEQ3VMqS8cqOZyWaJbfywi1ez5v9IjhHU6njiTUFjtm9XJJf7tbXfPJDTXxNc/Eqy
         QCHQ==
X-Forwarded-Encrypted: i=1; AKwUvBy00jvkNn3E3c+23FS2/w5FphRpnwMiGuHp6QKAOvgzdD7P93A6r1A6ncTU2rUYK320ixv2nB1V4x1fwj99@vger.kernel.org
X-Gm-Message-State: AFq9FYKTBXPmTSatUqZHPc3bJP965qW3gDmdb3LCYoyqLr2cIfkKnK/o
	GuznABxl1t3mAz1s54lw+EG6HVhOoAyDsMEQi1hFF3Pm6LZudE5+RZA0eArl1zYN3kQ=
X-Gm-Gg: AYBFou3gl9Ofo1erFCFlINiVpmQx2AE4u/S3dEaCRjc1zQ4e0sFWL5m/eSdqlqFp22i
	/mnFCWdDtzxbiEQ3LmziVEmd7kTHvWK423z57O8Hw619NUIgDQZB/Jm1oG1K9vNsd2cr1t+U5Hl
	4MXzrp4Lwtc/pDmVPoACncAG7zp6BIvGQSr53QxgD95dtiVdwiTu3gXUhaEYJoAOB1KT8gjNM7g
	6FTgqmKr65iiOSrhAxJllXiD1EavQVbovX/5JC8T/ftMEBWMTrunDSViuR5Cd547/8mF7KBzuyJ
	NFwXFzP103NTrUlV9Vtyr6OGlJnuHkVuMIhwara2B/JOrx6FPs2isqwRf/icQK8+AuxI9MqBHLn
	WuHxgWUdpKcT71oLiQCSVce/zAak8YjS6xiGHmv1c7IFOcgTcXq5jDUuWzoEoxODaNOLbNdDbj2
	IS2VWY80ppaGnhX7LUo9kUogXEPHVWId+RhOKTYxeP5CX5MnZ3gp3Ip0gfszOYPASAfBJGiEyhN
	Ef2t27gLgIuztvmaQP4jkC00KoxfKQeKcJFw+e9Q669emhQPgrkkznZX3wsbARbnyQcHiM2RliV
	oQh6lDkuKrr24zNKqg==
X-Received: by 2002:a05:690c:c101:b0:8b0:ab62:c636 with SMTP id 00721157ae682-8b166c43344mr48889497b3.45.1793030699032;
        Mon, 26 Oct 2026 09:04:59 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166dcf54esm33260377b3.10.2026.10.26.09.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:04:58 -0700 (PDT)
Date: Mon, 26 Oct 2026 16:04:52 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>,
 linux-fsdevel@vger.kernel.org
Subject: [RFC v2] cells: a container as one kernel object
Message-ID: <20261026-cells-rfc-v2-b41d7e0c95a3@toxicpanda.com>
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
Content-Transfer-Encoding: 7bit

Hello,

This is v2 of the cells RFC, a container as one kernel object instead of
a pile of namespaces that userspace holds together. v1 is at [1]. Same
deal as last time, it's 67 patches on top of the 13 patch cred series
[2] and this is still a design discussion, so the code is in a branch,
and what's in this email is what changed, the pitch, the things I would
like opinions on, and the design document from the branch in full at the
bottom so you can quote it and yell at specific lines.

  https://github.com/josefbacik/linux/commits/cells/
  git fetch https://github.com/josefbacik/linux.git cells

That's d5ad76c92c02 as I write this, based on vfs.all. What v1 described
is tagged cells-rfc-v1 in the same tree.

I called "cell" a placeholder last time. It has grown on me since and
I'm going to stick with it.

Thanks to Christian, James, Andrew and Jeremy for reading v1. I owe a
few of you replies, I've tried to answer everything that was still open
in here instead.

Since v1
--------

- Spawning is an empty pidfd (Christian). CLONE_EMBRYO and
  task_configure() are gone and clone3() is untouched.
  pidfd_open(cellfd, PIDFD_EMPTY) returns a pidfd that no task is
  attached to yet, pidfd_configure() says what the task is to be like,
  and PIDFD_CMD_START makes it. There is no task, no pid number and
  nothing to clean up before the start. -EBADF in place of the cellfd,
  for a task that is in no cell, is set aside and returns EOPNOTSUPP for
  now, I would like to do that as its own series.

- cell_kill() is a system call of its own instead of a command of
  cell_configure(), so everything cell_configure() does is now about a
  cell that is still being built.

- A pod is one cell (Andrew, James). I told James it should be several
  cells sharing a network namespace, and I had that backwards. The cell
  is the boundary between things that don't trust each other, and the
  containers of a pod do. In one cell a shared pid namespace, signals,
  /proc/<pid>/root, sysv ipc, abstract unix sockets and fd passing all
  just work, because none of it crosses a boundary, and a sidecar or a
  debug container that shows up late is one more spawn. See question 1
  for what's missing.

- The network is set up from the outside and handed to the cell, the
  same as the mount tree. In v1 a cell that said nothing about its
  network got a fresh network namespace that it owned, so its root had
  CAP_NET_ADMIN over a whole network stack, which is exactly what I
  don't want anybody to get by accident. Now a network namespace that is
  made for a cell belongs to the builder's user namespace, like the
  mount namespace does. The cell uses it and can't configure it, the
  builder can keep changing it while the cell runs. A cell owns its
  network namespace only if the builder asks for that by name. Listening
  on port 80 and ping don't need a capability, they are sysctls of the
  network namespace that the builder sets.

- No "net" slot means no network. Not an empty network namespace, which
  still lets you make sockets of every family and talk to rtnetlink, but
  the thing failfs is to an empty filesystem: socket() fails with
  EAFNOSUPPORT for everything but AF_UNIX, and ioctls that are about the
  network rather than the socket fail with ENODEV on any socket. A
  socket that is handed to the cell works, and is the only network it
  has.

- A task of a cell changes nothing in cgroupfs outside of its budget,
  and nothing in resctrl at all, whatever the modes say and whoever owns
  the node. A cell of one id runs on the uid of its maker, so it owns
  what its maker owns, and modes and owners are no help. Doing that
  properly took a hook in kernfs, since a chmod, a chown or an xattr
  never reaches the filesystem on top.

- That CLONE_NEW* is EPERM in a cell is now written down as a position,
  with the reason and where I want to go with it, instead of being
  listed under things that don't work yet (Andrew). Question 3.

- Bugs, for anybody who pulled the branch. SO_PEERPIDFD and friends
  checked the peer's cell and then read the peer in two steps, and a
  task of a cell could win a pidfd on a task of the host about one time
  in five. Enabling a controller on a world writable cgroup outside of
  the budget left files behind that were owned by an id of the cell.

- The tests are six programs by topic now, 69 of them.

The pitch
---------

A container isn't a thing in the kernel. It's eight kinds of namespace,
a cgroup, a seccomp filter and a pile of conventions that the runtime
holds together. The kernel can't name it, can't kill it in one go, and
can't tell you what's in it. Privilege inside of it hangs off of uids
and user namespaces, and a task can be half way between two sets of
namespaces at any given moment, which is where a depressing number of
our bugs come from.

A cell is a container as one object. A task is born in a cell and never
leaves it, and no existing task can move into one, so there is no
setns() and no unshare(). You build it from the outside by filling named
slots from file descriptors you already hold, you seal it, and then you
spawn tasks into it, at any point while it's running and not just to get
it going. Holding the cellfd is the authority to do all of that, there
is no uid or capability check on it, and making one takes no privilege.
The cell lives exactly as long as somebody holds the cellfd, when the
last one goes the cell is killed.

Whatever a cell has, somebody put there. The mount tree is built from
scratch by the builder, nothing in it hides anything, nothing propagates
into it and the cell can't mount. The network is set up by the builder
and the cell can't configure it. A new task starts with no mm and no
files, so what it has is what you gave it. Say nothing about the network
and there is none, it doesn't fall back to the host's.

A few rules fall out of wanting the boundary to actually mean something.
The kernel allocates the kuids for a cell out of a reserved window, the
builder never names one, and those ids can never be stored on a
filesystem the cell doesn't own. A uid means nothing across cells, not
an equal one and not 0. Files impart no privilege, every task has
no_new_privs, and set-id bits get dropped on anything a cell creates,
chmods or opens for writing. Unix sockets carry bytes between cells and
nothing else, no SCM_RIGHTS and no peer credentials.

Answers I owe
-------------

James asked whether a process can fork into a cell without an exec, and
what happens to the fd table. It can't, and nothing is inherited. There
is no fork involved, the new task is made from nothing by
PIDFD_CMD_START and the first thing it does is exec. You place every
file it should have by number, pidfd_configure(pidfd, PIDFD_SET_FD, "0",
NULL, ttyfd) and so on, so getting your current tty across for a shell
is three calls. That is more of a restriction than nsenter has today, on
purpose. The CVEs I listed in my last mail all came down to something
the new task had inherited.

IPC namespaces for database containers are covered by a pod being one
cell. So is debugging from a sidecar when you have no access to the
host, the debug container is spawned into the same cell by whoever holds
the cellfd, and in there ptrace works as ever.

Architecture emulation with the qemu binary outside of the image I
haven't tried. The cell has no binfmt_misc of its own so I would expect
a handler that the host registered with the F flag to apply, but I would
rather test that than promise it. Exec from an fd is still not written
and I still want it.

Jeremy asked for a convenient way to attach a network interface. It's
what any runtime does today, you make the network namespace, move one
end of a veth in there, give it an address, and put the namespace in the
slot. There is a test that does exactly that. A nicer wrapper, and
channels, I think are for a library.

What I would like opinions on
-----------------------------

The shape isn't on this list anymore. One object, born in it and never
leaves, no existing task moves in, built from the outside out of fds,
authority is the fd. That's what this is.

New, or moved on since v1:

1. Pods. With a pod being one cell, every task starts at the root of the
   cell and in its budget cgroup, which is no good for containers that
   each bring an image and a limit. I want to let a spawn name both, two
   more keys for pidfd_configure(): "root", a directory somewhere in the
   cell's tree, and "cgroup", a cgroup at or below the budget. The
   runtime lays out one subtree per container before it seals and makes
   one leaf per container. Nothing has to make a namespace from the
   inside. That root is a view and not a boundary, uid 0 of the cell can
   walk out of it, which is the deal inside of a pod with a shared pid
   namespace today. Not written yet. Is that enough for what runtimes do
   with pods?

2. The budget. Spawning from the outside still fails with EBUSY once the
   cell enables controllers on its own cgroup, which systemd does right
   away, and James is right that it can't stay that way. The "cgroup"
   key above is half of the answer, the builder makes the leaf, which is
   where Christian was leaning. The other half is what happens when
   nobody says anything, I have a prototype that spawns where the cell's
   init is. Also a cell with a block of ids still can't mkdir in
   cgroupfs. I prototyped letting cgroupfs store the ids of a cell below
   its own budget instead of making cgroupfs idmappable, it's about 50
   lines and a systemd like setup works on it. I can post that if
   anybody wants to look.

3. Namespaces inside of a cell. unshare(CLONE_NEWUSER | CLONE_NEWNET)
   handing anybody CAP_NET_ADMIN over a fresh network stack is the kind
   of thing a cell is there to keep out of reach, so the default stays
   EPERM. But I would like bubblewrap and chrome's sandbox to work. I
   have a prototype of a slot that the builder fills with which kinds of
   namespace the tasks of the cell may make, a ceiling on what
   capabilities a user namespace of theirs confers, on anybody, and
   which filesystems they may mount. Whatever they make still belongs to
   the cell and setns() stays refused. Stock bubblewrap runs on it with
   CAP_SYS_ADMIN, tmpfs and proc, and the sequence chrome goes through
   with CAP_SYS_ADMIN and CAP_SYS_CHROOT. bwrap --unshare-net wants
   CAP_NET_ADMIN just to bring up lo and I have no good answer for that
   yet. It's a follow up and not part of this, but I would like to know
   if the direction is sane.

4. No network. What's in the branch is the behaviour, on top of a bare
   network namespace per cell, because unix sockets live in a struct
   net. What I would like to end up with is one static struct net for
   all of them, the way there is one failfs, which also gets rid of
   setting up and tearing down a whole network namespace for something
   that never opens an inet socket. That means moving the unix socket
   tables out of it. I haven't cc'd netdev, I will when there is more to
   it than a check in net/socket.c.

5. ucounts (Andrew). Whatever is counted per user rolls up to whoever
   made the user namespace, so with a builder that runs as root one cell
   can use up root's 128 inotify instances, for the host and for every
   other cell. I wrote the test, it does. containerd works around this
   by making the user namespace as the container's own kuid, which a
   builder can't do if it never gets to name an id. But the kernel can:
   for a cell with a block, charge what its tasks do to the first kuid
   of the block in the parent namespace, and keep charging the user
   namespace and the block itself to the maker. The catch is that
   somebody unprivileged multiplies their per-user limits by the number
   of blocks they can hold, which is counted, and the pids and memory
   controllers on the budget bound the real thing. Not written, listed
   as a known limit for now.

Still open from v1, the long versions are in [1]:

6. The id window. Blocks of 65536 kuids come out of the upper half of
   the id space, so with CONFIG_CELLS on the host can't chown a file to
   an id of 2^31 or above anymore. Jeremy thinks this will become a
   problem and would rather see a separate id space, and Christian
   pointed me at the isolated user namespaces work with its 64 bit
   kuids, which I have not looked at properly yet. I'm not attached to
   the window, I'm attached to the kernel handing out ids that provably
   nobody else holds.

7. Capabilities. A capability held in an ancestor user namespace still
   applies to what a cell owns, so root on the host can still signal and
   ptrace by pid. I would like the boundary to be hard in both
   directions, you hold the cellfd or you have nothing. Nobody said
   anything about this one. How far do we want to go?

8. MNT_LOCKED (Christian). The seal refuses a tree with a locked mount
   in it, except for the tree itself on the empty root of a namespace
   made with FSMOUNT_NAMESPACE or OPEN_TREE_NAMESPACE, which the kernel
   locks there for any builder that works in a user namespace of its
   own. Is the exemption right, or should that not be locked to begin
   with?

9. seccomp. The filters a new task inherits are not consulted for what
   PIDFD_CMD_START does, because the exec isn't a system call of the new
   task, so a filter that denies execve() has to learn about
   pidfd_configure() as well. Christian would rather see a filter that
   belongs to the cell than more seccomp. I like that and haven't
   thought it through.

10. Lifetime. A cell dies with its last cellfd. Christian likes that,
    it's what CLONE_PIDFD_AUTOKILL does for pidfds, and userspace has
    systemd's fdstore to make one survive. James parks namespaces on a
    mount to keep empty containers around and would like the same for a
    cellfd. Christian brought that up as well and called it a can of
    worms best left alone for now. I'm with Christian for now, it turns
    a path and its mode into the authority over a cell, but it's a real
    use case and I would like to hear if the fdstore doesn't cover it.

Per cell procfs, sysfs, devtmpfs and cgroupfs were on the list last
time. Everybody who said anything likes the direction and nobody thinks
it has to come first, so it stays where it was.

How to read the branch
----------------------

It's one logical thing per patch and about half of them are 50 lines or
less, so it is less than it sounds like. The first 13 are the cred
series [2]. Read the document, then these are the ones with the design
in them:

  87819e2f62dc user_namespace: let a cell own a user namespace
  ccf48290e017 fs: seal a mount namespace for a cell
  ba0f966f634e cells: add the cell object and cell_create()
  80667872542a cells: add cell_configure()
  d6a4d334410e cells: add the "net" slot
  577469c2fa0c cells: lend a cell a block of ids
  a27f929f017d fork: let copy_process() place a task in a cell
  a68bdbccacd5 fork: add tasks that start out with nothing
  fd1dd033c5c3 pidfd: add PIDFD_EMPTY
  ef6a8b2ef291 pidfd: add pidfd_configure()

The rest are helpers in cgroup, fs, pid and nsproxy ahead of those, and
the rules of the boundary after them, one rule per patch. New among
those since v1:

  1a4e8ae2d5a2 kernfs: let a filesystem refuse a change to a node
  c99b6db5be84 cgroup: let a cell change nothing outside its budget
  257e4553a58f resctrl: let a cell change nothing
  2258dd34e5c3 net: give a cell without a network no sockets

The uid rule is the reason for the cred series: with the dozen hand
rolled copies of "the uids match so you can mess with that task" in one
place, it is one small patch,

  58726874c1d3 cred: let no id count across cells

CONFIG_CELLS doesn't exist until near the end, so everything before that
builds as stubs, and every commit builds on its own. The last patch is
the selftests.

State
-----

I've run the selftests under KASAN, lockdep and DEBUG_VFS in qemu, on
tmpfs, ext4 and 9p, and built it with gcc and clang and with the option
off. The resctrl patch is compile tested only, qemu has no cache
allocation to offer. It has still not been near real hardware, a real
runtime or a benchmark. Only x86 and the generic syscall table are wired
up. There are no rights on the cellfd and no LSM hooks of our own. "Not
there yet" at the end of the document is the full list, and I tried to
be honest in it. Please keep arguing. Thanks,

Josef

[1] https://lore.kernel.org/linux-fsdevel/20261019-cells-rfc-6f4c85415f29@toxicpanda.com/
[2] https://patch.msgid.link/20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com

-- >8 -- Documentation/userspace-api/cells.rst -- >8 --

.. SPDX-License-Identifier: GPL-2.0

=====
Cells
=====

A cell is a container as one kernel object.  A task is born in a cell and never
leaves it, and nothing can enter one.  A cell is built from the outside: the
builder fills named slots from file descriptors it holds, seals the cell, and
spawns tasks into it.  Holding the file descriptor of the cell, the *cellfd*, is
the authority to do all of that.

This document explains why cells exist, what they promise, how they are used and
what the first implementation does not do yet.

.. contents:: :local:


Why
===

A container on Linux is not an object.  It is eight kinds of namespace, a cgroup,
a seccomp filter and a set of conventions that a runtime holds together.  A number
of problems follow from that, and they do not go away by fixing bugs one at a
time.

There is nothing to name.
  The kernel cannot say which container a task is in, cannot kill a container in
  one operation and cannot tell what a container has access to.

Membership is a property of a task at a moment.
  ``setns()`` and ``unshare()`` let a task change one namespace at a time.  A task
  that is half way between two sets of namespaces, holding file descriptors, a
  working directory or a memory map from one side and credentials from the other,
  has been the source of many bugs.

Setup runs on the inside.
  A runtime forks, and the child sheds, one call at a time, what it inherited and
  should not have.  What it forgets to shed leaks into the container.

Privilege hangs off ids.
  A user namespace gives its creator a full set of capabilities over everything
  the namespace owns, which puts a large amount of code that was written for root
  within reach of every user.  Who may do what to whom is decided by comparing
  uids, and whether two uids are the same depends on how several runtimes agreed
  to carve up ``/etc/subuid``.

Hiding is done by mounting over.
  What a container must not see is commonly covered by a mount.  ``MNT_LOCKED``
  exists to keep such mounts in place, and a way to remove one, or to copy the tree
  without it, reveals what it covered.

A cell turns this around.  There is one object with one lifetime.  What it holds
was put there explicitly, by somebody who held it.  What was not put there is not
there.


The model
=========

Invariants
----------

The implementation is meant to uphold the following.  A way to break one of them
from the inside of a cell, or as an unprivileged user outside, is a bug.

#. **A task never changes cell.**  There is no way to enter a cell and no way to
   leave one.  The namespaces of a cell belong to the cell and not to its tasks.
#. **A cell holds what it was given.**  Slots are filled from file descriptors the
   builder holds.  Filling a slot takes what using the object would take.
#. **Authority over a cell is the cellfd.**  No uid and no capability is compared
   when a cell is configured, spawned into or killed.  There is no cell without
   somebody who holds one: it dies with the last.
#. **Nothing is inherited that gives access to anything.**  A task that is spawned
   into a cell starts with no memory map and no open files.  What it can reach is
   what it was given.  `Spawning: empty pidfds`_ lists what it does inherit.
#. **After that nothing crosses.**  Once a task has started, no file descriptor and
   no identity crosses the boundary of its cell.  A cell that was given a network
   namespace to share is an exception, see `Not there yet`_.
#. **A cell starts nothing it was not allowed to.**  Making a cell and starting a
   task in one is a slot like any other, ``spawn``.  It cannot be filled yet, so what
   runs in a cell comes from a ``fork()`` and ``execve()`` of what was spawned into
   it, or from outside.
#. **A uid means nothing across cells.**  Not an equal one, and not 0.
#. **Files impart no privilege.**  Nothing a cell runs can gain privilege from a
   file, and nothing a cell writes can give privilege to anybody else.
#. **Nothing is hidden by a mount.**  Whatever is in the tree of a cell, the cell
   may see all of it, including what lies under every mount point.
#. **Ids are lent.**  The kernel chooses the kuids and kgids of a block, nobody else
   can hold one of them while the cell does, and nothing the cell made may still be
   owned by one when they are lent again.
#. **DEAD means gone.**  When a cell reports that it is dead, no task of it is left,
   not even one that is on its way out, and the cell has dropped every reference it
   held.  What that sets off, such as the release of mounts, of the network
   namespace and of the block of ids, completes on its own time.

Life of a cell
--------------

A cell only ever moves down this list.

=================  =============================================================
``CELL_BUILDING``  Slots may be filled.  Nothing runs.
``CELL_SEALED``    Immutable.  Nothing has been spawned yet.
``CELL_RUNNING``   Has, or had, its first task.
``CELL_DYING``     Was killed, or its first task has exited.
``CELL_DEAD``      Nothing is left.  The exit status can be read.
=================  =============================================================

The first task that is spawned is the init of the pid namespace of the cell.  When
it exits the kernel kills everything else in that namespace, as it does for any pid
namespace, and the cell dies.

A cell can be killed in every state.

**A cell lives for as long as somebody holds a cellfd on it, and no longer.**  When the
last one is closed, be it because whoever held it was killed, the cell is killed.  A
cellfd can be passed on, so a cell can be handed to a supervisor, but a cell that nobody
holds is a cell that nobody could kill, spawn into or wait for.

Slots
-----

============  =========================================  =======================
Slot          Filled with                                If it is left empty
============  =========================================  =======================
``ids``       a count: 1 or 65536                        1; refused for root
``root``      a mount namespace nobody has entered       the seal fails
``budget``    a cgroup v2 directory                      the seal fails
``net``       a network namespace, or the string         no network
              ``"new"`` or ``"own"``
``hostname``  a string                                   ``(none)``
``spawn``     nothing yet, the name is reserved          no task of the cell can
                                                         make a cell or start a
                                                         task in one
============  =========================================  =======================

The pid, ipc, uts and cgroup namespaces of a cell are always new.  The cgroup
namespace is rooted at the budget.  The time namespace is that of the builder.

See `The network`_ for what goes into ``net``.

A file descriptor on a namespace is no authority over it, since anybody who can see a
task can open one.  So filling ``root`` or ``net`` from one takes ``CAP_SYS_ADMIN`` over
the user namespace that owns the namespace.  That is about what goes into the slot and
not about the cell.  It is half of what ``setns(2)`` asks for: the other half is about
the namespaces of the caller, which do not change.


Ids
===

Every consumer of a kuid in the kernel knows how to deal with a user namespace, so
a cell has one.  The kernel makes it together with the cell, and it differs from a
legacy user namespace in the ways that make a legacy one hard to reason about:

* Nobody can ``setns()`` into it.
* The uid that created it has no capability over it.
* Its map is set once, by the kernel, to ids the kernel chose.

All translation between the ids a cell sees and the ids on disk stays in the VFS,
in the idmapping of each mount of the tree.  See
Documentation/filesystems/idmappings.rst.

A cell comes in two shapes.

One id
  The cell runs on the uid and gid of whoever made it, under their own numbers, with
  the supplementary groups of its maker and without capabilities.  ``setgroups()`` is
  denied.  The groups are kept because a group can be there to deny something.  This
  shape is refused to root, since too much goes by the bare value of kuid 0, and to
  an id that lies in the window described below.

A block
  The cell sees uids and gids 0 to 65535.  They map to a block of 65536 kuids and
  kgids that the kernel allocates.  **The builder never names a kuid.**  It takes no
  privilege: a block that nobody holds gives access to nothing.  A user can hold
  ``user.max_cell_id_blocks`` of them.

The window
----------

Blocks come out of a window, the upper half of the id space less its last block:
2147483648 to 4294901759.

"Nobody else holds an id of this block" stands in for the privilege check that a
legacy user namespace needs before it may map a range.  So it is enforced rather
than assumed:

* A legacy user namespace cannot map into the window.
* **No create, chown or ACL stores an id of the window in a filesystem that the
  cell does not own.**  Creating a file and ``chown()`` fail with ``EOVERFLOW``,
  setting an ACL with ``EINVAL``.  Through a mount that is idmapped for the cell the
  id has become the on-disk id before the check is made, so that works.  The check
  goes by the value of the id and not by who is asking, because a stacking
  filesystem may create files with the credentials of whoever mounted it.
* A block lives as long as the user namespace object it was lent to, not as long as
  the cell.  Every credential, and every object that the namespace owns, pins the
  namespace.  That covers the inodes which the kernel makes on filesystems of its
  own and gives to the caller without asking: pipes, sockets, memfds, the slave of
  a pty.  Each lives no longer than a file that is open on it, and the file pins the
  credentials it was opened with.
* The idmapping of a mount holds a copy of the maps.  One that was made for a cell
  pins the user namespace as well, so a mount that is kept beyond the life of the
  cell keeps the block from being lent again.
* What the cell made below its budget is removed when the cell dies, and the budget
  returns to its owner.  If that fails the block is never lent again.
* Some tables are keyed by a bare kuid and pin nothing: ``struct user_struct`` and
  the quota records of keys.  A released block is quarantined until they hold
  nothing in its range, and a block is checked the same way before it is lent.

Blocks are handed out round robin, so that reuse comes as late as it can.  A block in
quarantine counts as used.  A leak therefore shows up as ``ENOSPC`` and never as one
tenant owning what another left behind.

.. warning::

   With ``CONFIG_CELLS`` enabled the host itself cannot ``chown()`` a file to an id
   of the window.  This is a change of behaviour for a system that uses such ids.
   Files that already belong to one, seen through a mount that is not idmapped,
   look as if they belonged to whichever cell is lent that block.

What the allocator does not cover is the ids on disk.  Through a mount that is
idmapped for it, a cell with a block always uses on-disk ids 0 to 65535, so two cells
that are given the same storage see each other's files.  That is sometimes intended,
as with shared images, and remains the responsibility of the builder.


The tree
========

The tree of a cell is built from scratch, one mount at a time, in a mount namespace
that nobody has entered: see ``fsmount(2)`` with ``FSMOUNT_NAMESPACE`` and
``open_tree(2)`` with ``OPEN_TREE_NAMESPACE``.  Sealing the cell makes that namespace
the cell's, or fails without having changed anything about it:

* No mount may be ``MNT_LOCKED``, since a locked mount hides what it covers.  The
  tree itself may be: it sits on the root of the namespace, which is empty, and the
  kernel locks it there for a builder that works in a user namespace of its own.
* Nobody is in the namespace, or on the way in.
* Every mount is made private.  Nothing propagates into a cell.
* In a cell with a block of ids, a writable mount of a filesystem that can be
  idmapped must be idmapped for the cell, or belong to a superblock the cell owns.
  This is only the early and readable form of the ``EOVERFLOW`` above.

To idmap a mount for a cell, pass the cellfd in ``mount_attr.userns_fd``.  On-disk
ids 0 to 65535 then belong to the ids of the cell, or the one id to itself.

A seal that fails leaves the cell ``CELL_BUILDING``.  What it had filled in for slots
that were left empty by then stays filled in.

The mount namespace stays owned by the user namespace of the builder.  That is what
keeps a task of the cell from mounting anything.


The network
===========

The network of a cell is set up from the outside and handed to the cell, as the tree
is.  A task of a cell uses it.  It does not configure it: a capability over a network
namespace is one in the user namespace that owns it, and that is not the cell's.  This
goes for ``CAP_NET_ADMIN``, ``CAP_NET_RAW`` and ``CAP_NET_BIND_SERVICE`` alike, and for
the root of the cell as for anybody else in it.

What the builder puts into the slot decides what the cell gets:

Nothing
  No network.  ``socket()`` and ``socketpair()`` fail with ``EAFNOSUPPORT`` for every
  family but ``AF_UNIX``, as in a kernel that was built without the rest.  An ``ioctl()``
  that is about the network a socket is in and not about the socket, its devices,
  addresses and routes, fails with ``ENODEV`` on any socket, and so do those that a
  protocol keeps to itself, ``SIOCPROTOPRIVATE``.  A socket that is handed
  to the cell works, and so does what ``accept()`` makes of it: it is the authority to
  use it, and the only network such a cell has.

A network namespace
  That one, the way the builder has set it up: one it made for the purpose, one that
  several cells share, or that of the host.  It may not be one that another cell owns.

``"new"``
  One that is made for the cell, for the builder to set up.  ``cell_open()`` returns a
  file descriptor on it, to enter it or to move a device there.  Until then there is a
  loopback device in it, which is down.

``"own"``
  A new one that the cell owns.  The root of the cell has every capability over it, and
  the cell sets up its network by itself.  This puts a large amount of code that was
  written for root within reach of the cell, so it has to be asked for.

Nothing is done for the builder.  Whatever is not set up is not there, the address of
the loopback device included.

Except for ``"own"`` the network namespace belongs to the user namespace the cell was
made in, or to whoever made it.  Who has ``CAP_SYS_ADMIN`` there can enter it whatever
state the cell is in, so a network can be changed while the cell is running.

Some of what a container commonly has a capability for is a setting of the network
namespace as well, and the builder can make it: ``net.ipv4.ip_unprivileged_port_start``
for listening on port 80, ``net.ipv4.ping_group_range`` for ``ping``.  There is no such
thing for raw and packet sockets.


Spawning: empty pidfds
======================

``pidfd_open()`` with ``PIDFD_EMPTY`` takes a cellfd where it otherwise takes a pid,
and returns a pidfd that no task is attached to yet.  Whoever has it says with
``pidfd_configure()`` what the task is to be like, and starts it.  Only then is there
a task.  It never runs an instruction of its creator's, and execs.  The creator does
not fork.  This is ``fsopen()`` for tasks.

A cell can be spawned into for as long as it is sealed or running, not only to get it
going.  **This is what takes the place of entering a container**: no task that exists
moves in, but whoever holds the cellfd can start a new one in there at any time.

An empty pidfd is a pidfd like any other, and stays the same pidfd once there is a
task.  Until then whatever it is passed to finds no task, which is ``ESRCH``, or
``ECHILD`` from ``waitid(2)``.  No task yet is not the same as no task any more: it does
not poll readable, ``PIDFD_GET_INFO`` has no exit to report, and its ``fdinfo`` says
``Pid: 0`` and not ``-1``.

It reserves nothing in the cell, not even a pid: whichever task is started first is the
init of the cell, one that is closed without having been started leaves no trace, and
one that is left empty keeps no cell from dying.

The new task has

* no memory map, from the start,
* an empty file table,
* the root of the tree of the cell as its root and working directory,
* the credentials of the root of the cell, or of its one id,
* default signal dispositions, nothing blocked and nothing pending,
* its own session and no controlling terminal,
* ``no_new_privs``,
* none of its creator's registers.

It still inherits attributes of whoever started it, as any new task does.  Among them are
resource limits, nice value, scheduling policy and affinity, the core scheduling
cookie, ``oom_score_adj``, I/O priority, memory policy, timer slack, the speculation
controls of ``prctl(2)``, perf events that are marked for inheritance, membership in
cgroup v1 hierarchies, the audit ids, **seccomp filters and LSM state**.  The list is
not complete.  The last two are deliberate: what a confined task spawns is confined as
it is itself.

For LSMs that covers the start as well.  The hooks for receiving a file, for changing
ids and for every step of an exec are called in the context of the new task, with the
state it inherited.

.. warning::

   For seccomp it does not.  The filters apply to every system call the new program
   makes.  They are **not** consulted for what ``PIDFD_CMD_START`` does on the way
   there, since the new session, the files, the credentials and the exec are not
   system calls of the new task.  A filter that denies ``execve()`` and ``execveat()``
   to keep a task from running another program does not keep it from starting one in
   a cell.  Such a filter has to deny ``pidfd_configure()`` too, without which there
   never is a task, as it once had to learn about ``execveat()``.

   This is about a task of the host.  A task of a cell cannot open an empty pidfd at
   all, see the ``spawn`` slot.  Evaluating the filters at the start may be added later.

The listener of a filter with ``SECCOMP_RET_USER_NOTIF`` stays behind, outside of the
cell.  It goes on answering for the system calls of what was spawned.  It cannot put a
file into it: ``SECCOMP_IOCTL_NOTIF_ADDFD`` fails with ``EPERM`` across cells.

Only the file that ``pidfd_open()`` returned for ``PIDFD_EMPTY`` can configure.
Another pidfd on the same task cannot.  From when the task is made until its exec has
succeeded nobody can ptrace it, or read the files in its ``/proc`` directory that are
gated by ptrace access.

====================  ==================  =======================================
Command               Key                 Value
====================  ==================  =======================================
``PIDFD_SET_STRING``  ``exec``            the path to execute, in the cell's tree
``PIDFD_SET_BINARY``  ``argv``, ``envp``  NUL terminated strings, back to back
``PIDFD_SET_BINARY``  ``cred``            ``struct pidfd_cred``, in the cell's ids
``PIDFD_SET_FD``      a decimal number    the file to have at that number
``PIDFD_CMD_START``   none                make the task, apply everything and exec
====================  ==================  =======================================

The file table of the new task is exactly what was put there.  io_uring files,
cellfds, namespace files and what ``pidfd_open()`` returned for ``PIDFD_EMPTY`` are
refused.  What was configured is let go of once it has been used, however long the
pidfd is kept.

Whatever goes wrong is returned by ``PIDFD_CMD_START``, which can be tried only once.
If there was a task by then it is killed, which is what the pidfd reports, and if it was
the first task of the cell, the cell dies with it.

The pid namespace of the spawner must be an ancestor of that of the cell.  Nobody has to
wait for the task: it is reaped on its own, and the pidfd tells how it ended.  For now
there is no empty pidfd without a cell.  ``-EBADF`` in place of the cellfd is set aside
for that, and fails with ``EOPNOTSUPP``.


The boundary
============

Namespaces
----------

For a task of a cell ``setns()``, ``unshare()`` and ``clone()`` with any
``CLONE_NEW*`` flag fail with ``EPERM``, as do ``OPEN_TREE_NAMESPACE`` and
``FSMOUNT_NAMESPACE``.

That is on purpose.  ``unshare(CLONE_NEWUSER | CLONE_NEWNET)`` hands whoever calls it
every capability over a network stack of its own, and with that a large amount of code
that was written for root.  A cell is there to keep such code out of reach, so it does
not come back by default.

The direction is a slot for the builder to fill: which kinds of namespace the tasks of
the cell may make, which capabilities a user namespace of theirs confers at most, and
which filesystems they may mount.  Whatever they make belongs to the cell, nobody
enters or leaves any more than before, and an empty slot is what is described above.

From the outside ``setns()`` into a namespace of a cell fails with ``EPERM``.  The one
exception is a network namespace that the cell owns, see `The network`_, while the cell
is still being built, which is how the tools that configure networks work today.  Whoever is in there when the cell is
sealed stays there, so it is for the builder to see that nobody is.  The pid namespace
is no exception: whoever got in there could become the init of the cell with the
credentials of the host.

Tasks
-----

A one-id cell runs on the kuid of its maker, and the pids of a cell are visible from
above.  So wherever one task acts on another and an equal uid is enough, the same
cell is required as well: signals, ptrace, scheduling attributes, priorities, I/O
priorities, resource limits, ``SIGIO``, moving a task between cgroup v1 or resctrl
groups, and ``KEYCTL_SESSION_TO_PARENT``.

There used to be a copy of such a check wherever one was needed, and a copy that is
overlooked is a way out of a cell.  They have been gathered in one place, see
"Comparing the Ids of Two Tasks" in Documentation/security/credentials.rst, and the
rule about cells is applied there, once, ahead of every one of them.  That includes
the two that let euid 0 act on anybody: root on the host can neither have ``SIGIO``
sent to a task of a cell nor move one between cgroup v1 or resctrl groups.  This is a
hard boundary.  A cell that is not as it should be is killed and built again.

The owner and group permissions of a key likewise only count within the cell the key
was made in.

``PTRACE_TRACEME`` fails across cells.  The parent of a task that was spawned into a
cell is the spawner, outside.

The capability branch of each of these checks is unchanged for now.  See
`Not there yet`_.

Files
-----

A file can hand a process privilege at exec, by its set-id bits or by its file
capabilities.  In a cell both are impossible.

*Running.*  Every task of a cell has ``no_new_privs``, which cannot be unset and is
inherited.

*Writing.*  The ids of a cell commonly map to on-disk ids from 0 up, because that is
how images are stored.  A set-uid bit that the root of a cell sets would make a
set-uid root file for whoever else looks at that filesystem.  So:

* No task of a cell ever has ``CAP_SETFCAP``, not even in its bounding set, so it
  cannot write a file capability.
* ``S_ISUID``, and ``S_ISGID`` on anything but a directory, are silently dropped from
  the mode of what a task of a cell creates and from the mode it sets.  They are
  dropped and not refused so that unpacking an archive keeps working.
* The set-id bits and file capabilities of an existing file are dropped as soon as a
  task of a cell opens it for writing, or is given it open for writing.  A
  ``write()`` drops them, a store through a shared mapping does not.

``sudo``, ``su`` run by anybody but root, ``pkexec``, and tools that rely on a set-gid
bit or a file capability do not work in a cell.  A daemon that starts as root and
drops privileges with ``setuid()`` works as ever.

Unix sockets
------------

A unix socket can span two cells, because both can see the tree it is bound in or
because one end was given to a new task.  **Between cells it carries bytes and nothing
else.**

* Ancillary data is delivered only within a cell.  Every message records the cell it
  was sent from, and whoever receives it gets the files, the credentials, the pidfd
  and the security label only if that is its own cell.  This covers a file that was
  queued on a socket before the socket was given away.
* Sending control data to a socket that another cell holds fails with ``EPERM``, where
  that can be known at the time.
* ``SO_PEERCRED``, ``SO_PEERGROUPS``, ``SO_PEERPIDFD`` and ``SO_PEERSEC`` fail with
  ``ENODATA`` if the peer is in another cell.  They fail rather than report the
  overflow ids: 65534 is a uid like any other inside a cell, and a server that lets
  in whoever has its own uid may well be running as it.  In a cell ``SO_PEERSEC`` also
  fails for a socket that has no peer credentials, such as a TCP connection.

Peer credentials are not a way to authorise anything between cells.  Protocols that
pass file descriptors to a service in another cell do not work.

The budget
----------

The budget of a cell bounds what the cell can use and is how the kernel finds every
task in it.  It belongs to one cell: when the slot is filled the cgroup must be empty,
have no children, and neither be nor lie within the budget of another cell.  Whoever
fills the slot needs everything that moving a task of its own there would take, and
must own the directory.

A task of a cell stays within the budget, whoever asks.  Nothing but a spawn gets a
task into one, kernel threads included.

A task of a cell changes nothing in cgroupfs outside of the budget, whatever the modes
say, whoever owns the cgroup and whoever opened the file.  It writes to no file, makes,
removes and renames no cgroup, and sets no mode, owner, time or extended attribute.  No
cgroup of a v1 hierarchy is within a budget.  Nor is anything in resctrl, where the same
goes.

On a cgroup v1 hierarchy a task of a cell is where its spawner was, and no request
moves it.  The kernel itself may: out of a cpuset that lost its last cpu, to the
nearest ancestor that has one.

Sealing hands the directory, ``cgroup.procs``, ``cgroup.threads`` and
``cgroup.subtree_control`` to the root of the cell.  The limits stay with whoever is
above.


The system calls
================

They are split by what they do, as the mount API is, so that "may look but not touch"
is a system call number: ``cell_info()`` changes nothing.  So is "may kill".

.. code-block:: c

   int cell_create(int parent, unsigned int flags);
   int cell_configure(int cfd, unsigned int cmd, const char *key,
                      const void *value, int aux);
   int cell_info(int cfd, struct cell_info *info, size_t size,
                 unsigned int flags);
   int cell_open(int cfd, unsigned int what, const char *key, const void *arg,
                 unsigned int flags);
   int cell_kill(int cfd, unsigned int flags);
   int pidfd_open(int cfd, unsigned int flags);    /* with PIDFD_EMPTY */
   int pidfd_configure(int pidfd, unsigned int cmd, const char *key,
                       const void *value, int aux);

``cell_create()``
  makes a new, empty cell and returns a cellfd, which is always close-on-exec.
  ``parent`` is ``CELL_SELF``.  It takes no privilege, but it makes a user namespace,
  and what applies to those applies here: ``user.max_user_namespaces``, the LSM hook,
  and no chrooted caller.

``cell_configure()``
  fills the slots of a cell that is being built, and seals it.  It is shaped like
  ``fsconfig(2)`` and data only goes in.

``cell_info()``
  reads from a cell.  The struct can grow: the caller says in ``mask`` what it wants,
  the kernel says there what it filled in, and in ``supported_mask`` what it knows of.
  With ``CELL_SELF`` for a cellfd it tells a task the id of its own cell.

``cell_open()``
  gets another file descriptor from a cell.  For now that is an nsfs file descriptor
  on the network (``"net"``) or pid (``"pids"``) namespace of a cell that is being
  built.  The namespace is made if the cell does not have it yet, which fills the
  slot.

``cell_kill()``
  kills a cell and everything in it, whatever state it is in.  It does not wait.

``pidfd_open()`` with ``PIDFD_EMPTY``
  returns a pidfd for a task that is yet to be, in the cell.

``pidfd_configure()``
  says what that task is to be like, and starts it.

A cellfd polls readable once the cell is dead, and ``read(2)`` then returns the wait
status of its first task as an ``int``, any number of times.  A cellfd can be passed on
but cannot be opened again through ``/proc/<pid>/fd``.

Every cell has a 64 bit id that is never reused.  It is the inode number of the
cellfd.

Example
-------

Error handling is left out.

.. code-block:: c

   unsigned int ids = 65536;
   int cfd, tree, pidns, fs, proc, ns, pidfd, status;

   cfd = cell_create(CELL_SELF, 0);
   cell_configure(cfd, CELL_SET_BINARY, "ids", &ids, sizeof(ids));

   /* The tree, from scratch.  The image becomes "/", for this cell. */
   struct mount_attr attr = {
           .attr_set  = MOUNT_ATTR_IDMAP,
           .userns_fd = cfd,
   };
   tree = open_tree_attr(AT_FDCWD, "/images/web", OPEN_TREE_CLONE,
                         &attr, sizeof(attr));

   /* A procfs for the pid namespace of the cell. */
   pidns = cell_open(cfd, CELL_OPEN_SLOT, "pids", NULL, 0);
   fs = fsopen("proc", 0);
   fsconfig(fs, FSCONFIG_SET_FD, "pidns", NULL, pidns);
   fsconfig(fs, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
   proc = fsmount(fs, 0, 0);
   move_mount(proc, "", tree, "proc", MOVE_MOUNT_F_EMPTY_PATH);

   ns = open_tree(tree, "", AT_EMPTY_PATH | AT_RECURSIVE | OPEN_TREE_NAMESPACE);

   cell_configure(cfd, CELL_SET_FD, "root", NULL, ns);
   cell_configure(cfd, CELL_SET_FD, "budget", NULL, cgroup_dirfd);
   cell_configure(cfd, CELL_SET_STRING, "hostname", "web-1", 0);
   cell_configure(cfd, CELL_CMD_SEAL, NULL, NULL, 0);

   pidfd = pidfd_open(cfd, PIDFD_EMPTY);   /* no task yet, the caller does not fork */

   pidfd_configure(pidfd, PIDFD_SET_STRING, "exec", "/usr/sbin/nginx", 0);
   pidfd_configure(pidfd, PIDFD_SET_BINARY, "argv", "nginx\0-g\0daemon off;", 21);
   pidfd_configure(pidfd, PIDFD_SET_FD, "1", NULL, log_fd);
   pidfd_configure(pidfd, PIDFD_SET_FD, "2", NULL, log_fd);
   pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0);

   read(cfd, &status, sizeof(status));     /* until the cell is dead */


Not there yet
=============

The first implementation is deliberately small.  It exists so that there is code to
argue about.

What a builder can still get wrong
----------------------------------

These are mistakes of a privileged builder, of the kind a container runtime can make
today.  None of them can be reached from the inside.

* There are no per-cell instances of procfs, sysfs, devtmpfs and cgroupfs.  The
  builder assembles those with what exists today, and can mount a procfs that shows
  the whole host.  The direction is for each of the four to take the cell as a mount
  parameter, show only what the cell holds, and be refused to a task of any other
  cell.
* There is no table of devices a cell may use.  The builder can put any device node
  into the tree.  Devices that create devices, such as ``loop-control``, must not be
  given to a cell.
* The list of files for a new task is only lightly filtered.  The builder can pass a
  plain directory of the host.
* A cellfd that sits in a message on a unix socket counts as held.  A builder that
  queues the cellfd of a cell on a socket, gives the other end to a task of that cell
  and closes the rest is left with a cell that nobody can reach.  It is killed when
  the message is read, since the file does not cross, or when the socket goes.

What does not work yet
----------------------

* **Spawning from the outside fails with** ``EBUSY`` **once the cell has enabled
  controllers on its budget**, by the rule that a cgroup with controllers enabled for
  its children has no tasks of its own.  An init that manages cgroups does that right
  away.  It needs a leaf below the budget for spawns to land in.
* **A cell with a block of ids cannot create a cgroup.**  The superblock of cgroupfs
  belongs to the host, so the ids of the cell cannot be stored there.  It needs
  cgroupfs to be idmappable.
* ``RLIMIT_NPROC`` is not applied to the uid that is set with ``cred``.
* The seccomp filters of a new task are not consulted for its first exec, see
  `Spawning: empty pidfds`_.
* There are no rights on a cellfd.  Every cellfd can do everything.
* Cells do not nest, since the ``spawn`` slot cannot be filled.
* Software that sandboxes itself with namespaces does not work in a cell, see
  `Namespaces`_.  What does it with seccomp or Landlock works.
* **Every task of a cell starts at the root of the cell and in the budget.**
  Containers that trust each other, as those of a pod do, belong in one cell: they
  share a pid namespace, can signal each other and pass each other files.  For each
  to have a root and a cgroup of its own, a spawn has to be able to name both.
* **What is counted per user is charged to whoever made the cell as well**, as with
  any user namespace.  One cell can use up the inotify instances of its maker, and
  with them those of every other cell that has the same maker.
* A cell cannot outlive its last cellfd, and there is no way to find one again by its
  id.  What is to run for long needs somebody who holds on to it for as long.
* Only x86 and the architectures that use the generic system call table are wired up.
* There are no LSM hooks for the new operations, other than those that come with the
  user namespace, the exec and the files.
* **A network namespace that is shared with a cell carries identities.**  Only unix
  sockets know about cells.  ``SCM_CREDENTIALS`` on a netlink socket says who sent a
  message, and ``NETLINK_USERSOCK`` lets any two tasks of a network namespace talk.

What is still decided the old way
---------------------------------

* **A capability in an ancestor user namespace still applies to what a cell owns.**
  Root on the host can signal and ptrace the tasks of a cell by pid and configure its
  network namespace.  Only the branch of each check that goes by a uid has been
  closed.
* Files in ``/proc/<pid>`` that are protected by nothing but their owner, such as
  ``oom_score_adj``, still go by the bare uid.
* A one-id cell shares the ``struct user_struct`` and the key quota of its maker.
* Nothing keeps root on the host from calling ``setresuid()`` with an id of a block
  that has been lent, or from mounting a filesystem with such an id for an option.
