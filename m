Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D921C16A;
	Tue, 21 Apr 2026 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771343; cv=none; b=LzSKzHoAVIFAtXgC1OBjwpR+FvB+5u8qwPDETaPOUca+a0MKB9BkmFLmhnHE6XK2oCVU/wsZkqFo8uD3HE+o4Guu63rFmVR1v3u6YWHSn1py3FCPqz21zBe70xNvflxMq+JEoisisRRshJKRcV/+jkDCgf1bQPzvqP9ojda3Bhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771343; c=relaxed/simple;
	bh=TUdRjokcQfFGyE2LkzyPJjmUUQri3UC6MzBwVN+Nlmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQxtBLs4/Gd3xdHW1uYPfD14ruR6NldhCtHxfEVH7L3zfHdKGO6btSzAGEqAPvMJV3wGhC4WHTTAlliVttfjsk86J402UxtLanqc6WiTU2js/jXOAYZgqa8JW66dPm4ckIIyOZVO6KbdVGlVvRXcvq4MBmG9tWk+byvoRhMxQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyswKJQd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyswKJQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DADC2BCB0;
	Tue, 21 Apr 2026 11:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776771342;
	bh=TUdRjokcQfFGyE2LkzyPJjmUUQri3UC6MzBwVN+Nlmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oyswKJQdZ4w6WhOwqNvl/ewdeiVPwaknlLSPBskkSrsrcn6cPKC6/xca+EK5sbWgV
	 ZSUxIuigWXhVF5k98H9Bf/J0zRqtuJZdYOtSHSYZ4+p4wZtibAp8ctV1Zs34PzX90S
	 IeBoDKeb7qTea4IpHdfixsKaLjxweOj8a4+vUGWpdvGTCfwo5XQsEntsLnjFAMNAph
	 KptrHcVMxFFZ7Nbu+XA1IQVsoxxzT7pVJu93teDUHMeLb7XQKIi0LVZQepu4IK7MF2
	 GRvhDTUTxSkteYifPMqyi3lefGvVAJhwRvUJF17i6cQYfnCtEjTTpyLVgr774suL7d
	 KdAxwoNQlOx3A==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] dcache: use kmalloc_flex() in __d_alloc
Date: Tue, 21 Apr 2026 13:35:28 +0200
Message-ID: <20260421-zucchini-kelch-6d9bf152ce29@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417094238.551114-3-thorsten.blum@linux.dev>
References: <20260417094238.551114-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=brauner@kernel.org; h=from:subject:message-id; bh=TUdRjokcQfFGyE2LkzyPJjmUUQri3UC6MzBwVN+Nlmg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ+T+TMFFvSU3Zt6na5LfnGtlPXcNc/mep0wUL0+1/+z Q/r7imv6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI1GeMDBPVWGfUx10QyWKO bL8YU/bN88VX9fVn5N+c7c9iX9WiUc/wz4b9g1ple8nBBAMpq77OA7eT5stGGEt8FP7+xCvGpdO EEQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 17 Apr 2026 11:42:40 +0200, Thorsten Blum wrote:
> Use kmalloc_flex() when allocating a new 'struct external_name' in
> __d_alloc() to replace offsetof() and the open-coded size arithmetic,
> and to keep the size type-safe.

Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[1/1] dcache: use kmalloc_flex() in __d_alloc
      https://git.kernel.org/vfs/vfs/c/4f521e4554a7
