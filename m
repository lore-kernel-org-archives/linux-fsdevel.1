Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004800;
	b=iYzZe0305Q/kZ3yNI8MEuAyehOafIJdQQ00c6u/BYbS7UQdoBUP0Dw0mT8RDnBoqP940
	 YdKSY9TJvoDbbd2yVxDGlonaJsPUS+gxkVL39xZa4xsbMhj0x9b0LUWu+bPSs5VyKgaom
	 C3AZgfzG4ZZSKrwucvKFAgf4c7HsYXcrQOZs4uoWUnJD6DEdK5lGrgjGb9eJBWjjCrx0c
	 hWlaLgw0p41Csf/0kUk8JRaeUOrL7hxSUWxYRBlWoLjQh5vPbGc4y5AyElPeijtmbAVUD
	 oj1UaFo//6jQ/cF5oAR/ol5zLK1SPaimmsUScRFjK0mCTguBnrDK1HWoTPOgYfVq+3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004800;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=bIHva9RvFKScdk+UZiCWNwsiHguCUsvhrhFyja4QYrc=;
	b=eMMCiZ7MnG4bmPG83RzWiWkU3uhSc8LonklLjCH3MkxxOYDkUSXgrtknK1Eh7U+Eezp4
	 2gUKzqI9ULJtveiKDqj7hJvM1dhBsYYWNA/LCwqi92Gt3wIfUp6hqDt+pMWjlisbrwgxJ
	 3WTVL90C9Lh+DgEPxNY7ijVqcJk+uKImLi3BAsrGeHG3CpG5N6He6Ot2Rn5vxwbJoNTGQ
	 LTKs7pJvrUCtHjVMZhvGIpVDtO7R9MeoTc0gFSrdPtZLGGrTwEqon9vMpy45Qd2PS3hL6
	 t/yWxOGkq8T1gy8vEQNYAjeFwuOnB8QhhlydBliRH2MMdECH+ig/egyN7bhYR0D2qpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a57daUlW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ACD606A31C;
	Wed, 18 Nov 2026 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a57daUlW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9501F000C5;
	Wed, 18 Nov 2026 12:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795004800;
	bh=bIHva9RvFKScdk+UZiCWNwsiHguCUsvhrhFyja4QYrc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=a57daUlWQxw9mUiTkE2WOsCbfJQSGmeEKvjSo9wj2P5r/7mMj42Hu6p+CZXDeo0Ia
	 CPfIWBt9HIn+6Tg7SlsZOUugGm8qGqDYMPrNjWzxC1utzudc3+feoJxvO2PsqFLN4r
	 jwVMBQ1hWrRNHaB7geSZyAq2/hhzIZcp0B9IcuyZGTwcS+Q+oN8qXaOFHHoFe9fhsV
	 pQPeg/IccsOiqz3vtEuWuAhGy71500bgF3+Fx9jQEklfRWU30wvaYIVtPzeU8mBgSS
	 p52xjg94moRa8nayBHYZgUYa6TtraKCwN+QK1jY6kbd/vzAtHXubC51vYjL7eU5kAf
	 CT5HxMFJNG81g==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Avi Weiss <thnkslprpt@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261108125617.2383285-2-thnkslprpt@gmail.com>
References: <20261108125617.2383285-2-thnkslprpt@gmail.com>
Subject: Re: [PATCH v2] fs/stat: reject invalid flags for empty paths
Message-Id: <20261118-mathematik-unrecht-hirnzellen-8bd719fcb1f7@brauner>
Date: Wed, 18 Nov 2026 13:26:35 +0100
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

On Sun, 08 Nov 2026 14:56:18 +0200, Avi Weiss wrote:
> vfs_fstatat() and statx() take the file descriptor fast path for empty
> paths when AT_EMPTY_PATH is set. These paths bypass the flag validation
> in vfs_statx(), allowing unsupported flags such as AT_RECURSIVE to
> succeed.
> 
> Return -EINVAL for unsupported flags in the vfs_fstatat() fast path,
> and validate flags in vfs_statx_fd() as is already done in vfs_statx().
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

[1/1] fs/stat: reject invalid flags for empty paths
      https://git.kernel.org/vfs/vfs/c/9a74699d0073

