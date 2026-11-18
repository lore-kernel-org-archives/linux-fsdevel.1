Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004041;
	b=4rIeBkqmXT6NIIylzV17BITociMNcRujjz/4KGpSFD8zZpXjesZiSkFesiFdFdg4ACD6
	 RDttPST+HdOGaJF4JPVtkydDbRBHzry3HU6XprezB6wqu5huOCDLI2COP0W7ZpUEeimdZ
	 KOqRp79cx1/WH86xfG9szovw1SDQLJ6WG2H1GWG3HoMJGMi/WFW1waq1vKg72hO0P1azb
	 A4J5BD1Za1g/Pd+x1EgNHPgxFxJYPJCW2x04U76jKZc/Eb9PH0BN3De3DDXB9Nf8omLIU
	 7wHNfHE5QTSbr3YcTyzJ5PqvCQ8M4GFkCDgZiSvOD9Gqbjer+iwG7mmA/1AxC0JVsiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004041;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=16+Tz0AONdk9H6wFwNcEZkKsrVFzK43MhOUaUVF05k8=;
	b=a1+nAnl///lChDyyMvJScxKn/fpphknPm5cEAfBuhsf14isJ4CynQUMzapq6XgwCwmQm
	 DNVJyi9TN4MIVGphInEslyjHinajReqMzboaNy1AK8nRPm3F+JP7R/MIFAFrVwE1uMOFb
	 x299onv933g8lyzREsuH8AVNJG5adgyxasfSEK/gss79drEqXbFkRWCg/IVQHfEMX25NF
	 bHrn4glxMrmJVwHrcPaYUpSfwSvRFk5oepoJCXuR5zcbkOvYM+mgBGQmK2AlTF0EmHoGy
	 GISPV96tHbqtHxIw2tF0lfJyRcVWXRmNi8ac5T8RsAK6t7oWZfXrz2AMz17ZXtVndcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MO1AazQW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FED606A31C;
	Wed, 18 Nov 2026 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MO1AazQW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B994B1F000C4;
	Wed, 18 Nov 2026 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795004040;
	bh=16+Tz0AONdk9H6wFwNcEZkKsrVFzK43MhOUaUVF05k8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MO1AazQWqgIOkSao401fZGNyqsd/pf2rgZPBn6Qm0PVedhbZkShpvpsBuLsM5ODHK
	 BZ1z7MlaLI1WdTDgsaG126heJ4Z3nxj3lNqOOLRiC5CbB7oCGGfoiZKig3qttDTlgS
	 yLV0kShu8fJ5s4YS5bLWB47LqOcbY+Se4ST6spkGxEpXTpeDGRyoaLZQUV8lpRhrPs
	 GjtOsg6qEwO+KMEyO/T2M3ays33Ny2rRfrelhX9zwNQZUhcJM4Ye5MqAuCiheUsaA/
	 Mv4hB92QDmbF9Ijt5QeAUMMuim/9jcygNFkCJ/QyZPGfuJ7zOBo5fBSZCBD7AtH7O8
	 yzDwV4jrbO5nQ==
From: Christian Brauner <brauner@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261106015227.3718251-1-sashal@kernel.org>
References: <20261106015227.3718251-1-sashal@kernel.org>
Subject: Re: [PATCH] selftests: add namespaces to TARGETS
Message-Id: <20261118-rockkonzert-baustart-reinigen-09e2764d4d17@brauner>
Date: Wed, 18 Nov 2026 13:13:56 +0100
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

On Thu, 05 Nov 2026 20:52:27 -0500, Sasha Levin wrote:
> The namespaces tests are not in TARGETS, so "make kselftest" and the CI
> systems that use the top-level Makefile never build or run them. Add
> them.

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

[1/1] selftests: add namespaces to TARGETS
      https://git.kernel.org/vfs/vfs/c/c07b5d746feb

