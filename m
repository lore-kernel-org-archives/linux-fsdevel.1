Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094538;
	b=myDUF2WWQ9q1/FCV/gl8fKvriBTgn4IGNwoF58QA3qY+MYGcPq/NJgkHQ5ies9HVb8Pu
	 yAgKg3ciVULeYjiP1D6uuuDs2LF1V5aSE3dZib6+2w++wcYWZc8OwS0eBZCK8caf7S+tT
	 pJhoIOx9LtGjBw6ygOFTb/gTUeNZG0SaLXBqX/ebZ6e4jRd9lBl4zhG10r+khE+v1LoGn
	 iJ3VEpSfFGGJCI55s9tBwWE5UUc8wkoppe1dmksuM8U+pGPVEFxuXVK5gY27NznH+/cdo
	 X3/5b2AfIVwVJ63dzwtVhKvSU+VtK8pz+nYLzsFBZHKQenL7iSpo/chK1seBKX4PC6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094538;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=JLf77SLTj5PHtO6sovwzG3G85OtIBR6cqVrzZiXyUwE=;
	b=YY2ZXvBqBEYfOIuuXOBPqfw9dVx9DbkKD4DJj5OmoIidnEWLyFXcxFfen7zkAeD7OLY0
	 l2bPsEGDAT1SP2xFpgYM5qxjjQoAtzEMeMlEO0DRn7nVOwluTjoNjuVQEJeMzI3FbSVaC
	 KgFBDAdReG3bP/qoIGivwAHW6bNhk9ry8L9HVlaDFLIqcUGJkDWGnVV9vFoYvfC4S1PzB
	 /8inNbOXc4mb84z41gQSg1s0/D/W4veyqk6jkMtCQef70HOfUQ6N6cjk7Hh4h3hPgoulN
	 YvExLwpmQuS+IvHJJHdOoiA9x8e+b7Qkqgs+u/ibg5KgCVVkxwkVG46v8AJRcDxSD0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="bCK718n/";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C214606A31A;
	Tue, 27 Oct 2026 09:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C214606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=bCK718n/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JLf77SLTj5PHtO6sovwzG3G85OtIBR6cqVrzZiXyUwE=; b=bCK718n/ZBne26JsgpPhr+1TeK
	aOyUPSHVLZDMGh9Aqw2rMPLBT68OMdG9zRiwDF4OIVm5ILVdWQwz5pN/7oyUEPkNfbX+Pb9VtbggO
	G2K7nQnnIo4ekKp0aiyau3kAJoka5i05wK/WUbZQNagtrvfqQk351pc49JewoWtwYjHmf6J26iYAO
	IfI7V2giU+ymWCK9hSiEmXyzzpmT1KLFojCL7rTmtJIRBmdAVf/BUBscFYtEbcsh/ek9b8OuAG7uL
	4J0v5GsemQ7o5Bth+XiglVXywdEVIIPSY938ukYDP7btoM3p739fw7AifYMpZaxgldNxlw3TLPi2b
	fe2+ZVrQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xLdnU-001Mzo-0T;
	Tue, 27 Oct 2026 09:48:48 +0000
Date: Tue, 27 Oct 2026 02:48:43 -0700
From: Breno Leitao <leitao@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	catalin.marinas@arm.com, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] init: do_mounts: free the ramfs info of the boot rootfs
Message-ID: <auBzcXQw0j4zTvTM@gmail.com>
References: <20261016-rootfs-kill-sb-v1-1-7631af3ba35f@debian.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-rootfs-kill-sb-v1-1-7631af3ba35f@debian.org>
X-Debian-User: leitao

On Fri, Oct 16, 2026 at 07:27:58AM -0700, Breno Leitao wrote:
> Kmemleak is reporting the following leak in ramfs_init_fs_context:
> 
>   unreferenced object 0xffff000080302480 (size 8):
>     comm "swapper/0", pid 0, jiffies 4294667306
>     hex dump (first 8 bytes):
>       ed 01 00 00 00 00 00 00                          ........
>     backtrace (crc bea23b04):
>       __kmalloc_cache_noprof+0x28c/0x5a0
>       ramfs_init_fs_context+0x5c/0xf8
>       rootfs_init_fs_context+0x30/0x40
>       alloc_fs_context+0x4c0/0x6a8
>       fs_context_for_mount+0x28/0x40
>       vfs_kern_mount+0x40/0x220
>       init_mount_tree+0x80/0x440
>       mnt_init+0x138/0x170
>       vfs_caches_init+0x2c/0x48
>       start_kernel+0x350/0x3f8
> 
> When init pivot_root()s away from a ramfs-backed boot rootfs and
> unmounts it, the rootfs superblock is killed with kill_anon_super() and
> the struct ramfs_fs_info allocated by ramfs_init_fs_context() is never
> freed.
> 
> Kill a ramfs-backed rootfs with ramfs_kill_sb(). A tmpfs-backed one keeps
> kill_anon_super(), as shmem frees its info in ->put_super.
> 
> Fixes: 576ee5dfd459 ("fs: add immutable rootfs")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Ping?
