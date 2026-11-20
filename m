Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795167027;
	b=zjQ0VcKf5gizcwgC+PGt0+qvnbCgcNwokj9cHf9dWQ04CaiOck0dFU1zHIw/Cx5hyaQX
	 CxcqReE0MmyD0w0FaJlI1oNArXvIR/N6fJx0w/kgvUMB7CJXEAUQmZjxVczW0RmbEcBEn
	 lZxRLcN38Di2iDTrAH4sQv5ZLCnyYlZt7kjqPyGOzfq5ToxflszLkjlYXEJjmIdcl1Fwu
	 008KMXgOMS82845LX15Aw6Vt8BRE0Y4bhA8qKDdXQIwi9w4UBogR1qq5dU7ojYnbjJJT5
	 1PWwf9a7lwHVPDq32SEY3Sf1/9QWVzs4ctL57SOzAG/NSyh1JjlNydBy/AJPE6fKLWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167027;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=oOA5sojz3IyHwjBcMt46WVGtF9TFbsnAvrVh1f5zgLI=;
	b=CnzDSQPNXL+YF++P3xh4EW2mvunuYLf74Qyg1PpTFVxXdPj9gq71PSEITZ2oCdTftdn9
	 +24YnaIXLs4bkgPtw/TMAbvkkYB3gnS4ie1lgyDklEN+Mybu0cz6f/rdN8acotBEGVdWS
	 WFzZy8vKV96oomOI6MuoAhb/q4qg8if/0EaBIMjyO+WmDkFFLY5zIT63gZ1Jbwns0ME1J
	 RQGAo4k76lNALT8FuS/j1sHFbIslZe0Ug3v2JDSTO568Pj1W7hBao9D0YLtctVGpMgBl4
	 Tlg+Jz7usn0LHSn2ql2y5Aq/MtWf9bU0wCASyoO+7ZPUdXITDNHdw8yc8pY7/4NRdXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WSQyZ+fq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDD5606A325;
	Fri, 20 Nov 2026 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WSQyZ+fq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5E71F000C6;
	Fri, 20 Nov 2026 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795167027;
	bh=oOA5sojz3IyHwjBcMt46WVGtF9TFbsnAvrVh1f5zgLI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WSQyZ+fqBS11QMpXvIGyboFhX1si193gW4KUCzOKobWN5gwwQk0CljEZI3KmTzGu3
	 /2tmQyWr2CwKnUbtQzTIvWtCiYa6AfxMaSqcmI807y8ClUzt4sfNLIP6qOCfFJyzXH
	 ufwa3vGNDcwNwhhGhFs69UXfZJxiYVs8rT2axpDimGGyzbNHPdgUehifalVPyCwa9j
	 zVb07CiqzKyq6qKYDFhuGcfGosSgk0bNNxx/PoCgQNI2zmJP9gci6Ug89Orh1qhcZo
	 nDo3Yt5jnukBo0wZ69z0m1fn6EN7kPBE9T6HFgOmHaUhf+Wb2icGPC4JJHjCC7dezP
	 EnpLcxJoOeLvQ==
From: Christian Brauner <brauner@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+c4a4cf7debda88305d2b@syzkaller.appspotmail.com
In-Reply-To: <20261111064717.17165-1-zhujun2@cmss.chinamobile.com>
References: <20261111064717.17165-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH] pipe: annotate lockless checks of the file count
Message-Id: <20261120-teilen-unehrlich-spangen-c789498d4645@brauner>
Date: Fri, 20 Nov 2026 10:30:23 +0100
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

On Wed, 11 Nov 2026 14:47:17 +0800, Zhu Jun wrote:
> pipe_lock() and pipe_unlock() inspect pipe->files without inode->i_lock,
> while opening or closing a pipe changes the count under that lock. KCSAN
> reports these checks racing with put_pipe_info().
> 
> Only the zero/nonzero distinction matters here: a caller's file reference
> keeps the count nonzero for a regular pipe or FIFO, and an internal splice
> pipe has no files. Use data_race(READ_ONCE()) to document that distinction
> and take a single snapshot without changing the file-count writers.
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

[1/1] pipe: annotate lockless checks of the file count
      https://git.kernel.org/vfs/vfs/c/12a0e69b748c

