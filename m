Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4157642EEA1
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982333; cv=pass; b=htfOgJiYcvbTVnDYIcHqzT408mQXZnf1e/oFQh2RsBx4JN7kB7zhlnZ08iVR+p7NkMe5IsAQUizFYLKbBLHJzDdMY2EQUm1p10VLQPUK8BU3bWLGfuMgW97aeR2LhQ5V9HQIbReYdh11ufLkhcU53tcYFTtjQ/UBW+jWhvvD22E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982333; c=relaxed/simple;
	bh=no5UqGeu/I9IJaiTWAxVWsktaYLTQKvl28qMYcHHr+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1SFByKBBimtK97Pjyaq3z178dtZKgXVdqA1gyLDVIHfEdtn0Rmfcfcc4TgSrFu93Tkjjj7WOQaaZi13rBwK4mAa1KremXW34/+CKDnM/GmQccGHDtl99hiLE10G80q5i7FcMs+6HA3MXlMeEH2vqtLTnF5kll9ShralAx3azhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cYUn7vv+; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cYUn7vv+"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93703cc9e2dso20068385a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 08:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786982331; cv=none;
        d=google.com; s=arc-20260327;
        b=XhE/9yva5zjk/xdwWjcbsiuXsi0Q546Bc+Zzh/h7tk5Zxux4XSR2gR2pq2Nrtwk8W0
         7e+fWNqXRSq/7+5GyMk1y2LwgZ6pyCsA9HlT0Sv1R7mEG58qoRQqV0x8fFsDB2nsmKuI
         tpq6kD4wD7LhbZXdngl9mseZoGcudWK3McjXhpSGs3NlLG6ZWMQNg7s3nRbs8MLA+QFL
         H2JSgsDANWeWP1nDUD0t1OwKaJQWBVuK7WXNJJboy9VNmIHntxEmJq9/H9O2PMNur+R/
         ZIjx67VVKL+vr1FuUZV7rpmy75dZAqQNcBO6x99se88Up/GQJEwt3ro0xkQvJk1rVQWM
         Mm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OJIRLSwLK/lqQ9XUExR41FCofow37PdnqIN9EEDwdwI=;
        fh=W9Nnlcj8N5Xlvz/ZtHclWy3+tUcbgK/N85/QhdSu/BM=;
        b=M0CINTv+FfM5UiXIG9V6WeuASE+Gwf4kzEMb9YMuXpFrWcisPyDAaYaKrn9aGNanhV
         SoFjoAn356g+vakwIfJFghD71JU87YzP8ELn5AKqc0bUZVfkU8LNQmAWfkIpY1M4Ur4Y
         dtZ6mC/URSvv9fPYOwM8thwwQ1mD8BSTu6H3Rlw3UjI9PohCU3VDnBrSA9m4urUH9xtS
         Z4Onj/lhHtSA3KIoTpu2EkuSIFGlxmMoQ3FXZYvEb6yrMWhIb3a5uw57eI+y/pXFL6Cs
         2mI45S2oJDaiCnH914g1eRXZReOtEzZiXx1eAnlPvfIfUtt8lvAeUdbel21SrAT5+iCI
         UFIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786982331; x=1787587131; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OJIRLSwLK/lqQ9XUExR41FCofow37PdnqIN9EEDwdwI=;
        b=cYUn7vv+/NM0UmxmOzcAOD1iOns4Z+X1PzoQWgqgWwvdSitZfzaXUXMkSbr9wNWKfr
         iDmh3AeBMWbhRcifC/Sztcg12QQDcRvBRC40BcLJz+csbnHXbxmBGax1AYfj1q6t9EhA
         5tMql5PUbK4NmEQvwixc6NXSIocViXu+IMz6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786982331; x=1787587131;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OJIRLSwLK/lqQ9XUExR41FCofow37PdnqIN9EEDwdwI=;
        b=rdF6m2IyR1XQgfGBm47AkrvkQUlUajeVmpDTYktgNlfOP4pq0l5VQXqhbr0GqVSwgl
         geMp4ud4Aze1AAHq2xcfx0lcXdbKZiq6Nns18Y+nLtP6PFC3ptPXTVe6ysF2I4sp3JpJ
         8Gd6IFUNhLABQxrm9vCyOXcvza5wW4cU8QvvCEyNqyG8x3u0VPwLfag/aDvBzX1CDqAo
         MU2zFviGVvnHSbtSVrtiBSxLwdLwVU9VkRxQm9iz0vGFLx7dBH6m/62CfvcnNx0NKhM4
         fHlp4+Sf8CoTU+KWR3wDuFEtzQbd9HjlKBF0pe5jaWftsD9q+Z8HzKjON/wqJfY9PU83
         Bu0A==
