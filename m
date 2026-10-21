Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576956;
	b=w3EjDTt/IMrLml0SmMfmMSDHxBy4IBNhCGUcv9MMfxKV9sWVmH7ilp6J66cOsGRRirwV
	 feMCZOfTuryu+7MLAx9HgROiyDRVuncjM/9TdBvjDO2ryA6akFucKh849tgcCJjIKa4JI
	 ze10RNj2SjO1T8HS26Mo3Wh7/Dj8cQChzfM2QbosP3THgxoqRAKvtjxSzGsDljiJKn9M4
	 oSteKRm5Pbyv7miPsVTNrIF3LH/mtfvlRecNW1/2hdIiQ2ps/DpjtIby9ct1LvVohVT8g
	 8gtuejPpG64Z1azv7Kcgk4RgRDrFQDYdlb6q1/UUtMM4KF7kjUPfpRN9CzZEuKRtlkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576956;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=/8thZwwk4e6u/nraycWk1C1Es0BQmw0ri9iwXnaXQhA=;
	b=B+66Y2f1UhcD/n6iknqA/N+ABLPwKs1vNGudquIu1F1KpVoPMkZ5zxUJagJLiCx7gwMZ
	 fAg6rYWhslgFE12skWmtbQMSrXX3n/RoHUoRXuMThPLqiuwesPJXk3QM/kEHTSsoWy9Gi
	 gvc9Rb+nhlSYxdDZFbk0p6ZnuChAZ376UkaDGuCWbXA9o2bptE9UH1si28JzrUm8jPt/o
	 V3CCvSbjkkU7ULhB31ppBvGWYx/I2LVrouMaajYmFdrk5uW4uvG3JpVv+lS5xZvP6g/W/
	 Z5jqE3FMIL5PNmpoxrnPbx1p9e3d+oCOFiQR3194hE4UqIWa4lmYUutsBuIUTDMBjbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OP5I0HEJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7399F606A319;
	Wed, 21 Oct 2026 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OP5I0HEJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF1B1F000C9;
	Wed, 21 Oct 2026 10:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792576956;
	bh=/8thZwwk4e6u/nraycWk1C1Es0BQmw0ri9iwXnaXQhA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OP5I0HEJe15bVZLgEcfFceGQM8avZ6OiBE46g5cgdCsqsGgFt9RdOHShw9n9g/+os
	 l/r0cOrabK35uwkVgzX0kUu3h8qKZofvbbp5tKC8Ez3bnmt5DLaSStCKmgyS0Wg69O
	 Imfgf9KVNEqU6md6aWCcL5cr1GQO2x9fh+DJutzq/Dxs/rP4BOJO9emtec+rb8vA6F
	 Gk/QqfS7UvKhN70YtR5k9WPp59mAqENbk880YEpgLDHSvpKg9vI5TwHErscfvM6mcA
	 hfQOdSIybGvZb4wWF2tO8AoTnlzWvNZ4U0LBE9DuLuCccGN5vFUgVXh4QJyx+Ny+ZL
	 vP6BzpJgDBRrw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, fujo <hooyan2024@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <179252551833.59967.12617794775210688694@gmail.com>
References: <179252551833.59967.12617794775210688694@gmail.com>
Subject: Re: [PATCH v4] selftests/pidfd: wait for POLLHUP before reading
 exit info
Message-Id: <20261021-krone-stornieren-meisennest-e65d2ca350f5@brauner>
Date: Wed, 21 Oct 2026 12:02:32 +0200
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
X-Mailer: b4 0.17-dev-3d1b8

On Tue, 20 Oct 2026 15:45:18 -0400, fujo wrote:
> The CLONE_AUTOREAP tests poll for POLLIN and then immediately call
> PIDFD_GET_INFO with PIDFD_INFO_EXIT.  PIDFD_INFO_EXIT is only published
> from release_task() -> pidfs_exit(), which runs after the pidfd already
> reported POLLIN for the exited task.  A poller woken by
> do_notify_pidfd() can therefore read a mask without PIDFD_INFO_EXIT;
> under KASAN the autoreap_multithreaded case fails this way.
> 
> [...]

Applied to the vfs-7.5.pidfd branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.pidfd branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.pidfd

[1/1] selftests/pidfd: wait for POLLHUP before reading exit info
      https://git.kernel.org/vfs/vfs/c/3f1cdfc09cef

