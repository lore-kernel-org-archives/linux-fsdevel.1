Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795145812;
	b=TDwGCElukoyRX3NnfTKL7iflyYcXgfPb0tjgk0AvW+oNeesL1LaBngfb2/Es7jiuXZ34
	 wSxcni6h0NfQEk+VQqLlfkBBc3rX36VNmiYrqI/750ZqhiOtF+Sw9uEmbU5q/hgHze0dm
	 rYRkWbPYHqWe4KRI3kietu0EeM//ARIgzPWIlsWqs8hX+aQ/tf+qbF6moazzttoiRe4ho
	 PvaHw5iRjsHjekH6AOO9xuIl+BQy0fvd8NrWBo/KU3hBqp6Jh1AyOYqtjL9PWMvnCMUgv
	 PSFMEekyM+qq5GiS7u6DAxYOfARVQ84KpMSUM5LuPTPE1ChQJvapLu5thYV6H90kNvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795145812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MI0ADFbz8sRruSBF8RUNgyc7izln8BOExEANme5gYDY=;
	b=ugxIxReY4ys0XNNS8b4f7C7C4naCraYsjnURbMuEPmP0/gycBG7AgpnXVWNmXG4MP08G
	 QmDiPLy0AlL3hZy55hbIa6Y0p/vNhE+/ejOEor4U03t0x1xPJu9jqPLjIUUussWSb+mUV
	 AUW4hWSNnjUuiHhsMPlGvwnYNQ+Zicyzx8Q6T+3YxqcHm0UJ8oNUDsCrmjR7aG44zKKj4
	 4f0XXkFlbKg3B0jnEGI8p/4zAbp4HtmeGb/5AqA2PMwcTskN87XAkM9EdDXTmBJRw5n/s
	 3aPQMLX+pSh5eeWYCiUrlCHc2ZaYDjhg3vT9R1DVuVeL+qH/akGokwCcw9aQyZBt6jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WWLQQSFC;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B8B606A320
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 03:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B8B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WWLQQSFC
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-385c497bf94so456105eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 19:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795145811; x=1795750611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MI0ADFbz8sRruSBF8RUNgyc7izln8BOExEANme5gYDY=;
        b=WWLQQSFCS4ynPz3MDQQN+2srUsJXfSACEjDNn4aPY5yuqJIeJgXXOkH9JZnRHWQERS
         FAHDuBj+ASqN9RwgLxGLAqFDY+KRkly5fAsnRiDtdYsGNeIsh824wjAN6hPCIeOftw6Q
         L+fsf9Lk/uv9YJRyxARVncHptGi56d59adUqa4tuKJ52ZOXAOdUj1vnqGHQwyGZ1SXzc
         N7h65crNW192X60Y6CA1P+Xio1+fVJWLlCX2aP0tLabCNuBzZPVyGmldtusx8kIiQT/2
         5Pwx+BUPG1ozLCkVf42X8RkFZ9nmlNO0jpjURUyEmVkiFy9z5cZiweyo0NhihzztUsBU
         UuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795145811; x=1795750611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MI0ADFbz8sRruSBF8RUNgyc7izln8BOExEANme5gYDY=;
        b=u2BANYTSFkTi6AiL2zU17PH8qUbCux1m7eNXQ56umfEdRkhXaWHCEDjgmKyJhVpPl7
         4lpdGoL9esP+OBzU2FMV4qx5be2Vp2BeAwCHafdvt+dreJyUvpx0/+gY/LRPplUu4tfa
         BnQRAvj4VEry8GjBER71r+hvPO5VBblwmdrEc89TBStbTEA7dGH8zXAqUelmIsIg4m7x
         juwQp5Mz9y0mVJykm0YERv07jljWzujCn1I9K6BlvMyMM6oWGu6Mz9mNr4+j1NEDtj5J
         RMNEYL8LYFhQVgFOW6ckTXvjBUTZyuFQVlSkuZAoahZwTt0qEjkGL/aFj1dOt329YcJs
         XMdg==
X-Forwarded-Encrypted: i=1; AL+hErEEnDw+DeOOWpx3zTFKKgl9wp6hdizF+7gtZYIyH8UyqwAbRModwCM/vmkFICtMYOO7vJ5HvQyY3uYH4u1T@vger.kernel.org
X-Gm-Message-State: APuU4Z/CrGdIjw7xKYfyoc9ND0Y+P3gJC7h7WsMQiPDeFduPffxcRyZf
	avpdynH8/PBm5Sx5VOQ84FFVBdeY7EgIn2/EeraZFcGlsyZ5GBl/CKb0
