Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098650;
	b=He1Ugxncn210bsA12PySIi69Y4H0lIfX4avszwOL7iLyya3XJHmhHabBt+V+lwrNQfGd
	 86SyFlBD+pyUrwXjYP7sHArywYvWQvpRcMt+Z2E23xh4aUKGybvHMfmtJfr6xF281Tb36
	 RfqO8eau1syNzR30gPa/r8aAWaIauxAmD2wyKFRET2e+9ojuACx9QpDVgaCD3tvrc++Nc
	 lD/qbSvzagIo61ith/oxorbmqjG/QNWwTIU2uMVYEEbnXISLwM3D9EXgxNpanbX+MsIpM
	 4nCF0lMDupbPd6tzCC0KcFyzEj4ZQH/ng+ZTUy6c8ffw//FlDKRRcNh8s3A9EV9ySSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098650;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=l/C1DKA2mG967MO6KAH7vKhZoLEilrqj2aGc1tORCpc=;
	b=ufvkxzR5ggSKzuRvlfbiNLMrzh1asFkUg0gIenVFniLoeW/7SpHJCXWjb1kd2IOmrTkT
	 /u90+Lz2xkHj7wF/HF/Ezz8Z1SJL3SWnos16RxuC7b3WI4gqM4fr/a4SmKEBhKgUvz9R5
	 AxMLnnTDc+0z2N7bM2ejNb2N+D0JejSx+2XZ2sRMSdC5bscejCX7hcywnQyOU8oJjJczJ
	 xSur6rQRBE5uTt3FbipGH+2DTY85lXrjPrnwmGLco9UdfuKr3jzzGGOb5FrTZudgsomqn
	 pSVF9bqc1CUZzjK460DGqZCCmnb/DexDJ9Qorx1rlgakOgA4nAPx9IrMjGLmE0dd2wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPLWnijZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E981606A324
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPLWnijZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2E61F000C5;
	Thu, 19 Nov 2026 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795098649;
	bh=l/C1DKA2mG967MO6KAH7vKhZoLEilrqj2aGc1tORCpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RPLWnijZtzCfSDVs+eh1M2sc5vytM2exqsz117e2JIViupzd1Z5kY2cDMmGCrEXLm
	 K89/a3NI7zfU71LNpzrCAVDBSTrwpPlXhz96JwXu+DoNMmk8pDPTViowIXGYxmqgQr
	 1YbHUd4LH0+VZ7vI6CXy1JW3OZ2yoEdePQp+Swui9yaEwGPoeIYYSkxN7HPlJu3BYr
	 2Uo1Mqsv1l5TTZq9F8asii/mTdaW1RJI/3P0/Jr6jgwH2kJckhLOI8AstlPH1bzK6B
	 sOWym+A9iRtSsDXitybcUNmt/sJspkf4vWTAgg+dLqFgkrS1z6hjsWIqlD0QQ1sEVl
	 bGy+9pyn3dkug==
From: Christian Brauner <brauner@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+4324f771847cecb27c54@syzkaller.appspotmail.com,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH] shmem: consume the reserved xattr space despite remount
Date: Thu, 19 Nov 2026 15:30:43 +0100
Message-ID: <20261119-zahlt-mitmachen-genom-b6bca236b924@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <00461f0c866d4a4eb9f50792f0e1f3d0.1@linux-foundation.org>
References: <00461f0c866d4a4eb9f50792f0e1f3d0.1@linux-foundation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=brauner@kernel.org; h=from:subject:message-id; bh=sL/wvWYqiVFPhGVN8MzDddQMTa/IduVM8SQcJxF+fQw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT95xDeNdGz6uK7yDVLjl7sXlTxaOb96FvGNioqCnzbn jEu6Npb0FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR/d2MDN0GfObnZKq7cxxb V5u8Ttc4nd215t/UKoFrLGzs6s1ZBxj+WeRJ16ZLMLOYvg3M2Pki/9xSLs39929sr2NQ1haevUG MGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 18 Nov 2026 10:23:05 -0800, Andrew Morton wrote:
> Creating a tmpfs inode can trigger WARN_ON(ispace) in shmem_initxattrs()
> when a concurrent remount sets nr_inodes=0.  With panic_on_warn enabled,
> this warning can panic the machine.
> 
> shmem_initxattrs() reserves space for the security xattrs while inode
> limits are enabled.  It later tests max_inodes again before consuming that
> reservation for each installed xattr.  If remount disables the limit
> between those steps, successfully installed xattrs leave a nonzero
> reservation behind.
> 
> [...]

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

[1/1] shmem: consume the reserved xattr space despite remount
      https://git.kernel.org/vfs/vfs/c/274ae8ab278e
