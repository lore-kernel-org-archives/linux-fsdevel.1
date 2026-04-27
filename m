Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FC333B6C4;
	Mon, 27 Apr 2026 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301052; cv=none; b=cXfTKBmvLIHXpp/bJtVL+G824XFqtsEKntnh4ppqsO2cj6jhW/dQbJaeJRvH3LGZISFODzfvIsHP0dnqDNzAhYJHzRJwYGFDWvXZXJj/10QbBZS1vtV0XjWVqOs7QbrMhbycxyeaCQ+JZqFpannBuV6AnfcmuAc4XhCfpcTwNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301052; c=relaxed/simple;
	bh=fhFmDqoCr8BSADddTdlY0vTA+S9G5d3cwgcPQKhdgE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCQ6GDx9VBB/bEdr7X2nCp+AI1SdVSpf9uVEI5FSLH7kWGlMDtVRMh56AH2AKrrXqYEO5uEg0qBx12fDv5YfuGfZgGHjn/pxIDtJMjDYG/RJG89Wls/s5cCnUMpDv6tR2MRy7LtZktcBX3BPOD7VLw04T6u+FjDpXxRG/YTKPBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcnEbMVX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcnEbMVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99808C2BCB4;
	Mon, 27 Apr 2026 14:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777301051;
	bh=fhFmDqoCr8BSADddTdlY0vTA+S9G5d3cwgcPQKhdgE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcnEbMVX9yABKd0B+6mHZ4P/FKfJUnwFFOpu/+Vn3vJFAqg5kbo5CNjEPHLbnCRf7
	 t0rF8AWS5NIamSWxjkYrfWhGcyDsptzd6kaVxiHmenSv5A6nfiEvEnT36IvbvUzsOh
	 7NiBmksuCmqMo980IIyR0Z4EubOFz0mrk808OBAUTppm+Ozzb9k+84oHGDCgHDkThB
	 7hvM4IDIOfK9o7zVukTOgvNwGRHYU45CexwWBAp5amaySQ0NwTKe9Ah3Qgu2a+IOab
	 iv/WIeLva1kkq9gwpZk4yvsnE5qRHL151JegavDZ7jXpwzQAv1iM4w0dmpia+/X5KQ
	 I2R5itp2GTrNA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: retire stale lock ordering annotations from inode hash
Date: Mon, 27 Apr 2026 16:44:05 +0200
Message-ID: <20260427-bauzeit-beipflichten-35fc65e409f9@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423170431.1483370-1-mjguzik@gmail.com>
References: <20260423170431.1483370-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=brauner@kernel.org; h=from:subject:message-id; bh=fhFmDqoCr8BSADddTdlY0vTA+S9G5d3cwgcPQKhdgE0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LzN72XS5KWfBgvLgQ61nVr3ffVKYkblgxs8tXlfPf r60akKgeEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEPnczMqxLely1ysf4rdCm ufc6T/yU2uzycVFJ5vmCkLevy68vfdjI8D89ZH7MJBvl8F3HGZPfLrnu/sHd6IDnen/Lk0+1dk5 gFGYAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 23 Apr 2026 19:04:31 +0200, Mateusz Guzik wrote:
> 1. iunique does not take the hash lock as of:
> 3f19b2ab97a97b41 ("vfs, afs, ext4: Make the inode hash table RCU searchable")
> 2. s_inode_list_lock is no longer taken under the hash lock as of:
> c918f15420e336a9 ("fs: call inode_sb_list_add() outside of inode hash lock")

Applied to the vfs-7.2.inode branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.inode branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.inode

[1/1] fs: retire stale lock ordering annotations from inode hash
      https://git.kernel.org/vfs/vfs/c/8edf31f99a20
