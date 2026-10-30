Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334557;
	b=Sit7p4gTjre3zUTxEKmK/No1T4gLfYHIamNpMD7JVcbbG071sF4fXa4kXelCSXUdi+oe
	 97Ue7FJ2/y8A6pAhE09HDAe2qxMFkJ84yvbNh9JtZ2K4Tor3LuBvSoU/sHNq4vhCcQJaa
	 FGuB3O5ajxlTIGL9vpUtQOfKMAOcPPDuPbbaRNOzrGI47lpgYSrOFvXimU2JGjlgGg/4n
	 lvBUkNs29qjXJWUTjw7ofBTO1o8rDk432NRsC7Dv0s6DfWMdsvN9nUKt9uk4exfUx3xod
	 YiihWUqwJT8665mdbeYg6/h0/cWUtwlf4d4n22LFkwJcoFHqDO94GraZRMEBLP0+JlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TonUOmkC2Ho+zT3lPitxkCdvY2hn2C5qR7OoygKnims=;
	b=lACf6M1yOH1M7grMERLK3SAZUw7KDRoGWiuKqM0vq0jz/CVYUHWzhtlQAljNRFXZ0QCu
	 vqfbKVNtQ/Nrhxa+vz99IwJfeM57wc7h86p7xehQHkvq9Oc87cBUD1dh/3YBLQAI55IBt
	 dRuZmwUftU+1hsLjLR0HglFprrmoEotJkXsv6RpUcMWhps9sSRWse67LU7PpnmE/JNRZ+
	 Yx50ocu44iuTlLeuT9j5UO597XbCDUcPnZ6cN8YGC7VQjn29VJzdOLfzlcOV3Eq1zJ1da
	 HTsSxXnq3iY97ZWORJ5bSZICsj9XCDzZRhitzNzsW1JmYrv00t6VJ8I0LQr1xXyHr3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=jePlDtbE;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF8606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 04:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AAF8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=jePlDtbE
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5364648ae07so2506971cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 21:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793334555; x=1793939355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TonUOmkC2Ho+zT3lPitxkCdvY2hn2C5qR7OoygKnims=;
        b=jePlDtbEfVO4f1i5M6xZBxZnygixkiBJFneuq3WiL3C0trzneJUgCnL/sqy/38WINf
         mD1bhwjMCMo6YpGj7rHFRMDLxt99SwO8CDpBcSlvxXXng/qe2LzosSkvjMHtPV01bv50
         GiVOUUzyyCdO9kEtec90pFCIvmCXsid9mXKFpEdKvQjfXQexPndr9jSKSTsX5vqkQUko
         NYH65vBawki32Dji4Z5m5+bNu9m7kWBGqnbDaQfL5zS/fwjS2yCJXudNDUjk1JSYvonV
         vyDcNmb4WKZQZW7vMg5lYEmUrshegmoTXlfc+Ok1lBUT4VoAawszTq5bET4YF+3JOwul
         iUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334555; x=1793939355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TonUOmkC2Ho+zT3lPitxkCdvY2hn2C5qR7OoygKnims=;
        b=K27lj/lX0GFxnx9QAiHcOaZX3Urhyazd4yf7Dr/Knpl6doZQEoLejKVt2IzW1MwpAo
         HuTAJoTTTsqcSC49UjZq9wMBmEj+XzXf/Y8qW7q3dQMq7IC/yoMF7iqhiY+0FJxXnPly
         xggTF9grXBpCOrPhjLMe3h1HYD351FE1+08BcKqeeWxL7HXh0zL0h57zDnJz2FZXtYgH
         Y4IY0Bc1ncsNjj0HfI5N80rtQyY4GzLnwLFPpjEb7EpFuE89/9ERh0qN5+bP04erLRdp
         /dEccNTAhz2h0U/x45qXS1z61JVIULiYia2NIC4W3Hah0JRKG8QDyZKDfaABDoNWUlaZ
         6QUg==
