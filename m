Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890679;
	b=bP9akYVneEmpj+0Rk6n760/NSV/q7NymBxMJzzIU5zefHs4ERwdMn5nTJfMOdKl7mVcf
	 faUKeP7dNjab7oqNjwLGy/tMPNs3SEk0rSdSYUgXdd+DMCBQxR6U777Ig4ZoQSZs8V1C3
	 SXkphvoJgbxnTHaWQ6d4YkNzXLREdGE7CCDbvIlqR34DfZDhPokhulShHviweiJ53jQOa
	 +G8N+f+vuvjuW551zl60idTxPy26dV6xbzIGcQy9d966qcGJp/0ZGUwk/WLara+3LwIcH
	 sKs6HTT7M3kHoDeBcWGfJuNZ2OyFgmkcpsk9+b7Gd+MSiccPiIuMLszY5nfq4twTOLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=6Lt0saW6nKevt/r6uqmz53xH/jUKC91LIaq40anXrPQ=;
	b=F+POxG7Xx7OvgFz2yNyUw9OA7Q2ktKRaFBKvotgoD7CNq7ueH6rqYUdbBNT5lqA9do63
	 E3x7I2aDATk3qYL38jkBc9VUK87etKiVCCfKtwlNs/iQGNkn+Ph+8PwLgml4zw22iJ3q7
	 iwmlY+H9uuSdX+aTPp3wSSAiz07VJIMt99nAz+HMgAwiQ3xug9TNJe4rck66tUoKKP1p7
	 1N2+wK8Rs1UgOj16wyfqPAZduNzEWDWhY6UZXkPfV8fWJpFX+lvnAAHjXe5VoJxzDbL2X
	 YlyZUppyTF0L6UyVsEld6QWu6MR1xTPbkvIUs8dxA4kBV1ic2xsEb7Yw1LCb8re+kRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=gyFQiLI7;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18955606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18955606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=gyFQiLI7
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-706113e92f9so1057626eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890677; x=1794495477; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6Lt0saW6nKevt/r6uqmz53xH/jUKC91LIaq40anXrPQ=;
        b=gyFQiLI7Z/d4xEw9nzxn11D3fHBwx8O+ZBqHTnJhkilllbr5M1W0D57ghByC7n8aoM
         /EXGS5afdwhfTkxYzg3tPQK/OmnuNQ43GyOlIb3Fv76YIs5ImWdPujfHlOFaWrBiU9kJ
         i8/PVhVp1pMEvuiUBZ43m7fMKzix/I8OaKx2ueJ/13AzyGHJsJV9M6j67GjfQkhfmY4p
         HEDOKSamhACW7GwDejK1MqfjwLoM6Dsz5RXTvyRQ9nMOcDPkwvT4t1lSGlxZ3q4cz8Vk
         SFyHQHe3dyaOJYImEOUZHZ4J3faMruDy83Byx1Kas4GDRpc1XB20BnOtCFHmDUg3+cK0
         NCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890677; x=1794495477;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6Lt0saW6nKevt/r6uqmz53xH/jUKC91LIaq40anXrPQ=;
        b=ITWk6qqBj+gtn+ZdUcGb1jpQXQYjZeYbzbFalyAdEV5x9Fp5s8ykOuKwjat86M9b0n
         rgi6H7l9rXpobyAV+9d1Q13rk0t6ha3cYvuS/bBg7Y3sz3hWkfZAZ/71Z8SEbBjLrKk0
         p1hTUgJVtAjY9rQgyMPAUnLzhAYzyVume/lDgl7U9UeaupLCttkVWnVEZO3Fu5Ks7Dyo
         mymWLEhBHs8Nwk/7LVTZW/cQcqiRwu7ytZKnxzBS5SenWxkv3nHbfBNL0nKyElh0qcm8
         DIh/vwd4qcRWs5fVAva8QI2tbEeWJ9sf6TV0VFJO5nkl0Nm6ineJA3RpFEh56XU3/gzo
         GT9w==
X-Gm-Message-State: APuU4Z8WFIAjMlOAypukE8c/dRxNcp33uW8+1x1J9Zt4IgXAURlFM0g4
	UXyh784Z+YkQDtjRN2IT2XFlXK9fXeUJUHFw9foi0xd5cQF1t5xMZ27Gnn9gLpEOM7o=
