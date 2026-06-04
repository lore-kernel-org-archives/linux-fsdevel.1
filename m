Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68302E65D
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559884; cv=none; b=Lw8KnorIhHnmzEOG8baUZMF8HydMrSJKIGJ8LmEIUxACkxbUN2inSzQ9Bkf6QlakkjhW5+IjvrBAZq80hv+xKJBXGgJleHAwGY7KtWf5DiGjFT15QB+kA2Tb8BuGJZKRqOH7GL/j22N6mYTHXn1mhra3vsJl+uK7+qGf6brkpHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559884; c=relaxed/simple;
	bh=YMxPTYDdkF7IraIgPYc3h7RQBdD8Sm+l8+ID18AGRN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+JbnlFKFLNte+ZNF+lBkOZj3YsUJlxJGRL48mKil2lIzc1uh+xBC20hTB6hTSGYeJlg/+iMcsKLe7LfCEgKsjwqmP0hKhx4yRWen6rLbEseH/gGF7+Pt9MokzsKmCaqnVWnZrHeUWt4e9dsyrIZn8henCXdYGi71BSnsvKLyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkznYE8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkznYE8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6238D1F00898;
	Thu,  4 Jun 2026 07:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780559883;
	bh=iXXbESo9eTqVGR8ViL/VB7dGhYfkScoezT3jtnMYi3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KkznYE8pUV7SKXSiKkfStYEzDnNYvVdcMD0/Z7ujuC+tdxnv1Jo1HnFRNeSY1gREG
	 IqAiPcTMJLjEocvOTnL5Scs6rdbWrXaHFzASHlch3P4IzX0mryIiMhaxvsvf93UGaa
	 Rl5pGRRVcUT1iLAyAPCDJB87DX9o7Xd2sf5oQrl0y9zu14RvAUUXbasFvOLV0Gf/76
	 vQA/2UEZtUryQkYAj7NPRA06sxiI+E27xD3o1HdsL9OYWi8lsjcRP3OApG99mvQqWw
	 7xyyXVjfRaiLpi6bCzR4fAuFTly9p1rRWOat+B99XhSX3sZzrvwcR4jZhwRZihJctZ
	 QiAWieG3zYNRw==
From: Christian Brauner <brauner@kernel.org>
To: djwong@kernel.org,
	hch@lst.de,
	Namjae Jeon <linkinjeon@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Add IOMAP_F_ZERO_TAIL flag to trace event strings
Date: Thu,  4 Jun 2026 09:57:59 +0200
Message-ID: <20260604-einnimmt-walzen-nieren-153b3e69f40a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603144031.7370-1-linkinjeon@kernel.org>
References: <20260603144031.7370-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1017; i=brauner@kernel.org; h=from:subject:message-id; bh=YMxPTYDdkF7IraIgPYc3h7RQBdD8Sm+l8+ID18AGRN8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQpGrCvYFULDL/cv2bb0t/ztWzeBstt5nr5iPMTf2jfR 4upTdxVHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMxm8Tw3zE8q+vA+p6/+28y RlzdLrw+W1zwQaloXhqfwKfvMR3s7xkZ9jX76dp8KQ/qzKsT0/wgOf3hu18H+x/ZF7Y0lwhm969 iAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 03 Jun 2026 23:40:31 +0900, Namjae Jeon wrote:
> Add IOMAP_F_ZERO_TAIL to the flag string mapping in iomap trace
> events. This allows the new flag to be properly displayed in
> ftrace output when iomap operations use it.

Applied to the vfs-7.2.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.iomap

[1/1] iomap: Add IOMAP_F_ZERO_TAIL flag to trace event strings
      https://git.kernel.org/vfs/vfs/c/26f7aa308824
