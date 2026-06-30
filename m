Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B76B3F20E9;
	Tue, 30 Jun 2026 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817446; cv=none; b=AaiCC6dobGwnmx6Txwscf5O+fj4XaXt4+c+Le1sNAoQDKWqXo0+ipcqtW6C967scVZ1DV0TS1GnZE7xfiM0Z/BZe9y/0ufNuM3HY21L9ao11GPsLqtnfOzh4XhukzwZ/m3qlz3NzUmOOctVS/KhnKU8SpsDslh7j7Cg7ispyjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817446; c=relaxed/simple;
	bh=RWHpyOEtyX6yqJR3jEUD5twW6Cwi4YSA+TMJMUcPXhQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ubeiBN0ImTHZljPi+M3Tb+4xIDN31hH8HrDXVcthB+qYDFhcQ92xwZTIQXi72IpIqdgmbPeCDwTKC9RixTgucfxJHnLRyUh3ugT9sy/2RrAJIjJNY4+E5IH0PLA6fBHz16BmXVQCghrIaLByLgNWGNzS1DUfQVpwC5mrP8mS5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzopgjVZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzopgjVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760861F000E9;
	Tue, 30 Jun 2026 11:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817444;
	bh=gMOSiu1mZi/pCjzvabAmavJIa0nJN1dnMEdBM7PU3Bc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CzopgjVZIoGX2ea3iGDcSybUopaxukBhSwX0Wo9NuMb6TosQPVQ7W3wTZ+Ynf2rYI
	 qbNcSLISPFPAMxJ976Q5GYYRR3y8wPbOQV3z0lj97EuDaM8GafAEjQFtpHr/eic0Kx
	 7Ka+eslZPqnwtJOlOWFyH6HyFop0UQVovfiwq+A2MlqX0hOoqg0fg3B7FFAIqwcy83
	 94GgMXhcvZ3300RxiuY4E6+HmrTan/1Pb/yvVT24SwwE4JkFFBtLKSiRoAd4QO/9nA
	 7t/Ig7vjVj27fHeKsU4D9lU/JYE1NOR1DBUpXk72gzR4SOUBT7KH6G9rCt+/Pw5KCN
	 tALqYwWCWocnA==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <20260601032911.940507-1-guopeng.zhang@linux.dev>
References: <20260601032911.940507-1-guopeng.zhang@linux.dev>
Subject: Re: [PATCH v2] fs/namespace: notify pollers of legacy propagation
 changes
Message-Id: <20260630-schokolade-epilog-waggon-dd4e2d8930be@brauner>
Date: Tue, 30 Jun 2026 13:03:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=905; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RWHpyOEtyX6yqJR3jEUD5twW6Cwi4YSA+TMJMUcPXhQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5L1rMYLDM62LLu9mzuJ11jBMMTbr3OYntYndT9M1qf
 Vrp8smqo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMYEO4OAVgIlL3GBkm/LS+1Zn/J+ae9fHt
 xyLWNYqmXz0/9fvfyQdWtidcfPUwluF/5J7IBM3PUx9t+LKBVaft+rk/vLHMnHdKl2j27r/zaLs
 DHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 01 Jun 2026 11:29:11 +0800, Guopeng Zhang wrote:
> fs/namespace: notify pollers of legacy propagation changes

Applied to the vfs-7.3.mount branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.mount

[1/1] fs/namespace: notify pollers of legacy propagation changes
      https://git.kernel.org/vfs/vfs/c/0ae44a20835e