X-Gm-Gg: AYBFou3KwGD2VWgbiCDJgusX7dYoemGpe+F3mu55Tm+GhtYta6tr1THPUPZs5AFmiOO
	h8jt18Mjk3Acysrwm6/NGwm496Hk2iBCn4eTYcV5W2YMRdRsQz/w4EQpegneJfTzK+KGqlnAwgs
	wJ6Eau6z7uzPGi8kWb/26zYQhTz+CSpt3LCfulfE3QZaUcD4mUmk6BMk8p3nzgIJUZ1FzO/kUOs
	pqX0GCVAHOISKWJBrkALj5MBe23OFYdwIark2Ylm8Z7VZv5h4pppH8ytbK+XJDN0HuSxomcNp6o
	Ngeu1r06ahMlcBrmREc43AQss4EXyuCTpA9wcNdXhlGrE2iR2TtXZWeOa51slHjgQGabzAU1/iE
	3oolyKNDUjGeM/TRIs7NQvbM2sUyNCJBe8u6KjJC67/pLR3l9J62s82ANYLxazGDLSuDWz7cSTs
	+ewYKwp6S9jw/60yH7McgEMtj6WkoEbMuCqNeWxgIN9w2BJtrZ9YxR0DRM78sekMHnqBcYlvsuo
	FWPZEp2zBGc9otifdMQyM3E9hNPlN//YUPXZ3eoCg6bTsTW2dwgymKJKFcpchBjzGdHXFHHUytc
	k4enLpnoV1DRDaFh/NJbhj3ftgub6Q8ukof9i5cR+TjryQ==
X-Received: by 2002:a05:6820:607:b0:707:5453:73c5 with SMTP id 006d021491bc7-714f242152fmr12003437eaf.2.1793890676386;
        Thu, 05 Nov 2026 06:57:56 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716c129a718sm4338085eaf.6.2026.11.05.06.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:57:55 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v3 00/90] cells: a container as one kernel object
Date: Thu, 05 Nov 2026 14:56:51 +0000
Message-Id: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
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
X-B4-Tracking: v=1; b=H4sIAD6Z7GoC/02PzW7CMBCEXyXacy3stWNMrkh9gF4rDl57AVeQt
 HZAlRDvjvNz4Dij0TczDyicExfomgdkvqeShr4K/dFAOPv+xCLFqgElWqWkFmRE4MulCGWks24
 XpAkaavw38zH9z6hv+Prcw2Exy41+OIwTZIqRLywo+z6cJ4vMZnYW5tCLkDnWzrIiM//d6qhx5
 S7Z4XpNY9dYi4630QRL2AYXlTsqbVrWHmVE5XDnPW/ZwPuZrpmvSOXmK2ubYJKKkLRr0XR3hMP
 z+QJe3ZgLHAEAAA==
X-Change-ID: 20261103-b4-cells-1408689c04c3
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890669; l=33823;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=zsZcxK0TQCoFYHsDPewfVBsWUs9+7QbAyeTKindp22c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDXOoOajeM3jDo2BwccA7h6IOtP7oh04+mLyepc5/bNJH8Pj9xWu2veZrLB8MGnRezPuo01Rq1A
 3/E4WDSOwdgI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261019-cells-rfc-6f4c85415f29@toxicpanda.com/
v2: https://lore.kernel.org/all/20261026-cells-rfc-v2-b41d7e0c95a3@toxicpanda.com/

v2->v3:
- It's the patches this time and not a link to a branch, 90 of them on
  top of v2 of the cred series [2]. Sorry. I tried to post it in pieces,
  and every cut either left a first series that wasn't a boundary yet or
  needed the core rewritten. So it's one series, grouped so that you can
  find your part, see below.
- What a cell may do to its network is a slot, "net-rights", and not
  CAP_NET_ADMIN. This is the big one, see below. A network namespace
  that the cell owns, which v2 had as an option, is gone.
- No capabilities unless the builder names them in the new "caps" slot,
  which is the bounding set as well. uid 0 of a cell comes with nothing.
- File capabilities are ignored in a cell, and a cell can drop from its
  bounding set without CAP_SETPCAP.
- A spawn can name the cgroup it starts in, at or below the budget, so
  spawning into a cell that runs systemd works. (James, Christian)
- A cell can make cgroups below its budget. It can't touch the limits of
  the budget itself.
- The host runs no usermode helper for a task of a cell, so no modprobe
  and no request-key, and a core dump doesn't go to a pipe or a socket.
- cell_info() tells the builder which block of ids the cell got, for
  netfilter and routing rules that go by uid.
- A uid= or gid= mount option can't name an id of a cell.
- The owner and the group of a tun device only count in the cell that
  set them. A cell of one id could attach to the tap devices of its
  maker.
- New document with examples, patch 2.
- Rewrote the commit messages, and reordered the series by topic.
- Rebased onto v7.4-rc1.

