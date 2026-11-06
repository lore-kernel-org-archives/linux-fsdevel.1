Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972417;
	b=0doVuqOCQcdd8RT+McJKgwW8C5D3w2SQRWoJ3lgfU3lpE0hSwkBBJyl1n+XDKWv1nkmC
	 fl+npyDhHpecL9BrY83LDDrF4/BZWosqzuA5DvIi5MsrTijTysd6p+XGhlPGKv0Nom1sY
	 GJHeo24RYrhAm5ND6eNWcXF6QCNiav4y1r74DGdSwgBEKMx+HwrAyBdA3tYFCLDG2t2CF
	 11IPnkeC1awkGIHLhEL7tepnPL5hxJngdoBGl/U6fj0Dl6yqLzBtWAmKVEQsKgYge/Izn
	 K1/3I5cJK0Yg8VFcgmmEYBkiGGe8dKeQPrQsJYEV+ofiaRs9rlqqseHUILH6uf/3RIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972417;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=3rATodojpsxEqkftZ1FEKOTyrl/GuBlbM9Q9jLKkyls=;
	b=QwnJKwUxpIngzACJTAtgXjLp2Ql93ueyPckR4KHq5cnSDgJNt9c05N+KTgGTI4aWa076
	 MBqtwwfiHxrKCY76IWAG/da+RJ8ZLDnXUQvUl/1ZtjKl/KK6LXVRRipZb+dNrvpbLiLjm
	 9O5VmkWzEH9OYOjzuZFu857lbjGqVlFX0B5exqeOtf9NXkBKYuf7vLZJkAsgL4jXNLDNk
	 bOcZzkfmFzmKh06zqfumRB18XgM8NOPRWJwFR7ZerraT+C0BWFeAHM74KYjjxoepxi6Qx
	 b4YOBY+8gFeZtU3EYR31ijGTLXDKBnt3WvnnpvAiz29q4JfPSVm1Z5I4fy6uD74ksGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnWrxozl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1B5606A335;
	Fri,  6 Nov 2026 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnWrxozl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018451F0089F;
	Fri,  6 Nov 2026 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793972417;
	bh=3rATodojpsxEqkftZ1FEKOTyrl/GuBlbM9Q9jLKkyls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hnWrxozl6fgklbBYR94ILVesaaLnMI85nZvhReOChn8irCGUXVHsR/jrFA54a2Krx
	 F0P7SBUSECSqPBv5nklAanE00bWOj3ZBd57AGQwR6rPCvX1tHSkEDsXPwAA8Lo3yZ0
	 reeZSCDzEb8SEF/3am924Jnf0DL6UWD1ENStCq9358h5nqdJR/eofcqDpsq+n0gfSi
	 m+ckgATYZqAxojBjuj6ZL8my0S7SKD4GiRfDKpHFXBJJbLRW//yQdXU52hbb6eX9pj
	 xbgGEynKFGTqMY9Dub6BaupMckwVI4g09wTNaRiJVTyZ5v7LejRcMI6EjQfKdBdG4Y
	 ggTSvbJAOgiBQ==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, Hungyu Lin <dennylin0707@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261027044257.90408-1-dennylin0707@gmail.com>
References: <20261027044257.90408-1-dennylin0707@gmail.com>
Subject: Re: [PATCH] fs: allow sendfile EOF at the file size limit
Message-Id: <20261106-benzinkanister-gehen-rhodium-13157543d782@brauner>
Date: Fri, 06 Nov 2026 14:40:13 +0100
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
X-Mailer: b4 0.17-dev-ce4c1

On Tue, 27 Oct 2026 04:42:57 +0000, Hungyu Lin wrote:
> do_sendfile() returns EOVERFLOW when a positive-count request starts
> at the effective file size limit. If the input file ends exactly at
> that limit, this rejects the final EOF probe even though no bytes
> remain to be copied.
> 
> For example, Python 3.12 shutil.copyfile() copies all 4294967295 bytes
> of a maximum-size FAT32 file to ext4, then raises EOVERFLOW on its
> next sendfile() call instead of completing successfully.
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

[1/1] fs: allow sendfile EOF at the file size limit
      https://git.kernel.org/vfs/vfs/c/7c1cb643ddb7

