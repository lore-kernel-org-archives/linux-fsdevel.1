Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5703FF1C4
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785227431; cv=none; b=n6QIZw2qjtN0nqdjfj3V5AqKHybV3VeB8YltmX3sAUnHUIEMd31fdC0rukGPg5fYduWfbPvrKprtd6umXyyhFjCyQIN0XfeC+qOaKHyDdmAc9FV49iaoXt4MhddO15wtUexwiKb2m3zWz7nckmxUxAMds6819VFGBIZq65Irus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785227431; c=relaxed/simple;
	bh=4t4Jo60dIpLaCOaHpZKbcolRvh5txz8Is8mVqGZz+8s=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nas9XeehA7wnqlejiLkHRx0KjclofM8sDVTZBVllThE4Xq45l6mtMgSGxtQqmvdqEArHZ93i1r5SZL8azATwd6SwsCV/nJh6H7yvPhNriE4ZIGClDtP3QsWB4Lzmt3NL0xOSsrdwemLfVDEF4eFEfn5EGPDgKnN030rc5vb+h94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf3aAowP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf3aAowP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FDE1F00A3A;
	Tue, 28 Jul 2026 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785227429;
	bh=cH2WNnegzAkJv3pY5RRBpyqgQIzWmqScJrw35nO5M2E=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=gf3aAowP6xvkuJKps01kcxdIvzwY6XnP4QDCWS+Bst0/6hTYov98GsVid8LOEALUz
	 Jlwh2A0le1KrQ1HEXnklEfUiHzAzfFt4kNwkZPuWyUZWN5suciGY8dtVF19ui3UcGw
	 Raapd4PrLoa+v7QYqX+rjStoCEk09YPufAUeYhjEkug/60C4lQJlBXklSAtoi6GsKt
	 sGcqCbYLvFC516WVzLlPyl9zKDZIkcyGTH22kMaYGSaIR3lkvcrh3YH2Nn4y/n1die
	 ZuSLnomkTWCTexB5q8JbZ+cU3p1Z88UChvVNDb6j+gi+LW0ptx7whbXfQ/LN1jEZV0
	 sowm7FcmKoiqA==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org, 
 pmladek@suse.com, arnd@arndb.de, johannes@sipsolutions.net, 
 andriy.shevchenko@linux.intel.com, linux-fsdevel@vger.kernel.org, 
 Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260727195730.2306887-1-alex.hung@amd.com>
References: <20260727195730.2306887-1-alex.hung@amd.com>
Subject: Re: [PATCH] seq_file: rename mangle_path to seq_mangle_path
Message-Id: <20260728-gelyncht-erbleichen-werft-86527db8c3f3@brauner>
Date: Tue, 28 Jul 2026 10:30:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-cca4b
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4t4Jo60dIpLaCOaHpZKbcolRvh5txz8Is8mVqGZz+8s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlZCw+PvXIwzvTmUNOyxg9eMw7ryzkQNzkU8n3tz62q
 0rXcdaX6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIgCLD/5I1oaeuPxSQnmOy
 7O8/292P3vRYyjnUPVWIZRG+eN227yYjw6yXGoLHCniql8e35Xz5sF4mnp0rTJWlfWfh47fJV2I
 3cQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 27 Jul 2026 13:57:30 -0600, Alex Hung wrote:
> seq_file: rename mangle_path to seq_mangle_path

Seems fine.

---

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/1] seq_file: rename mangle_path to seq_mangle_path
      https://git.kernel.org/vfs/vfs/c/b70cb1ebbf87