v1->v2:
- Spawning is an empty pidfd, pidfd_open(cellfd, PIDFD_EMPTY) and
  pidfd_configure(). CLONE_EMBRYO and task_configure() are gone and
  clone3() is untouched. (Christian)
- cell_kill() is a system call of its own.
- A pod is one cell and not several that share a network namespace.
  (Andrew, James)
- The network is set up from the outside and handed to the cell, like
  the mount tree.
- No "net" slot means no network, no sockets but AF_UNIX.
- A cell changes nothing in cgroupfs outside of its budget and nothing
  in resctrl, which took a hook in kernfs.
- CLONE_NEW* being EPERM in a cell is written down as a position and not
  as something that is missing. (Andrew)
- Fixed SO_PEERPIDFD and friends racing with connect(), and files owned
  by an id of a cell being left behind outside of the budget.

What it does now:

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
scratch by the builder and the cell can't mount. The network is set up
by the builder. A new task starts with no mm and no files, so what it
has is what you gave it. It has no capability that the builder didn't
name. Say nothing about the network and there is none.

Spawning is pidfd_open(cellfd, PIDFD_EMPTY), which returns a pidfd that
no task is attached to yet, pidfd_configure() to say what the task is to
be like, and PIDFD_CMD_START to make it.

The branch has the cred series in it, and what v2 described is tagged
cells-rfc-v2 in the same tree.

  https://github.com/josefbacik/linux/commits/cells/
  git fetch https://github.com/josefbacik/linux.git cells

The network:

Patches 73-85. I expect this to be the part people have opinions about,
so it's all in one place and nothing before it depends on it.

Nearly everything that changes a network namespace is behind
ns_capable(net->user_ns, CAP_NET_ADMIN). That's well over a hundred
checks, for devices, addresses, routes, netfilter, tc, tunnels, IPsec,
socket options and so on, and none of them says which of those it is
for. So a container that needs to add one iptables rule gets all of it,
and to have any of it, it has to own the network namespace, which means
the runtime can't set that namespace up with the tools it has.

Patches 75-82 don't know about cells and change no behaviour. They add
net_may(net, right), where the right says what the check is for: link,
link-new, addr, route, filter, tc, tun, sysctl, sockopt, raw. It comes
down to the same capability over the same user namespace as before.
About fifty checks are converted, the ones behind rtnetlink, the old
ioctls, nfnetlink and the xtables sockopts, tun, the net sysctls, socket
options, and raw and packet sockets.

Then a cell gets the "net-rights" slot (83), and net_may() learns one
rule (84): for a task of a cell it takes the right in the slot, on the
network namespace in the cell's "net" slot and no other, and the
capability in the cell's own user namespace. The slot says what the cell
may do, the capability says who in the cell may do it, so an init
container can add its rules and drop CAP_NET_ADMIN, and LSMs and audit
see the check they have always seen.

The namespace stays the runtime's, CNI sets it up as ever and can go
back in at any time. A check that nobody has converted keeps asking for
the capability over the owner, which no task of a cell has, so what
nobody has thought about is refused. And you can only grant what you
could do yourself.

I have not cc'd netdev on this round, I would like to hear from the
people who have been following along first. What I will be asking them:

 - Is naming what a CAP_NET_ADMIN check is for something they would take
   at all, cells or no cells? It seems useful to me on its own, an LSM
   could go by it for one. If the answer is no I need a different plan.
 - Are the rights cut in the right places? They follow the entry points,
   because that's where the checks are. "filter" is all of netfilter as
   far as it is per namespace, which is a lot of code for one bit.
 - rtnetlink. RTM_NEWLINK both changes a device and makes one, so the
   gate takes either right and __rtnl_newlink() checks the one that
   applies once it has looked. And a request can name another namespace
   as its target by nsid, which anybody can read off of a veth, so the
   check has to be about the target. It is, and there's a test that
   makes a device on the host if it isn't, but I would like somebody who
   knows that code to look at it.

What I would like opinions on:

 - Sealed means sealed. A runtime that wants the network namespace
   later, for CNI DEL say, keeps the file it got while building. A cell
   that dies takes its network along, and ptp's DEL without the
   namespace succeeds, gives the address back and leaves its masquerade
   rules on the host. I think "keep the file" is the right answer, the
   alternative is a dead cell that still holds things.
 - Pods. The "cgroup" key is in. The "root" key, a directory in the
   cell's tree for a spawn to start in, is still not written.
 - Capabilities and a cell of one id. Its tasks aren't uid 0 in there,
   so they would lose whatever they were given at the first exec. The
   seal refuses capabilities for such a cell rather than let them
   vanish. That means an unprivileged user's cell can't have any, unless
   it has a block.
 - Still open, the long versions are in v2: namespaces inside of a cell
   for bubblewrap and chrome (3), one static struct net for cells
   without a network (4), ucounts rolling up to the maker (5), the id
   window versus a separate id space (6), capabilities held in an
   ancestor user namespace (7), MNT_LOCKED (8), seccomp and
   PIDFD_CMD_START (9), and parking a cellfd somewhere (10).

