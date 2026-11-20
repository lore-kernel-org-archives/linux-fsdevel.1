Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166518;
	b=gWsrD4F+pNQhtEUvW7Cj5h67F09Qv1ZLFuNZ2QIZRA5lDFJEVl6mFhBeTfXHcMFQ6st3
	 mrLz712bYpU3xgdCIeNrmcRWWK4PZWGfdH7ZW85rDaSFhhtZBvnF0sy6vZDFuFZD9StQ3
	 +R3l8WJyAXU8tLsOR50Da2RW/XiFpERqkUYTn/WB8FUJFhduFgYfP5dR5y3Fx3Nd43io2
	 x/faaXPcfEuqqUCOnxvooFyavoD/O/r1U44BGCDsevcnPt6usQyPqORwd6Mmu7PrUi9jn
	 OwzbbeJGVoUvkRePKeAO4b50k304fca4KhSCZYZJFpf2SXKG3Nkq6889QeqXetPyg8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166518;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=i1+UgPdXlfOvSsyCGrBlo780rYAl7TGYCytSL4ryGGM=;
	b=VLbf6EyuBT85B5HqWYPPt7R6n039Jq5u1r1Bn0h8ZwMun+ssVyQXLK/xIFnEISeT9+Jx
	 c+GX+szl15BLSD1KJnSWCGlnYbCxBonoLG0KL/RR4oypopn7lhRg1zLpBTuxDk8+otf7V
	 Um9ykAchxH43bVmyeZF5IIH9UJowtWHxFrTzu4C79boys4Ha+Qh+aBBrQ9e3Jeceu3hN+
	 fRmJOrhlvTGvoQHpr/tZToocHT5GcN+eqW4VQRk6wQfhkSfZEaf3ZBhALiD0wsYIiJzn8
	 P1QgPShIPg9krvtafRYEjbA7PjaUviuOrYzzyawTN/rTz6hC6Obybwp7AhDo9zo/lIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjfgnGTa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598D606A325
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjfgnGTa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEC71F000C6;
	Fri, 20 Nov 2026 09:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795166518;
	bh=i1+UgPdXlfOvSsyCGrBlo780rYAl7TGYCytSL4ryGGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UjfgnGTaBiiDEodPPtMNeOEYQemf1p0TYwoSfWZoEGKLCxSQsLI1qFHOQQNWQv5uk
	 Vvmr4B9//FokATHdRQulGYPivDfpEIb0bSmI4aB4L7I/3l+tNbGW/vtpAIUvXZ3+rH
	 1eLa9UqlP0Z0bPHUgolcEmYkzDp7ZpxdfxqaKNIjcrUfSav1FKpEwiMX7IdaX1f4OL
	 278PhNyIqZO5r3uaeb/dwS4eIu1ZejQ4SkT9+/zZ9QngoAYgFChfGJaRxrBF65CuB8
	 /6qZKHT7W4OZNiPwqkmz7yemXIB9i8AEJlMgTBCHyLExlOIp/Xh71QgraJESbN5Jyh
	 akNfn2OYc7PdQ==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Dominik Maier <dmnk@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	dmnk+artist@google.com
Subject: Re: [PATCH] xattr: require inode owner or CAP_FOWNER to write user.* xattrs on sockets
Date: Fri, 20 Nov 2026 10:21:35 +0100
Message-ID: <20261120-anpacken-inklusive-denkmal-b8d8766daa5f@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119192204.2648126-1-dmnk@google.com>
References: <20261119192204.2648126-1-dmnk@google.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1990; i=brauner@kernel.org; h=from:subject:message-id; bh=N8IbLX3ooA76k6vv+qvJC/yJJSkbt/u/TcbBOUWl04g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQzCOplrmBevFHr3dKr9n1hPou8z//XnMKzaeOVpbKzF 3Wy6Lzh7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIUxQjw/JdjP9y73/gUDEJ KjEvNf9xn+N/w7/z7yecm3LXPF+3XJqR4fQkxusMO88FSdUf2qzR/ethq51akOl7lWxFp7Nl39U DuQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 19 Nov 2026 20:22:04 +0100, Dominik Maier wrote:
> Commit dc0876b9846d ("xattr: support extended attributes on sockets")
> enabled user.* extended attributes on S_IFSOCK inodes so services can
> publish protocol discovery metadata (such as user.varlink=1 or /dev/log
> structured logging support) on bound UNIX domain sockets.
> 
> However, connecting to a path-based AF_UNIX socket requires MAY_WRITE on
> the socket inode, so public system daemon sockets in /run and /dev are
> routinely created with mode 0666. Because xattr_permission() allows
> S_IFSOCK writes without checking inode_owner_or_capable(), any
> unprivileged local user who can connect to a 0666 socket can also call
> setxattr() or removexattr() to overwrite or delete the daemon's user.*
> attributes. Moreover, on tmpfs mounts such as /run (where unprivileged
> users normally cannot create files), shmem_xattr_handler_set() uses
> simple_xattr_set() and charges each attribute against the superblock's
> sbinfo->free_ispace pool, allowing an unprivileged user to exhaust /run
> inode space via a 0666 socket and cause -ENOSPC for privileged daemons.
> 
> [...]

Yup, that looks good. Thanks!

---

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] xattr: require inode owner or CAP_FOWNER to write user.* xattrs on sockets
      https://git.kernel.org/vfs/vfs/c/f1d026b55bb2
