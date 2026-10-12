Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1481746F4A2;
	Mon, 12 Oct 2026 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795649; cv=none; b=F0WEs1pqCIPHWxCaGcTUlrRO5ftLK7ylyndouZdRldSSE9xhnm+LIa4KlJd+iXO6Tu1qWz0D9r61/Gm7wWrS02q3tKLq7+fzeHh4hzdc36JCGNv4KhKGbI5GROLBKYXvF2QmDTV4Xa31auZJC5swW9ZKFQaQng8rrq1yLSwVBBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795649; c=relaxed/simple;
	bh=wTiI0iHeI6+rCi9fxuVDCsRFsR0MNcgeOnonM/qR6OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klb6tC+4ayIVqw44k8gSGZV1TivVGCvragAu/iGoTLdxICs+tMHLik3lYFUoheVY3QUJgTOI+rGzW8/pWj6cPFDE3nrqqkDiUeaIJ8TTmfjTq9bo0UJb3DxEuz3DZ9W7sr7Lz+k0/EGPQSHNJW8xZsvdn0fi0vxKBg8P+T9Z2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zpdx5wE8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zpdx5wE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C561F0089C;
	Mon, 12 Oct 2026 09:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795646;
	bh=Yio4BxqjmUGLg3hJX/RSp3mDRnAATsmzLPWn0D1ZObI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zpdx5wE8L+jfuZjwCH6Z7JnTXKaM16sioeBTHsLInaQZpvKQ/ClJuFoEpUK9/6WeY
	 mq8t2kBJHAW3fyyTYJi5XbDisCrhr4JuXUciDEzOHt92vm3ZqgB45V9fzhXf0gZMFY
	 wUXhK13ckQ35e9wzOV8MP4JQrlBw2F9IhowX+nvQTJEsSR/COi8sXGh80qcBvEXww4
	 /Qx5vDLk/9cXuYGGQ36dlxz1u3IBKuMdzlX9D1N0zA5jIq8CMAYHN7jXX6uZr4coJL
	 Ll1HSUS9hK4h85EZzJdfcO189aJ7SSdk+mJzL0QJmg3dJLVjHmtr0ozN0dRHGi2njO
	 Js7Wk9GbSaHcA==
From: Christian Brauner <brauner@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrew Halaney <andrew@amutable.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH v4 00/10] net: support thread-specific pidfds for send and connect
Date: Mon, 12 Oct 2026 11:00:25 +0200
Message-ID: <20261012-panik-helligkeitsgrad-hackfleisch-c9830fcaf7fc@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2468; i=brauner@kernel.org; h=from:subject:message-id; bh=wTiI0iHeI6+rCi9fxuVDCsRFsR0MNcgeOnonM/qR6OI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSdWbhdKTolOrw1Y90FxQXzOv/c3+7wfrPW15fSC46uO DKdfYVQX0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEbn9nZPh9gHmjx/nJ/6Jq 1mkv/b/vWMUKH8vVLv5H+fImXdw99eMdhn9GF79fKsm+3Swfc7mJp61jfVYt+6KMj9fXblgaEP5 j1ywGAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 05 Oct 2026 10:09:30 -0500, Andrew Halaney wrote:
> SO_PASSPIDFD/SCM_PIDFD and SO_PEERPIDFD allow to retrieve a pidfd for
> the thread-group leader. The coredump server using the coredump socket
> cannot get a handle on the task that took the signal and is writing the
> coredump easily. Workloads interested in per-thread authentification
> have similar problems.
> 
> Add SO_PASSPIDFD_THREAD/SCM_PIDFD_THREAD and SO_PEERPIDFD_THREAD. We
> record the sending and the connecting thread in addition to the
> thread-group leader.
> 
> [...]

Ok, stable branch it is as discussed.

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
        https://git.kernel.org/vfs/vfs/c/fd0349aadbb9
[02/10] af_unix: record the pid of the sending thread
        https://git.kernel.org/vfs/vfs/c/c48ae5bcfc35
[03/10] net: add SO_PASSPIDFD_THREAD to get a thread-specific SCM_PIDFD
        https://git.kernel.org/vfs/vfs/c/be3a5e06b962
[04/10] selftests/net: SO_PASSPIDFD_THREAD
        https://git.kernel.org/vfs/vfs/c/4e2446c83f38
[05/10] net: turn sk_peer_pid into an array indexed by pid type
        https://git.kernel.org/vfs/vfs/c/95d9b7369665
[06/10] af_unix: record the pid of the connecting thread
        https://git.kernel.org/vfs/vfs/c/1592d89361e9
[07/10] net: add SO_PEERPIDFD_THREAD to get a thread-specific pidfd
        https://git.kernel.org/vfs/vfs/c/e10899b2a098
[08/10] selftests/net: SO_PEERPIDFD_THREAD
        https://git.kernel.org/vfs/vfs/c/02e658dffe50
[09/10] pidfs: record the coredump on the dumping thread's pid too
        https://git.kernel.org/vfs/vfs/c/3209535cd39e
[10/10] selftests/coredump: check the dumping thread's pidfd
        https://git.kernel.org/vfs/vfs/c/1f47b275d5d5
