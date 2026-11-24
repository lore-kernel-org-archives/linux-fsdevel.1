Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795517756;
	b=JJQXRTOk0ssCJvqXIhSR0jx3DZWVOwKqDMzjfoId3KWl5DWp3S5mkND4s19OgmUOAjOu
	 X40BUO6XnLBXflyeV6+n9PSODBBf8C6TBQCJ+eXeKSvdOMPiErP+UyFDSaAPyGf4p/yf/
	 MKZft86q2h7mnNs9FtBjVkZ1hmleIa0QEDe4IEfFUo9AaIMzs0CmZmG0BA5Z6xJwhdrkv
	 Y2SnP83jz38DGDuyl5UFJE2aATiHwbPoj+mpBrf7zVaGXt1y+DNvEx5HgshunMAU6+2Hm
	 y3nR3cM+Waz4ur4rq1OmajNf5xGFvPAciMSOPpZG7HCkVeNm6kfrkK9GYZWNa0VXRoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=f7K+OWT5/zN97AWFOPBzuexi2dmP1ajwM95QsLerSkw=;
	b=GZQD9fGiicJaGbtuDTvZozM80Rqd/R0Py2zh3rzrpESj31LvHbKz5Sh6aXqTrl2ZC4iK
	 Tvo8b7SRAwOhKwLIKkcaHBYvvKgqFQXU6xKIXcuIaCx9Ppb5FCv0v7/UtXD88iTcycvsw
	 1R+wPox11idxhQf0BAhGd1jYwmCfVRSU99/hqT6Jh9fKrGhFeR+WAMKBINYZxUkNEm5U/
	 PTnBzo8dlFZxiJp79AQBUx6E5os5BCGPoUZu4cWsa0Q/fAGQlh03yrggN6u9Yw5xbus8h
	 dzpjw3z65yFV+yvOn8jjlF7P/gb9SyQvCLexbr5k/D+AjbAaLDE5ilqVqChq5z3NPaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=Wip4E6dx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41B606A333
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 10:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F41B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=Wip4E6dx
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55bd96affd2so68964791cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 02:55:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795517754; cv=none;
        d=google.com; s=arc-20260327;
        b=aifVaSVjQ9f38knxklU2qR+/IZbyoVTHFW/gjSToZR+Izx7DExCyRO3lju0xM3eX//
         qzo1f/PtwsQqGdkWmjysueMxxAhM1lYKtIABiHQfvxi3xvmRw+KcHruLzr3WZ03p4La3
         TPspWnSte5lFrQg7DnAoLOqmx7NydgSt8gaacLtBgl4s3ioaXInJ2LzpEyO2wIeE/prc
         ZxJRwF1mLjIK4ihmAhpFE5LX2fBnMS/6LfB6ncDkkavLliYu9U91UVXDPZTRkNfA1N2J
         HCbrou9u5xQ09ukMbl4MhcQI3av+mOtXXn9l06lfwemSd+1X9WunwBs6H6BAZvsiV+zQ
         4jDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f7K+OWT5/zN97AWFOPBzuexi2dmP1ajwM95QsLerSkw=;
        fh=ykTw3bm+GdZjHlmRkv4XAzKMiYKrl/S2paBE0cfaGp8=;
        b=pqaQDqvrmkJZ+092ZQnlBu5D6Q+9BrZHt91IzRruP/TpgMuezB/4xfYLfbGt2yE6w0
         rm69r0anqM1bnqKDqm3kt1QKNkRtL/1R5JyjVCzyVo31Cq9+Kpjnf48GR6J8wZ1bjeWR
         sUpv1NKLgJqACG2S0WC43NcrLZ4ImSJekmjudyZYpdhzicMEdN3hqYPeiUStBglSYWwS
         /TNmpb6Yr7iJyn1klnSS8FcYZDR+HIrh9g+sEz0CCeXP0p0m5lNdKEG9H8ZpDqn17vyW
         a74RgIwyaj6ezGHEybhZZtUUvwXSipdu8efa0hQlURey0AiB8ASeUvkbLO46tyt+5jXP
         zP0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1795517754; x=1796122554; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7K+OWT5/zN97AWFOPBzuexi2dmP1ajwM95QsLerSkw=;
        b=Wip4E6dxiWFVbt1L04It971uqQTKbiSj9IOndK1OLhIEk0KTSTbb4/018jrBaQRk8S
         jfSQit1DJnLOimAHzQ2m5BCXPAin4CVW3H7X7RX1nMx2Sbrg8496nVO29xMFdR9MqOip
         QGLLxLoJKacfZI61yVwInyF6/zagKjAohFeWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795517754; x=1796122554;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f7K+OWT5/zN97AWFOPBzuexi2dmP1ajwM95QsLerSkw=;
        b=vhLKvd+rcjKT71SPUy7U5pLSOQabj7atIcqk8ojHdyXU1/Boz81FmMLUH4q6Ae4RMQ
         srwyv9pRGgXVVJOVFuxtsy6DZjyTenT/fprO3Mp6QteXW4R9BQZilEEE6Vz+18ASSe3J
         lLaqCExLr7rqnfCZPv3SEAuHA5Ak8uzQ1q1BK09GwtMAOAS4C2Kjerv6MZcw5yKr94E9
         8GQx1TRfb2UEvI4HbjhZhRSPtgdZet4NqGkMpsu2FhdCiuqeoZ4BrW3AZemrOoXOBdwo
         11hNaHyabDnWACRM+8DAnHZBrNwXUhuuZI/mXTvtWFWfPRJ3QS+HSdy3O50LnR5uaGcG
         2nZg==
