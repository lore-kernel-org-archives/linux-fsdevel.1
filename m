Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968260;
	b=TWsQ/wV0VLcJV9BAeqaD7XULbFZ845T3BZdRigzVF+0NoV8VijAMocnVs2VyfrueujRP
	 PPTyjo19PyqasXQJeA+iDfEXdLKGFB2QmmOhJkzyaZQILHKF56yimniHnTqunI1ukf9Rx
	 TVWKXZqx4uaUE9r5NsveLJRSeHNnLo3trI/JtqOL47USBprPipJsYu0h6S1Go8HBIzoU4
	 KgkltxQnPUN3nNsOXRqSfDJz6+Zfgryf1W4V8a3YDSMIwFBYTIY8Ypc4nEO4RSbMGN/fK
	 d44cjug84MHm/ur0ipTI+VwxXxGJjEAZzJrroul7g3BBcngppNabQKyPRVWhW2wnlXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=u3zq46NekLm0rnRE7EnHC6taGjs4cYTrxEDBUmEQrUc=;
	b=opEzjSFc24k+VGylcGMAzn2gs/WvEqF6yhROr+JWOsq0PunZ8mcEWUHXZGAz2q1XTKFo
	 T6fwdofQAy9rKHieC2yhSskm0NYk183Ksde9PkOQakz8/FqsMH+5l4Cxq6vGlihysLcG0
	 Gkjaek0GxU2Jd0dkdbzSsQLq2OIQpmbf+mKUdiaU264voJvwhACpeRqLk68M9pead1E9A
	 xIsiiWqP6N/6UcuP6nMe628uajEf/E1eM24xW6NWz+wn6UfwE7Gdrb9kdL6gLJralZnNu
	 vtFTSLGD3Ua8d5tGr5xUWdatm8XnVTTDNHoyB5ngDi+HZGLu6v430d7e9VwjP0Obj3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZkTvKvm1;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669A606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 02:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A669A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZkTvKvm1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdaf2073b0cso277467a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 18:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794968259; x=1795573059; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3zq46NekLm0rnRE7EnHC6taGjs4cYTrxEDBUmEQrUc=;
        b=ZkTvKvm1rMMk5zqcfqPID8WwrkwGWAl9Eapq1UmUFb2WZbh5UiRoS3es43K6iE2jEl
         dmysshDJ3kqm2A1kyE80zxmrX16ks+LymUnpDI5cEejxlz/pPr1OTnkrh9i3rmQqhayo
         wFuFdRYrNkzoneg6tt4VyDW/bCKgNCVsbetQS3dwTpRMgziJReNRnfizRC1OxGwZqYtp
         QepEMjQFxgxbhFp+RZjBWdnGmEMfXc2mcK9lT6ihyDOIxKznX9pC0863534SU5NQW/So
         5aXEJBBUcHx0XPU2/FSB/2vY8MB6y1TVrjC0fixTJf6Y5FgDsbXpoCg7ungrniOK5nHF
         nZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794968259; x=1795573059;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u3zq46NekLm0rnRE7EnHC6taGjs4cYTrxEDBUmEQrUc=;
        b=F1BdKIIdcOM8BNrmaQZEvAQYKKzctxZ1x5XZE0FMvl2OaYsmXfB6pOSDtQ/JZEUiet
         abO9Q6rFwps54cLcgZfLr57H/dchj0m+qUe4hzvCgUvBOeKEqDWIaDcWOAMPMCxs3aSM
         sItNYu8+uEcpcMX0C0kx9IR54m3TC055ExFeHlw/a64nSgNvVTKznX1LiW7B0IZxLk9V
         YgFBfsT6VB6iD6OeLGe6pf4uNAKsqDav3x0F3izWglgANXzapXtbPKZw/+KQprs5+Khe
         m9oZ9HMtELcHGDpKnkdiSrwnAsx6PpDK9l2M2NrUcssyQ3yFCoUFjQrqdwlyUfaluDgc
         dlqA==
X-Forwarded-Encrypted: i=1; AL+hErGNJuWoVcpbqRkBBXgK4emytusn/8XKb6T81Asq3MjWfvLWd/QCcHNCDEQQ8PRm94WPSGhVX8cIWQYCRDo/@vger.kernel.org
X-Gm-Message-State: APuU4Z9UOkyngKY4ITjWmOSoIngPW80ndz8C1pI0TeMq3mnzmgwSbCxt
	15t2Lmqkr9It7pa2KNudqsaeoiaGbwq7nYprviHIzUy+otFO2Vd7KUETm15nDZNMtlQj4vNqPYJ
	+Ao2nvA==
X-Received: from pgfv18-n1.prod.google.com ([2002:a05:6a02:8752:10b0:cc7:b626:d7f3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:95:b0:3f9:a6b6:e173
 with SMTP id adf61e73a8af0-3fe89a0fc34mr1234614637.26.1794968258882; Tue, 17
 Nov 2026 18:17:38 -0800 (PST)
Date: Wed, 18 Nov 2026 02:17:38 +0000
In-Reply-To: <20261117-work-net-peerpidfd_short_optlen-v1-2-a93f56288501@kernel.org>
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
 <20261117-work-net-peerpidfd_short_optlen-v1-2-a93f56288501@kernel.org>
Message-ID: <av0Kt6neQbnIJpp7@google.com>
Subject: Re: [PATCH net 2/2] selftests/net: check that a short SO_PEERPIDFD
 optlen fails
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, 17 Nov 2026 16:25:31 +0100, Christian Brauner wrote:
> Cover SO_PEERPIDFD and SO_PEERPIDFD_THREAD with an optlen of 0 to 3:
> 
> - getsockopt() fails with EINVAL
> - optlen and the buffer stay untouched
> - no pidfd is installed in the file descriptor table
> 
> Check that a full-sized buffer still gets a pidfd.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
