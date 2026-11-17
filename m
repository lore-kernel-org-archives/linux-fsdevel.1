Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923368;
	b=C5w90R7nVksbBhaweJzDNvPIdvTR2GNDGd6K54cM6f9PMTryJC3y72bS4hKbKz0YJz4e
	 +O79DNO89CqCwo/9nXwOnWdcdTjtNdaDqCKA3970PNqfK8EYqOBTNOlcTLXoY1wD0x4LK
	 h8Mr4pGQ9Z/IiIzKszwgsawX9cNr4UU3hSopTewYTyN0aBJQvN98GBESrU0mLRI7hN9sJ
	 8BSQc0wdJcOBdCyxYN8LQqPg5gAJOFBK1ObCTyDQ0HYSRaRizQqMDuBO1Rgc/Wa6Xbqt0
	 NfWUHPIRHx/eCZ1VytNB4BvQHWQgJV/3oHCnHl2gFBrFDRvS/VfswkcxWtzxLAxxV6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923368;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WqLLw0Nf7jJ/i3YBveOWu2QuDFM8/esGrHisHGGzsXQ=;
	b=tIr2nqpo9ByLVR2q1/lEuPHj7AcfM16yxoEFVZQEeijSOQAqXSzGc5gUq5o4/LgeIJvq
	 q3M+sehtlBSeLwgA5XG+iPOFOIO40HrU+tS1MvL1zh9y6ZuKlH9EKyykh6+t0oNefEAW9
	 qQryJ7MbHW6niJjQiQNxrPva1bW/mvsE3aiYjvj+gwLUlzHFN8uYvtxX8ams0MRYQEGmU
	 4njx3CSziAXXa/dgLp18Bh8DQ5oM5Tp3lmy6GEnD35QRPe7olA7uhpWfTz8vmZMwj+QDn
	 Snz2QYLlUpk+tO2O0vzCcJHc1DgstYsUuf5fkY8sAlcuCqOrJ1h29KFFX1aMAiF02YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhxPhOE3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7731C606A31C;
	Tue, 17 Nov 2026 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhxPhOE3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F681F000C5;
	Tue, 17 Nov 2026 13:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794923368;
	bh=WqLLw0Nf7jJ/i3YBveOWu2QuDFM8/esGrHisHGGzsXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bhxPhOE3Kr4aQXNkdurGtoau+c3+rPpot2eQrS4hhnwwdji9xNOTo0kYYXvQZKdhA
	 Dum/zPjQK2ILQAJP7zAtPlJjSxzEZlR6C37InwWzz2/+d3bywTPE3q0/3oUe77nq5P
	 EgCiJx9DLGJBohNQ3zXxBypkPF6wC2cG9kVBBwrg9KQhyuRWM3FdeixSV/G28Z+sIh
	 Vt6xop407Xzbn75wQFlGFukPL8arsdFjP4Ajhom2LaGkQ49JOFtxchb86PSf24HDzN
	 1u1H5CN+d4TuZ1N6+ZzTlQmjeL3fziKq2NnprNYt96knlFfTX0P4vZr0HzHVliswPX
	 9fSz6NVlNPgVw==
Date: Tue, 17 Nov 2026 14:49:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Guikun Yang <yangguikun19@qq.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ufs: validate fs_cgsize when reading the superblock
Message-ID: <20261117-absorbieren-geduscht-holzlatten-0552aac29cc8@brauner>
References: <c5-ufs-cgsize-ubsan-20261031@qq.com>
 <tencent_EBEADAF7CF88B39381E959548BCF46146006@qq.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_EBEADAF7CF88B39381E959548BCF46146006@qq.com>

On Sun, Nov 08, 2026 at 10:00:00AM +0800, Guikun Yang wrote:
> diff --git a/fs/ufs/super.c b/fs/ufs/super.c
> index 1111111..2222222 100644
> --- a/fs/ufs/super.c
> +++ b/fs/ufs/super.c
> @@ -1140,6 +1140,14 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)

This diff was never produced by git. The index line is made up, the
hunk header doesn't match the hunk, ufs_fill_super() hasn't had that
signature since b70cb459890b ("ufs: convert ufs to the new mount API"),
and the Fixes: tag sits below the diff. It doesn't apply.

I'm not going to fix up hand-written or generated diffs. Generate
patches with git format-patch from a tree you actually built and tested
the change in, and send them with git send-email. Anything else won't
be applied.
