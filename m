Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009937;
	b=eFzyygeKeRFoD3TyA7VJhFnltCF17HgNHfavOFQTMPvv1RXjogNKtx7A0cmbMT/mE0XO
	 scfG3CAvmNYH8/vNI0VbiGSJORXU6R1JdfqEp1Lw3zM5hmeMP2QgTjqq3aoRH7PwhUIbr
	 VY8SAuOzqg4Wq0pRjB+CWsFrp4JiPiWxQ3I7BxRJofFgwapIK4cTMekU6ZoMT5siCOgBo
	 12aRg4e+WKib7T2x7Hidx2K1bVNI3UbkcuOLkFbmugaVc1Z/B4LoAC45quu4DbbUg5tcR
	 3DdOInrQf4fLYwd4uE9erWjXQJkgh5J7S+63sjv8JmE8B6YrYTiGb8+QcvRDXt5tArw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009937;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=fadJbRdwnT01mpVtOTOr/DR2sXf6oKH2cpwR7oHbpKE=;
	b=crs9vI9bFP4N6B9iZ8ygHyDjq54OxuN6UKgehbHPzAzqgAYVRJEPuardeJhJWzMXcwkT
	 rmbKj6ueCVvEIk6mjX3wJFBW+4qlbMwK9EnYfX3bChRmIza1J9yX+psQGhi2jJKpOhWxr
	 xWlXmBKc+IqCWpN04Tw6uUvhROircSxMEmZ+BdBAI21YaXrHny8dIM2sX+S8y8MhYKy5D
	 L+Wzfu82ixVEeN3LUsGCDYAqCYR9JUpUPG6hXes7FS8Nk3UvhAvtx75OI+X3qk96FZYHL
	 MWTiJYz6n6DPeQf8Mnlhne2PCu/SBe1Ffqo52NT7f63eEC7ZuFcPt1aCszLl/GjSo3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAFLfsLi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976AE606A31C;
	Wed, 18 Nov 2026 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAFLfsLi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C6C1F000CE;
	Wed, 18 Nov 2026 13:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795009937;
	bh=fadJbRdwnT01mpVtOTOr/DR2sXf6oKH2cpwR7oHbpKE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cAFLfsLi2bo7R6VadIkjGduO1sPGao/qItOHf7NFXu0NFytl0TQeGSYusNFviTAyS
	 gx8be/Rcg0I8YmeC+3B+r4fUpjZFzuMhOhZaLNK8dVXIR8NZwiUwHKBFZ88hhH0o38
	 tRmponS529HAy+EZg6vsZ0Kv5f36iXtQK+o+rBBfJZOSurojFdoZ4a22lmMWCmWqfh
	 dMYf5q8VhiCfdoEbKETWqPcE4hWtkp4gdLH+qtDeLI58F6cZe0ebFV4TklkvnX0vwh
	 rIHO72nUB6an6sF8zhQzLgalweDfcKjstsNjpGC4I6xRjOtHBbWZlzhxCTQAhCMKs7
	 mtCl6/3J3C68g==
From: Christian Brauner <brauner@kernel.org>
To: willy@infradead.org, jack@suse.cz, corbet@lwn.net, 
 mohamedalibouhaouala@gmail.com
Cc: skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-doc@vger.kernel.org
In-Reply-To: <20261115001334.23026-1-mohamedalibouhaouala@gmail.com>
References: <20261115001334.23026-1-mohamedalibouhaouala@gmail.com>
Subject: Re: [PATCH v3 0/1] docs: filesystems: update VFS locking
 documentation
Message-Id: <20261118-anzweifeln-umtriebe-mittragen-88527e288aaf@brauner>
Date: Wed, 18 Nov 2026 14:52:13 +0100
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
X-Mailer: b4 0.17-dev-04696

On Sun, 15 Nov 2026 01:13:33 +0100, mohamedalibouhaouala@gmail.com wrote:
> From: Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>
> 
> Apologies, I accidentally sent v2 instead of v3 in my previous email.
> 
> Please disregard the previous submission. This email contains the corrected v3, rebased onto the latest upstream master and including Jan's Reviewed-by tag.
> 
> Thanks,
> Mohamed Ali
> 
> [...]

Applied to the vfs-7.5.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.misc

[1/1] docs: filesystems: update VFS locking documentation
      https://git.kernel.org/vfs/vfs/c/fa7f1d6a9213

