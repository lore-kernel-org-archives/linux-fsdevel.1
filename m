Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F64B1D0F;
	Thu, 17 Sep 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638020; cv=none; b=t72EL6S7KgN+pzYgzDXgCgHdZnbFdrlmv2JB6vMR2sEHqfMZhyw+TDFDgXqopek2kUPu85eVOKONtAW53hg0Qmddrxco7vIj9uSs6CXyu4pBxC0h6YQClfpg7iUjkDo8EchkBSI0w1s7zcTxpDu5x5qXK30Hb1Y31U/7jhMVpuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638020; c=relaxed/simple;
	bh=dYKhPsTzVH4KrFqy9k+jmhgSz5dJCz2S4pWY10zrzPo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mBSDAwCdkjfoWDMPRBZponyeZB/N30C/IyTzrtyBI8iDBZXJS/X/+28dMiSpC/wEqLhLcxnQesX/toroH5qJSL8dPrbGkAoXDmIM7tKRWJqQgyoIlz2o1EWDnbzPdn5vIVxBqTUgvUP09mExUGJFv1w30+/Q7qmwzLnrYlkmrkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj+pbhe8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj+pbhe8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C301F00893;
	Thu, 17 Sep 2026 09:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789638001;
	bh=Oer9j0DWbCwhco3vi5BHRvWEzq7DRzgjgVjzSG/KR2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Pj+pbhe8Qj5Dw9OpUiShqFgGBt1I3DkuWfnr6JonXQxPsPNmtCs+SV9+Qz1uzqtaB
	 F2fHUY/Ectz+DfzFM2YOzxYgqZ17inpfjymvVHnS9pwlW0v6pBGUKWPgkDLEeuhlro
	 sz5xlDWE5CEZCrjStzJuYzCy7oYB5wFZGO6bEnxT6uXgkaSZxTSH3CCk+4+ROAJyQU
	 Rip76Ah5eyACJ6e2velsVOGgabq5jdEA/EB9b5DJVR8dimgbm2MqkUIEWgZTOdTDDv
	 0nst5BX3m2Z4hCwG1CKiLSDkRvm5BM2Wz7Xcf1zJjHNWwdjbNUWvm7618QtS5y+dvX
	 t6hCSqEDTeDnw==
From: Christian Brauner <brauner@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260910045406.485295-1-shakeel.butt@linux.dev>
References: <20260910045406.485295-1-shakeel.butt@linux.dev>
Subject: Re: [PATCH] kernfs: don't hold kernfs_rwsem across notification
 delivery
Message-Id: <20260917-keimzelle-koordinaten-sparsam-ca35d792d848@brauner>
Date: Thu, 17 Sep 2026 11:39:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dYKhPsTzVH4KrFqy9k+jmhgSz5dJCz2S4pWY10zrzPo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt3ppr+UGWs6Tp/i/PyBxrhbznvEUrjjGUT9vNfWpV0
 9SFkfvaO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbia8TwV6j68wF2pRWiqT8T
 OU6nsyo8ijxR5JnxstRk0eNP6xk+uTMyTDvGMNmnfvmFXUzRi15LFoZvX/b+fV2tTc3ZvVtbH+/
 dxg4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 09 Sep 2026 21:54:06 -0700, Shakeel Butt wrote:
> kernfs: don't hold kernfs_rwsem across notification delivery

Applied to the vfs-7.4.kernfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.kernfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.kernfs

[1/1] kernfs: don't hold kernfs_rwsem across notification delivery
      https://git.kernel.org/vfs/vfs/c/23985e2b1f31

