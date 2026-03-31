Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CBD3E0C66;
	Tue, 31 Mar 2026 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950201; cv=none; b=AsNxjnu2HrY/aMEES9Chrxn2SrVuahxtbR7fY6axExlDl1w32nIg2qtIqQ3Q0SdYCPD6vafxPIRzWroVJYG1WLun7XtlHVAvuexIYh/2OxWXttmgzIf9f525GyJ7fQnHV2iGuHKSBboa2yt9RWUkJqZSro5B+BD7u+53iTYRsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950201; c=relaxed/simple;
	bh=WgkT6SsBoBVjujuygTqBx7Rcj7mTs0RtMvOfqXkcG5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBAEjiKkiWuc9IygN0cY+khHJ+WhThnYCrKHsB1KGsiGzqxPJLK7kJsaaJeuzQVj1vYoCffc8BW6G8m7YPbI24uNWZTm9AnqMXVyujF+b6nPzIH4vJ0JRaMhmE0e/xhdkQCbPwmOki9XLB3Z7rTfV+GiG1DffJB5K2BobKosqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUUM2pcV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUUM2pcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3325EC19423;
	Tue, 31 Mar 2026 09:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774950201;
	bh=WgkT6SsBoBVjujuygTqBx7Rcj7mTs0RtMvOfqXkcG5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUUM2pcVZGQCb1gSEsT9rnrDzjmsEjzltt/oz5lYmnzHS5HysLMiuKb71tJVB4ugJ
	 U9L0vg+vjR7F7S1f2s1ZkRJKOt1KJHyce2lwXHpw2ZN+7E6MSl87bk18I1EQdLYgIS
	 PL2WNxLuUrpDq6W9cL3QXZBfl45KeRGelrVW8WUyWdHRv5TVawMEyomGyu7lXglSu6
	 ++mH3dk4Dydttl9DWvYtas3P/aIAd6AUs3T8/2WWFJBgsnsxtdOgsdftw4sAT3gxlV
	 npFc/uyy3CKUFEH6Rv6jPra0hjIMveZruSId1FXk1eAxzZUrhmrBA+EP2hyTehE6Df
	 MOIP++jRkyGaw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: write a better comment in step_into() concerning .mnt assignment
Date: Tue, 31 Mar 2026 11:43:16 +0200
Message-ID: <20260331-lawinen-basen-f313d878faff@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328175841.3390950-1-mjguzik@gmail.com>
References: <20260328175841.3390950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=brauner@kernel.org; h=from:subject:message-id; bh=WgkT6SsBoBVjujuygTqBx7Rcj7mTs0RtMvOfqXkcG5M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSenm5qs/kGx5mW+4pGvJ/FHa+fszC4v3fjm8St8kfNC lml3STZOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiXcDwv1oq/E27c0zQGoup itHzXjzpV4ybfMVYh6mD8V0fY26uJyPDTcbp5b9XWnIYXsyZ+ibhnXHujTZ/sUP3r6a5+FvPMeP lBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 28 Mar 2026 18:58:40 +0100, Mateusz Guzik wrote:
> 


Applied to the vfs-7.1.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.misc

[1/1] fs: write a better comment in step_into() concerning .mnt assignment
      https://git.kernel.org/vfs/vfs/c/18f2e0ea200c
