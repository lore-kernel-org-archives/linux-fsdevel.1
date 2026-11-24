Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542194;
	b=yRd3v7rJ2hQ5bisEGr7k1zGyhVIfsG0kEHxSXud5YEhx5duXV0dv3LhSCw+phKXXCPmS
	 OzJvcq02y+vIl4/o31H0sFcwyXXxmFAY2Xr7jm5JTeLisGh2cryAwyZehtODBe+38w6kI
	 IkaFrmx2jxsqou4xXYenB5ti0i6oNW+ytB8oxlc5woDB6g8wFwityrVD+ZzopaWDjCy7M
	 xRaetOCfyHBagtOzckcGo9ROwKURDrFiDptRIxY30i9aOIq+V2wlztF6uGQCBJ/latrT1
	 F8ZoZyKhQixykcJCcHsMjjHdMGePuwSJWSZJJlpFTj3SLtLOhEMIeUXDx0huBTqU5bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=sGwL+rAjN7ROYVGUA8Ywk3WhpiIIp3H2Jwa6afAFCVc=;
	b=lRp647o1dKxr2xZvWyKNPK7JyaSx0vUwu1X/XAlSGcCexEi+ZfIiQPaqGajBU4FkYDbW
	 QpOSpIcbi0xrqeseOOAP4E+4HPV8rxIh8ZI/W3guwpFYSUrnLtaMv8sq8ebjfUXZTAYuK
	 1QnfLn4QhLF/UhA9LCWC81i6mMCRBXZQNQ/OewLhy5S3chGp6DaOz+XlODiEuXWEnAWHX
	 YSlpUCq68dcwTXBWGIC/GHJqIh0cbsCyPdwzWZ2Vmn5OpoEhdLar/GX5X4fBxdFF2BRNP
	 UfslKfKWdZvycbjhZZrnSFMh0VA03nEl1EBo1BAieNFfMpcZkRXIx1xnnqmKo8fnfTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=KMMLETkZ;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6275606A683
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 17:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6275606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=KMMLETkZ
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b8815693e2so5544336a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542192; x=1796146992; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sGwL+rAjN7ROYVGUA8Ywk3WhpiIIp3H2Jwa6afAFCVc=;
        b=KMMLETkZ4BGYa+5B7Cf3aD+4pEtmzCxPaAyGY+dPo+iSjpJLp0P41pL7E9fy0WGHUv
         jVKfKPyV/Lz5NdM2ljPtHojff8LDblbCTBKn+2GPBSkFxcvjp/0LM/iV0HpG9SPVMAZv
         H2KoRggIWqVq4HZRKVuGcWfEZ38caB2gGG8jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542192; x=1796146992;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sGwL+rAjN7ROYVGUA8Ywk3WhpiIIp3H2Jwa6afAFCVc=;
        b=yJImZIGBvkJz6UI6V7C5G72w3ZSjdi8/kilIGGS2K+DwNGqdaToK6nPjfHcWPBi3U2
         6bpDu0O1YwTN4Pg4Z6wU7C79gdNwDemXOY4hQbAaxriKpiWsyPkMg8a//nR6IK+yonpM
         0pGua0dxqvOrJF6XLiHdEX3WjEEsBGR5CGfLROMpGUx4qgZ8HYbfz4JeoeH6pxRU/LRq
         ewYJp4oE0g/AGdue1G4N9bZCF1Z3IkLi+CK3jLc3fcL91GF/gp9vjqsnxLhAWajLzHmi
         o9F5BPnt4QJBBw9v9n5Sj1uGL3CK6YlKaDYlh8z1ad87W7S92SbvFX8v1JfMLzUVzF9x
         8fAg==
X-Forwarded-Encrypted: i=1; AL+hErEYy0LyjGOki2dQsRq/iPIukkM0jHaiasPoXUxhkw20pV6P2WIvPZVVKtE8FbaurvKKWKMtSQo7f7gO6R9m@vger.kernel.org
X-Gm-Message-State: APuU4Z8gTyR9II7hUCvuD1ur8OdBj8Rj+qY1nwf3GNi594kTK9SPHfxp
	AfibqOR4TH739mCo8O3a6HNyqszqSJtFwyYGz4UYaZSYyiDVd99/kvbn+3+QWMsQdukzlLjgolp
	fBHm6GvbQfA==
