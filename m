Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793301516;
	b=ynROOu52rHf2z10q9qD1QvoyNJE5fRz/qJmDulm9rBY4g6ND8TgEfpodfKP9logOt4UZ
	 Zl4nXx3hgvan9JRS/69Qejk7B6ZQzdPwYMwQpdE2IxzURtyAzb0APi4KvQ1jLVMrpRZjL
	 JuzglsKRu8Y0/KqXY+vXFGoRhPnwhOb7nEnh2ABxjyRyXa7Cx/+T+JhpM8WCVwKFsAYo1
	 t+Tqw6bqfQhli8ysWajh6ThhRNuHwRkeWdMt5VYlieI3pOw089EBZcA1XhPIxeds52FWg
	 RL6/vHUY1XqTtJmGcDRheExrse4pMDtKlslEDNkVYvGyf8wjjEEi77YyuRMZliuTBwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=zGi19Wr+uZ7jaR+JUDIMwu1MpVlwg/hES0VNUGXQGiE=;
	b=pRWeV4iC9lbKpmgm5PG89pKg2WOSoesW+8oCKrJXtDO1haDa2f5W6+cwiUX3lKS0U+cX
	 S9opFYyeAuAWFcDIp9sjsqg5wY2SAhO257PPf6Ty6Pb/3gAe4MtKSTcPF8DL22vPrQgid
	 G6H7bzEtNaxKbnuyhdEpnBLZ6TikUa0WzrC+4Zj6LvLkL0y4wr+MhRNwhux3WVnMPkl5B
	 XurUWR4lngmKoBfLSpAUBVEACO/z5keIqk2cZGLZ4psFbEGzGzoloftymybZi7Z7LXanx
	 Zx+SDCbnjLr6XtwTWbfrlPD/O+0PoNHwRe5b4BMrPFqqW2YLi5NyHmKgD9Vb47cHLag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="nlFp/Wm6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.68
