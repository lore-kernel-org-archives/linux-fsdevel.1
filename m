Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8C0470444;
	Tue, 21 Jul 2026 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663617; cv=none; b=o3eQ/vTmEzzf/u67XWnPD8w4L1BKC2CVWUEB4G+Tej4wyR6UrOIRCmcT3nKGHP+SaCcYwhi9/BShjpZiB/+2zMSurNeK786Mn8e6VNCYkogxVtQm5KCcvpq+a4uWzp4mHBKu4PeBoC+QG1BzC0xHJsIuKdVswQBAVo2gApeCygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663617; c=relaxed/simple;
	bh=JqvfSiC7cX1c+lScMhu4+cv07tUy79gb7YGS5lz10Fw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OUnCLE1t04GdlMTxpEwbCOP4WujmhMrO7WrRIyFKasLXy8JO7UkrN3fxoNsBqzgJOSh3jkgUEplAylNhhuu8Yyfk3fKiDVXlm4yytBkqfh0ZVZTEkYoGGLbkUz3ucomk4kn1M2ly9SsgW2XX+EtC8jNn4ObO7NxAWBiPPz2z/wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk5XTw4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk5XTw4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6011F00A3A;
	Tue, 21 Jul 2026 19:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784663615;
	bh=2ggrn9XyIKCQny1JL5vrXSp37lSngaz7lY9EDDxQuY0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Jk5XTw4aKLXtLTktilXZPUmOo0PqyH3NgG5jfBGrVWTXRGsbtPhdIsUIzhegSFIUg
	 QBVGsKKbvNBTj/aHJSloLM1Nt2uZsvmpHSMQJN703jJpHK+noNmHSgD4dpv5+nJjhI
	 /8fHSMFkdSk72gzCY4k3hM3RqItlnAanbqeQTp23c69vnuWKBq39xbXMufgdsolwM2
	 Rr7hHH3GU25+T87O/G1cKtZ1fR2HET1yw+fn2BWYHNXHJiXaPFZb4lQotPTddHI8xG
	 J5gfRu7q4OEAIJN6qPrErrzbaOoBFh7ElDDG7KOs7k1s7agCeKIJ3KtecvAy8BfgXL
	 Z1dQcGiBwHE0g==
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
In-Reply-To: <20260713220932.413004-1-amir73il@gmail.com>
References: <20260713220932.413004-1-amir73il@gmail.com>
Subject: Re: [PATCH 0/2] Fix for unintended FUSE ACL cache
Message-Id: <20260721-windig-probieren-neben-887a66d13db4@brauner>
Date: Tue, 21 Jul 2026 21:53:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JqvfSiC7cX1c+lScMhu4+cv07tUy79gb7YGS5lz10Fw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFn7NzXHPpaWHErjLPM627VhXsyt3k+G3OdrEH8T6z7
 hqrnuW72lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR37YM/7NY9uus3HPixHHn
 f9kqNw7c0xeyaz6txnxigR6H4K/FSqWMDHNvLY3zP5K/5+Dx9MKKWXdv7/wiy6Rh+HW9Ruhao90
 XjFkB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 14 Jul 2026 00:09:30 +0200, Amir Goldstein wrote:
> Fix for unintended FUSE ACL cache
> 
> Christian,
> 
> I bet you did not miss fuse acls...
> Ghosts from the past have come back to haunt me now.
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

[1/2] fs: preserve ACL_DONT_CACHE state in forget_cached_acl()
      https://git.kernel.org/vfs/vfs/c/85f9e659787f
[2/2] selftests/fuse: add ACL_DONT_CACHE regression test
      https://git.kernel.org/vfs/vfs/c/67eca5c355be

