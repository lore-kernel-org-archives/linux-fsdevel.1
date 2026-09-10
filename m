Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82469427A03
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027974; cv=none; b=D2s/wbakMQm/osANm3RZiT/XtpiAHrvHp5BrTaVkNLzlkAN75nRoTiYGYIwNPLook+x95RtcpKceUpP5Eg0DBY7qyeOqgd0aBGeNgzO5VCQHdSKnmVBoPUxGvBvkhv5gX4evk+UHT1q7HCLiiqsl3zCvcSxQdMMQLoNowsOhFx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027974; c=relaxed/simple;
	bh=HSsR1D6YAiS6qvXqcrb1LH4mIXd3lsKpfE5AaBxfve8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bZeZZkU1a/yAL0Y9DIUo09U8SKQWltU7rJLZLlvO9YXUMNQMlFRsuIrn5PqNaSFbpIrFHSUOymaZT+BIO42nV+9gnhix5cS5wjIMXar8yREp3xkznLIe/hEZ7ONWixjFOAKRAeoeqIDHoFS2SNNWWXiHmiWkp3BzjfNRTyHisfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrabAK9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrabAK9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291D11F000FF;
	Thu, 10 Sep 2026 08:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789027970;
	bh=e+xrVpYRyO+hCzyGFmTMTFziknLFRhlwkBmcBBRs4d4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HrabAK9s/JndbAZvAdv19nl59e+NFnL0fCNKzon3H2yJJ+ozLfvAI8jyIYuVyG+yJ
	 LWpogfXXGOOc7cznoF6HE4GeMxroL71m8AzS7PahEpD0fAJuTiUPE/gfYeZOrDqX+0
	 c4/iojwxdsjK0CjSwTyktqbOTEAB+DDjK8QV2A/H3qFcB/st0UmvP58mQPIxcBIS/y
	 pPAVvwvmmj+OjajEFy6rxrd2MOVDavDYcsW80vAunJgNnf4XmshtDPS6zA5DIBPaCs
	 RoU0nFgc1ht9R9p8o5TAnDbxrwJO7Dlz1bHnBAYwlmUBDNSSWLHVNvrLw0/XaoFw+E
	 GFtmbFhHpER3A==
From: Christian Brauner <brauner@kernel.org>
To: phillip@squashfs.org.uk, Ray Lee <hburaylee@gmail.com>
Cc: squashfs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260908130103.272230-1-hburaylee@gmail.com>
References: <20260908130103.272230-1-hburaylee@gmail.com>
Subject: Re: [PATCH] squashfs: fix inode number description in
 documentation
Message-Id: <20260910-bedrucken-wipfel-beraten-dca08f04b19c@brauner>
Date: Thu, 10 Sep 2026 10:12:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HSsR1D6YAiS6qvXqcrb1LH4mIXd3lsKpfE5AaBxfve8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtSqu/MWFhu7DYhetKNjsub87wmqPpPfn3ZCWOnMp39
 abddrdWd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkyjWG/6lH9jyV7TPVsxNa
 FtK55oHUdvXv/drb9yS/XbyctyhdupPhr8CRD0scZVbutUxc5W2Q7V7n5mMxw+nqj/xa95dXmqz
 iuQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 08 Sep 2026 21:01:03 +0800, Ray Lee wrote:
> squashfs: fix inode number description in documentation

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] squashfs: fix inode number description in documentation
      https://git.kernel.org/vfs/vfs/c/bfe240aab4a1

