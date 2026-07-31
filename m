Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8722E3F0
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493989; cv=none; b=pR6nURSl1MuUnBF2uL3TvFk1si7+eQC8NLaVWORo0CCK+adwx/W0eqTpWrhV/DgcI6ciCakI/sB5NrN6qmpoH2X23e6UtwDnwhlU9vd+dT+KGGxdXDJ/DLhTc9w83lxKQLiRGudRfc9KeUY6EyYszmW1594qtmrO4qZtUFmrUzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493989; c=relaxed/simple;
	bh=PAcQizL/J34VM5kbDYTIc+4V9JcxRhT8azr7P0wiTCU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L9f+PKBqkZUISFNv71gGsahf3CGtMvSh8Cu806dwhIbUvzdrr7GE++UZ86HR19SsaTLShYVCCjeJMeYaAPs6y+0ciX3vuWEOXINXdv9DpOcath3KS1AovbzLLslqfhOrXYgp1mdOxJvCTwhqbMuuLqrShlQESQqvJmoilF0N7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqIepPqb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqIepPqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D521F000E9;
	Fri, 31 Jul 2026 10:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785493976;
	bh=3oOi7+50SXOiwo00/ilgRWWOUTeLD10A7UgJFbFsRtI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fqIepPqbxVPuFXtkivzcGftJ0lpbfxqmQjjogCoZEaNqm+hrLzTC1jqvY08RVexWI
	 7UJ+TjzpJhPLcDzkqocsoMQ2w3icaq9wo7ApUU76mS29IY4fbobDImd67OIR2IEzwh
	 yiEcmWLCB6LTb1kC3atHwNQU3WyPvS7+7k/llez6vh7/k5kzDL7zw9qI8JeJeSMfjK
	 JZpjbvwcVs9F8//Tr+f3lsQpoZv6yZijAQr6zcKsY2L2/36diQtodpCTxtjdoGEgk6
	 Vj/UE2yPu+zbXxkhWcniYOBoGq9Blcc+Lkg78abzkxBSDIs9AQhY56dzIAGgnif4sQ
	 u5rAFAubH1ZBA==
From: Christian Brauner <brauner@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: linux-fsdevel@vger.kernel.org
In-Reply-To: <20260729151320.21001-2-ddiss@suse.de>
References: <20260729151320.21001-2-ddiss@suse.de>
Subject: Re: [PATCH vfs-7.3.kthread] initramfs_test: use test init/exit
 hooks to override init fs
Message-Id: <20260731-rausnehmen-wangen-herbst-5427d5c51c7c@brauner>
Date: Fri, 31 Jul 2026 12:32:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-af865
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PAcQizL/J34VM5kbDYTIc+4V9JcxRhT8azr7P0wiTCU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTlVF6/cDfGZmPqbKkkztxEnsavLm8muftqL36m3iE6M
 Zr/69GcjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInotzIybPxfHhCZd1fR6rhy
 4tlMm56JSR92Op1buPvb72bvCs935xj+Kac9n+7+8GrDGjvuy6q1P/fbJail3mCdYStWL67lG9L
 OBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 30 Jul 2026 01:13:21 +1000, David Disseldorp wrote:
> initramfs_test: use test init/exit hooks to override init fs

I missed this somehow. Thank you!

---

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/1] initramfs_test: use test init/exit hooks to override init fs
      https://git.kernel.org/vfs/vfs/c/da46f0e1053c

