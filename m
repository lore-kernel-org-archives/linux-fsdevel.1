Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956550;
	b=F0xA2yxJQ68HVOUkGjWnJkHL7wzgvNrY6NfMBuI/ePWIhXyrr8ejxZ9uZ0+x0ox/W6JC
	 /1QP4Cp/ZkalV3s88xjxzRtwyGEgQeVay5+E7l4YBf2o5x6KJhGLQ0AtZaRmceYyk5jUt
	 FbL3LU4zmHyoYI9y8JX7aEuewbHUkr3oVDxjx6wO81wqgeyFsYHnylBjXeiOQ2Nwo2Qp1
	 coRY6wTyU6F13QdFov/qqd2jdP5vXhDZZoRaJvCN5rHc+nK6w+2bYVLDYsBAmIPBrShwp
	 GQyRZ6s9PYWdK5szcy1BVXHO4C3D55MIgkG9NyugXqPOzCp+dh/BUuEhIaOr9cST2sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956550;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Ichcn6R1WA+kVr6ejRwn+uYrwL9UqNqqT+ZrDzCqQlU=;
	b=WxoNoh9UulJOUYkH26Skxdr8is+0pTGGNEWT8S0lIF3jlomniFIPT3YioCPMhz5ZStyz
	 oUzcD34YY7j9+O34qADx6ulztIqJz3g3auppJCGW7Tv7b8EnqumktxhYEiMXSaXiDKEJN
	 FJcJAHh7nCrQmPWrQ+NgPQb4ziGqjG6f5XRrr0S9FOHmBc5IwfXpG6+nks4U3Z8DZOVbb
	 RzKehHWy7gH9Jsgb2lQZuEyeuK2ssGXtEaIqsFq2Tdh/Xi3//trl5kkWXFJuM7pqldM7g
	 OPlw/peAnnoUgtFgmQrIRXM/y7iclLcsVD+lC4LUHOd7fF4ock8Jh/QY48wdtC3DHPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CR6KPJIi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC09606A326;
	Fri,  6 Nov 2026 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CR6KPJIi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012CA1F008A5;
	Fri,  6 Nov 2026 09:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793956550;
	bh=Ichcn6R1WA+kVr6ejRwn+uYrwL9UqNqqT+ZrDzCqQlU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CR6KPJIiAYWgaVFI3RlaWUf7+QTpIe9G5TGty5Cs8wzHctDd2+y55HNlFY5QpprWU
	 CotY0QXCKCuhgufyaGNDdgopzknZGZtcwhcMpugccp8+em9ee1gdTv4VEyx7hJrqrV
	 M2jVo789nCaOAfE2KGXpZYUkqmcS/zzH7hSEJH/Ig5lXK+cQPY2EuyG/SPtcTR40PN
	 tEse04g6lUBTg92d7oE55a9mGYbaqTB4at9AykOviovXddRjfnVQ20ZJKHwxxusZHX
	 R9/7kUsL5IC/5g1uQNP/ofsRKO3LXgKAyMgl/BllHjGT2rsXbdsGMnLr9ksK6sDvmQ
	 YvjU3ifaN+qHw==
From: Christian Brauner <brauner@kernel.org>
To: Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, 
 =?utf-8?q?Axel_D=C3=B6rfler?= <axeld@pinc-software.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261102141714.306719-1-axeld@pinc-software.de>
References: <20261102141714.306719-1-axeld@pinc-software.de>
Subject: Re: [PATCH v2 0/2] befs: Large file support and a superblock check
 fix
Message-Id: <20261106-ungemacht-beispiel-aufgearbeitet-e038f1941ca2@brauner>
Date: Fri, 06 Nov 2026 10:15:46 +0100
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.17-dev-ce4c1

On Mon, 02 Nov 2026 15:17:11 +0100, Axel Dörfler wrote:
> Two small befs fixes I originally sent in 2019 [1][2], which never got
> picked up. Rebased onto v7.3 and resent as v2.
> 
> Patch 1 lets befs serve files larger than 2GiB; the on-disk format and
> the implementation already handle 64-bit file sizes, only s_maxbytes was
> never raised from the MAX_NON_LFS default.
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

[1/2] befs: Allow file sizes beyond 2GiB
      https://git.kernel.org/vfs/vfs/c/cd1fb89d09f9
[2/2] befs: Fix allocation group consistency check
      https://git.kernel.org/vfs/vfs/c/f51cd637b410