How this is laid out:

One logical thing per patch, and more than half of them are 50 lines or
less. 5,600 lines of kernel, 1,400 of documentation, 6,900 of tests.

    1-2    The design document and a page of examples. Start here.
    3-11   The user namespace of a cell and the ids the kernel lends
           it. user_namespace, ucount, keys.
   12-15   Those ids never end up on a filesystem the cell does not
           own. vfs.
   16-20   Helpers for the budget. cgroup.
   21-23   Helpers for the tree and the namespaces. vfs, nsproxy.
   24-33   The cell: the object, cell_create(), cell_kill(),
           cell_configure(), the slots it cannot do without, the seal,
           cell_open().
   34-46   Spawning: empty pidfds and pidfd_configure(). pid, fork,
           x86, uprobes, pidfd, ptrace.
   47-51   Nobody gets in and nobody gets out. nsproxy, vfs, cgroup.
   52-57   A cell runs the cgroups below its budget and touches nothing
           else. kernfs, cgroup, resctrl.
   58-60   A uid means nothing across cells. cred, ptrace, keys.
   61-63   A tree that belongs to the cell, and nothing a cell writes
           imparts privilege. vfs.
   64-66   Capabilities: none unless the builder names them.
   67-70   What does not cross on a socket or through a seccomp
           listener. af_unix, net, seccomp.
   71-72   The host runs no program on behalf of a cell.
   73-85   The network, all of it. net, netfilter, tun. See above.
   86-90   cell_info(), Kconfig, the syscall tables, MAINTAINERS and
           the tests.

CONFIG_CELLS doesn't exist until near the end, so everything before that
builds as stubs, and every commit builds on its own, with the option off
and with the cells code forced on.

Testing: the selftests are seven programs and 100 tests now. I've run
them under KASAN, lockdep and DEBUG_VFS in qemu, on tmpfs, ext4 and 9p,
and built it with gcc and clang and with the option off. I've booted
systemd 255 in a cell to multi-user.target, with units under other users
and limits of their own, and shut it down in order. I've set up pod
networking with the reference CNI plugins, which work unchanged, and in
a namespace that ptp set up I've run nft and iptables with "filter" and
nothing else, a VPN style tun with tun, link, addr and route, a tap and
a bridge for a VMM with tun, link and link-new, and something like a CNI
agent in the host's namespace. What all of that took is in the examples.
The resctrl patch is compile tested only. It has still not been near
real hardware, a real runtime or a benchmark. Only x86 and the generic
syscall table are wired up. There are no rights on the cellfd and no LSM
hooks of our own. "Not there yet" at the end of the document is the full
list.

[2] https://lore.kernel.org/all/20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com/

--- Original email (v1) ---

Hello,

This is the thing Christian and I and a few others have been going back
and forth on, a container as one kernel object instead of a pile of
namespaces that userspace holds together. I have a barebones
implementation of it. It's 62 patches on top of the 13 patch cred series
[1], and I don't think anybody wants that in their inbox for what is at
this point a design discussion, so the code is in a branch, and what's
in this email is the pitch, the things I would like opinions on, and the
design document from the branch in full at the bottom so you can quote
it and yell at specific lines.

  https://github.com/josefbacik/linux/commits/cells/
  git fetch https://github.com/josefbacik/linux.git cells

That's 6cbfd1952c30 as I write this, based on vfs.all. "Cell" is a
placeholder name, I don't love it, suggestions welcome.

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
leaves it, and nothing can enter one, so there is no setns() and no
unshare(). You build it from the outside by filling named slots from
file descriptors you already hold, you seal it, and then you spawn tasks
into it. Holding the cellfd is the authority to do all of that, there is
no uid or capability check on it, and making one takes no privilege. The
cell lives exactly as long as somebody holds the cellfd, when the last
one goes the cell is killed.

Spawning is the other half. clone3(CLONE_EMBRYO) gives you a pidfd on a
task that exists but has never run anything, you set it up with
task_configure() the way you would set up a mount with fsconfig(), and
then you start it and it execs. It starts with no mm and no files, so
what it has is what you gave it. I think this is useful without cells at
all and would like to send it on its own eventually.

