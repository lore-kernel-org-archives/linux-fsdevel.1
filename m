Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CFF3233E8
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302319; cv=none; b=mk2XoZKmKlPQ0BN4RzoGZZS+q7PxIKMMt+CTH8yrhUWdt6OQzQha1YsexPzir/0u+kdNLzNdr9tqvgugiL9CnmfwQgCWw+FtO3QUI05rKXng2rqdUsn+oCBIpPgXxgJ+VquamRJlkK/WGK3doThOZqX9FSj9ZGVCp8QBa6/KnSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302319; c=relaxed/simple;
	bh=fmbCxgN5AAnWW6FzNHwFYQoqabTxWok3DqL4GVCXrTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFSCn8QmFiksHsjnsFkiEwMrQoIkPpStIqh5ZAEdBkao9ZtGVMmQytzXOzkckqHyT0neJNmGj4vLJLZ97HclHwRyw60bRX0HtacsFK5q3UWl7o7HF2Dsnkfe7NPgdspvH0odRHXAbd1ZZbYBTn4Yumc20bvZkkr3EzFfSdOX5hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsHl+q/L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsHl+q/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747D9C2BCB4;
	Mon, 27 Apr 2026 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302318;
	bh=fmbCxgN5AAnWW6FzNHwFYQoqabTxWok3DqL4GVCXrTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GsHl+q/Ly9QHdr+VBjVemHv+ReNLoN7Z/u5gB+sCKeBCrVRZjEaSmfOS3L6Mf+R/u
	 8DHP9n3IcO3jP2qLoh4Dinxxujh3hrPerY1VhitjQ/jJncruA+TEciK74a0ZAm8HU3
	 O8BQyRzh8fRrf0G0Aj9/gdQNVmfYrKpBqjZIli2BLNb+V/mTBrxHBJ/rWYH71JNRx5
	 9Ueh+LW/o1S3klKxUGdeQe2X26pi0mqfYYxwfgjqN132KnDWW+/HshHmggQpS8mLfF
	 pMzcPuOYUk5HN7IMeCE/J6A1x54eBVBIYrouPeKYyhzwVcfNmRAGRpvRSGcqCoR87x
	 Q4Tdsj5AUI94Q==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] docs: add guidelines for submitting new filesystems
Date: Mon, 27 Apr 2026 17:05:12 +0200
Message-ID: <20260427-labyrinth-kocht-7d51d2f837e4@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125212.1743006-1-amir73il@gmail.com>
References: <20260422125212.1743006-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; i=brauner@kernel.org; h=from:subject:message-id; bh=fmbCxgN5AAnWW6FzNHwFYQoqabTxWok3DqL4GVCXrTY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+r9bMDpOosXUWWv2OYfYFnjiPiwXRXlx1b74nTtzVq blm36ljHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpeM7wP6d45jkR27tux+dr iX8wulMS8uGplOrBlJexQt/dV32au4/hn3XCxnknDR18QmzetoQ9nnDTVsP+vYHv13N7T22/NPX pVC4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 22 Apr 2026 14:52:12 +0200, Amir Goldstein wrote:
> This document is motivated by the ongoing maintenance burden that
> abandoned and untestable filesystems impose on VFS developers, blocking
> infrastructure changes such as folio conversions and iomap migration.
> 
> This week alone, two new filesystems were proposed on linux-fsdevel
> (VMUFAT and FTRFS), highlighting the need for documented guidelines
> that new filesystem authors can refer to before submission.
> 
> [...]

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

[1/1] docs: add guidelines for submitting new filesystems
      https://git.kernel.org/vfs/vfs/c/b34d597faae6