X-Forwarded-Encrypted: i=1; AHgh+Rp6ofoS6geX67nsqnRtu0kcWyegTa5h7jGs+SotYhtn07VP8CNvCSHTTF2UQTV5X4rVgEKa+X17PO4uJ7Hm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx658Ewdw+alI8DFowjQ6v6Oz2l6Eq0NzZt4OD0fNMLlPYVpKxi
	2AotK3TfkRO/ZqVS3r2TxfTAA5CDhyaxq0ZgfoNDXJTaM7QodMc3fnA+ipw/phbwG2tPM6E2nRM
	/OFiwUMZMnGioTogYlyI//U3CHYsU6F/G7TM57spyEw==
X-Gm-Gg: AR+sD13+wSh2hDMab3N38oD+JdAb16OsgpKvCaZ8BFE5vNUxWkLlGUDF9NN+mI8PlxA
	EItNiXTBpZ0uumSsRfbufDKVU5e711a5sKL5YMmarDl001l9L052OxvxjGuH9kIO7dMwjIgiFNa
	4yZNNR0pKI4jrMnHskV+zvFm6yozVhDzllRmdiJZws4b6BSryx+rMQkmlIpjXCQouHOp8PSrOnq
	OnPlbE+isn5M3ESEHo6b0Zpdyr6qAKBEd0y5qRT/vMkGQ+LeJOLLBJIkdD/WROKqjXKjQZlXilP
	uVVgTzDP0ekCwZEjtLFSlHJU1u2auVGt47Ift2olyKbjGsB5E9ENOL2s+LSmR8nOfs7MziQfwbv
	K
X-Received: by 2002:a05:620a:bd4:b0:915:e670:4021 with SMTP id
 af79cd13be357-93704c453bamr158105685a.45.1786982331219; Mon, 17 Aug 2026
 08:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813035836.74045-1-rochan.avlur@gmail.com>
In-Reply-To: <20260813035836.74045-1-rochan.avlur@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 17 Aug 2026 17:58:39 +0200
X-Gm-Features: AcwNN1VSPxOYN7kpQnUrOdAukJXi-HG8yj6uq1YUzdXVgD6MbWB9mTBM8yTMWRQ
Message-ID: <CAJfpeguLnQ3rps_zz5sQmb4BZSG+C8+d5cCJdW2+VxCdtajhxA@mail.gmail.com>
Subject: Re: [PATCH] fuse: wait for FR_FINISHED on abort_on_kill to prevent use-after-free
To: Rochan Avlur <rochan.avlur@gmail.com>
Cc: bernd@bsbernd.com, joannelkoong@gmail.com, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Aug 2026 at 05:59, Rochan Avlur <rochan.avlur@gmail.com> wrote:
>
> The abort_on_kill path in request_wait_answer() calls fuse_abort_conn()
> and returns without waiting for FR_FINISHED.  If fuse_dev_do_write() is
> concurrently processing the same request (FR_LOCKED set), the caller
> frees req->args while it is still being accessed, causing a
> use-after-free.
>
> Fix this by jumping to the existing wait_event(FR_FINISHED) instead of
> returning early.  The wait will not hang because fuse_abort_conn()
> ensures all requests are ended.
>
> Reported-by: syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com
> Fixes: 204aa22a686b ("fuse: abort on fatal signal during sync init")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>

Applied, thanks.

Miklos