X-Gm-Gg: AZFdTZc5M6/WdwlS84cun82MnaX4sQcRavr3DWgcfWiPEQZFtgseoabm7gJ774jjiMP
	SW9kcq6HrsaIV073XCRRkIcrts93cWj8giVhkO0meiWY30ewpZhUIXyh4tBM8/GHT5LTlaz8+Tc
	jd02LIQElkjNn6O/IGlzuqU0lmm/yG4SAuFjIfj4nNUTMlqsTTa8g5OXNqOzjYJ8fLqPRE9SXFQ
	jzKDqheJQ+NDEZahSiPJ12zNDUEkKH4JVwajSSoLx6u7MVXOSKswoCjKr9bO1tPtzFS7cYxRSRT
	//LW+aDfPsQihCkoZ5HrkpYIrNkBGTAYbOTvuD/u5iI15yH5MdRf9XaLwwnjM4DfQtdcJIqYca1
	HiXQ3Alimh3/oS/Xnxt/fEq0BZHUcKm1PbB9UGldmFsxKlk18Vjc0X5w4eXbLfwMtCj0e2o1AAO
	rycOX+CInpWmyja6QupVTjKs10RS1sdy6V4x4htclFRnxbRWw5UyRvw6xT64I8fefzi2XFABtJl
	NZEDtVxAp8gOCioVA4ov4JNlhFAYp+ecsRq1ZK98IIjvrHy6XBAbyXlu/sNNcdCUY5aHFLeSRAc
	e8cS3oqohXKAJZB9v/9PRXFgP7L2Mhqfh/46AVVE/5Z5jc/QbTzNldhJi3CHGuFVjkp5msDgVpQ
	SFpc=
X-Received: by 2002:aa7:d819:0:b0:6b8:a703:8ffe with SMTP id 4fb4d7f45d1cf-6ba37c7ba68mr8728903a12.5.1795542192245;
        Tue, 24 Nov 2026 09:43:12 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb07844211sm738267a12.6.2026.11.24.09.43.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:43:11 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4d427836e9so661852066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:43:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGuZU3mFDeSLQyITqaj4wEI/YyqhkiTZldRHcRFEGuYLF5Ty1Q+bzwRDzFFdEvgc7JzxI9M5UqEKdg0Wsyc@vger.kernel.org
X-Received: by 2002:a17:907:a88e:b0:c42:5363:38dc with SMTP id
 a640c23a62f3a-c513ab0e03fmr1346144566b.25.1795542189561; Tue, 24 Nov 2026
 09:43:09 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 09:43:09 -0800
From: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com> <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 09:43:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiBBNtcLyu2fq47oXi-v2hX02m2=xFiG7tNa_hssaMNTw@mail.gmail.com>
X-Gm-Features: Aa3M54qKnfQZwxI-mjKB8QHeQk1--kc11z_QwsMG6NLOaQrTy8GdH9me-KahpT4
Message-ID: <CAHk-=wiBBNtcLyu2fq47oXi-v2hX02m2=xFiG7tNa_hssaMNTw@mail.gmail.com>
Subject: [PATCH 1/7] sctp: don't let a blocked reader take write-space wakeups
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Nov 2026 17:33:14 -0800
Subject: [PATCH 1/7] sctp: don't let a blocked reader take write-space wakeups

sctp_wait_for_packet() waits exclusively on sk_sleep() with the default
autoremove wake function, so it accepts any wakeup and consumes it.

Then __sctp_write_space() sends EPOLLOUT with a wake-one wakeup:
sctp_wait_for_packet() wakes up, finds no data, goes back to sleep, and
the walk stops.

End result: anybody else queued behind it that was waiting for EPOLLOUT
will never see it.

Filter on EPOLLIN | EPOLLERR like receiver_wake_function() in
net/core/datagram.c.  State changes (using sock_def_wakeup()) use an
unkeyed wake-all and still get through and will ignore the exclusive
nature of sctp_wait_for_packet().

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 net/sctp/socket.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index bc68af88e271..85ac4952e9cb 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9070,6 +9070,15 @@ static int sctp_msghdr_parse(const struct
msghdr *msg, struct sctp_cmsgs *cmsgs)
 	return 0;
 }

+/* Don't take wakeups for other events, e.g. EPOLLOUT from write space. */
+static int sctp_receiver_wake_function(wait_queue_entry_t *wait,
+				       unsigned int mode, int sync, void *key)
+{
+	if (key && !(key_to_poll(key) & (EPOLLIN | EPOLLERR)))
+		return 0;
+	return autoremove_wake_function(wait, mode, sync, key);
+}
+
 /*
  * Wait for a packet..
  * Note: This function is the same function as in core/datagram.c
@@ -9078,7 +9087,7 @@ static int sctp_msghdr_parse(const struct msghdr
*msg, struct sctp_cmsgs *cmsgs)
 static int sctp_wait_for_packet(struct sock *sk, int *err, long *timeo_p)
 {
 	int error;
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT_FUNC(wait, sctp_receiver_wake_function);

 	prepare_to_wait_exclusive(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);

-- 
2.56.0.313.g975a75ca90
