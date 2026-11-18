Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005413;
	b=GpxV/Q/JGrtvwmefUFxap1dc2gR3Oi72fuyekNJyyZIWQJdNNGH3XjUdd4aAtzbfhMhF
	 aoTMkV2Pn4QzNIMw+8ZLIFdKyGzacbFSZdV0NT7SFOJVESrUl2SjBgsQDHJJWriMIpF9P
	 lE3IJfxceQk1pxgrrcHSZtobUjkPyEBlWxNy+tCHxFUap/iK/48npJusodz6+BSffBCa2
	 qkHrxPzRyGVF+TaEubefWBTvIrBe/qJ/CSp6SzEULrIpsYMV7PziFQhOiVKxVAr8ND/0/
	 76qoIqTHfrPbtxBi8hhibOGWaSYRor7xeLWaU8BzLOOO/mLYdovx5+Rc8Fbi1NUS4iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005413;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=zMEe7YQwtpnVI0gOKUZKWSs/+kW5E4Wzfdpq8ADafeM=;
	b=ImZEWlsu9bHAg+C/OabCqNx379AWR4Aez2rKosVBFOgyMBhRSsQYkNdNK0zerTotWRal
	 lhhXUmuldzloNm0R6QPU1PgorzEu63m6X/2YR1j6j61vecx7b3I4x4znAb4N60ZrHQClA
	 lNa8qY7O6+id0a1kXHf0/X9vAl+L9PSV2s8sGW8P/b2tx5nplQ18fW+d4LLG/D6LKhThb
	 yFG2mBePnhy33LMDmsYQpElIHuw1HSDSE8n2uYTNKf4qysjo2V81dMwpbj6DgdMYhEDo8
	 tz9sOECAwnbNxUJZ3sdWqER058EKGQ9ua3kR+eAH3AcVtqWFrB57RNpUJ75/E3rHjJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYdoFEP0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23544606A31C;
	Wed, 18 Nov 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYdoFEP0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4924B1F000C4;
	Wed, 18 Nov 2026 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005413;
	bh=zMEe7YQwtpnVI0gOKUZKWSs/+kW5E4Wzfdpq8ADafeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BYdoFEP01l1Bt5oqrl6M30Q9xrM/DSRaUq8IQdDh/cz/FRVxiWdGGHN2PWNxagtEE
	 76SanPwS8lZ8hYz3V5ICbgTupyf/5GNV6AVvbPQkJw7wjVBGZfHsc111Q1plPwDJbK
	 yTzJqwdQCZ0Zl2OeUkzw/5irnsENdobVIHzSSNJA0tvVDN+rndKF3iug+giWWUl17T
	 5x4qKRksDzO0074GLY9pHqoOKC5LQ18RV8B/fLPlqFWgXAWtEy2Yu4CKWhE0HR5EHe
	 mcl4SSTlj080IPLHnLOrUgHlhRJz9/Hg2Ut2vER8vfaCXplGiXwyY8WSMl89yPy/1k
	 7PR3soUZW/f/A==
From: Christian Brauner <brauner@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+a088f9d6bf95dc66a923@syzkaller.appspotmail.com
In-Reply-To: <20261111064731.17214-1-zhujun2@cmss.chinamobile.com>
References: <20261111064731.17214-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH] stat: annotate the lockless inode block count snapshot
Message-Id: <20261118-einwickeln-resonanz-elegant-ebf7a88011b3@brauner>
Date: Wed, 18 Nov 2026 13:36:49 +0100
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
X-Mailer: b4 0.17-dev-04696

On Wed, 11 Nov 2026 14:47:30 +0800, Zhu Jun wrote:
> generic_fillattr() reads i_blocks without inode->i_lock, while concurrent
> space accounting updates it under that lock. KCSAN reports the read
> racing with inode_add_bytes(), for example during a tmpfs write.
> 
> The block count returned by stat is a snapshot taken while file contents
> may change. Annotate this intentional lockless read with data_race(),
> without marking or weakening the locked space-accounting updates.
> 
> [...]

Applied to the vfs-7.5.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.misc

[1/1] stat: annotate the lockless inode block count snapshot
      https://git.kernel.org/vfs/vfs/c/70e4c5f78aa5

