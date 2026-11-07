Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049148;
	b=ToG38YZ2SdGCZBW3jR3KQH79Xn/pFNgdPFfABN+kN6m+iPAvflc4lKCMzbJghr8vDjzl
	 FRQtDjtDezU+rlpSDcfqIOEBEA3qPfp0U/yw0gA0zNKb+M66/E2c89PM5xrEqnJn2L983
	 NUeV4zQy2x97AFdCgleQ0azRb3vjT2GKg+q94QfGiyeLJb2bG3zKF8sza9ekbzJekvB7Q
	 RgIDWuJuLRDtzZeLT13rxkACgfBAZ7VeqAuEcUvXhfJdsvKVUXs6idYllpAYHD3K+Bi4w
	 9HOwG/WkvEFNYaDrjsvpYaahcGOARGMMt4BYWa/y2MB6mpLNqQCw/XdB935D9EBmCwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uF3NLECGowX2y5BaUJvCNV96peqx+/eZQsYA4HOxfiA=;
	b=jUnnKIX0pZ16lucoASBGagGGwtJWSbSAWWry3x1Z3WrXyHWsi76fRPxu5mvJa+WXCFVp
	 bklrsDtnOPtOtC33H2cA0yB+aztR/mH2jte8bVECAHIKh0EWka35ay2Mt/Kb+crX8fAhp
	 fXPN2f9osDym+yqh0iQ6UsN7+s/6sy34EkhPlzyPcGsrHBfsfmwmdCBd8WElfVPehKzfY
	 kvdcr7z2C1eSEJ9aq4PI302LSbjN51oOOBKkYx2sI7Byboo2XS6n3Rb1eIMYoRdVRmqpA
	 /T37BgaEaUydDKyu6pwhMMTtwC37VZibwQWjRs9aLRpvzCgoOr6JHqwXeRryAArtfJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AfRugtVJ;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2AA606A332
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2026 10:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A2AA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AfRugtVJ
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c40e30c26a4so63678266b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 02:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794049146; x=1794653946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uF3NLECGowX2y5BaUJvCNV96peqx+/eZQsYA4HOxfiA=;
        b=AfRugtVJHHWWen0rD4EPsg5cpCcP0AekhrFA9Qt/I/sf0AYhVFxJuJiuAaP9JFZtp0
         9yLwbTGPT4/921m5nXTYLd5LLMuzVqDb+Ws7u8HPuAjJhOuvma0tuCHivKiS2jNdBCbd
         Wz/2t0HI7G5QShGuq54OjEk7kvdwGFSsGqXVnIcoWjEpg3G/J/CtiMvkKoRfVVlLkNx+
         NJkDTTdZYy5W+2znJZcRy8D7Ua0T+MwIHdWnzM2+XXDCiUkOMVtqJJ2Hiyq6NpkpRckn
         gjA0dptNa7A0UY0NPLF4MLzY+Q8D0vk98gXYz3ZTuFiaTAZDmSueug51qA028x3scVF/
         fDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794049146; x=1794653946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uF3NLECGowX2y5BaUJvCNV96peqx+/eZQsYA4HOxfiA=;
        b=Zd60PcFJEfdtZXlCglb+8mMy/Kj3YvsB8qmFLsYreqRH7KPDAHKxtsBCi5I4/9R6hw
         D9g6jQt8uchtPUZnFdtOQU/L7+bx45P6vnZIOcQJFMiKOCwIVVxBdUqxdLho8wTpHswS
         HQKwUs31kE1ESVS5MtVDSeXawF6vKcMPaWYDs1bDjTMn4BUWAEZbqgAGgetkuNnjV1uH
         U02XaOrUC+mIHaUInaGuvlCD+bEi1O8UumWBVVrlD/IAQyBWODMvKTS5OhEoINU3Ee2w
         isJYIlIIUJm+S5xArdPckCF/lNCvCopZfyWkIo6jAmLd9JwyaMRdB1oRPKpbNF+ViqXV
         9YvA==
X-Forwarded-Encrypted: i=1; AKwUvByuwGv08bt4QJLT67+dMacYKnK54JroUjHvrQg2X/93Sr5oduqHFktIiuDXIpkdsYyfkU0YH/GgV9iATHDN@vger.kernel.org
X-Gm-Message-State: APuU4Z/Bw1HS9aUQCzhkkPJB0rYRQFJEiqLuDa7V/X54eeEQAIw2vkza
	NqAy3O5l2YCmny4LjHHTi39yx93RiRXWjJ3Ia4NYpoPQ22snGH9XjFxr
