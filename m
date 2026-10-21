Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579792;
	b=0Fho5Wj5n/8IeQndQGWSK6PKFKymckwZATzwnEVUumHLTF57LYKelnFObS0kQGYLO8He
	 HSKEQELt5BbPx9QbgXiwwfCUEErXADy6NmGo0c2jPOpF4uaj/2TLvulxoewX7rsUB4QIP
	 D1sAy3fwnOpiBoFivvwQs1MIi2QuEU1OBQ1pB3LaaTZK6f8IFs2LuNBEYiNRLtCWdbxd5
	 Uia7pvYsO6+Qd+A9IOIsuadbBQG4z+NoMYi9Vb4DwB/nvKLPYFZhTFGQima+5nJzYUEWW
	 1HTHIKTPI+uqdV9f3F3voqcj6ZTXJISIh6e442Rf5GWj+5iVZ5U+OAwULfEdxtXraHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579792;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DukTZR04O4Mf71QQ4MqD3hsXZ7E8zrSwj1aEE7Lmueg=;
	b=wgoegNSo45YXDTZJAjQLgY97gb7bKC79y1j3Xlm2q9zRZ68lcZRhP6s04TqwYAaHMpsy
	 cicGJORie/O6Za+20JVJIN1iGOM4Wq+3wZCrYdvlL8+1foTMJCjb0ixpWniG5+BgsktEL
	 l0lbrbizvAOc3Rjhj4v5nLDgo4nLI2i5jgn5UZWhtgCMTrSQpBaS88OiEWjaWFDGv/rPP
	 BJV0wc6bU/VBM5iGKsFRUJ6aKV9hYwca6JC8omgL6gGppuWh1sDSGzJYLyyKYypKlHpOR
	 y3hP4yJfVStb3fXTqOJMjwli5mXzxgYm6FlHFkASlRYfDDqlR9jHUI5O2qgmT8CukRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1pxnqeW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D8B606A31A;
	Wed, 21 Oct 2026 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1pxnqeW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AAB1F000C9;
	Wed, 21 Oct 2026 10:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792579791;
	bh=DukTZR04O4Mf71QQ4MqD3hsXZ7E8zrSwj1aEE7Lmueg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=d1pxnqeW1QcLQQ5UEaTeXj3nsSV9eN0z4G/YkHtH7xf2mtv2PBIaKiqoDx+/yxB6z
	 G4+5LwyVUPyNSkS7Zhx/M2DfVqWKlYH+KKJ/eJv40z7n6GzB8j9F04K78IBF9/bBlX
	 ouY9CszuZNAJf2xqZHGU9/D5GWelYBK8mBFvBvmZvlvHX0qMvoFqGW2Xt/+t/yUlcZ
	 C7lOeglJd8NxjicAZbg0QGQnkqYpYLfMTXsSMzZmQOjI/ERLtoWGwEfuFZUpjBGxQp
	 wd/VuBO4mC6X2+DxeRYI6PSWkDRemH6qyzUXWShgjaTgC08yx00kj3UUBnI1IwuA+q
	 viTRaeg5QxG5w==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Andrew Halaney <andrew@amutable.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>, 
 Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees+treewide@kernel.org>, 
 NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261016194650.1580988-1-arnd@kernel.org>
References: <20261016194650.1580988-1-arnd@kernel.org>
Subject: Re: [PATCH] coredump: reduce stack usage in vfs_coredump
Message-Id: <20261021-hochmoderne-anbringen-backofen-82be5b386e1e@brauner>
Date: Wed, 21 Oct 2026 12:49:45 +0200
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
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9+GbO+GXMlcdKTMM7/6xB3fARjLNG1oyJ8iSnfvMG68=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdmHF6U6HGTva50zm51hosueexJ3JztXHc0SsCXG05X
 ufPV7GzdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkzI7hf6WM5Zn2hKt7V934
 d3z2jYkn/0U9XHyNbeKRdc+DMrqMJQ4zMiyQyGVJUTbV+tt217Waa0PF99rO41O6fEsm3MqMnaw
 7jxEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 16 Oct 2026 21:46:39 +0200, Arnd Bergmann wrote:
> coredump: reduce stack usage in vfs_coredump

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

[1/1] coredump: reduce stack usage in vfs_coredump
      https://git.kernel.org/vfs/vfs/c/5a7e104cc9bb

