Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968106;
	b=0kg1AHrsAq5FNVh7vIdQnt/KuXTBxt6awfXJK3zxD4/DmrLEdCcM0MoN9zpO0t9VB8YJ
	 QDHZc1xYR0WMmhaZggx0xa/2Vw9HKK0/ZhmlYAT4QVk6Tm9Mia+q2Ir2llSjqVK15a2Kx
	 uuK5PJSaFoz8iFI1NHs96IL1m77XUmnfgBQpB25UsNoLNJ5D35Og+RzTPfILt0CUgLO7d
	 YwOaypZER7g6NmBhNks/eaTre0bIsA3g5cAoEdNtTpP+mc+wx/+Jh0sWj8fHRZCKzG1HT
	 j1zCHZnidEY8SV0rtrNzEOuDpseAFs3cODDkOSdnWqAPbSka1+OPN+Xwvi1Vrb7l85g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Hek+ZE9sdaq9Ge80vFXi/7LSVSangUgBYjZCzNy2wbw=;
	b=FB/p+4liIEqCG3Qt3rUgg42TsD9zgNKOCHIprVkl5y0dqi9iCN7Bpu864wtjFnmZfQco
	 tysuYKD1bKIUDUfJMmcOdfu8F/RtarPOM4n6vYlCyrY30YBIEIV2ycmHKzu994cwlscT7
	 4Vl5twIcMZKDg75Unho7jGeYJ3GCPRno+RUVt+pMG1/g0B6Oq7A3e7Gcs6YsWwSBRFjk6
	 T0kWKaSYZoSamTbX8UU4nQeoKBxGupLjhy2sKfeR1NJd5uJlfLOHWqeaHHyzMF8+unxSN
	 tG4OGBE2K8kkLFCdgUaJEltnguym0BRsTCn5fim9cDRJ7pTUkHypQDhIYCQ6+mj596g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hcNs234f;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957A5606A331
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 02:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 957A5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hcNs234f
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ed08904845so5684605ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 18:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794968105; x=1795572905; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hek+ZE9sdaq9Ge80vFXi/7LSVSangUgBYjZCzNy2wbw=;
        b=hcNs234fv2gBaZqCmj9VF5K0kL1XLIKNqqfa9Ib7n00vrxU4xjZB89GqYUPwRoKKPR
         HQZiz/q+uS/wdr9I4W56QJaECk5u/vHYslwah52MEuCs+Feoq/mLB8AknBzRQQxDKsvj
         LdTEIlPJ+YCz6rvXc+WGq3Bqt/lgn0RFe7LNZl9RecSftLv/8AtzOPEMo1JPSB1vzdw/
         y0iabgq2OoPSmtNqEOqU8n0XEcAykRFq7aEmPU0YVgKvYOIXKKfOj4PEJ7/TivNFqVdF
         L54ZIBHKMZHi9Y6jlofa+en7kQzLsCNXgGfDGyW3raz0HrVuhhEvsEACUu4JNU60TyzA
         COGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794968105; x=1795572905;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hek+ZE9sdaq9Ge80vFXi/7LSVSangUgBYjZCzNy2wbw=;
        b=J+NI1d8jZXP2mMiBN6wwmaYlvnORe6DJuQqz2r0x7Z0X09/xu3+/O29b/HM/0b1Cmm
         +A33lcQeF4e+WjTsCofp4FtsNNROxWNUkj0zcY0TKiLMsYgyR7MRNbKJihSXGj2IjzcZ
         HB7AUQFP+6Cv64ffKphHnepdXWnNYy+4VDHNXks93iKJQC6ksAn5E1vR5PuEqZALS+nD
         qCY5ramHWBhDryzSRiFtRpzeUfrmrB3fQFxtjbqt1bfRaNBOVg7Zvbp700rLuaKqmQlK
         MkcdDn5HVXFW/yzKBRaR8AwfLMWD9fbidqwczZQOdGF8JAGyG2COH1iKZkdVQDZ398M3
         CGLQ==
X-Forwarded-Encrypted: i=1; AL+hErE/KzX7Z9fbXKBS7ulr42ISI7amFnkFCuXndCYPjOAOmUqn7eJsWK2Owlx+0/WQtDnfazObrhRupwc592Iu@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZGVX0nEnbS6GcPMrBCwhctCjDjC6pk1H4A4r2X+n3hvM7EM90
	1Lc+h/Rwx1J5dzRM0oXKxrAo41wap4c71ECnWUHjotvBdlGjAG6sQ5G67ou1J9wPYD690KnlGv8
	r+GyeTw==
X-Received: from plhq17.prod.google.com ([2002:a17:903:11d1:b0:2eb:4a7:306e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:90f:b0:2e9:8202:509c
 with SMTP id d9443c01a7336-2eff70fd303mr11865625ad.7.1794968104719; Tue, 17
 Nov 2026 18:15:04 -0800 (PST)
Date: Wed, 18 Nov 2026 02:15:04 +0000
In-Reply-To: <20261117-work-net-peerpidfd_short_optlen-v1-1-a93f56288501@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117-work-net-peerpidfd_short_optlen-v1-0-a93f56288501@kernel.org>
 <20261117-work-net-peerpidfd_short_optlen-v1-1-a93f56288501@kernel.org>
Message-ID: <av0KF1liMktF5Hg-@google.com>
Subject: Re: [PATCH net 1/2] net: don't leak pidfds through a short
 SO_PEERPIDFD optlen
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, 17 Nov 2026 16:25:30 +0100, Christian Brauner wrote:
> sk_getsockopt_peerpidfd() caps the caller's optlen at sizeof(int) but
> never checks that it is at least that large. sk_getsockopt() only
> rejects a negative optlen. So with an optlen of 0 to 3 we still
> allocate a pidfd via pidfd_prepare(), copy zero to three bytes of the
> fd number to userspace, write the short optlen back and then
> fd_install() the pidfd anyway.
> 
> getsockopt() reports success but the caller only got part of the fd
> number or none of it at all. It has no sane way to find out which fd it
> has to close and the pidfd stays in its file descriptor table until the
> process exits. Calling it in a loop fills up the table.
> 
> scm_pidfd_recv() deals with the same problem for SCM_PIDFD. Since
> put_cmsg() doesn't fail on truncation it checks the size of the control
> buffer itself and sets MSG_CTRUNC before it allocates a pidfd.
> 
> There's no point in handing out part of a file descriptor number. So
> fail with EINVAL if optlen is smaller than sizeof(int) before we
> prepare a pidfd. Since commit e10899b2a098 ("net: add
> SO_PEERPIDFD_THREAD to get a thread-specific pidfd") SO_PEERPIDFD and
> SO_PEERPIDFD_THREAD share the helper and the latter inherited the bug,
> so this fixes both.
> 
> Fixes: 7b26952a91cf ("net: core: add getsockopt SO_PEERPIDFD")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-205984@kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
