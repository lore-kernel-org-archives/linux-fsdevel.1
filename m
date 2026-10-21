Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583407;
	b=hR5i5qFJOTKWKaXjN+4j8zFTk3Pwiglejfc0uJs2lYrMcLOin7VieilTP5PQgYiFyWvU
	 axk9+i6/wYayLQPi9dMHqGLzxeOmVtu5JOBk8QmZJ/KEPK01CqRJMkZg+0QXvENA5cUr3
	 N2cgfGWlLG6cZ9lm3z4MBOQYzmjP2rCXerlq9xwQzRhn89nIGQEryFLS5pTUcbuwfHQuj
	 NoPC4HGmdFKlO4WU0KrSspu+R1BX1ed0M3Y+OwtFLfdNOwr7Sw3D6axf44xqRkUSEtiT9
	 du3q6IbF7I6c5mBNP3iql0a0hoXiPaj7ljcP4lQ86nlRAP1A9KDAPgvn8VQ/xrmFZjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583407;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3mNfhXSOsVuM7NZFLpBDd/6HfivE3NdmEuTrBpPhTE0=;
	b=j3PD0vy1mQd33XADxqgqTzkbykTqjlpUnVPsIp/w4/RVx+CEcIQlD6g2Hd7rRk6zcVXf
	 Xlp4Mi7LHV5PPuY69Yi3b4KkaFrc+R7+oEFqOw+GCitUNp73F0+uJ4mKsW0C4jz3aE5FB
	 PvQ+9L1rPRtFnKyDz2p8qpKyB1vrLbUCNGVp4jEm4gkHCE0LuXAo7p5wPTYWfPeMHJKDU
	 H143YQk4XjUDQU/svgvFXbEpHOZ0qo7dV8vLBPYtxYjh3JitdzArNveM7VCujzBH8AYSR
	 2Jz/2njNGQho48HLZ1RAcpefB68NxQsYhAYC78wqYD/pKqBq4tHC3xqe/mY42CxYGOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XmdYvTgw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638F606A320;
	Wed, 21 Oct 2026 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XmdYvTgw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189E41F000C4;
	Wed, 21 Oct 2026 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583407;
	bh=3mNfhXSOsVuM7NZFLpBDd/6HfivE3NdmEuTrBpPhTE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XmdYvTgwJdpGeVbnJCO7Z/zjxyeaj6UnNGZH6/n3bpUwB5uBSenSeLfHrKTdC8Omn
	 UTXoXbhrEL5ioz9cUiV4VarsKtGa9VBAG5Rglo0gq+t9pnGNaMGM2MzoEnnDLvUWe6
	 DaAx9mR41DL1Fok/qmTHs62PcH0jYnT8GB+T7wIV+N7tYd+xejNkU2dbYR+WPmBxr+
	 Q99uMhAuhnHsPU/GOJBcx9kL98xDZuGc/HxhP8c46V6rCHwUJcqzo+pMSwjjrL8Gic
	 Itp6ZFzAQ4L7ictv+cLJcpxw87helQLhVQb4p1EfGyCK9L2YMP2n5TEJUgsjAERyvp
	 HrsLScAK+fAfQ==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <20261009055546.85279-1-kmehltretter@gmail.com>
References: <20261009055546.85279-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] fs: fix ramfs_fs_info leak when rootfs is unmounted
Message-Id: <20261021-umgekehrt-vintage-titulieren-815db10a1e07@brauner>
Date: Wed, 21 Oct 2026 13:50:02 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1PIailozRbOyhnkx+NXoIRv5+rp+8eccR237tQWBv1s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdWPb6RtZxxgRZIUfnmNiGWtNTLoHfw16b7znTUD5F8
 5KNy69DHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5as/I8HOlreJ2+zimGYXf
 b0Z0n/XdluwmuMYg6Hfr5TklO/PuyjH8D495uP1l1+/Zxj+vBMc15G1o3/31xF4jxnyTqI1WX6W
 ecAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 09 Oct 2026 07:55:46 +0200, Karl Mehltretter wrote:
> fs: fix ramfs_fs_info leak when rootfs is unmounted

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

[1/1] fs: fix ramfs_fs_info leak when rootfs is unmounted
      https://git.kernel.org/vfs/vfs/c/997de4711268