X-Forwarded-Encrypted: i=1; AKwUvBzkDFiGS5BmUycR1TX1B29/czok0O09dezBiYwog6wxA4qKFWp2QgLydaqMAqVvDRnH1f69+VSnMAz01Aj3@vger.kernel.org
X-Gm-Message-State: AFq9FYK/HjeM9NM0zLDME8NfV09HmlFoAQuKt44eYJt7LQ8ClnOYWsoZ
	83SmF03NNzHm94f165SUromA+ibwRJr5ggd0EDg2nMOdJFbcqx2bBRght9YyYgCwOEx3OPlhPYn
	OLw351w==
X-Gm-Gg: AYBFou3Urt89volVCF6ZVlQyR+0iXM+cOYkkEsnsx3jMIp8vD6FPU/xv3WRU8WGIDm1
	2e1pADFtvbQFJvi+gn0QOxyea59Ua9H5ErOf09ogKpLrXI6JRHKqRRUtGs3KNyLRa1CT8ouaJGG
	OQ75lK2wzsLxZVcyuhIxMum5u1jApTOAcpOJ1Mpkt1sWIvqr+T4LQM0MLlYxJ84qs9rH+/nzCVO
	dbPYQhnzEwvOX5+wTqCOHkohJXIlwqNGIpBcUlpuSZ248WGAZ6jqOzhO7erbzj0MeYcFsePrSvO
	IjwWzq8uWjxJYL4eqRBBVTU7oA1fhnfo94vA6hlk/kM97KaxjIVGDROjXalxNIp0lUwB8AeOhLO
	bkHuUjbYofhempRf5Tti/lfcswHIE0qM0fUEJxsue9M/5YUJJWB/Y2T3Yq/YGn5+b2QlmX+/tCq
	nvFPlkBJhU59PzcmIsJytYsog0qpSLuueECvvuzwS+2uZeMTeEOG1/4Lg8hwEf61zSGFyaIg3VK
	5Wkj/i7s+Hllp3CoKtWDM+Er1k6jaepxG+ZaXvUB37IuRrqC6TtwluRouprdfqTdPz0QVCVACPy
	DfaEJ072f+gtGDu5KWghD8M+84xREdUru6/HQqe7g0n4uLWon8n9Wb4xJ3omjg3u1T90nfJDWg=
	=
X-Received: by 2002:a05:622a:a584:b0:536:70cf:a87 with SMTP id d75a77b69052e-542b3e6877dmr17432931cf.2.1793334555403;
        Thu, 29 Oct 2026 21:29:15 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f254a1sm5058166d6.7.2026.10.29.21.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:29:15 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hfs: fall back to buffered I/O for direct writes past phys_size
Date: Fri, 30 Oct 2026 00:29:01 -0400
Message-ID: <20261030042903.4160506-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Hi Slava,

As discussed in the setattr thread [1], a direct write that ends past
phys_size loses data at the last close, because hfs_file_truncate()
zeroes the file from phys_size up to i_size. Patch 1 makes such writes
fall back to buffered I/O, as FAT does. Patch 2 is the
hfs_file_truncate() cleanup you suggested.

The series applies on top of "hfs: report errors when extending files
with setattr" v2 [2], which patch 2 needs. The HFS+ fix is sent
separately.

Tested in KVM with KASAN, all 805 fstests on HFS with that v2 applied:
26 failures without the series, 14 with patch 1 and 15 with both, no
new failures. The extra one, generic/589, fails on and off on all three
kernels with "invalid MDB drNxtCNID", the next CNID issue from the CNID
thread.

[1] https://lore.kernel.org/linux-fsdevel/161fab786f919adb384fbf22dc19f3289bf5f24d.camel@dubeyko.com/
[2] https://lore.kernel.org/linux-fsdevel/20261021145627.288953-1-hengyul@cs.unc.edu/

Hengyu Liang (2):
  hfs: fall back to buffered I/O for direct writes past phys_size
  hfs: remove the dead grow path from hfs_file_truncate()

 fs/hfs/extent.c | 18 ++----------------
 fs/hfs/inode.c  | 10 ++++++++++
 2 files changed, 12 insertions(+), 16 deletions(-)


base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
prerequisite-patch-id: 737ea6125c4a7fa08a4deb38cf33d27fb791a812
-- 
2.53.0

