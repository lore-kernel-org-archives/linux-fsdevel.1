Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372207;
	b=seIyCfe4a3MXej8tuC5SB3y5jOvaX+Z6xcjzzQf6/Bz4nZ2ftAHA7WHUIzrpKrv//NmZ
	 OAPNGGFxKbULhvCNUf9zfZrV0On0sRMzoO95UwKlEsbVTnY4BsfB0Qb0WXx2fFbJ+HTDT
	 ge0TEPKxoaz8o9OryKTNo497IuDsh/am1fQ0sqYke8rxW2X/hwNAGQr6urMEre8N+MDpc
	 aQLDoCvzdE1YgDi+udKyYKn3XJ8EIUUyACJ0Je1jdgAvn0p93Ya8t6aRzzxELe0jjRHKh
	 wxFEIleG0rYe0gAqzh/oVCi1JI59krAsY4K3zyOOLY9HmnUB8ZBwCovFj6/sdYAWOQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372207;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=+YF+v1dNguT0ji48f97fFUgP//UB342uvDZm32hXdz4=;
	b=c4RRntDQ2cCn9caOSq7bJhwsWFGpLdMjLr52HUe2YGg8BvXFaCL6h9AyHFff4WuVp5xf
	 CT8Yqnawm27iZP8rGfxDWavgwpjREXND88KLnQOK2o4X1jVpS6+5bP5yVwKELMRkR0G3C
	 aoMY6pFAtFlDuN0D1vGj9t3+jZaiso3yOOy3awaPb0A4yHp36XXpTld9R5ydFZBIbH+HG
	 5i2naWOLiCUJRDAPqL28PXAtTevKcZr5MdCET6kNIvyGJ4W5Tl//2WwGO/tfK+Szn5KrN
	 AtCjq324XTJfWO0jeBKhvT1tAPxQvfZLB0PNUx+pCk06ySQ1WegmhwainXspGS7iRmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mY/Zaw59";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED47606A31A;
	Fri, 30 Oct 2026 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mY/Zaw59
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AE71F000C1;
	Fri, 30 Oct 2026 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793372206;
	bh=+YF+v1dNguT0ji48f97fFUgP//UB342uvDZm32hXdz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mY/Zaw59ABpCATRKfpNaVWpWjx+PYvx0uoFKpoRf7tuGJqg9V8mNjQzssL0Y7Aslr
	 /7MsKJmiSxhlESmHp9NhXyokp+17Kj3s3yrTqIHdCiW5fl9mu4tWJJzybcdysO85PH
	 u5KruxsyqXc6ictftQwlcIJK5N4YnSrsV7lW4NcqPZllS9xg+Uy0kxR4MW/5P88XlS
	 /aiu44/7cPIr5SWJwsza4bgN3KIMfGicR5/gOYP4u8Dki0Ks7Hndqb7NvaKGShRDiD
	 Y0Ciu2OqIJzqifHoKBh5/6UeJ7/APHO74TMZ/wuIPijLkDypXBDN9IkzyrxatrCMEJ
	 PAZN3mp+OZp/Q==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, Daehyeon Ko <4ncienth@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261018051708.2422394-1-4ncienth@gmail.com>
References: <20261018051708.2422394-1-4ncienth@gmail.com>
Subject: Re: [PATCH] splice: avoid stale f_pos writeback on error
Message-Id: <20261030-bosheit-einmieten-abkoppeln-f815d1179ab7@brauner>
Date: Fri, 30 Oct 2026 15:56:43 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-ce4c1

On Sun, 18 Oct 2026 14:17:08 +0900, Daehyeon Ko wrote:
> do_splice() snapshots an implicit file position before calling the splice
> helper. Since splice does not take f_pos_lock, another operation on the
> same open file description can update f_pos while the helper is blocked.
> If the helper then fails, the unconditional writeback restores the stale
> snapshot.
> 
> For a directory without ->splice_read, a file-to-pipe splice fails with
> -EINVAL. A concurrent directory mutation and getdents() call can advance
> f_pos and refresh the filesystem's revalidation cookie before that failure
> restores only the old position. The next ext2 readdir can then trust an
> offset inside a directory entry and copy data from the adjacent page to
> userspace.
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

[1/1] splice: avoid stale f_pos writeback on error
      https://git.kernel.org/vfs/vfs/c/79b496ebe382

