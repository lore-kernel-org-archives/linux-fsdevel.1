Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011300;
	b=cB8H4CPRrf9BXmN2y+wMsTAjeZQhyOHUCu0UaYfIN0MglD1Wt81UdfApQxITtO2kPOum
	 p8F1lskbGiTD/zAzSVle959pivMRAc08yxplm1Kt2CbY6sitA/5NszlgerPzWoc3jrBtX
	 l6jkT0wlM4Nu/FDAvl6j2m8O4G9HcnZweQWv2HupFfEIMMtGwfNUVH+hfZPeT0iZnOcft
	 /1vYEU9RJiI5NdgnliYdc/A4iiJD0KhwHC6GA72J5/g8+pxzz6Q0JZfceB0FlTFA3Qgui
	 APjP8AnRmG60vMoUh2yb9sbwRHN5qXEGTkgHY/g5AVC8hM+UWW+sk7RSE/QYeSKlfIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 In-Reply-To:Date:Message-ID:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=Lr6L+cYeRUIJDJyNctOopXpHFnq46QKdQrQ9Ke1StVE=;
	b=jSVr3rLr7kHYoZOjudFJicRk6O4wcqwgJdG1esi18841yL1MzRdi/1VO8L7q3Qnh3ADg
	 Lz8C5JbHF+qX9kQA38oH2nIGX655CPCjAuimNGsbymF+dHsNp2qINK6VJdqsoMKB0l/0R
	 ts/w7Y/D5HRrnaouyS7qwQ+V6qXUhuRE5IzrDTw/txsbBAdh+85XnL8VKVQfgjKalnDhh
	 5m2PHvS6s4RYvYenNojAvJWI/sZ7pZMtdgu0WaQpeR93JX2rcYIo34hBgAI1kgjpIGzdU
	 DalTlHSdSdU+TzadWUXq80Qm8T29lJ7aNtuZxHr9Q5dA6H1F2aYLxuPNbCMjUbE6q0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Owut/OfF";
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EEA606A335
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 14:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05EEA606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Owut/OfF
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so673953f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 06:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795011298; x=1795616098; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lr6L+cYeRUIJDJyNctOopXpHFnq46QKdQrQ9Ke1StVE=;
        b=Owut/OfFa6E71kOopud76C/B5gBb9b7Sz2N38c23akPgcj6Qm1z+UL6sXme/0Pao3y
         qS4qK3drbWZRzdMIOMD3Ih+B/ksIu5sHIXGXJ3awEe+oVHABGh7Pl1junppwjc9V6JUU
         XUC2c2iM4q5RsoR3otxYFcLvEf44ROR5UrM3oMCdh47tpI75gQWnR1BEmTYncyFTWMAR
         /DTZowrkx1xO/gJOZeatRIGTjkmlIcXXfK2FyPbu+JL/gUBrweFoMclDqUH9W+l6Gcsr
         uFAxy7rxyNCXq1t7r60B+8GEkFzzNLAGvUqiqkXIftfcWbHwZJHYoMFf3FOQe80lmX3V
         zuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795011298; x=1795616098;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Lr6L+cYeRUIJDJyNctOopXpHFnq46QKdQrQ9Ke1StVE=;
        b=i1vy6fDLNjtB1YNe2R2EzYiGerbZ4A7qRR3lotAzho+EVpan0HfPS6JQFyGZgX5b8t
         5i5jLRTdWT86k0OByz6TlWDzuLbJxQVYiXfTvhd++ym4IVa8LCN0hr1KaKi7YsQdcVgZ
         LMnLp3UaroqgzTZrFWjDN7nP8+ozrp8NPThEf65SFOZfT5nh4nLpbzR9SbgmR5X6Gbtu
         Db2wlp1PpqC3+r2cW3fL4tsnTM5dgBdUD+Rg5UxmAKaIhO+YtR8a4yOdz+QhHJux7Tpq
         +SZAofY71SW8dYSA7RsNKeKmKyTiqRFovK6OTXeRkeki9QSlTEFC8NENwdFJgtq+xpVz
         M7EA==
X-Gm-Message-State: APuU4Z98aW7bsEVhdjLsU7fhnRczVQBJ5m00nCMm9NfAmXPVCGIlVdvf
	blTigLAaqXjbpUR5x8JhtIhH7bWDD6wDVnULdH1dKhvtt0IHD8Yr5zvozpcGyFn0Zac=
X-Gm-Gg: AZFdTZdvbRgHRqFtOnm3znF3xx2LmbII5s0o2cr3y2gYJcM7jsjuvpy4X/POtE+LzbL
	GoUGkKkrF3wABsTLRG1h62OGgjxA+nChUcQvjedKNXraTolHwMSc1zUVREcKeCzwn9TxNh+dTCH
	EEIVY7QTgNJWAJGG50naMg8Ypb4sFQOg78BKXC0iUedBLuaXNzknbFzziN+J6MVL8OUdppXgzSS
	0Bt7ejPaPrC5qHyY+IrGbDX9PC4R0uEYBOnQ0y3iWf1gQH3k5Un8gjAaBWnE0wiBS3fu63T2ZA9
	KVml42d0YSzt7hy2KSE4CFKggEFd1FkUgxMrq5XssoPgg6dpd/x3GUerdk2go0gNp4ghy9HfxOB
	DTlK7uMDZOtoVMtIpT8YNWWkaggicPXVARtFnpyDfRm7AQuU+9maj8iLFY/ajGghJYVHxYREgcz
	1YEK+IBeuK3S9THREc7/OSkeUa0Wz7Zm5MjeyqDj7yKdqljYBU9O0/RykT7S7n7TbAIKIe0OYLh
	DItXZOBynFRd5AW+XGHe0LEETNS8UCryhIwbUn2GTpJ7PoB4N9H2LaIbYCaxB6Jltk2KMPTpKPT
	V5VQS/bRl+YKELR5lsrDwsaaE4tckTryRfGgXopdgLmTR9C68FCJ1l8VWVbBRCfwSHpNiSmIH7X
	URIk7
X-Received: by 2002:a05:6000:4812:b0:48f:bc05:76fc with SMTP id ffacd0b85a97d-4a63c657f66mr5381340f8f.11.1795011298295;
        Wed, 18 Nov 2026 06:14:58 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a6569338acsm5108876f8f.45.2026.11.18.06.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:14:57 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fuse: stop stealing pipe pages into the page cache
In-Reply-To: <20261118135359.6256-1-suruurism@gmail.com>
Date: Wed, 18 Nov 2026 17:14:54 +0300
Message-ID: <179501129496.10449.5445396291756842907@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hello,

Please ignore/drop my patch "fuse: stop stealing pipe pages into the page
cache" (message-id <20261118135359.6256-1-suruurism@gmail.com>). After
further checking I found that this issue has already been reported and
fixed upstream by commit 80beb226de50b859913a55be0d6bff9046662294, which
predates my submission. I should have checked the post-snapshot history
more carefully; my patch is redundant. Sorry for the noise.

Thanks,
Abdifatah Suruur
suruurism@gmail.com
