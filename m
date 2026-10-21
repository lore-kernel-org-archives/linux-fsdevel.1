Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583840;
	b=FG0RWxEHj58EYj+VrjduofaR1gs5zDr0TKEvvIM6iyf/auwoMXml82YV7+jcTzgbiwyW
	 ED4Y+Os3w02FqoS6+2hRMbuujc2+2EQmlpsM5B/q7s/tZ3HpHscaAl12TSRYQ/nA6ye7u
	 wdp4sxbCxOF88tNi+Qv9ot4NKPLUbB2oks/QR02PiALaH6DcZzqY/oCGKSNveXGb+v17L
	 u6SHhBBrq9qWpNT5Gvf46Yg5+8sZ1Sb1RSZSF+O38QxXrKdw4ot0V6xEwsk73XmVNCg5J
	 U9tRjK+HiZMk9pmZfKdkLzhBHcdr84w9FIeTQP7egFVQjDbrA9JIgXbZObnxLfQOicQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583840;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wYR+v2mdGZMLGWYFyc3YXeS168gKV1HRSfFeOK/0/mw=;
	b=OqOnFHRRaF+NGjiat8Nr+wOi9qqolohlFJW3IQ0QZcUs6wEVC1eeXq2038wuYH8vdZkR
	 +m8wD9Rg7W9vxj+/cUEaq/PvhVX+ZThVsLgGgHxZJJWdJ97D2KM1v0d4Cr27EaZJ3tanG
	 cR8gxcEM01gQhhXGZ5VkxbCHg788NgjXXawXexBfWTYjU+GdJWpkz+oHRPI+dOD9L1vSQ
	 GEse53cdHlTk4UDlngdxUDIjW5ghTzXggXIGkuGbW1mKmwFqPHS1ZgxnkgiMv5q4md8P/
	 7udOJ7VqYbc6VEjBGPDeP0ZBVty3EBTokUdFTxTe1eBV7DSwOxlB1uXRRHOGZrVhjOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkDyOapE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D88606A31B;
	Wed, 21 Oct 2026 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkDyOapE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9E11F000C6;
	Wed, 21 Oct 2026 11:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583839;
	bh=wYR+v2mdGZMLGWYFyc3YXeS168gKV1HRSfFeOK/0/mw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SkDyOapEp2jkn5PeSxgZeVelgYAx5815MagRNye1j4z4Bh8mlLLokKF/85ImJD79M
	 rgGVS4mrWFSFLxACj5qcyowsKnOx0PTuNImGCA1YYaRQLmq4/Qj7IBdklgZ1TuvhcQ
	 Xyv+VLRMRWjQqnP8hT1qYDTVmPKWeONsNbAWEQ7fU9TKR7l2gfOITPP5Iwrxqx5Cqs
	 /MtHfKpKuOePCglS2TbBHzNT5FUZuMciPm+KhusXiT8hTBMHabEoNiQHTze2/JDLdk
	 KA2ws2HV2MsXj7731jgQCfAgtqoXVOyB/CO8w52aF9w5Ln92fMCNNTLPjPDNPbbXMk
	 K3mPUEiZwz5fQ==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, jack@suse.cz, 
 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+1cfd29c242c7cd26da02@syzkaller.appspotmail.com
In-Reply-To: <20261012132218.106771-1-ngocthang2710.1999@gmail.com>
References: <20261012132218.106771-1-ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH] fs/dcache: annotate the lockless d_unhashed() check in
 retain_dentry()
Message-Id: <20261021-endabrechnung-insofern-stiel-85a15aa120d1@brauner>
Date: Wed, 21 Oct 2026 13:57:14 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ohpQB5WQrXwaNpd16dEsBhXw8ko3wee3J5RAfgvYGPk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdWDGn/sia/1kTGucduGxoU2bIvM/xhPGpOTNtEy3Vf
 FOZTdendpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykZSEjw+bvR+6arqjWizI9
 +kl//YW4RaZlEw0WKnflphWnCudc8GD4p8noKKPjuq6F9//sT0IJVblrVrwUMa78r7GQ5ZH0vSu
 buAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 12 Oct 2026 20:22:18 +0700, Nguyen Ngoc Thang wrote:
> fs/dcache: annotate the lockless d_unhashed() check in retain_dentry()

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

[1/1] fs/dcache: annotate the lockless d_unhashed() check in retain_dentry()
      https://git.kernel.org/vfs/vfs/c/5a298355d8e2