X-Gm-Gg: AYBFou1om1O6El52GaswB9/CMLd0DGc9gaGvysLs0SBcd/Qd1lQsZ2QdVqmzKWkGIuR
	KnnaF1AeOMUkGg7yq/nEczXQ2FwdbPZvkb9hbZXXcsl/hMV1q52qetVnFz4xMPiyOq3Agr6q2s3
	Mj+daOFPqHK2uhb2bafW/Kflp8HFf4doVXKXiT0asoKHgUnKxYdWdX2xS2/TOtyBdZze8t5kDGJ
	jplD+VZJKIPXW4QaLCxzWNK98bIPem9BUbcgz+mOjKL+dFid93UBKM902W0lWr26Qct9JLE6Xko
	xP0a6VJIDJuAKpVNEp3YZWqRQRmTXR8eaIBOxrJ2oIv+rkx3y11Ds6pMjRnpLmWwjqPatNfXAac
	ugjPkB2lAMx+GdAlj0WnCJnu1M+F9DLICrY8aIdVqbKH9F1JeDdBfl5i6WJVTKhY3XxBTFdl2EB
	bbZZCRU1W6SoQIHRo/EoKsNH1DGaFpQanZUiPnBiqHZTgnEsJZhN/oTOHtPwHqTOmPPADg4F3eG
	JrMGABf5JmYNrA5ijGiXStHJXtMWo1Va8MVirbLc3LigMiWWGFuHV32QYYQfiBPBaV6HVaYkiui
	LSbdfWVpy07X5Biw6FisG0di9fDbNFgkTNztElJhA0PtROQhZ/abTC2IyHxBK2aiHA==
X-Received: by 2002:a05:7300:108:b0:375:50d9:474e with SMTP id 5a478bee46e88-3856c0d0bb4mr1785949eec.4.1795145811208;
        Thu, 19 Nov 2026 19:36:51 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm2982064eec.16.2026.11.19.19.36.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 19:36:50 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Ding Feng <dingf3ng@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Ian Kent <raven@themaw.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] statmount: retry an overflowed string before reporting -EOVERFLOW
Date: Fri, 20 Nov 2026 11:36:44 +0800
Message-ID: <20261120033644.99834-1-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
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

statmount_string() compares the seq_file count with the caller's buffer
size before it checks whether the seq_file overflowed. After an
overflow, seq->count equals seq->size, so every buffer of up to
sizeof(struct statmount) + seq->size bytes gets -EOVERFLOW, and the
retry with a larger seq buffer never runs.

The result can still fit in such a buffer. statmount_mnt_root() and
statmount_sb_source() write escaped strings and unescape them in place,
so the escaped form can overflow the 3 * PATH_MAX seq buffer while the
final string is much shorter. A bind mount whose root is a 3765-byte
path of spaces needs a 4.3 KiB buffer, but STATMOUNT_MNT_ROOT fails
with -EOVERFLOW for every buffer up to 12800 bytes and succeeds from
12801.

Check for the overflow first, so the string is regenerated in a larger
seq buffer and the size check sees its final length.

Fixes: 68385d77c05b ("statmount: simplify string option retrieval")
Assisted-by: Claude:claude-opus-5-5 Frama-C
Signed-off-by: Ding Feng <dingf3ng@gmail.com>
---

Notes:
    Tested on v7.4-rc3 (65e4fd942), arm64 tinyconfig in QEMU. The test bind
    mounts a tmpfs directory whose path below the tmpfs root is 15 names of
    250 spaces (3765 bytes, about 15000 bytes escaped) and calls statmount()
    with STATMOUNT_MNT_ROOT; the result needs 4279 bytes:
    
      bufsize   unpatched    patched
      1024      EOVERFLOW    EOVERFLOW
      4096      EOVERFLOW    EOVERFLOW
      8192      EOVERFLOW    ok
      12800     EOVERFLOW    ok
      12801     ok           ok
    
    A plain mount gives the same results on both kernels (1024 ok, 512
    EOVERFLOW).
    
    With this order, a buffer too small for a string longer than the seq
    buffer now costs one or more retries before -EOVERFLOW, instead of
    failing at once.
    
    This came up while proving statmount(2) against its man page with
    Frama-C/WP.

 fs/namespace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index aecd05ac0..2c4987942 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5813,15 +5813,15 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 	 */
 	if (seq->count == start)
 		return ret;
+	/* signal a retry */
+	if (unlikely(seq_has_overflowed(seq)))
+		return -EAGAIN;
+
 	if (unlikely(check_add_overflow(sizeof(*sm), seq->count, &kbufsize)))
 		return -EOVERFLOW;
 	if (kbufsize >= s->bufsize)
 		return -EOVERFLOW;
 
-	/* signal a retry */
-	if (unlikely(seq_has_overflowed(seq)))
-		return -EAGAIN;
-
 	if (ret)
 		return ret;
 
-- 
2.47.3