X-Forwarded-Encrypted: i=1; AL+hErFLMruOcmdjOeBi2WqJb9bh36I4JQ3zPxrd6uVX6KzeAwwMAiCwXUbD2ourCpWMPINwsOtnulTNrkTWXcA/@vger.kernel.org
X-Gm-Message-State: APuU4Z9GHnC24/PPAdCDwaKFM/eI6cshtSnEOVOLbkADJVrVO57+73kC
	ZGqWulXCzAMmT0m+sl3qH7SBv9CKjmgklp9H2j0BBsBn63uvBj041nwC0I/hQqD9iF5Lrz/Y6CK
	lo5L8xu3GHNsgrYGX9MIy6SIj6WyTTzGMlcezJP7YLQ==
X-Gm-Gg: AZFdTZcJCeL9/gdNJokHV3FWRoF78Ob7Yxr3i4vRHYcNxEu1GOYtprfR+h8AneRfyKB
	FqZ+RywJ57eVHypubPzpcn8C3FPlhwYNe6W+I28EW/w3Aks14MGuCRYQ7PnSnBlt/sX9/Wozb90
	3vjjAoRSSE2s+sAzXY0McrmLTxxBXSwXs7WLTxN/qrbscDGhvKWBT6iBydYLvHUPR+IyHShZJbt
	qs6nlERjw++aRHUDbu/iusgas4sVnVg2vQv2EVjkwUpDjIKggQV7Oncc8p4xmi0eSeLGPUmwkIS
	SNbR3SNWVl54awXyGsfl7IJjqMcafOVo3VzqqWLYfz+X3TEerQkWDrvTHw3p7/oOT4Z1X8zPSeR
	9dmbHDBneqw6LqBoPqF+aPGpsWv4l+KzqLljbLvCHAm18VGXVIBUJHDb7GmQQ4szi0A==
X-Received: by 2002:ac8:5d04:0:b0:54f:50e7:6d69 with SMTP id
 d75a77b69052e-55d6fbfc728mr265521821cf.1.1795517753910; Tue, 24 Nov 2026
 02:55:53 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6c6cea56-1af2-4a37-b081-83244d5e09cd@kylinos.cn> <20261123063609.82014-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20261123063609.82014-1-q.h.hack.winter@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Nov 2026 11:55:42 +0100
X-Gm-Features: Aa3M54r7eAE856Qdq3AsqWMUaoTcqR2q2T6lCT40Ts3802VL14VNSmjueVArc1E
Message-ID: <CAJfpeguspTb0w7DK8-4ALHMcHbH0+Qs8nfh78mOJRwN3VQcAdg@mail.gmail.com>
Subject: Re: [PATCH v5] fuse: virtio-fs: fix lost wakeup on a full virtqueue
To: Qihang <q.h.hack.winter@gmail.com>
Cc: Li Wang <liwang@kylinos.cn>, German Maglione <gmaglione@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 07:36, Qihang <q.h.hack.winter@gmail.com> wrote:

> On -ENOSPC, add the request to queued_reqs before releasing fsvq->lock,
> as send_forget_request() does.  This prevents
> virtio_fs_requests_done_work() from checking queued_reqs between the
> failed submission and the insertion.  Both callers can then return
> immediately on -ENOSPC.

Applied, thanks.

Miklos
