Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4337BE93
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335920; cv=pass; b=rqPzdJYUAzf4elVS8dbMh5dZA7iFkvPOFUEh1PQOE77d1cRp1g23dx5j9qvqY0wP2SBctQmiMoTkS5FX/FNrVUUBjFMApomxc/sSmo61514BbIPCQHGUvtksn6EpO1AqfJhfv/SjyTLjtctXW1yC0gtPSG28VrN2j/+6BO+Z6Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335920; c=relaxed/simple;
	bh=2/kjDlwcFZVaYMX3Qmx8vbln/vywhoMM+fH4ioYnGNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6Xj0HK0RbfrX2Tk9gpGopSFR0KWZrRUSLjwcC/eLyn1qvCVd4Se3JytYpnFxWLWaKzqeZTLOqoC68ISG/Tc8VWH3D33ZYYcfZBZwgxuifeFu7tXCJ0lqFB0C/ntqEr3wBrGsTstXmzgx4eBN8AVIi3WD0ZuNXGDeGY0zt6S83g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=oIucUARZ; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="oIucUARZ"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8aca0469204so52003736d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 03:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776335918; cv=none;
        d=google.com; s=arc-20240605;
        b=MXAqJEXhE/yp7IaMUMF43xslVU13eQ1PLD5uIUMcnJPtF1xgMGziebg1hbgh96gcF/
         gOhfkCcvHh0wfjuRnxRWWFuq+yKEGns3R6aGKcbkeA3Z43eC1VTawBXja6pl719XdIK0
         xMk3/a3vf4eMEmr/C5EUtZMmHyvpCo3G7e8a1h8IWj35FrZnxdkdmMYo28N6s/Xyi26y
         GvdIRVWDGxZSufydyC4SiT2WNOQYbM5uOPoVVroUzsog1p5uOvK+kbLNUR8S+l+NXrrb
         a4sCQxxuiJpAS1O/sIzcZh2Zcst7nqp6OrJwF0n4vXGhc2dU7kZnsyXH6rNfiQtcHSpc
         FGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vkmG5E9vUTsiAEy3w3y6L7D9KdUbBli74u9esBd+as8=;
        fh=XtZa6XvVFQYiLuLpf0AZm7LiHLpQqcG79bUnpcxLXkI=;
        b=gvMhIUbwTgndDvFzTSJojz1Bl0+nLYI0nWtlajYkfhO50RAUw0qVM+1a0SI7Pet1Pe
         m3A245ChYig47BqJb7QfEYSv4mNU8w/N9hkc1d6d0lSHJhXG9J65ayi4eFuNctqoOcRZ
         qmrxAsOkCse40/foB2SmH8e8wG47rP69rEyNnojNh/58Le/OL3zQNlyuJVwUTRrEWn1X
         6/vak5PrzqPUl7s0Dw88tnTE9qNWSEunQgUvkjtxVyK0SPBKa4vsv+K3uzS/30Yj0Iw5
         U/h4sFf1xBG5/9iCtOsgQ6lli2gI6IKv9gM6dBvX+t/OfCpQI+MR3UmQWfnvqoYXSQqY
         Rx5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776335918; x=1776940718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vkmG5E9vUTsiAEy3w3y6L7D9KdUbBli74u9esBd+as8=;
        b=oIucUARZ1GqZQQkDERXQGRRsMem2CfW3DkZlZdWLjfpD6OBrdKc+1yXg5j3R9QKkPI
         UuHNOdJLX2Ws4ZS0J2f57IAC+w7C5Nqa48tsZnbIHYImUoJNyJP4JlQANgdamfPkBhKf
         zD0E8Oks03uAkovlrswudWi7ZfyuYT/bkonnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335918; x=1776940718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkmG5E9vUTsiAEy3w3y6L7D9KdUbBli74u9esBd+as8=;
        b=iV7sa3fl+u5eGj7nYrjH2x8u+KDPJrIsmbb48UfhazGUUs0BHp+kp0Il8YfKa/t6KX
         Aq6lOCkjyWauE4wmTakjJgNa/p7oy7UFuHMX8jg1/NqvaNktH2BqnfySeVs2kP4ivSuz
         t5RQxWQWmAVMYjMLtn+J8qBerWO2Rp46GQmuLzaBhsfTrBlwmPtSU0xgrQdFeUGBDSls
         iOAMjcYbukmyD9KFUiiOlxUAXcoQPBQ3KiO+6SaQpd2hY1yFwCa/ZjM1wzuVSwpff+16
         QlEtHnZ80FSAZtxGZv6+yD6kL2SNRyfbwv9lNfEm5GjPCGQG2+NtTfacv1X9k9wK4hiF
         SyEA==
X-Forwarded-Encrypted: i=1; AFNElJ/LlhCE7P9lsAKYMsV9dOlmGSV3SwENNhcFd/edAwDykX2gwR+UT2//+1YnSyEsNRUdfsGXqcBA2SvEqzgn@vger.kernel.org
X-Gm-Message-State: AOJu0YweHbg2BYT0qS+gW5O9L4Xya0qDGNpiU9TzPZ/RCHvFfzyNoout
	CuYz1785SpS7DiV7cUQ5stqu9lbzARR1hrrbPFYpuUZV/zr0u3I0pBK4xkQPTLvgO7rv8XdiNzK
	jn6WG2aW9o0Fs8Yq4FapWNyzSAoqJttP+aqzxUTwTTw==
X-Gm-Gg: AeBDietEBH1HvdwdZW5PJ3xJNKObOvo9iYW2azyU31QQu/t0fb1H1V4tRrUTkHlp44C
	UvkFwl0qMiElwziHgQJm3fUBiBi3t5I/6JqGg5YkDpwdrG/Fe+tPdBqzXGyO3+z6RSD1GEx+0Pe
	ApJez1wi986rwF0McpjOrauAKfg/y4BfKDYSIlhHuZ+o3xOOqO4rpFNFHHK//CHhGE0hKtlZb7H
	EOH41cTK43HAGbFXTIZlVvYFDMGPelbwUY6T+NaDTvKchAyTHLXxzxzfoq5sG5lWE8ap4q0+BMt
	wTRViLpSSRtrtLEBXu7ClzfruUIDvg9T6VI1
X-Received: by 2002:a05:6214:3285:b0:899:fb4e:47aa with SMTP id
 6a1803df08f44-8ac86297b6dmr410682816d6.39.1776335917973; Thu, 16 Apr 2026
 03:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-xfstests-generic-451-v3-1-bb6ad2f59512@ddn.com>
In-Reply-To: <20260309-xfstests-generic-451-v3-1-bb6ad2f59512@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 16 Apr 2026 12:38:27 +0200
X-Gm-Features: AQROBzCbs-TSMS8vEENDnxou7iwTuZgF-roA4zUpO0hA1IlIZ2RLx8EM-L5JRjA
Message-ID: <CAJfpegvBgxszeg02aQ1iCqxXrEMU0L1xx6UcoJfotCRPm71f2w@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: invalidate page cache after sync and async
 direct writes
To: cding@ddn.com
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert <bschubert@ddn.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Mar 2026 at 09:36, Cheng Ding via B4 Relay
<devnull+cding.ddn.com@kernel.org> wrote:
>
> From: Cheng Ding <cding@ddn.com>
>
> Fixes xfstests generic/451, similar to how commit b359af8275a9 ("fuse:
> Invalidate the page cache after FOPEN_DIRECT_IO write") fixes xfstests
> generic/209.

This just tells what this fixes, but not how it's fixed.  Please elaborate.

One aspect in particular: why is the invalidation done in a worker
thread for async I/O?

Thanks,
Miklos
