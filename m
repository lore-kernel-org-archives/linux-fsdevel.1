Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793563653;
	b=F9NCE2qCe4AldIRj4f8pRLVwcgjKPOXgKsJV4QLXtquGI+JAlT/4oK6u3k663KRORMVp
	 eLkq1Q1O1nsmRBnzDBxCYcd3M++xZBoysyzG37z1hXYpbpXRDkvYcQq3v/LxMSBIpM2by
	 TsqNFmbui9CC2hZ85j2/+5MBpPZPyd0c5vzuMbFyZQ8YG4/TGyUuwX58KveEMF6GEJYhf
	 7NFH7yO1dz1MD4Ke4bsd2BwPA470UxHqndjq0pTNiIWDeHBEUK3vA3lZI9XeAIaiIL3Oo
	 lNV4Ch3R7lZFiQvvICp9/5f4RaSkfXDK4n4Lqg8EbGyGKEpsvPCpdrCXyZraD1bSkFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=26V9a9aMGmLVeqkqAbfZgzyyhjfF3Os6qezAyBkdxJI=;
	b=qCPU33f2TIVq4Otk1M28qrUbbDgRZBRSxJZuOGTET7qwBfTBBGUcGFjhthPLxzwLG7kt
	 LLW824BnPOCnsSblo9K90EP3Z1nXMoX+cLU/06WDyb3GnsXKLvLETw9khJUhkvWEUqOMT
	 jho2ZwCIv9l4hiAoqtaAbzFNGopUmTEAU2iFSA7C4cGIpna17p2/jP+VXD1BcrdQ6tu/D
	 d0rdouIASGa2McXPsOganI26lggDPA4Ws26S+UNGoQ1E41AVw+mz91wjj2IP50qf3kMbs
	 8p2jqfzbh/eBVEJUS+p6tXTlr79IQpbnn+hkZvo1eZUFwP3vrkJ/ZW/udOSLiUAcIhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H97WD1p6;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2550D606A324
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 20:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2550D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H97WD1p6
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a315ed211so2875270eec.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 12:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793563652; x=1794168452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=26V9a9aMGmLVeqkqAbfZgzyyhjfF3Os6qezAyBkdxJI=;
        b=H97WD1p6d5/EVI7F57TkMr97HS82HTIdDZuh7Sw77hyT1l6Vq6Ethtfh77aGCKH1NH
         goxg0jFmw02vjTXGwFkETieEgB11VZliuMuh9DddXIYEr7DLKfns7FPqTNWmyeNZgf16
         Lntlkx+e1ARIHqW4vzzcFHuaqHuPUb2QUgk+gFJz2igoO8hdbLpHwuElOf4JbiMr14Bs
         +ThgFK3bZz4Jz3+d/buaomWz5TKVZqNTk1ZaGPSXOz1yEfQgWTQ2GH2G0vxyD1Hxvy9Y
         9k268S6SvWRKCp+Ve4cwabuwZNryq3EVV1AzznMKJ4bHxTzV9pRNqvVJL0REvxZ6qO0f
         brsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793563652; x=1794168452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=26V9a9aMGmLVeqkqAbfZgzyyhjfF3Os6qezAyBkdxJI=;
        b=ROgybCk1eD84PycukMqxgMGD8NukmgCrPUFR0zGjnHoHoL0Sr9DJZy11J79zilCRt+
         zga4m0KihuOe9l1CQxUHu+5tNVA/8OxguoJF7wzWXqQVle1Y0fxnB9QUA8tfkX1zF3sC
         y+0IBpEum/u2SxwHgVn2niDsriYeEgdV8YOid3WImqRn/PZMyMC/PCuB5i+WrdanKgqp
         L9YRvB4x2boGM6QlCxITaTV23DKDfjXbXMfQEiAPO8gJy2lNx7WNMSZHyTn1e4V0RUMT
         gNpi6iyloDuYh043lsrk03OObc6XCW066NgAHOR8aRwvMpLHkk9wT1HrCP8J7/qjiaEo
         FKXQ==