Received: from mail-lr2-f4.google.com (mail-lr2-f4.google.com [74.125.230.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5EC606A31A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 19:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA5EC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nlFp/Wm6
Received: by mail-lr2-f4.google.com with SMTP id 38308e7fff4ca-3ac4f373d3bso210461fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 12:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793301514; cv=none;
        d=google.com; s=arc-20260327;
        b=imPuzl5kbth9DIU2mXErmTEGIIJjBjaiLXJvAgjicnsQ738FhFFdkWiOqXIIwD0OqE
         AxkjqNkvt/bWKq8lTZAgoZGYT51cqs6D3j4drjqBSATG++/ovVqMRqCsTFD2QMl+wOfn
         UlVe6VmDXL4cnLuoLutKis3kZV/UH10GId8JitV+CIKk38lj6rqmb7sI4eEcCKbsiyzc
         kOq8uf0kMaYwIDhFEdiEYe9e5l0Fjmm6KtW7YCkm7+dDsK5cHLMjFLOUdPo6vNqTbN79
         uAeVmrzKvS5f1Ay+/p8zD3Up5ODSfK2dHqDkpt/Ts2vdsjRJ9deaTTGYVTJL4R20rqNx
         dV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zGi19Wr+uZ7jaR+JUDIMwu1MpVlwg/hES0VNUGXQGiE=;
        fh=gO8t1kuP6UWbvKQMGt0vfBKQt2kAM508nfuhk47py7s=;
        b=ljGknlqYcxQYxY70W5L4jVw5Pf5+zu/O0hBngABUWN4YXwGMYmNDNUtMUoHyzYLDUf
         pwWb/93LORhDSjHLHGue5BkexBlDNPUfjatS+JTHcXWIMksqpm1nHTCEybbD/HArULKP
         X0CCecUjFqrLQfZbTAJagkiTAL44qUf8Uh9yZ0kWmQvZxLmiQt6UGNE5IOZM7uSUmP1f
         Ym9dmNNIsd+4WK4EqMiOjmJLH1rlpU47gFK1EAxxm0yrkYwwvv98m1WYjek2fc0vFw4D
         r784pklpUIN9ad08e7r52CjMhgUugPgMwyvE7DIYCNX6ixW9kB3wv84974YGCuJwY2FR
         Fk6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793301514; x=1793906314; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGi19Wr+uZ7jaR+JUDIMwu1MpVlwg/hES0VNUGXQGiE=;
        b=nlFp/Wm6iihYzsToCCOcA3EnMO9LALNGsAtR+SQliMDixLqP7RXC3MQMzlAT3lu7nz
         A3zf//3jMMZELqWiXu+56+Q4v4wWwjhLZPPr6ZrNbjaOoFmaMnQJmCrBiYf8ct7ouKoY
         nC6Wojn9s7END+JBbsbB/obpmOJMyMfMUTW6vJnH/cV/Gug/IwwQMjIgN0NJAFRIz2G+
         Tol892UgCQ+9jb+/iC2hRH7Kgw/2uHvJYjG09ypqPFE70+Hru/v0Vul0z2anzbx3t7Sp
         0REAQTl8pshcccDBfr6IBS9143w0kmdUEneSUIJBmgzX2+SVUENhNEYc3Jsdtf3NvmTV
         WgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301514; x=1793906314;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zGi19Wr+uZ7jaR+JUDIMwu1MpVlwg/hES0VNUGXQGiE=;
        b=DFQcNspK2UYQISjwWHyH0k+wijUvKOl1utxFzR6H5G8Ds9ixONBTUqFzjS3csQXZey
         DIwxl9KukYvPINR8Ljld1Tx/idHEHn0fTlwDv11G5olfklNkKSHCdIlaU4E8DNss+qBp
         XO8pYEubpZtSR25L1dAahD/mFY0kk6YXVEVcJ4NjGidqf4YPgEGTKl5zVl0fz4byb4kF
         0aTO4aQN5qZegKA6qkz7gnnlbjTP39mc9G56FF/yO2G6m3QIDaxGsXxkYwpj/No0V8OP
         dyNm41wJH2qz+RtcdXSHmLy03ib2oKsrpJOLC0f1HriwGOeWUGnO3V8ChmMSjZD2Zph9
         5+kg==
X-Forwarded-Encrypted: i=1; AKwUvBy8MgLGGfC7tjVPJs0hHOdEllfK6bRn8T29i3RRv3sV/O4fSOdyBooJNVlm47mw1gkdo5nE0+oUurIUl/GG@vger.kernel.org
X-Gm-Message-State: AFq9FYK28TjRzX9VIh+JU8REUvh/l8hhd8RgCFle5qxx9MbaIh6t4rSl
	pv3guA43VabVgidJjKUu9XxIxHTIeHbE6lQ/a2PqLuRVlMdxGDF2azWIhByktxItLOgo9g+IHTP
	WaMbT3ddPaxc4Y/8O8WUdGnrbh/dRJCc=
X-Gm-Gg: AYBFou2oypQpMhYGC5hi5yyPLV/oeWbp8WiZb+dZlcnf8ajCOg89Wl9ByVRETDlIKhr
	6lpqkvrv31rl/rKINgm0sjWipP8SzNWMP7bb1D7RKLuXFT/TeGcCl3069ymKErfPIPhj8N5mU9W
	o7JAypmysWgfqx7f0MsXChxi0KWL9C6OgAa7cM0WBZRLZ2j3nrXv+W6ifwcC4CGGkYepdvsOdoK
	6ManJV+s0qLQa/RRgRTz65OE7CHft/NRvD/GGHywtQX5C3C7Dlej7YVYKwO0mW0zu8uj+5FfPyL
	hDgjt6m6nVvhPl902aoYdo+pReEF4KVOgEutapsJ+73ZRP0/ieRR6trN/5DDS+X1Y3zhl1WkIp5
	Lz3VAugpwtOglQbgsmbxY+Vlxa54DbIel0HCX8a762SsMioJbAkLaCmRxvSs5YmwbTxypR08=
X-Received: by 2002:a05:6512:3e1e:b0:5bf:d6f5:f966 with SMTP id
 2adb3069b0e04-5bfd6f5fa47mr405402e87.47.1793301513706; Thu, 29 Oct 2026
 12:18:33 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029174907.98721-1-dennylin0707@gmail.com> <CAOQ4uxhc6a5jdwj+o_pCByYpwOC20=uHj0mi4D5n3UgrTqR7uQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhc6a5jdwj+o_pCByYpwOC20=uHj0mi4D5n3UgrTqR7uQ@mail.gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 29 Oct 2026 12:18:17 -0700
X-Gm-Features: AclHuK_8VrzokGWXomjZEgCHDMKIkH6MgppVgTX-POqoNF6kX7NhfdTmuPJdxGs
Message-ID: <CAGEkeHdYqS_9wipk9oy=ofo=KbNpOwccuqVEYPg0LqzCykXUrw@mail.gmail.com>
Subject: Re: [PATCH v3] inotify13: check rename cookie pairing after adjacent moves
To: Amir Goldstein <amir73il@gmail.com>
Cc: ltp@lists.linux.it, jack@suse.cz, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> It highlights the mismatch without cluttering the log with more information.

Thanks, Amir. I should have followed the existing examples more closely.
I'll place the expected value next to the mismatched field and check the
rest of the test for consistency with the usual LTP conventions.

I'll keep v4 limited to the diagnostic messages.

Thanks,
Hungyu
