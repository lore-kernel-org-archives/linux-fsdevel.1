Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577751;
	b=cWTZd32B1izk05mBjuzB4+Uj2nAeuMzsGvHJqaFa4xAI9kHZZDAjoOWzjxh0TLRB4tPp
	 PvRU9mbrE9h4fpz8WvWnus8XALpMPm9ajKJ7NPRk37LGzMVupqzOOQI7lcgb39tQlld5l
	 4aidD4kEgPHUhPfkwGQjMrpG8CENmFhivp6MWY/TU6nnsZlK2CRsQKVB7UeE8TiO8aJ+T
	 BjRbKG8aZ8Azy7fnBb06YfnRWs2rxIq/9Q5kfy3dIMx9B7SaqMHnu2V40SLCMeLu7TMSe
	 ANsodMUIMhuMMF/fDWLMLUeelDLa6XwKzfh+kJzy5wLp6IrP5HARHwU+oSq+kMednaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577751;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8DP/MZB0fBPgzIkekTeOHpghkVXCO1d9ZH2ktreL8ZA=;
	b=HMWH1ahtpeGRlOwj8zBpuMvEkwTijpLUGpWMiNZW009+pdBCIYrKaz4K8B06GdA6ydy9
	 GyC0tIODxEqrXPXxuzQ9GF6SaY09s9OO7Q3j8WdHg8kIU3dARFXFGgJUHXDUNLimtOWE0
	 hOT0qJT8PJPISpxxzTO9PBpv/8NMBEurJTEllhr/PbtBc+QJlgJmoezf/a+L4VTHqJVTN
	 d/6NQS7aEo+E8qPAyGtjDqzUNgw85inJOQrz3NyAXv4cmDfylZ2hqdnkJh9AR9d5It8iW
	 RKEBH38pkqpUWdLCB2Rq+w7dldOdQI2B6Zo6PWX1FEZLZX77JvDN8zo9ic8RKqHqD/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nu0Gv38l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B2C606A319;
	Wed, 21 Oct 2026 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nu0Gv38l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191961F000C9;
	Wed, 21 Oct 2026 10:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792577751;
	bh=8DP/MZB0fBPgzIkekTeOHpghkVXCO1d9ZH2ktreL8ZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nu0Gv38l6a37pGTLMqhs645yg3oyDeOkh/XUs2wGR5+3sevlAeZUpFynqlPqbFq7o
	 AZTdpKIDN/vfSa3PK/Py8IqHCilWPlSmG47+4GnxIg6uDXWmCJGdmi8YXDy4Rh3rVk
	 /4oE/wJWmmpaSK8rbmypR9YyuNKiDrCWB1OqSMyLyOZ1aNHW2k5IZrHCDYUJmIyIcT
	 pz9VmR3X0BCe7g32vQ+xPn49BotRx+nhKEnlPJsicMVZV97ueJNCRub//2Z0ejmC6z
	 uKedhMuTeRH86yN/WShUk6DGCRGw0FQ7p4gb1GfOvfKS7qfZjpS1JzgYoFh+gQTNRP
	 PlG5ettxmuCEQ==
From: Christian Brauner <brauner@kernel.org>
To: Omar Sandoval <osandov@osandov.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
 Baoquan He <baoquan.he@linux.dev>, linux-debuggers@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261017034739.793431-1-nickolai@csail.mit.edu>
References: <20261017034739.793431-1-nickolai@csail.mit.edu>
Subject: Re: [PATCH v1] proc/kcore: advance the vmalloc retry by the last
 copy, not the total
Message-Id: <20261021-abgeurteilt-pinguine-eurem-93f8d494f0d7@brauner>
Date: Wed, 21 Oct 2026 12:15:45 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RCzk9gNf4TjIK3xWO8ze8xq7ZGB32EECa5yJVQPrRgo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdmHCJUdXjmrrvFMV26e9lEVKnnU+7i9/ebrpLcZOAh
 3ykkVJDRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQW7GH4p/xHsHybenmwzM6S
 7GimgHuX1nxuDj+uXLtz6/Kc/NmTnjP8r7+cOlt6sW2GdPa15XOFjesV2aQLDOQzZ6q3b9YS2iD
 EBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 16 Oct 2026 23:47:39 -0400, Nickolai Zeldovich wrote:
> proc/kcore: advance the vmalloc retry by the last copy, not the total

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

[1/1] proc/kcore: advance the vmalloc retry by the last copy, not the total
      https://git.kernel.org/vfs/vfs/c/499e14b44f0d