X-Forwarded-Encrypted: i=1; AKwUvByBZ2iZ2rfqXePC6RKOMv+4Yq05V33pylwAgtUYzhCXnR2SWJ42nJdixtXJfK6h/1iaxuK4/jPFKt3ovCyT@vger.kernel.org
X-Gm-Message-State: APuU4Z/iatY131xDofSoolmTOstcOpOjVhThae78qrKZcit05XOr3VhA
	pQ5/Mz/t0YuUn9JISWrOglyfqGpeV+NSfSce/RMI6Sx8ClIIKrHMRpgo
X-Gm-Gg: AYBFou30xkKok8vqc3Hlp8r6T3j27OsyE26E20gjwYkzrPuH6a0K/ojXkbgeK9OkbkJ
	KvqVIMH24r9JKOMok1MVe4sbEOLgPbnq/mk1GubCSYlgMmA+PVMYPzTYvfr6cDgDSH3vDRrBySU
	LXNhn5MuqxG/BJUh2Lgt0fTaDssSs7wd2dK7kR9jkTkBzz35bwqCrmZfi/hhI53zDUOz/fVn15Z
	/YUXV0RW8OTEiof3/xLQtXwwGhiEjDkvrZ5iVJQuvE+iX5wdDcrhE6JH8yxrBX12Uc0nYh2EfIH
	wqn1CAGdPVumkbzwZwYVnXMv6my05GZjdP5Mbf8v0wfDpDFuQUoM1c8yUvuFsNqDojnDJSEKhPU
	x8xegYkQ/3jknnKlItGQkopoLHmtI+vNtNaNZdBsW8yzPve2Si6w1h6d+iyPpOeF5qTtbzpjIK+
	h6yoHOlYSiApEEcxLlXBAiMifM6gPmY1Gr0nEfH+Rlks6u6fnbjxLrNCNZe7iU7pj9Nz7E1RVfy
	3gx4WnXRBPRk+mtflZpD+1WZ8uFIViCPO5eozxjuprbHhXBO60iDcDwQw2IRnX0QxxqbMTJWQWv
	he9MA+IsZ6OZDguLTJUdB4+hQRvhuStvw88KIt5hoSy/TpS3LxSgpEg1SUR+mHtFQS4a0L+B1K1
	QYcYV6MGip8I=
X-Received: by 2002:a05:7301:4290:b0:35e:af84:bf1e with SMTP id 5a478bee46e88-36a4238989dmr12095636eec.7.1793563652095;
        Sun, 01 Nov 2026 12:07:32 -0800 (PST)
Received: from pranith.org (c-67-164-4-239.hsd1.ca.comcast.net. [67.164.4.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm35052920eec.26.2026.11.01.12.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:07:31 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH] file: Use release ordering in file_ref_put()
Date: Sun,  1 Nov 2026 12:07:28 -0800
Message-ID: <20261101200729.2872806-1-bobby.prani@gmail.com>
X-Mailer: git-send-email 2.47.3
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

file_ref_put() uses a fully ordered atomic decrement for every put,
although it only requires release ordering for the decrement.
Acquire ordering is needed only when the caller may destroy the file.
On that path, __file_ref_put() already executes
smp_acquire__after_ctrl_dep() after successfully changing the count
to FILE_REF_DEAD.

Use atomic_long_dec_return_release() for the common decrement. On
arm64 LSE this changes the fput() instruction from LDADDAL to LDADDL,
so subsequent independent loads need not wait for an acquire that
the common path does not require.

A pipe workload that performs 20,000 write/read pairs while a sleeping
helper keeps the file table shared runs in 2.92% fewer cycles with
this change.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 include/linux/file_ref.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
index 31551e4cb8f3..a5e262d7083c 100644
--- a/include/linux/file_ref.h
+++ b/include/linux/file_ref.h
@@ -154,7 +154,7 @@ static __always_inline __must_check bool file_ref_put(file_ref_t *ref)
 	 * fails then we need to handle the last reference drop and
 	 * cases inside the saturation and dead zones.
 	 */
-	cnt = atomic_long_dec_return(&ref->refcnt);
+	cnt = atomic_long_dec_return_release(&ref->refcnt);
 	if (cnt >= 0)
 		return false;
 	return __file_ref_put(ref, cnt);
-- 
2.47.3

