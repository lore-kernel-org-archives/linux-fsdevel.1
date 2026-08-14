Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E534750F;
	Fri, 14 Aug 2026 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733140; cv=none; b=XV4VumkNPVpTm46G5n5+6OtS6gDx00TPAIojTYo2R4cqB2Hrg4sC3YzYRnIOdyVyfVg5v4GuvH4zI4MDJ/ebWe9CgWwdYeNfAwGXo/iWiyxzpfNPDX3wWu5IaqLflbGTZgDA+BQ2D3ItESU7e6YsAzAQCLv/BbWGx1cCj5nTNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733140; c=relaxed/simple;
	bh=YDimcwwVnCQAqguz0+lja+OCi5Uv6mv4JWRGLAtr1Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqqz/l3FdrEUBxuZ4zfVh9yjSnVi0wB6UXIO5AdT7tt0ncgFjkmI6B5Z+Oeve4mK+TsLunWqu30I77+GIJmPaXzgTD8vHIFL1HsnIrytXYXPpSrJPX2iYfMJwAd2Nc6zcMcXjc5ApNNJ9D88dQSy5IJ5c1JLXDTf/2uqFgOs2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4cdOMDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4cdOMDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63A41F000E9;
	Fri, 14 Aug 2026 18:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786733139;
	bh=YDimcwwVnCQAqguz0+lja+OCi5Uv6mv4JWRGLAtr1Gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j4cdOMDk1EQFugJhI1hHBxT0gFAX/92joK7WiVnDki1YLH1vH/h6r7E/ZUdzG5UXT
	 Du70PolFCYtmuGlaNAgpdg4CzNvbzG7I1Rro8iA2iIK/eTSAHTKAxVx6rajpSgrXVx
	 uDB6vsizr20ZTcqAPB5ex40NY6DWSCm2IkniwudlDswxmx/WR1tFSMj9nGnMiC9at/
	 ESwmmrpfxPcFb++q8jD3+T4c4N5jQRP9aRGFPA+Cwcxyupdc4YkxV2N+fyebPLsKoC
	 qyDGS7gfGknQJc684kF03MdnNOf/f8NDf5WPCuFWqu7CPlupSl2O5N4PTr42MFLl5b
	 ylKaDWK8oU5MA==
Date: Fri, 14 Aug 2026 11:45:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, kuniyu@google.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/4] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
Message-ID: <20260814114538.1d22334b@kernel.org>
In-Reply-To: <710021802.503191.1786728764671@kpc.webmail.kpnmail.nl>
References: <20260813162818.149248-1-jkoolstra@xs4all.nl>
	<1036785927.390839.1786639504241@kpc.webmail.kpnmail.nl>
	<20260814101828.2ea54f8a@kernel.org>
	<710021802.503191.1786728764671@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 19:32:44 +0200 (CEST) Jori Koolstra wrote:
> Does that work now for you? Otherwise, I literally cannot fix it
> until I get home, because it's more messages than the rate limit
> allows.

Yup! looks like patchwork caught this one, thanks.
