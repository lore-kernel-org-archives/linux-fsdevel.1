Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6502441629;
	Thu, 23 Jul 2026 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804023; cv=none; b=CAA82lWAXNzQJGFmqV/b/Vjnf7SMf/ss0EHCcEA07XL/rDPprhIVco6I2XRVF+M5W37AB/mHVRXL0TlX62AYutOFbl7VB3ZmzIvX8GbBbiNA/2+fBXztdCfjad9MJn59tW4kXQpdOIyZ6tBVQBurj6NZXpVNMYdLUnDSWk3JNmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804023; c=relaxed/simple;
	bh=Wm30Vx/JbMXGzUO9YkvsKMWzk1HWoZFAWySUTdHij/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JfLcopy2NHMtQm226+nj93yjKX0y8v5XGR7zzcelp8MoHat/FmcDbgH4ueqyUA8ZJJNEZw5Hgwne+5glHJzcpgKiqfiuqNNfJmBD4KOyXgX82hRPLSMOej7jWoGd0qcbSN7JqX8qibA5NStPe7BYs7+qljGidvRtkqbyNGnUDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTzSoNgs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTzSoNgs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34BC1F000E9;
	Thu, 23 Jul 2026 10:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784804021;
	bh=LwRRlOKk47crI6h/dq7+Q5T6X7dpKxp0KGJ7w5WN9nE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DTzSoNgsmpJ/L97G/x7W57Dd2/zOJpueLEnLi+xWjDMMWL3dRPPt+corxuJpw4RUW
	 PGb8BRd11l5RUc4fAVASDL9UpBSjTRYOBERMCWiHEAMQ4sY78+KsSXAcq19XMFwYlP
	 JbdQ8PI5alFkymw/UCDvekSseoLRmY7EF7b6AP91hg7Ghpww2OaZBDHWnQj34kECqZ
	 safN4aTOrleqKmP7PiTF53P1TofyJDt4Cgkw759oErhVcALIRzZo2jJWnPYgW01ekY
	 wQW6rDJic8sK7TbDw7qtKlf15d6fmvxsTocaAlQMmKcYoj7vy/owYNH1dNzTcYAIqR
	 8p+2OMM1XAgTg==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Guidong Han <2045gemini@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 Qi Tang <tpluszz77@gmail.com>, Junxi Qian <qjx1298677004@gmail.com>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260718104406.27897-1-2045gemini@gmail.com>
References: <20260718104406.27897-1-2045gemini@gmail.com>
Subject: Re: [PATCH] eventpoll: pin files while checking reverse paths
Message-Id: <20260723-blaulicht-datum-bissfest-0d4b5058d225@brauner>
Date: Thu, 23 Jul 2026 12:53:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-0e65f
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Wm30Vx/JbMXGzUO9YkvsKMWzk1HWoZFAWySUTdHij/0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlfto8PWrNOrW9jjccKtZOE7/LpC2xZroFw0r3C/Zvr
 d8k3Dxf2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARV1lGhj0nzaRCTuZlMHuv
 auYLMn3kdWkf/7rfvAVHOAu23+JgyGFkuLnaMWENU7iyk4q15JXPEuuObWoO3b+T9e7r4/r/Dz6
 ZyQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sat, 18 Jul 2026 18:44:06 +0800, Guidong Han wrote:
> eventpoll: pin files while checking reverse paths

Thanks, this is a good bug report.

---

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

[1/1] eventpoll: pin files while checking reverse paths
      https://git.kernel.org/vfs/vfs/c/5d26e9caedff

