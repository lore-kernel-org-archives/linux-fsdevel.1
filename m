Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1E3CCFB0;
	Tue, 28 Jul 2026 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223281; cv=none; b=Aj8/kazoSTt5q1BWznrwAWhhuuy3levjP1pmNdRUICiEx+wgABZbUeS2lwf/BwD7tkrZVlAb6iwv25rCC97DECKGWQAucMdsZH6nMY4NaNbJFp7BuUmZ2H1fPeAGz4TCqgdYBck4So2V/aoaQnHKwT4dcG1NLmFkuzqmZWgXeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223281; c=relaxed/simple;
	bh=T0IcT2Aw/BbUMcESWWH6BFmQ5UAyAqHHUr6zG2ZuoMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cY1Z8hMPmSVL3QRoh55qdCy1Zailc6Sz3gUhOO22cUfdv5Xpqj13zOhLbt6tS/nNnBkJj72v/fEAUYv9hN6/UM61g/XczTnnhXsEXliuUSJJmkqyc2BCYvpPWde3FvZir/oRMjK0x9x10p72ajQjmiIpKuNcuxgk8BUadsytB/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiIfdgpD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiIfdgpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548D51F000E9;
	Tue, 28 Jul 2026 07:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785223279;
	bh=Cz0HEGMHvi6672g4zR3eKtcU2yN+n+I1/NYW49iXRFI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FiIfdgpD4G/b72irPLtd2zjmpEu5fTrYHfJ9XuYcf83IXG2x0Ev5b+zKjukzBTAl6
	 FbkFBy7FxabbFNJG3wkf/ACPcW/EbVSTtEt0vmPuR0Qyk7ZzW5gQ7JRsQ7uP6SoxfP
	 nmMdxEeinxV2tWwrcnbCsPXJjky/9TRpENAwkZybkXiaIIpFUk7eeL5kMFN++UVvfA
	 y/ae0wnE9E1CMB5bIgZesvMUqnUcPIhwgE1hBOYYxiR3hB84uKR8tI6HbodoBCzak6
	 gHuA+Oz6KmaIGLqiALFtc8SMqaPqE8k6bIRyazVkAXyRvlUz/WvgrXhCuVJFbbyqQ4
	 0YoVZzakIwfrQ==
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260723113452.566619-1-dhowells@redhat.com>
References: <20260723113452.566619-1-dhowells@redhat.com>
Subject: Re: [PATCH 0/3] afs: Miscellaneous fixes
Message-Id: <20260728-backen-zugnummer-jetzigen-e4af6030028f@brauner>
Date: Tue, 28 Jul 2026 09:21:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-cca4b
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=brauner@kernel.org;
 h=from:subject:message-id; bh=T0IcT2Aw/BbUMcESWWH6BFmQ5UAyAqHHUr6zG2ZuoMc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlROQeWm5UdDqm1qfgzLVfL+a6H/0mdr2rU5n/3/b8J
 l0+d4GpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO50MXI8OXgjpfWK1VyDz7W
 L3y4rGH3gYu3e2TUr29pS3OYGSxZm8/wm/VI68WjLks7vVUuOBjM+aj8yE5/SjuHeeedBynm7Zb
 nuAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 23 Jul 2026 12:34:45 +0100, David Howells wrote:
> afs: Miscellaneous fixes
> 
> Hi Christian,
> 
> Can you pick up these miscellaneous AFS fixes, please?  Note that most of
> these are derived from Sashiko review of some rxrpc patches[1][2].
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/3] afs: Fix afs_fs_fetch_data() to set call->async
      https://git.kernel.org/vfs/vfs/c/d568a43f6dbb
[2/3] afs: Fix afs_fs_fetch_data() to subtract transferred from len
      https://git.kernel.org/vfs/vfs/c/222052c6be18
[3/3] afs: Fix UAF when sending a message
      https://git.kernel.org/vfs/vfs/c/4af1ec68d54b

