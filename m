Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740DB3CAE95
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445266; cv=none; b=QRqtTBvwXxDFMveBnLc+TgDPpepA5hlBxEq8/z8gZz+J4hZOH+vH2j5QdWYse25fvpiiVNIcuUAd8LTjyb7W6NpL11wceTzjcnW9dk1LZblNYBHEXTdYn3D31dSveIBdo1+OWwSL28mle19PxQQQXz1Zq+Kf5YCi5NUgdGWsKBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445266; c=relaxed/simple;
	bh=/YCv9Nx7VzBApomziiH/saMuJoQUiqs1eIoxwoJkd9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOuQ/fu7ILnJBqMoLRA+xY456ZdCBSy0nHu+hm2VENJDF8hg28X+uNzZf0LTR4FgxHHeBK7YIxVu6/Z9vlWOO0ZVdGwi3qTNcTJSmuR9ZZA7p8Y6bXq6ET8bBOmmeaDBqsTZMaVNL1I/zCwBX0w09m80JUeMlXjh0o/Syznncas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGyTnem2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGyTnem2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE3F1F000E9;
	Fri, 22 May 2026 10:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779445265;
	bh=c+P1bJG/MAnnSEZjJ81P3L6nA5SKZie2QXTWcaXddIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mGyTnem2lu7UedsfYl9lXHpiWSub40Hof87tADzXFkL0b7zB9liRZtkMTyJf+jE/q
	 uoCrh6p4/Mxr4/eq4x27x/eOns5W/o9p7u6XIVgEppsR2gHmUedQv8xmotJhE2fd1/
	 Yrkt9YdL65wqO066ogDavDKF5snh4GxbDgUI+wudflEhsvmok9COJ+BXGESeoVQI6u
	 EXNVrRe5sYaEyZjbAI2ByGseRVrwXaBP/BCJCt/3bIQt+FyclKgVQeG+TCcgloPQwO
	 0q8xrB1ukKGP4EiOxp3tf9OA/LPAkLErFKgNnF/wU9JuiHPpSx34+VifSCJI5/VoT3
	 XHrtLJDXIsj5w==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] minix: release the sb buffer_head when setting the v3 block size fails
Date: Fri, 22 May 2026 12:21:00 +0200
Message-ID: <20260522-zaungast-weitreichend-herkommen-9e6549634e9a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518130330.529085-1-hch@lst.de>
References: <20260518130330.529085-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=967; i=brauner@kernel.org; h=from:subject:message-id; bh=/YCv9Nx7VzBApomziiH/saMuJoQUiqs1eIoxwoJkd9w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQJ6PGG9YanF+QX366/Y3nlbbFL/K1XYckx6RbqN45+N KlO3WTfUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJErkxn+StwWmXvu37Fn83OU GT9EBnF/+/+m8Fz8rsMWKVpTZ1f1LWX4HxWiHW69sHjZg0Cr75V56ywWF2bN3fombImARt7c2ft WcAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 18 May 2026 15:03:30 +0200, Christoph Hellwig wrote:
> At this point the superblock is already read, so jump to the label that
> releases the buffer_head for it.

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

[1/1] minix: release the sb buffer_head when setting the v3 block size fails
      https://git.kernel.org/vfs/vfs/c/988c918b812e
