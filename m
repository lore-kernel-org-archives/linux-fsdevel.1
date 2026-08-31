Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E4E3D9DD3
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164669; cv=none; b=ih6jRT6ikFA/eA6YL7s4SyjB7uyuXQeJPTBLCMrd4r2pX7WfV4rQukI01UTJG0fiavPvxYVLj7qJLYWvjR7r5BNdzrwubpKuFVU9GSvqHC2LmtZQ3FczCBl5slyiwneaLZf/wF43uhMO/QFejm+Bo8G7IFabAAXKICrWULlX/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164669; c=relaxed/simple;
	bh=FkS+ahJeg7qjw/WJy6ymJsQw7++6+VoDYDxKvDH4VnE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kXoIUWh3ooxuM+ZnVROjbcQBFQmGgRIPevLbh2GcVS6ayX5EhLeeaL5DgO3nmZypBddddwxWiCBO5wqss9+yXG8TFE8qBnUapfIq+bcuyTPa4GwGXUuCJVjHoPoWUgA0wgEKUzi/siQFXq1MdqCozcCvFvcxiFLMR9y4y0eHzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIH+tqDC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIH+tqDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C0C1F000E9;
	Mon, 31 Aug 2026 08:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164667;
	bh=7w3vHZVRtiWAtn40+pBEPBpBqysAP+0RBfzas6IDWxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZIH+tqDCQbbcvwJggqzPXx1Kj/5BREETj2bzF4F14xIKInbecvOPcSYCcSO6OfEzG
	 CAsUPUhlK+CUnaPWXBSpWcsKtc6FKDzW557T1wY2jOj7MKHE5AbwniuEm6ChU/ig/V
	 ENC4TjcOTKSbTyg8vL0z6aZCcX9DSMbnwao7mow2EABiMi2xsrPmyxk0Ib6P0VNlY5
	 3ovaCk1GvSVLpTCbLOi/rIA/vxhHdETQNa+D6x6KUkNrNrocV3/V5KsnRIajM+giBV
	 wLImMqA8y/2byuhDMKS5KNhjiIOcAE6fV4u1T0gIK8Q6YluRzXeOzIcwzKn7FqmUDf
	 KDobq6OJ/6O2A==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Manush Prajwal <manushprajwal555@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260813093603.1971-1-manushprajwal555@gmail.com>
References: <20260813093603.1971-1-manushprajwal555@gmail.com>
Subject: Re: [PATCH] fs: fix comment typo in inode.c
Message-Id: <20260831-akrobatisch-triumphieren-insignien-553c58ea40ee@brauner>
Date: Mon, 31 Aug 2026 10:24:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=brauner@kernel.org;
 h=from:subject:message-id; bh=FkS+ahJeg7qjw/WJy6ymJsQw7++6+VoDYDxKvDH4VnE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNtbJa+zH9802D7CNL7/wLmWm/cGdf8iHt2Wemfsz9t
 W+qoXdjY0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE1MsY/soyJy9/3XEj99Ej
 vXDv3yrLfSolHmbXr7vzbPX3iW65a7gY/uccOnf+m+NG3a83k+WbfQJaol55FmkLPHp1v9h7wvy
 CGawA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 13 Aug 2026 15:06:03 +0530, Manush Prajwal wrote:
> fs: fix comment typo in inode.c

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

[1/1] fs: fix comment typo in inode.c
      https://git.kernel.org/vfs/vfs/c/1906eb0102af