A few rules fall out of wanting the boundary to actually mean something.
The kernel allocates the kuids for a cell out of a reserved window, the
builder never names one, and those ids can never be stored on a
filesystem the cell doesn't own. A uid means nothing across cells, not
an equal one and not 0. Files impart no privilege, every task has
no_new_privs, and set-id bits get dropped on anything a cell creates,
chmods or opens for writing. Unix sockets carry bytes between cells and
nothing else, no SCM_RIGHTS and no peer credentials. The mount tree is
built from scratch, nothing in it hides anything, and nothing propagates
into it.

What I would like opinions on
-----------------------------

1. The shape. One object, born in it and never leaves, nothing enters,
   built from the outside out of fds, authority is the fd. If you think
   this is the wrong shape then the rest doesn't matter, so start here.

2. The id window. Blocks of 65536 kuids come out of the upper half of
   the id space, and "nobody else holds an id of this block" is what
   replaces the privilege check for mapping a range, so it has to be
   enforced. With CONFIG_CELLS on the host can't chown a file to an id
   of 2^31 or above anymore, because the check has to go by value. This
   is the one I expect to get yelled at for, and I'm open to better
   ideas.

3. Capabilities. A capability held in an ancestor user namespace still
   applies to what a cell owns, so root on the host can still signal and
   ptrace by pid. In the checks that let one task act on another I
   closed the branch that goes by a uid, euid 0 included, and left the
   capability branch alone. I would like the boundary to be hard in both
   directions, you hold the cellfd or you have nothing, but that is a
   much bigger conversation. How far do we want to go?

4. MNT_LOCKED (Christian, this one is for you). The seal refuses a tree
   with a locked mount in it, since a locked mount hides what it covers.
   But for a builder that works in a user namespace of its own, the
   kernel locks the tree itself onto the empty root of a namespace made
   with FSMOUNT_NAMESPACE or OPEN_TREE_NAMESPACE, so an unprivileged
   builder could never seal anything. I exempted exactly that mount, on
   the grounds that there is nothing under it to hide. Is that right, or
   should it not be locked there to begin with?

5. seccomp. An embryo inherits the filters of whoever made it and they
   apply to everything the new program does, but they are not consulted
   for what TASK_CMD_START does on the way there, because the exec isn't
   a system call of the embryo. So a filter that denies execve() and
   execveat() to keep a task from running another program has to learn
   about task_configure() as well, same as it once had to learn about
   execveat(). This is only about tasks of the host, a task of a cell
   can't spawn at all. Documented for now. Good enough, or do we run the
   filters at the start?

6. Lifetime. A cell dies with its last cellfd, there is no opt out and
   no way to look one up by id. An earlier version had this as a flag,
   and without it you ended up with a running cell that nobody held, so
   nothing could spawn into it or wait for it, and killing it meant
   going around it by pid or cgroup. You can pass the fd to a
   supervisor. I would rather add the foot gun later if somebody really
   needs it.

7. The budget. Spawning from the outside fails with EBUSY once the cell
   enables controllers on its own cgroup, which systemd does right away.
   It needs a leaf below the budget for spawns to land in. Does the
   kernel make that leaf, or is it a convention for the builder? Also a
   cell with a block of ids can't mkdir in cgroupfs until cgroupfs can
   be idmapped.

8. procfs, sysfs, devtmpfs and cgroupfs. There are no per-cell instances
   yet, the builder assembles those with what exists today and can get
   it wrong the same way a runtime can today. Where I want to go is each
   of the four taking the cell as a mount parameter and showing only
   what the cell holds. That's a lot of work and I wanted this out
   first, but I would like to know if anybody hates the direction.

9. The API. Five system calls, cell_create(), cell_configure(),
   cell_info(), cell_open() and task_configure(), no ioctls, with string
   keys in the style of fsconfig(). The right to spawn is a slot as
   well, reserved and always empty for now, which is why cells don't
   nest. We do want unprivileged things to be able to build smaller
   cells out of what they hold eventually, but it touches ids, cgroups
   and mounts all at once and I left it out.

How to read the branch
----------------------

It's one logical thing per patch and more than half of them are 50 lines
or less, so it is less than it sounds like. The first 13 are the cred
series [1]. Read the document, then these are the ones with the design
in them:

  3c1f5defa226 user_namespace: let a cell own a user namespace
  380bd1bf37a7 fs: seal a mount namespace for a cell
  0837cfd6d117 cells: add the cell object and cell_create()
  1c42ab4f15a9 cells: add cell_configure()
  cef86b491459 cells: lend a cell a block of ids
  253d7f9627c0 fork: let copy_process() place a task in a cell
  424a90b3e37a fork: add CLONE_EMBRYO
  8bef8549476e fork: add task_configure()

