Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231772;
	b=l1Jxk49txjymNZCDmc0DRhAedsCqdGcnvexEidXYdRgtQpGgbS/W9x9sjFENAnvIUPhL
	 eQVbdEgXPc68rD0BET2g38+HIhHTMRxlYcLmyxR8b/ekr9n9WwyPjNpOiXDCyempn22sR
	 01N/1O0ymEA113KIKR1N7kOTbqPIvD+1iNRLhsjQPxMgvPtmtp+s7kPETSF+4IclcBBLg
	 ZEtzhoyV6Fa+K2/TQ6jz+1Ql7jA9Rt9LEJQGMR3dsbu0OWTyd5aeBqa7vjioVEXWJTbM0
	 cg9LZlNCO/kGTzLZW9WiOISYOXidVueNO869fv1uf/QVOE4LrHCoFabCZBzO56RlAyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231772;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dizxdHN+Hjf/bAHQ82t385sENo5zauygxAJLQNqW5gY=;
	b=pp6SVTiC8Jx1sR4nfPUEz9rLbOwjgqWqesWHechq9j3z6+ZD/2NsIwepDUFrkOO5uQXj
	 R8O8iynfb55TN5dkfZXHR95EcGNJ02TeXw3bCxkgzNLicDRTfH6nPMHbBTiLjtr5K038R
	 lFDRopFhHfVBrta504hn4S3H8Nkyp9OaQnl4HrAsPKIPovpdPTb2BmaqwefO7j8+vbsF2
	 +EK+FKfG7PQlB7twTaJ0VzOD/3i5Vrw84AjOV8ygZUQrnK/5u3IiFcPjS3fM4lxJkmeqz
	 Afe2XYFgWe5z19mfp568yHDlo8N5heOhzq16BNMF/1rGRCvhBlp4UWgGCbP2It1ChvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDHmpJWJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36230606A31A;
	Wed, 28 Oct 2026 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDHmpJWJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294461F01825;
	Wed, 28 Oct 2026 23:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793231771;
	bh=dizxdHN+Hjf/bAHQ82t385sENo5zauygxAJLQNqW5gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FDHmpJWJ6rX2UFgqZte6QWiF4DvyQ+SkvYzxF5W4jljWLsyCcW7c6EyD7uKUhE/IH
	 Rd19VP6P087ira+N7uKir2UZLq7r41dToqYn6W8KQL+lcOU34FHgR0pTciP+qbIgZm
	 oL9wpVaAnvI/Ew6EY4WciSU2lyCtRr2JvBt4YaAfon9AhGh1WvMIFcmex9gr4uRwl6
	 ckgg0du89dDQoVWuaItqSfq1jESMFG+xGzOwDS7LrPjqzyzR1zIGbcs4n6COmy8JNL
	 52x+pb7+QmXlr28pMwZgdOrMPif2qMR9kjG2cGpOMC/+jc4oOzFtLAN3ZitPEA+RDV
	 1mDubKMfdBs6A==
From: Sasha Levin <sashal@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Luis Henriques <luis@igalia.com>,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: Re: [GIT PULL] fuse update for 7.4
Date: Wed, 28 Oct 2026 19:56:04 -0400
Message-ID: <20261028235606.2463931-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAJfpeguS78Y_ZB=fNbYqFPcpo_mznJBR=5KTqifMzCm7c3O+8g@mail.gmail.com>
References: <CAJfpeguS78Y_ZB=fNbYqFPcpo_mznJBR=5KTqifMzCm7c3O+8g@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 26, 2026 at 10:20:44PM +0100, Miklos Szeredi wrote:
>git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
>tags/fuse-update-7.4

Hi,

Two build problems came in with this pull and are now in mainline. Both
have fixes on the list that aren't the tree yet:

 - https://lore.kernel.org/r/20261026194008.274349-1-sashal@kernel.org

 - https://lore.kernel.org/r/20261026152650.102745-1-sashal@kernel.org

Both apply to current mainline.

--
Thanks,
Sasha
