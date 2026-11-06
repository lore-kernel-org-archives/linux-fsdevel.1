Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958337;
	b=tTMh872MU5tDJ0dMmQ3m357wvMbr0W7vKZhmKJ5hWpdAQnxg1diHo7jheCPmAKr5CniR
	 3ADm8gsB8bUDIQiTyyxZ+Jl68w84uMiJ14L2VSaBZ0HTw/IAgnCZ0TmtPDf9JEmLS2CnV
	 oOJY5qkubsCOf/hBC+seFDdpyAXJJWkX+Ad8lz7GZkc/+ralsh/JHu1ZoaFcE37sxi3E2
	 7uzq8KKRdgcnJ6G3LkXhv1PzldEQgY4O/XozuoZP0Y1dpAoyeX7NbWaS1hO4zNeo5TWrn
	 y+7CVgE/iD3lBYFPMs8K5B0U1vXKsppw/LdzF8G43JMeXhVROZsy9osTb0uwhRk9aLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dKZSeqgbkMQyFVAGTenY+vWDa9hVzBnn0+B7i3zsr7U=;
	b=KMa1qYjmO64IqXiKkKCljGHmK0lCPfu5Yt1rdeWsd8kxZLgVGQXp7KcgVjQY5vdqZf/g
	 qPqNc0hatttPLSmiqU/Qmg9P6v5ZAWby7k6Tzyr0lrD6C6oreGOn49Q5ht0oWb2K0493Y
	 uqu2Dz4C02Qr7xvRVCuipum+Xlck+gdHGFsTL76L99PNdjR36pL8J6uIwl5a9HanjqBSq
	 Zr11WZI35KNX3gJJE8XRjus/dN24JgXMgJshmcRDJg45mqnX4QiQP21CvNbHx0T+lDY1L
	 WelzkWGhbYp+bufdSmBHjIkjXbyVOPiXMzpwuz2pyOBkgfTtKA8aBI1lkIkF89lwCAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q5LrCFsK;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFF8606A332
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 09:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFFF8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q5LrCFsK
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so264166a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 01:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958336; x=1794563136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dKZSeqgbkMQyFVAGTenY+vWDa9hVzBnn0+B7i3zsr7U=;
        b=q5LrCFsK+e3dv8EdOMLzuHrfvQS2xsdL80z6yfvFGXSZmbEtDX3VHH/5htqLz9HKau
         7fJfLLIVTe/lDA8VNI0dgITRCZzoDXiH87aRS8losW1jIRrCltrHQ1o1k8zw4AUcLDll
         wzbbwhpjnXrabkiGte7wpzjDkVskdoGJKzZI6Jr3tC3ZMRLX3W8JurNygKhYRm9XbcxU
         yC/PwT69rWmEva3zs59gJgZlA0nFfVbG4Nko7+yUTJllT7K5q3qVsTBAPQTdtgjmIdWt
         XtJxE9K74A/CpLlj0k/nPJ0Ssu5JLp+N0pgDAeGqRolP/6+F9WNjQT92kDHRFNLFuoqY
         lYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958336; x=1794563136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dKZSeqgbkMQyFVAGTenY+vWDa9hVzBnn0+B7i3zsr7U=;
        b=LQm0jz64Ew5fHgyXUfB6FfO9MT/6JP3Ithb1j5tAGMJSQSV+PuZ2xtcI2Cv7ke2yzN
         kzJ4WfdKgZzKfhgiMyTXGHWOFpxhJAn3uQ2GPOonNRNmp5uYBLz+Up4CUgtlOhs0Srzk
         XJ3enf04yQ7PDYAoeGYnSe/cHEei2kMBRN7hNfOhyY81ZM51dYOMI79TPIMxiSM3bnMV
         qx/S4oQButSEB9YOXznWm/eLaetpVimgjoSQbw1H7NbuypZ1PZydiGJsBbSDgKxRw+fW
         rO9EKyRR+T7iY0yTDY1il2ASAzlZxbow9WAZsistFR9hsKNXR2BE8TLTo2yBS7bNia8P
         NYfQ==
X-Forwarded-Encrypted: i=1; AL+hErEUSjz3lGaxxfhfthWrTA4OzLTGHsm1IK9CffNhYALpRsrhnBb2amObiwoF0DdK7C42kKqhTOL+1pz8rOn6@vger.kernel.org
X-Gm-Message-State: APuU4Z8bPZT1peQd94Krv9u04yNbObnHUDoaYqERCvjKal8A3RB27tNg
	Sp9TyJ/3kTA0+uYC+kxf6blEcAQ3uDu5Uq+6R20wysV6NTyUbWbC2iCU