X-Gm-Gg: AYBFou1sFNdmx1g2goTvwi0+bTifmX5ifOJCt07BnbeS8QaR1Ab03NwR8OgZZAgoep1
	+5jwof+EvHPpBU7Sb17lJlG2Uy3E8Nru98XVG1m4qcojeh+I4uQ7Uqcptl83FsApgNGuvvEaw8i
	enjj1wB44rQNUt4pitiZQoCmCZMjvp4rzllvLPjKqRAlERyHdYUCLYYGN/oBcDPmaWAdjJiL3E/
	OjMg++5DHcQ1FPtpuTCq2c6zfQ6uDDzLXgtEdlUvfYhX+GO9+T/MAwQpGlR/rxlehELKKQDxMoH
	IKushzdfVvI4FUcYcFDVlj6aeO5OYY0x8S7Y94+2H3VBCG1oUymi+OOXI3+PLw6mi4pgjmk0Bzg
	itxfNFms+4DCX3gsmfMOWaAxNH2G9RW50pctmnwr6yatguM3TlYMBPCOLwZp2zw5KAMyZ3CAtZV
	TO01z9bPmDfcod68u+s03h7n9FWpbccHOUfAX6leXhhNVi0fnolBooUeyELKR8iisW+gECacvG1
	U7VWSprLFaE8HsUtUQocndFeF5IqAJOo8bSNvwJXfm8/Qv4O0rCrrdxS4BGRNEzKjfG+1L4dJYC
	82c03mcsIf5lVx7+m4/+mO9IYIm3P4jzdv2n0qh6QVPMv/E3xzAUqnaOauG/vW24kE4qX5HTkfn
	1TWJfxzNJCxgc
X-Received: by 2002:a17:907:1c92:b0:c2e:2275:1168 with SMTP id a640c23a62f3a-c4d527afc43mr109634466b.19.1794049146286;
        Sat, 07 Nov 2026 02:59:06 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ff8a6asm1695097a12.32.2026.11.07.02.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:59:05 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chris Mason <mason@kernel.org>
Subject: [PATCH 6.18] backing-file: always end a queued write
Date: Sat,  7 Nov 2026 11:59:01 +0100
Message-ID: <20261107105904.3962893-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107105904.3962893-1-amir73il@gmail.com>
References: <20261107105904.3962893-1-amir73il@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

commit 627cdcbc2a2eceb0452078a0c14370f9f1f17a91 upstream.

Writes to a loop device with direct I/O on an overlay file make the
next freeze of the upper filesystem hang for ever.

Every kiocb_start_write() needs a kiocb_end_write(). For a write that
is queued, vfs_iocb_iter_write() leaves the end to the completion, and
backing_aio_rw_complete() only calls kiocb_end_write() when IOCB_WRITE
is set in the flags copied from the submitter. In-kernel submitters
such as loop do not set that flag, so each queued write keeps the
freeze protection of the backing filesystem.

Direct writes to a loop device with direct I/O backed by an overlay
file left fsfreeze of the ext4 upper filesystem, and a later touch
there, blocked in D state. It takes write access to the node of the
loop device, which root has by default, to attach the file and to write.

The fix used here is to mark a write in struct backing_aio and to call
kiocb_end_write() on completion of every marked write.

Reproduced under qemu without KVM, on v7.3-rc6-21-g602042bf29f6 with
earlier fixes of this series applied, with and without this change,
once each. The kernel was not changed for the run. With this change
fsfreeze finished in about a second. Not run: the nvmet and LIO file
backends, which do not set IOCB_WRITE either, FUSE passthrough, and an
xfs upper filesystem.

Fixes: 2406a307ac7d ("ovl: implement async IO routines")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[amir: use aio->is_write to explicitly mark a write aio]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://patch.msgid.link/20261029180319.2852090-1-amir73il@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
[ backport: context: no do_backing_file_write_iter(), the write is marked
  in backing_file_write_iter() ]

 fs/backing-file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -83,6 +83,7 @@ struct backing_aio {
 	refcount_t ref;
 	struct kiocb *orig_iocb;
 	/* used for aio completion */
+	bool is_write;
 	void (*end_write)(struct kiocb *iocb, ssize_t);
 	struct work_struct work;
 	long res;
@@ -123,7 +124,8 @@ static void backing_aio_rw_complete(struct kiocb *iocb, long res)
 	struct backing_aio *aio = container_of(iocb, struct backing_aio, iocb);
 	struct kiocb *orig_iocb = aio->orig_iocb;
 
-	if (iocb->ki_flags & IOCB_WRITE)
+	/* Pairs with kiocb_start_write() in vfs_iocb_iter_write() */
+	if (aio->is_write)
 		kiocb_end_write(iocb);
 
 	backing_aio_cleanup(aio, res);
@@ -255,6 +257,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 		if (!aio)
 			goto out;
 
 		aio->orig_iocb = iocb;
+		aio->is_write = true;
 		aio->end_write = ctx->end_write;
 		kiocb_clone(&aio->iocb, iocb, get_file(file));
 		aio->iocb.ki_flags = flags;
-- 
backport

