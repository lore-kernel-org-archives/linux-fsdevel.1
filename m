Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE51DED49;
	Wed, 22 Apr 2026 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863311; cv=none; b=tbqPOgfUYShEHqIIZ2BOFbJRKlGo/8Wn686xjxFpSjKbxeXn+P+/dy1pMWjmQmsfelt5CiJND8jFDRdOyuWmm6c7gqu5LsddPp5pVYJQPJYcXzPVJfaxjJpnRgKj77adONdk4wlYPv7+GIklwthb2fpg6uoQGUQuUKvQk0Smw/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863311; c=relaxed/simple;
	bh=b2nK61g/BJzumPfFQoDu0SDYMk2XBywmSVrI1tNHd1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEyFbQ+wwqEcub9sYXAeQDR3kzOs2QwLoM0u5/3JtIx4AcZRnWCI2ZXzdcIIa4iGoJ8eVjGPWxVoBVzi/AplULDsd9/AWx1OXdHwZHUV6nEKGfP1RPf8I3s3g9Yk31VCYtPGM6ppufrwCXoUDgJL1OBBbLDY7VRM67Nsjx0d88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewUzbciu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewUzbciu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2625AC19425;
	Wed, 22 Apr 2026 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776863310;
	bh=b2nK61g/BJzumPfFQoDu0SDYMk2XBywmSVrI1tNHd1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewUzbciuxsD6nmFcG9r0Yhv2qAJr7msQvp9/EkHfaj374LCNvzVt152C1fEWu1CH3
	 vZyz3jG+0dyFRA/Q0LJZ2/1wEgGC7wKw6INU4PQ4mRfWW+1h9FMwp8yPQK9KvO/urf
	 qBRlFCp4sgZfPhIGS8P5K0fA2TmPGik+cLLYzZKrC27dIKYxX/jPao+cfvU6pz9FRU
	 VCIt9V6qk1VHpqA0vPujNYjAbjLM902norcsnhMbb+rtQ0RW0Dp2NL5l9JzIhF6/JH
	 ubOfmT4KJAN7qyyrMO33yTeQj9ZM8jKyXYDxW7HMx15wVuywz/XNmJqh/BmnohDFNW
	 yGd2Vo1p0UBUg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] dcache: add extra sanity checks of the dentry in dentry_free()
Date: Wed, 22 Apr 2026 15:08:20 +0200
Message-ID: <20260422-darstellen-etikettieren-2f659f8a36f0@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422-dcache-warn-v1-1-50155e1b40b6@kernel.org>
References: <20260422-dcache-warn-v1-1-50155e1b40b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=brauner@kernel.org; h=from:subject:message-id; bh=b2nK61g/BJzumPfFQoDu0SDYMk2XBywmSVrI1tNHd1U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+OOEZ1PBc5+O8XNkTs6PWPbv4a3XmQnc+njzXBz5il 18vqfy0r6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAilz4wMtyIlcpMOXhG7vKi uhe7/Tg5v8l8ec/I97dNz9ps0q2MidwMf7huPHzIuFG6rKr+i+NrTt9XnpuPT3n5V07po1P0JcP /G1gB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 22 Apr 2026 07:29:48 -0400, Jeff Layton wrote:
> If d_flags isn't what we expect, then it's good to display it. Add a new
> DENTRY_WARN_ONCE() macro that also displays d_flags for the dentry.
> Change D_FLAG_VERIFY() to call that instead of a generic WARN_ON_ONCE().
> 
> Change the existing hlist_unhashed() check in dentry_free() to use the
> new macro, and add checks for other invariants of a dead dentry. Notably:
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

[1/1] dcache: add extra sanity checks of the dentry in dentry_free()
      https://git.kernel.org/vfs/vfs/c/94607391f5ae