The rest are helpers in cgroup, fs and nsproxy ahead of those, and the
rules of the boundary after them, one rule per patch. The uid rule is
the reason for the cred series: with the dozen hand rolled copies of
"the uids match so you can mess with that task" in one place, it is one
small patch,

  5372a6763133 cred: let no id count across cells

CONFIG_CELLS doesn't exist until near the end, so everything before that
builds as stubs, and every commit builds on its own. The last patch is
the selftests, 47 of them.

State
-----

I've run the selftests under KASAN, lockdep and DEBUG_VFS in qemu, on
tmpfs, ext4 and 9p, and built it with gcc and clang and with the option
off. It has not been near real hardware, a real runtime or a benchmark.
Only x86 and the generic syscall table are wired up. There are no rights
on the cellfd and no LSM hooks of our own. "Not there yet" at the end of
the document is the full list, and I tried to be honest in it. This is
an RFC in the truest sense, the point is to have code to argue about, so
please argue. Thanks,

Josef

[1] https://patch.msgid.link/20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Josef Bacik (90):
      Documentation: add a design document for cells
      Documentation: add examples for cells
      cells: reserve a window of ids
      user_namespace: let a cell own a user namespace
      user_namespace: refuse setns() into a cell
      capability: give the owner no say over a cell
      ucount: count the id blocks a user holds
      user_namespace: let the kernel map the ids of a cell
      user_namespace: keep legacy maps out of the window
      user: add uid_range_in_use()
      keys: add key_user_range_in_use()
      fs: add kuid_has_fsmapping() and kgid_has_fsmapping()
      fs: never store an id that was lent to a cell
      fs: take no id of a cell for a mount option
      fs: let an idmapping pin the ids of a cell
      cgroup: let a cgroup become the budget of a cell
      cgroup: add cgroup_cell_chown()
      cgroup: give the budget of a cell back
      cgroup: add cgroup_cell_kill()
      cgroup: root a cgroup namespace at a given cgroup
      fs: seal a mount namespace for a cell
      nsfs: make open_namespace() available outside of fs/
      nsproxy: build the nsproxy the tasks of a cell share
      cells: add the cell object and cell_create()
      cells: add cell_kill()
      cells: add cell_configure()
      cells: add the "budget" slot
      cells: add the "root" slot
      cells: add the "ids" slot, for a single id
      cells: lend a cell a block of ids
      cells: reserve the "spawn" slot
      cells: add CELL_CMD_SEAL
      cells: add cell_open()
      pid: allocate a struct pid ahead of its numbers
      fork: let copy_process() place a task in a cell
      cgroup: fork a task of a cell into the budget
      x86: give a task without an mm no user state
      uprobes: cope with a new task that has no mm
      fork: add tasks that start out with nothing
      pidfd: add PIDFD_EMPTY
      pidfd: add pidfd_configure()
      pidfd: let pidfd_configure() place files
      pidfd: let pidfd_configure() set credentials
      pidfd: let pidfd_configure() name a cgroup to start in
      ptrace: keep everybody off an embryo
      cells: end a cell when its init exits
      cells: refuse a task of a cell a change of namespaces
      fs: refuse a task of a cell a new mount namespace
      nsproxy: refuse to enter a namespace of a cell
      cgroup: keep a task of a cell within the budget
      cgroup: let nothing but a spawn into a budget
      kernfs: let a filesystem refuse a change to a node
      cgroup: let a cell change nothing outside its budget
      cgroup: leave the limits of a budget to who is above
      fs: let a filesystem hold ids that go with the cell
      cgroup: let a cell make cgroups below its budget
      resctrl: let a cell change nothing
      cred: let no id count across cells
      ptrace: refuse PTRACE_TRACEME across cells
      keys: ignore an equal uid or gid across cells
      fs: accept a cellfd for MOUNT_ATTR_IDMAP
      fs: let a cell set no set-id bits
      fs: drop privileges from what a cell may write to
      cells: add the "caps" slot
      capabilities: take nothing from a file in a cell
      capabilities: let a cell shrink its bounding sets
      af_unix: deliver ancillary data only within a cell
      af_unix: tell a sender that control data will not cross
      net: do not identify a peer in another cell
      seccomp: let a listener put no file into a cell
      umh: run no program for a task of a cell
      coredump: let no core dump leave a cell
      cells: add the "net" slot
      net: give a cell without a network no sockets
      net: add net_may()
      rtnetlink: use net_may() for requests that change state
      net: use net_may() in the configuration ioctls
      netfilter: use net_may() for configuration
      tun: use net_may() to create and attach to devices
      net: use net_may() for the net sysctls
      net: use net_may() for privileged socket options
      net: use net_may() for raw and packet sockets
      cells: add the "net-rights" slot
      net: honour the rights of a cell in net_may()
      tun: ignore an equal uid or gid across cells
      cells: add cell_info()
      cells: add CONFIG_CELLS
      arch: wire up the cell system calls
      MAINTAINERS: add an entry for cells
      selftests: add tests for cells

 Documentation/userspace-api/cells-examples.rst    |  551 +++++++
 Documentation/userspace-api/cells.rst             |  861 +++++++++++
 Documentation/userspace-api/index.rst             |    2 +
 MAINTAINERS                                       |   14 +
 arch/x86/entry/syscalls/syscall_32.tbl            |    6 +
 arch/x86/entry/syscalls/syscall_64.tbl            |    6 +
 arch/x86/include/asm/shstk.h                      |    2 +
 arch/x86/kernel/process.c                         |   24 +-
 arch/x86/kernel/shstk.c                           |   14 +
 drivers/net/tun.c                                 |   17 +-
 fs/Makefile                                       |    2 +
 fs/attr.c                                         |   13 +-
 fs/cellfs.c                                       |  141 ++
 fs/coredump.c                                     |    8 +
 fs/fs_parser.c                                    |    7 +
 fs/fuse/inode.c                                   |    4 +-
 fs/inode.c                                        |   61 +
 fs/internal.h                                     |    3 +-
 fs/kernfs/file.c                                  |    5 +
 fs/kernfs/inode.c                                 |   25 +
 fs/kernfs/kernfs-internal.h                       |   11 +
 fs/mnt_idmapping.c                                |   36 +
 fs/mount.h                                        |    3 +
 fs/namei.c                                        |   11 +-
 fs/namespace.c                                    |  160 +-
 fs/nsfs.c                                         |    6 +-
 fs/overlayfs/copy_up.c                            |    4 +-
 fs/pidfs.c                                        |   31 +-
 fs/posix_acl.c                                    |    4 +-
 fs/resctrl/rdtgroup.c                             |    8 +
 include/linux/cell.h                              |  312 ++++
 include/linux/cell_ids.h                          |  103 ++
 include/linux/cgroup-defs.h                       |    3 +
 include/linux/cgroup.h                            |    8 +
 include/linux/cred.h                              |    3 +-
 include/linux/fs.h                                |   44 +-
 include/linux/fs/super_types.h                    |    1 +
 include/linux/kernfs.h                            |   15 +
 include/linux/key.h                               |    3 +
 include/linux/mnt_idmapping.h                     |   44 +-
 include/linux/mnt_namespace.h                     |    6 +
 include/linux/netlink.h                           |    2 +
 include/linux/nsfs.h                              |    1 +
 include/linux/nsproxy.h                           |   11 +-
 include/linux/pid.h                               |   13 +-
 include/linux/sched.h                             |    6 +
 include/linux/sched/task.h                        |    7 +
 include/linux/sched/user.h                        |    1 +
 include/linux/syscalls.h                          |   14 +
 include/linux/user_namespace.h                    |   18 +
 include/net/af_unix.h                             |    4 +
 include/net/net_namespace.h                       |   25 +
 include/net/sock.h                                |    1 +
 include/uapi/asm-generic/unistd.h                 |   15 +-
 include/uapi/linux/cell.h                         |   81 +
 include/uapi/linux/fcntl.h                        |    1 +
 include/uapi/linux/magic.h                        |    1 +
 include/uapi/linux/pidfd.h                        |   18 +
 init/Kconfig                                      |   16 +
 kernel/Makefile                                   |    1 +
 kernel/bpf/inode.c                                |    4 +-
 kernel/cell/Makefile                              |    6 +
 kernel/cell/boundary.c                            |  125 ++
 kernel/cell/core.c                                |  481 ++++++
 kernel/cell/ids.c                                 |  218 +++
 kernel/cell/internal.h                            |   67 +
 kernel/cell/slots.c                               |  480 ++++++
 kernel/cell/spawn.c                               |  211 +++
 kernel/cgroup/cgroup-internal.h                   |    1 +
 kernel/cgroup/cgroup-v1.c                         |    1 +
 kernel/cgroup/cgroup.c                            |  339 +++++
 kernel/cgroup/namespace.c                         |   44 +
 kernel/cred.c                                     |   49 +-
 kernel/cred_kunit.c                               |    5 +
 kernel/embryo.c                                   |  764 ++++++++++
 kernel/events/uprobes.c                           |    4 +
 kernel/exit.c                                     |   14 +
 kernel/fork.c                                     |   88 +-
 kernel/nsproxy.c                                  |  107 +-
 kernel/pid.c                                      |   98 +-
 kernel/ptrace.c                                   |   16 +
 kernel/seccomp.c                                  |   12 +
 kernel/sys_ni.c                                   |    6 +
 kernel/ucount.c                                   |    3 +
 kernel/umh.c                                      |    9 +
 kernel/user.c                                     |   32 +
 kernel/user_namespace.c                           |  146 +-
 mm/shmem.c                                        |    4 +-
 net/bridge/netfilter/ebtables.c                   |    4 +-
 net/core/dev_ioctl.c                              |    4 +-
 net/core/net_namespace.c                          |   66 +
 net/core/rtnetlink.c                              |   60 +-
 net/core/sock.c                                   |   83 +-
 net/ipv4/af_inet.c                                |    2 +-
 net/ipv4/arp.c                                    |    2 +-
 net/ipv4/devinet.c                                |    6 +-
 net/ipv4/fib_frontend.c                           |    2 +-
 net/ipv4/ip_options.c                             |    8 +-
 net/ipv4/ip_sockglue.c                            |    4 +-
 net/ipv4/netfilter/arp_tables.c                   |    4 +-
 net/ipv4/netfilter/ip_tables.c                    |    4 +-
 net/ipv6/addrconf.c                               |    4 +-
 net/ipv6/af_inet6.c                               |    2 +-
 net/ipv6/datagram.c                               |    6 +-
 net/ipv6/ipv6_sockglue.c                          |    7 +-
 net/ipv6/netfilter/ip6_tables.c                   |    4 +-
 net/ipv6/route.c                                  |    2 +-
 net/netfilter/ipset/ip_set_core.c                 |    2 +-
 net/netfilter/nfnetlink.c                         |    2 +-
 net/netlink/af_netlink.c                          |   21 +
 net/packet/af_packet.c                            |    2 +-
 net/socket.c                                      |   28 +
 net/sysctl_net.c                                  |    2 +-
 net/unix/af_unix.c                                |  113 +-
 net/unix/af_unix.h                                |   14 +-
 scripts/syscall.tbl                               |    6 +
 security/commoncap.c                              |   21 +-
 security/keys/key.c                               |   40 +
 security/keys/permission.c                        |    7 +
 tools/testing/selftests/Makefile                  |    1 +
 tools/testing/selftests/cell/.gitignore           |    2 +
 tools/testing/selftests/cell/Makefile             |   14 +
 tools/testing/selftests/cell/cell_boundary_test.c |  535 +++++++
 tools/testing/selftests/cell/cell_cgroup_test.c   |  546 +++++++
 tools/testing/selftests/cell/cell_child.c         | 1626 +++++++++++++++++++++
 tools/testing/selftests/cell/cell_ids_test.c      |  762 ++++++++++
 tools/testing/selftests/cell/cell_life_test.c     |  446 ++++++
 tools/testing/selftests/cell/cell_net_test.c      |  915 ++++++++++++
 tools/testing/selftests/cell/cell_slots_test.c    |  748 ++++++++++
 tools/testing/selftests/cell/cell_spawn_test.c    |  559 +++++++
 tools/testing/selftests/cell/cell_test.h          |  586 ++++++++
 tools/testing/selftests/cell/cell_util.h          |  108 ++
 tools/testing/selftests/cell/config               |   35 +
 133 files changed, 13426 insertions(+), 141 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-b4-cells-1408689c04c3
