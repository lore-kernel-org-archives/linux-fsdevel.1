Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585814;
	b=GmODSlIVzRG+YpPYFTe1muB++JtwoIL4p5eKdr6MBOzAgOo3hJR54u5Wk6Zm6zvO63Hf
	 8XKzhTVDfWfoM2BIynqPIbKJItWjENguP7bp5wv6S4hTX0Hqn9Cazl7ZFb8bG/imV8KXA
	 Tt1jM4PQR5y/cfgd1k+DKrD6atj0pD4VJDnk42omRVyNBTVvn/u7bXPclKqcgV+yhPqrW
	 YIJ/n2iST2Oiagwvd1Ff8vYgIO1yUtvuiNPrvZQIILukj0gUAOwf5R0L0G9sRmIp20lFy
	 bIblO6ehwsYhO83R0mRDTiAUM6Nweq6Cm4EGOxzfhl+8Wua3YtlRquN3c7oygSQWneA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585814;
	h=Received:DKIM-Signature:From:To:Cc:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=SPvwqxlJ5BdpL7mIBDv6+lJZJJBo+NcQCFXkzsy92MU=;
	b=Hb1xhR8ISzONsGfawI2ww51FHkPAxgc2oR78CyBLUSTVTVocU7KnERpewN89ZHivzewA
	 bYWv5sTFGR7XKUqpgNw9h1peC/Z6rhbYNkQqY8ZBvqiAupR9aNVLr/dFzyTsFT7GeC83G
	 ApyvwmjbJo3Gj9OafSkh837fbcG1MSrEj2WLNs9zF4lms9TYrTcQwCstDXxgfckcKxFFR
	 sPVSTWNSo2jNkYkg9WjFdjyJQu69Zbird1fVETxx0V5KePGIykIRJnsDmtoxaSVaxnKeo
	 8Dd4n73bC83nVYJXyUnO3CbPakPDSEi2u0KGvOJ4Dknl0LP5BAoIFPFtHbNe+adkUIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwVUKj2u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222BF606A320;
	Wed, 21 Oct 2026 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwVUKj2u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE3C1F000C6;
	Wed, 21 Oct 2026 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792585813;
	bh=SPvwqxlJ5BdpL7mIBDv6+lJZJJBo+NcQCFXkzsy92MU=;
	h=From:To:Cc:Cc:In-Reply-To:References:Subject:Date;
	b=bwVUKj2upv4wcdd6/qk4FjjxJAKOtZW1lsW2rD0Fyzq9wHKmtU4HMi0mFyeC68OKA
	 JV1E+MNSTpehRvU4ngvooue4SIO/6CnfN2UWea2d1yZP92YOuyxkksMHEY4HNUQKm4
	 IObuk5hifb58gB71LM3H1nrwNI3zPNEIFrQUtUTEO/9Z0TD96UZnHwHRVAsXzL7hJm
	 TaXojUlYJnExhVH5IuuGCqL4qzK9qTI5+3eKqjhPRFi0aHpGpBupVvjLVtwkms4mYt
	 ejxGnI8uIEwg+3Ib9eefVu9D3yxmMvpcJNL6iyhUkWPDDl1go8qqwTMlDJqlzV1PXg
	 CYITm/NKqANbA==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
References: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
Subject: Re: [PATCH 0/5] fs: don't let a stuck unmount take everybody else
 with it
Message-Id: <20261021-badeort-wichtel-ungebeten-b31df4d9153f@brauner>
Date: Wed, 21 Oct 2026 14:29:47 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1750; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DOy7ShPvFsan0CKTQzMgeLaSNJRaEOFdopVUo01lzco=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd2BB0T2/2950//jqzfDb2d3YNVzi06FrO9jLn5Bi9n
 mCFHas1OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACais4iR4dehY1Mkzmxp2zit
 SKLF5ONRSaMYkb9n4my8bgoars/t72f4n/Fs81GRJ9bXmdfmvl0+aVKDfNLyOfcPL49o0K2SuPU
 hgBMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 21 Oct 2026 00:56:34 +0000, Josef Bacik wrote:
> fs: don't let a stuck unmount take everybody else with it
> 
> Hello,
> 
> A consistent problem we have in containerized environments is a
> misbehaving mount taking out all of the other containers. We hit the
> super_lock() while we've got a stuck or slow umount and everything backs
> up behind it, and there's no way to kill those things.
> 
> [...]

This makes sense to me.

---

Applied to the vfs-7.5.super branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.super

[1/5] fs: make sync(2) wait for superblocks being shut down explicitly
      https://git.kernel.org/vfs/vfs/c/4afadc443112
[2/5] fs: make freezing for suspend wait for superblocks being shut down
      https://git.kernel.org/vfs/vfs/c/86a14b765007
[3/5] fs: make the block device callbacks wait for superblocks being shut down
      https://git.kernel.org/vfs/vfs/c/3505dd5c488d
[4/5] fs: don't sleep on s_umount of a superblock being shut down
      https://git.kernel.org/vfs/vfs/c/e240433824ae
[5/5] fs: let a mount waiting for the old superblock to die be killed
      https://git.kernel.org/vfs/vfs/c/6f55404958eb

