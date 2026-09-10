Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612823C3F7C;
	Thu, 10 Sep 2026 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025620; cv=none; b=R8PAK1GA7ZVY07GlLNpBxjCwEd2BkHU2E9hHxtNKPi7AYTZc24hxfR9VSkFbZWVmdqTXy+wWCucS0NVomM0g8BiCWQACS9FyITMamNS4pD3z+bnVSFqv72J4W5FSxsHAq5MAWneTOet5C7vOraw170bgFZeGs1kJCvyyO+/HG9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025620; c=relaxed/simple;
	bh=1d8w7ui85/0qY1mROsA4xzHGlsvgDLaqoUhJlCWzBrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NV8k/Jx9Hy23LWF8Wf5UGONYKhW9obKms6v3N/IROHQaiYDWedOo6/1UTCPS4g4putlJt+kEXzPT5I0AIXUKBlfBiznaBaiPWDeN0JF6Ox0HKFIkjPlu+yvy1jcPNJafeDF5Rd88PgLFbkPXSUqUs15yI7XD+JK77zLGUB2FRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4bQpzDK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4bQpzDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB27A1F00899;
	Thu, 10 Sep 2026 07:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789025609;
	bh=aEAFRt1jQhk1/EtwU4Ewz84hGckJ+DFZBt6VeyZo+l4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=g4bQpzDKFWpJr/sKLAV8vyB+AW1vSE53/KgkamSsKW4SEzeTRJ0pb+Fobc/WNiUG3
	 lcLRJSCHfIyjTmkGtBcPwWfUc1yejwueMSFYjU/PzP/akqoQzNrinwYyyhxNKVijl5
	 dJY/3dPS89SHibA7EYQyeX2tTqXG4Xq0mcFrAKGgk7dafAYhgbPN/p45D5dH0XMIaB
	 PoS+Fw/sWAHWjFbub7vkvEmb3CxWTX6y4Hp2bxaKFLYEt6J8ftF5xCC/ufcp2/MxW9
	 AjNkP73qdopFFGTb2A52AajZ8+Zh5TSk1R7C6DMxcIkDrZzInKEB9Sih4ujpwf7h8o
	 q2Bm1qrIs061w==
From: Christian Brauner <brauner@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 codemender-patching+linux@google.com, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260827041732.188707-1-morbo@google.com>
References: <20260827041732.188707-1-morbo@google.com>
Subject: Re: [PATCH v3 1/2] vfs: Annotate struct fdtable's fd field with
 __counted_by_ptr
Message-Id: <20260910-murren-barmherzigen-erstklassig-8aefa4c88f27@brauner>
Date: Thu, 10 Sep 2026 09:33:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1d8w7ui85/0qY1mROsA4xzHGlsvgDLaqoUhJlCWzBrY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtinV9JMJ6UGvBdFfRf6e6nJ3niNzZfbrtsExE97rDk
 hK2KTMZO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS5cTI0J7+/e4RF5eO68Y7
 e7jmu7Q9r9C0OnFuEuuCMnOrqogaIYb/Htfiohaop14++Snp6obFzF13heX+tN4889R+adsUsWd
 bGAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 27 Aug 2026 04:17:29 +0000, Bill Wendling wrote:
> vfs: Annotate struct fdtable's fd field with __counted_by_ptr

Applied to the vfs-7.4.file branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.file branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.file

[1/2] vfs: Annotate struct fdtable's fd field with __counted_by_ptr
      https://git.kernel.org/vfs/vfs/c/b4db97b9ef46
[2/2] vfs: Add KUnit tests for fdtable
      https://git.kernel.org/vfs/vfs/c/501cbbd276b7

