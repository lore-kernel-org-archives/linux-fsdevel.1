Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED572C21E6;
	Wed, 12 Aug 2026 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518835; cv=none; b=Y5ZgTxV4SBTTCVpprqgPZBLthj07Mp1O1B9pt8SOkvv++B+74FM99pMuQOPOYjnKRV889lerPYJ7HKiESroWnKXRA4aFDBPE8XW5WZZMN7rolJymDRIKVmdguthNLTNV/bRTZGLnZ6KNu/ZVbaJXDlSKvhFsiDLVQwi8tO5G8Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518835; c=relaxed/simple;
	bh=J4nl/WO1BjeYqtu9LV84brT8r/9bpMkUjNj6ca2U5bE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=M4LmTn6AqCbCtRzhUGRwWJH2VRsSORd9bQuSotZSmZE2SxqddSpAkQZYnoV21E9qE9hZY/7DcVP2Sx5jVwWuIDmbtA79Fq0yqjSRznWUzAKfnkvEqXaMRhMmHk1qnlJZya0XZgA5txNGEoGkPLA6/ARU867N5dgPLrBng4QqazA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJkG3D6I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJkG3D6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1B11F000E9;
	Wed, 12 Aug 2026 07:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786518833;
	bh=/Nw/Y884Ealu3ulbBX9np8NnL5KhS3NCUdRtkCROCBw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=BJkG3D6ILeopL6PettTlaUx2kC0rNeHfIOSS+acJRNSK1E6z6DncSAxJwGIVmGUt7
	 8K9wZbZfnMUoxNOB/RU5zZyMB8HQ3IJRpyk3K20tmV0uJaYaFHwBXHoEHUC9+9wRLH
	 Eydwl4+T5YNAivqwxGIHxQ1g1ukBzWrxoqAGNOe0Dy84HNlRRte/PApfd3RibSt/ec
	 Ngx8EM3SaPDpp7uTT8MykRYUcBGrZPjCN3gm4umxOFOdL4nKKfdWsvXO93x5oVT2ep
	 +fLnBoadKDSqZO2l6ahJPt+ifiBGOM+EKc9oAl1KL3DK7ziUdJyQOIeM3g87o0Vzkv
	 +hcT6uwIlrcfg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH RESEND] eventpoll: add lockless fast-path for
 eventfd
From: Christian Brauner <brauner@kernel.org>
To: Siyuan Huang <syhuang.nju@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, jack@suse.cz, 
 nathan@kernel.org, ojeda@kernel.org, nsc@kernel.org, gary@garyguo.net, 
 tglx@kernel.org, thomas.weissschuh@linutronix.de, aliceryhl@google.com, 
 dianders@chromium.org, linux.amoon@gmail.com
In-Reply-To: <20260811031538.2782906-1-syhuang.nju@gmail.com>
References: <20260811031538.2782906-1-syhuang.nju@gmail.com>
Date: Wed, 12 Aug 2026 09:13:43 +0200
Message-Id: <20260812-zitat-neueinstellung-ruckartig-727e55f45cc1@brauner>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=664; i=brauner@kernel.org;
 h=from:subject:message-id; bh=J4nl/WO1BjeYqtu9LV84brT8r/9bpMkUjNj6ca2U5bE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVyOq9u3tJa+HdoifOrl4vU0/YlV+v+9N7UNx3N5/Eu
 W9zFn+17ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIVDTDPyP+3JSFVtceHd+8
 aeXHK//KZq3+8OyIy3+j1q9XTTrVu1UY/vCKe597rsV1xLjsZt9XtTmB1ZNS277c9p2gUXGtMee
 sDDsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hi Siyuan,

> This PATCH introduces a lockless fast-path in ep_poll_callback() that
> avoids acquiring ep->lock when the target epitem is already owned by the
> ready-processing path (on rdllist or in a scan batch). The optimization
> is applied to eventfd-backed epitems only currently, but the mechanism
> is general and could be applied to other level-triggered files that opt
> in by setting FOP_EPOLL_LOCKLESS.

I think this is misguided. Not just the special-casing of eventfd but
also letting file operations opt-in how locking is done in another
subystem. That's almost guaranteed to wreak havoc... and sashiko is
already proving this.

-- 

