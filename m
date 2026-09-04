Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB74A441C;
	Fri,  4 Sep 2026 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519488; cv=none; b=kDJoIu9D6TIhiV2v9+Z/eK80kl/gW5TfuFcVy6W25riYW6WTFE+06Oyj+2jscRA54QSL/nPTVi505UEklCS6vWV/CdUvoyHkuq3rCudd770YiR/aTpTsZbQVJqrT9pIl8rr837scmDZ1NNYJX8Bf1Ry3xFWnP8MiPiBCin7kMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519488; c=relaxed/simple;
	bh=WAu37Wf9tMkWpoYzMfRhp+AkaKn9p9AEbTWk1OVWxNI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D+aES2U8g06p+T6LgpiEClya1Dn286P7fduRKSIHHzvy4F/+5f5Wuxxot9LVRVcF2zjZ7H8/THzL7mccBrPRpP/qVelttyjRYkoFbWkYseM/rYamgD6kD2JCVx9GaY/7gEwGe5NHyaGwgDQ9HX3yQU8G62bT2cAC5iv1MKZlvGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym5Jg6zg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym5Jg6zg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D251F00A3F;
	Fri,  4 Sep 2026 10:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519486;
	bh=Bp0VHA1PwQw/uqdYstlZ0IWSYQFCuHVceyAYmCy4GKg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Ym5Jg6zgWavoQEPClP1C+O17d6qWP5qW6Nr0PodZGUnBoVGoqZd4pcFMOH+2hxrkh
	 XkpmGoyf9jMKNpbOAEDzhopPZFTi9XmJHAtnrbnSgaM5pNLr90DvPns3KD1aBvD7+G
	 rsXZR0xdZeVbUA84vx2ETzSX8ZcxV8lACHjirPOXyaQp8AlhmDTxr2v4LwqtMUHchS
	 0mS+JpSSOhdeIX8zlJSXo16go/4jPqmRKvapXecFhcOkZL46ohHimhM5odiFjfw8a6
	 kQSkS0gXxQmKjIw7S5M16AmNeBkU98BxsP6+vpy/AomQE9XyDkC1gJmEK5ZH5OvO/U
	 mle2oekg4jVUA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
 Tao Cui <cui.tao@linux.dev>
Cc: jack@suse.cz, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
 lxc-devel@lists.linuxcontainers.org, Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <20260903033625.1042796-1-cui.tao@linux.dev>
References: <20260903033625.1042796-1-cui.tao@linux.dev>
Subject: Re: [PATCH] devpts: reject max=0 instead of silently lifting the
 limit
Message-Id: <20260904-umgedeutet-gegossen-narzissen-bbf3fc243694@brauner>
Date: Fri, 04 Sep 2026 12:57:50 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WAu37Wf9tMkWpoYzMfRhp+AkaKn9p9AEbTWk1OVWxNI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNWmJ99dpah7B33Ul3/jDmLNldwed0QJrp5s5a40+PD
 r+0VFa52lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRnGcM/93fvBdh/72CJf6g
 ysfZp+4sF9ERfXHVnueCuPb1wGn7az0Y/kr1S1TvvP1961/TjrzDKqGl/gtLVPZyMNewbgtd2r3
 SngsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 03 Sep 2026 11:36:25 +0800, Tao Cui wrote:
> devpts: reject max=0 instead of silently lifting the limit

I'll figure out the Fixes tag.

---

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] devpts: reject max=0 instead of silently lifting the limit
      https://git.kernel.org/vfs/vfs/c/7d1d1a34d29c

