Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576627;
	b=cRet/YOoFeT0OTYUCs7kznMCjs/jCYsdLAdOG5umKb5Uie3PkTVAqw5+/nZ8/VnGJN7N
	 UpRCrNk0KDPLLgYubMeU6TipyW3mtkeeSkXAXBuv0of6Yg+22lF1C2mt3aKn4RDcYnKeb
	 2BSMTmlcB1G+1AeC5aonk3zIavwmdx4rX3o2pbe6OORyI+/PV1M0+JCSV6BQmXb3DVo6o
	 TpeIiUTKGWvO3Mj7B20+0DUOYO602qXLYES63ydSjkhMg7WJipWeyCam2tCh3xYJF+kl2
	 OegYBPIgIhlJU26cC491AzLw/dlyj4W4DBptGyYlfmfKUPjyW1dbnPzcj2hZ6ufGJfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576627;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mmNDCdeKa3yD2Gl3CTC7+/aQ/aNMhU0J3kwcOnofaIg=;
	b=g9tVliwp1DslEqJAaZALNg2OlkPV+FGXkHLj+L6AffdoOfV/YAiLiC6pr9dls9aCripZ
	 wz8RjproOaXU/RvU9GL6FE50qJypcsCW8S76QQzAUPnyyKFFCKXySTguKW4GzKprGivgA
	 ds8gkUECIc5ntocgz/kSkGwo8H5uLXINhEjoGhbfbKX6HnRrDCAlpvGFeFR+j0xySUJDk
	 AOBL6p/eCmF8Bn2CG/gQ421JDKnzcAmIfLilX3I1MHz9tZO8G9caopRXgiUq7vqRGP3EG
	 MLPpZPUXPOD6YIdk3RbfG9jVV403F76ZBNFge9GnZwGFU6DquQUuWsYkqPt5vFhBgmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsbSL8lm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443DA606A31B;
	Wed, 21 Oct 2026 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsbSL8lm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D44D1F000C9;
	Wed, 21 Oct 2026 09:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792576627;
	bh=mmNDCdeKa3yD2Gl3CTC7+/aQ/aNMhU0J3kwcOnofaIg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FsbSL8lmB/UMYQbvLckJmDB1B0LWta/nkkM/K8PrFY4A7jN6lZFrsPy+jwxIW3AiQ
	 Fu78ylkbyVpzqE5pzdcEYYExyWomuYz3qCqgRIgJEjr5aFXbFPXW3YjXqQNyoa5gnU
	 SOMF91yYRynn5Hsjl80jkTsUTFC8kv2BtJafqhorcCM3R84CvL+uGFdbbBVmah5W0e
	 9y68L76WlAtPEPEchM/q0olQkW++OJH8BNCWrsCYWlPnKDzQo/z8K6yfI7l+mspmV8
	 Frm36bgNK2U9/ULmw414lvEM7AWL19RkOqof/s6zJ34phIQZCqPrRW+/QGAxnzhEdB
	 W0uBfkwhvaUFQ==
From: Christian Brauner <brauner@kernel.org>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Hui Peng <benquike@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260927225002.509062-1-matthias.goergens@gmail.com>
References: <20260927225002.509062-1-matthias.goergens@gmail.com>
Subject: Re: [PATCH] qnx6: keep the top-level pointer index unsigned in
 qnx6_block_map()
Message-Id: <20261021-frohsinn-lawinen-fluggast-a2d6f13fe709@brauner>
Date: Wed, 21 Oct 2026 11:57:00 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=924; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8f56Pl6L+FfFM49t1sg2EGWfG/P+YKY3xO3hIxlGqfE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd6Mln2/wxL1NYRXq//aFHy1UFdpR0J5aV8b6f1mMWl
 jzp1rz4jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk81GdkuDI1z2rz7fnu7kub
 ZN2687dx7v1Twe168v2H+9v+9QtNC2T4p5gw83S//AQx1YOuNpujz5atqT+U+8ip5Oz2qfte90g
 08wIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 28 Sep 2026 06:50:02 +0800, Matthias Goergens wrote:
> qnx6: keep the top-level pointer index unsigned in qnx6_block_map()

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

[1/1] qnx6: keep the top-level pointer index unsigned in qnx6_block_map()
      https://git.kernel.org/vfs/vfs/c/345a23b25153

