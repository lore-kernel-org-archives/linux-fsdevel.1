Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4DA5581FB;
	Wed,  9 Sep 2026 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957741; cv=none; b=bgqHZ+Ll72GHefqEIW8GQ63tgdvClxkCqp1KGBrhnlH46ltC5icAoj3lCzaOqxtzjBFq4DLKeqDwQKL134Kcl4xRitmsiqzngZkVeNj4RpKNGtcvVKbyqDIOdfAn3iK4LQpOssz5jJKutMiQQ63ocYXEJymCOL3U8DZHzcioCCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957741; c=relaxed/simple;
	bh=NY5kkXrnZzZgiNLFun8C7Lr1re+TSRpPdQy0gKiyCxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsHh2A0wVRpqSMI1VdmZ0c+5rfazE73wmjO05FZUEZMgmZlBhP/oQF2RB5bqbXH+AKm4jNfCDsmBuHH8+z8y0tdXQNJ6pZ18EwpogLK8UxU9992LgzTBrdWP1heSaNA77y3qoCqC0aaE0b3wDqK61Z+6UDdSrZKcE9BtmjXs2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj6jKoa/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj6jKoa/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FD51F00A3A;
	Wed,  9 Sep 2026 12:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957740;
	bh=PzrFCfaRwUPe/W44IVH55NxsQ4oS2KmOl4ikIySWXXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mj6jKoa/E+1Y1ng+DBulHZL2CsdA+w+cysWTVP9I7XnRCr/snpaqH5OVp8ugfox+Q
	 sm9DdRq7tMchvorL3oPmolchcLnpL3gqGrH7GOVNwNcjBlvirT3xvldumFKO/fQ3oV
	 QrL8PNFCcyv6+QJPvdoPOb8+ycwWV23iWhqJCH45Dl9YpNUQ8pv8teA9WEoJ9cn+uO
	 rmVsaorHf8s76hOqViprmfaiYccLrmy4LEGfuNqqprR2pNXEj0NHp0/7jGzMHNeZpB
	 y6ln0t5DvRogREfD1gt/3ber4Yrba4s30WJgNBWg5kH3upUqJDqFUbqlaetH1xWZdA
	 nq9WoIGL3c1JA==
From: Christian Brauner <brauner@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v2 00/10] net: support thread-specific pidfds for send and connect
Date: Wed,  9 Sep 2026 14:40:25 +0200
Message-ID: <20260909-vorkommen-einwickeln-entspannen-fb7fb4e29575@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2547; i=brauner@kernel.org; h=from:subject:message-id; bh=NY5kkXrnZzZgiNLFun8C7Lr1re+TSRpPdQy0gKiyCxg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtDFG6cehOsdfexKJUhaXBcxczTz585WaNS3+qKLffn 8vT11w17ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjII11Ghosmk71PGSxITTTW 3asup87SdZvh19ZVYff2Xp3fOH+JawUjQ//THLdDHCELVc1yVY9fX2PvO2em3/tTLtOvem+azFH GzggA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 09 Sep 2026 12:42:59 +0200, Christian Brauner wrote:
> SO_PASSPIDFD/SCM_PIDFD and SO_PEERPIDFD allow to retrieve a pidfd for
> the thread-group leader. The coredump server using the coredump socket
> cannot get a handle on the task that took the signal and is writing the
> coredump easily. Workloads interested in per-thread authentification
> have similar problems.
> 
> Add SO_PASSPIDFD_THREAD and SO_PEERPIDFD_THREAD. We record the sending
> and the connecting thread in addition to the thread-group leader.
> 
> [...]

@Jakub, shared branch in vfs-7.4.shared.net-next.pidfd. I'm open to rebasing if
you have need for that on your end during the cycle.

---

Applied to the vfs-7.4.shared.net-next.pidfd branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.shared.net-next.pidfd branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.shared.net-next.pidfd

[01/10] pid: add helpers to operate on a struct pid array
        https://git.kernel.org/vfs/vfs/c/b674dcb18f1d
[02/10] af_unix: record the pid of the sending thread
        https://git.kernel.org/vfs/vfs/c/a8575fe8b94e
[03/10] net: add SO_PASSPIDFD_THREAD to get a thread-specific SCM_PIDFD
        https://git.kernel.org/vfs/vfs/c/78dc8469581d
[04/10] selftests/net: SO_PASSPIDFD_THREAD
        https://git.kernel.org/vfs/vfs/c/7810049c5675
[05/10] net: turn sk_peer_pid into an array indexed by pid type
        https://git.kernel.org/vfs/vfs/c/0149a6ceaf8f
[06/10] af_unix: record the pid of the connecting thread
        https://git.kernel.org/vfs/vfs/c/4dd362b00be5
[07/10] net: add SO_PEERPIDFD_THREAD to get a thread-specific pidfd
        https://git.kernel.org/vfs/vfs/c/41972f2e5ab0
[08/10] selftests/net: SO_PEERPIDFD_THREAD
        https://git.kernel.org/vfs/vfs/c/6e8bef9686e4
[09/10] pidfs: record the coredump on the dumping thread's pid too
        https://git.kernel.org/vfs/vfs/c/52671ec3712c
[10/10] selftests/coredump: check the dumping thread's pidfd
        https://git.kernel.org/vfs/vfs/c/b956027e73be
