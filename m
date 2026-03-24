Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59521DFF7;
	Tue, 24 Mar 2026 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364944; cv=none; b=loSL6UjplzOo5gLa8JwGBHykW+w2g19zhRxmd1ri8Gmf6GAZZe49pnYO+wZYJ4HQ6cqbShl5Z7MkSGJneErQcm7YnFe/UqGGPt/fY1tG4d+9p2yo+43pbbc+QzYHgi0+mp5cXgH71GQ4HJRpn6rc5gu8An8Pxeg5yaRICurSpck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364944; c=relaxed/simple;
	bh=RQ70HQsVYWmPm/K/HyN+iwWbjAfIhPqjVv41JZUYmts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIRMCDPssLi6l8fGsdIvHLRtP/9jmugkJnck7U9iyJz0dgZ7SGwJOKCcDssDOEzo+ZD1v4Z87R7HKY/svZ6EYZe8kSNyF0NTNgZgmAko8UvDqpUzaxsodJQJunerTV2oyOZylGBZ12Saei4Y1huxkXWA63yLIS2JjgYYbsvXCIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ama7c9Oo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ama7c9Oo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1B7C2BCB2;
	Tue, 24 Mar 2026 15:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774364944;
	bh=RQ70HQsVYWmPm/K/HyN+iwWbjAfIhPqjVv41JZUYmts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ama7c9OoYQ0W9/2yIkRLOxF7NdEaqt7KiSBbIFfyFPgsJxb52FdI81A+ZKpMVZyB6
	 Rnq37MkUhpuUWLsOr/ZlrXSTiarF158G3mhwvu1IaZ847JHteA7hSxs1oazdOBwp/x
	 PvyA6k+CZCAcS6kHFk0jLt8Otdj1A7CyUYmuF4jTcn1Tuwq/vuYvXCwu9++ivDByvZ
	 eTAjla3hB42rmclFzSbua1tUnaffm+z5qZuIbIa1eaSOhXCnxMb6Rnc16kewCO/Cuo
	 IJ5nH/DVGQvlTohOVXbZpDR+/QT1FyJqiFlCju/rH5UhRw+Fka/oJtMx3AnyDsFobA
	 emkyJuetJLL4Q==
From: Christian Brauner <brauner@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v5 1/2] readdir: Introduce dirent_size()
Date: Tue, 24 Mar 2026 16:07:00 +0100
Message-ID: <20260324-jargon-infamieren-1e00d08c01ec@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c20d2f8f6817a39401155cfc80f0dff88df116e0.1774350128.git.chleroy@kernel.org>
References: <c20d2f8f6817a39401155cfc80f0dff88df116e0.1774350128.git.chleroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754; i=brauner@kernel.org; h=from:subject:message-id; bh=RQ70HQsVYWmPm/K/HyN+iwWbjAfIhPqjVv41JZUYmts=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQeWvGucPmCXk5pNYZYjoenWjckKLbP3L1kWuk0Nu5dE v4eC/j+dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkYS/DH07riKkc6z7unOO7 WXTl5Ne6PmZJSw+0TBXTOLuCcXfNWkVGhjXi6+QDnjesjlv3S17gpfgCh6qcxS/Se6d8exioePR 5AisA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 24 Mar 2026 12:41:15 +0100, Christophe Leroy (CS GROUP) wrote:
> In several places in readdir.c there are calculations of the total size
> of a dirent, which contains a few fixed fields plus a name field with
> variable size. To add fun every dirent is of a slightly different type:
> - struct old_linux_dirent
> - struct linux_dirent
> - struct linux_dirent64
> - struct compat_old_linux_dirent
> - struct compat_linux_dirent
> 
> [...]

VFS CI: https://github.com/linux-fsdevel/vfs/actions/runs/23491121925

  x86_64 (gcc, debian, ovl-fstests)  pass
  x86_64 (gcc, debian, selftests)    pass
  x86_64 (gcc, debian, xfstests)     pass
  x86_64 (gcc, fedora, ovl-fstests)  pass
  x86_64 (gcc, fedora, selftests)    pass
  x86_64 (gcc, fedora, xfstests)     pass

No meaningful VFS AI review comments.

This looks pretty clean to me overall.

---

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

[1/2] readdir: Introduce dirent_size()
      https://git.kernel.org/vfs/vfs/c/4bf798e027d3
[2/2] fs: Replace user_access_{begin/end} by scoped user access
      https://git.kernel.org/vfs/vfs/c/b98f7363f72f