X-Gm-Gg: AYBFou1IcpyP1y9rtNPBlK+w9zOqeiGOlb8QfT9XpKC6dlVo9V27ePHu5zXrw7fP57R
	NQwH5gJZdzHygzkyZKhuHgyLFOP4HLvg8wsxFieMmGy0KMmyBdHtELhFaSpJzSsMXmA95JZjsez
	Dv0yOxBxo0cEG/CNSq6e3GMnGQmU+u34+VlcbqO7j0ax1all8b9MPKPWvGoVx+c1ag4L6cCQ+pQ
	Jh5sAHIG46DjY+Xk1MqVZCGWgeWt5aDbyR+UL6CbVPeTbI1H5FYJA3skRWOS/X8Tmu2ymQRAl2f
	mczj5SJGaQOb/3uiqCqZmzsb2FD3H2q6mADBnkxxQO4yAWuqhHBRv1dvOqO/JfSL7uxeGBHpWPy
	5GM5tMFRfq3c5VrSpvut2dFHoixGyQx9bCyWsJdcUcfxg0V3pRuSElm9VyfOiJ541nZCSYmxNBD
	x8Zd+aNlhz61BmS3Z6VkuNOd8RlD6sU8Y5xLbt4nQPlWcmB9Bvy5w3f/7j1Jg3Mzep4rh9OQaPf
	P81lKL/kPgAV8XXj/k+u2oxnJnYEEiwRlalbIXpT3yNvwomhK00aW7rQKQk2tDGWJ9OZQ0V2dW5
	/YTbAo75/PYZK8GO85eTd4leMee+uQ1Gn0HHcw4Mdz2IxwLp
X-Received: by 2002:a17:90b:3892:b0:3ac:77c8:ac29 with SMTP id 98e67ed59e1d1-3b0db6d78bdmr1674541a91.15.1793958336106;
        Fri, 06 Nov 2026 01:45:36 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32baf86sm7049969a91.17.2026.11.06.01.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:45:35 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] adfs: bound big-directory entry name length to ADFS_FPLUS_NAME_LEN
Date: Fri,  6 Nov 2026 18:45:16 +0900
Message-ID: <20261106094516.2401170-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

adfs_fplus_getnext() reads a directory entry's name length straight from
the on-disk big-directory entry and uses it, unchecked, as the length of
a copy into the fixed-size name buffer of the on-stack struct object_info:

	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);

	offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
	offset += le32_to_cpu(bde.bigdirobnameptr);

	ret = adfs_dir_copyfrom(obj->name, dir, offset, obj->name_len);

obj->name is char[ADFS_MAX_NAME_LEN] (260 bytes), but bigdirobnamelen is
an attacker-controlled __le32 with no upper bound.  adfs_dir_copyfrom()
only validates that the source offset+length stay within the directory
buffers; it does not bound the length against the destination.  A crafted
image whose directory holds enough data at the name offset therefore lets
a single entry drive a copy of up to ~4 GiB into the 260-byte stack
buffer, a stack out-of-bounds write (detected by CONFIG_STACKPROTECTOR as
a corrupted canary, or by KASAN with CONFIG_KASAN_STACK).  The copy is
reached from both readdir and ->lookup via adfs_dir_lookup_byname().

The old-format directory parser (dir_f.c) already caps names at
ADFS_F_NAME_LEN while reading them; the big-directory parser has no
equivalent guard even though ADFS_FPLUS_NAME_LEN (255) is defined for
exactly this limit and is used elsewhere (super.c, s_namelen).

Reject entries whose name length exceeds ADFS_FPLUS_NAME_LEN before the
copy.  255 bytes fit in the 260-byte buffer and still leave room for the
4-byte ",xyz" filetype suffix that adfs_object_fixup() may append.

To trigger: build an ADFS image with a valid F+ ("big") directory whose
header, tail (BIGDIRENDNAME magic, matching masseq) and computed
check byte all validate, containing one adfs_bigdirentry with
bigdirobnamelen set to e.g. 300 and bigdirobnameptr pointing at 300 bytes
of in-bounds directory data.  mount -o loop followed by ls (or opening a
path under the mount) overflows obj->name.  The check byte is a computed
checksum, which is why random fuzzing rarely reaches this code; a
hand-crafted image does.

Reproduced under KASAN on 7.3-rc3 and 7.4-rc1 by mounting a crafted
ADFS image and running ls: KASAN reports a stack-out-of-bounds in the
adfs_fplus_getnext() name copy path.

Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 fs/adfs/dir_fplus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -191,6 +191,9 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 	obj->attr     = le32_to_cpu(bde.bigdirattr);
 	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);

+	if (obj->name_len > ADFS_FPLUS_NAME_LEN)
+		return -EIO;
+
 	offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
 	offset += le32_to_cpu(bde.bigdirobnameptr);

--
2.43.0