prerequisite-change-id: 20261018-b4-cred-ids-eb01b2b38524:v2
prerequisite-patch-id: 8c80879ddb5001edd272dcb0c64d7d196cbd967f
prerequisite-patch-id: 5d990d2b1fce14667ea5b7240d82dee380bc9571
prerequisite-patch-id: 71798c0f95cf38c21735affa9479ced238d80db0
prerequisite-patch-id: c506972ae7fdf17afdddbf134c6d3e6328425506
prerequisite-patch-id: d8cc6bbfc2b70fb1b08f6f90080b07dc1fc6e568
prerequisite-patch-id: d6ac288cbce55962a8677270deb9248ea9b865ad
prerequisite-patch-id: a088d829b21a605a678ef6225b8b0d9529a7c719
prerequisite-patch-id: 9d33de3e73545d64039b5ab0020e17d84c29ef31
prerequisite-patch-id: 19e1b4d88b8af7fc24061f3c3becb3480fa33557
prerequisite-patch-id: d6c92fa03be2a3c1511da11d561679aee6a957ea
prerequisite-patch-id: 03b389cf65fe7242391c1e7b55d8714e09662b94
prerequisite-patch-id: ee84977e58369ad065a9e5a0870a9780ad57e6e3
prerequisite-patch-id: f8529903a8bbafdb11208eaf671af625031afd92

