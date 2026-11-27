Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795739891;
	b=B9Bh0oc20Qle5t/r/6xLRr9zdR73ftcb1v+bICw5CXqPP4t/Mdx77nrPc9TsikERZxiX
	 i38+DmEUZXFnE5dY9kJux3Cv7RLLvQu0GME6gMS1TgLNXMDkPoqJT/V57iDflpCPj0kIE
	 egoPwmLsyV80GjMzFPMLSWCUZCXwTlqEEJ1M4gAyokBcF5XNk6OheLur+DUdMbiKwDs3r
	 KypMoaJflozT66J5By1DKJE4R8XoQKV81O8hmldh/WxrtwzVMhhFVfvmFMsXX2AIvbxab
	 hPu1pfkx7mWv9IK6EXCspnbgTVyYI32wniDCpqRrNZ5BN7QRe1aJajktw42C8COQ9Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795739891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LWsu4t1Z6rR8vk07XEWna5nqyMHBxZlP0kNSwzNj69I=;
	b=X+f6/Tthm8+EQOl53bV+qXCFbalKtWHsMHM2yc/qoQgnKxLVlHEb438B1ueVoBPmTG5m
	 ZwdXstQz9Qqv3aRAXaE8t23TZ0668zAXeUrf31MdbhsdQmAr0DhogCEwrPxT8d/Za11Cr
	 MoShHKqjTbNtifTBZGGw2eqLNpFQgd1Ez2dDFT+egNMwx13xzr+6QwApSyk2aCKSIrs2t
	 v8hKkUwiIaTVmG5acfeutTjbzA3tFxpG/Opf121lrMfzimqSoTWyKPyCbHoYnX9Za9qEI
	 ATz4YR7uL0GbnV5XBNK13gVxUX3Zl0NrNFMNWDEwnJHy39fqXu6ZnEU31LpRPYvWawA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mwbah4Pt;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD2606A321
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 00:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0FD2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mwbah4Pt
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e3b22e971so3986954f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 16:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795739889; x=1796344689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LWsu4t1Z6rR8vk07XEWna5nqyMHBxZlP0kNSwzNj69I=;
        b=Mwbah4PtjxNzhzQX2pknAeb6/sYufyfivt8FmkDEKSNWgmbyqCT13qjDQFmkKmvHpS
         dC3Po63UytlhTSO8jXvAJkeSO5JOKOzYCKDyhlRMaX9uMMW1F/IV7+0BYhdxFv5BF2Rs
         a1jEepSKSPBaWRaS89vmLNwdNTaZIEdsb635SgfnI4O+qTYkMfFmbDDuWz2cJmFAXZXS
         nBLZhQbZ59Ck6Ts4MJfi/Hk6Xudyngx3Bn3lNmJq5mPg0Ip345X7gFz0izZZ1am2WKfn
         a1FDWS4M7KALxfKxTHaWKqZXI9vpf98oB7IiNwnN6wDe+mGhvr3Z1Go3y4ZnnwE05d3E
         Wz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795739889; x=1796344689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LWsu4t1Z6rR8vk07XEWna5nqyMHBxZlP0kNSwzNj69I=;
        b=eHpaSjLbFfMfQgibuuwi1y/xaR87vNKe93T/3RRXI8hgn0ANCyvKW7cmDtDC6XwCxu
         TVbn77XUd+iz0qkNTdFaEyzN26qZz+omSjkb1sJLxpvKxH9gyuF/panW+dOw113xGCED
         KfWIkt8sCUDSH2+1a//Yh6I5ArfElGIc7L+3mtf/nC6QZ6h9/vm4FV8hOs2XtCg0QNDu
         RJLiuk4cop4gQVFNO1zGSu8jydpdbiZ4n8F+erdlM/zTky9AAHATutVjfyRDXf4DFvzt
         ouF0W0yE0vCXllztjfn7PRZzkAB4mzW8uceQ3XnyMXLMlOzF3rWwCAmgrpyb4iVaOkzM
         1+Cw==
X-Forwarded-Encrypted: i=1; AL+hErElzW9UKlcVwTecoJt2alo/i59/IhQtP8JMgOY0c9w54TvRRxu6jDah6hHpjVUJMc2UrL2l3Pv2fsT0ed5b@vger.kernel.org
X-Gm-Message-State: APuU4Z9dTQNvwcBOIUl4q3m6nA58S2YQsCreJhl8qNj+e1eoOuij11Ae
	FhiljAua51FSEzDbMg81Ci7Y6P0VHX1cgxR5h6VT8vu8cPrm8xBzgiF1
X-Gm-Gg: AZFdTZc6umXIyWJfHHFIosAQCi3jz2nw1PqZVDuTZHffaQ0ECQH4zwFiSfbgLk+cFHu
	H4RGhDNfPPYCaXdjt4j8cZIOCMnVtyQ3fP6jMlF5REHm0DQ4q8yWnsmWbL9WDjGxuoPoRYKI0/3
	WgRV326Qqm27UIJLsQ/xWiT5XFBd/z+F3QeMtunblugusiqeh0q1m0MQyMr7pjs4uT0HT54idrP
	GSDFwRjWWa9a7+ZpJKG/4prU1K1AuGJDfX74dw/RlF2OSWNpLthKLfYB6RdYhaXPngl5kqvgDSK
	ejbf1iVkKWXG07wDz/hgAGgVF+2+YzJvzvDfswDpMjjgXHlCYjpRsG9xQAU1xGgCaF05BbmxNtF
	JzHkoFieproCTR53H6qmhqOCFyWHwwRbwnROYruIFjW2zIXeejUxKfHmrCyoVmpiTlrO4SaiO0m
	qH/IAd8oom6V9RnDEVLMJ99z3RdCSZj2vGZWWJNhivbnPxb5Kv6CYtz3Csx48Zk1kcNH4DX6E4O
	CDjbNQnFGVNh7RFQd1HIFkfa2nDMgwqvk1w/sOXdBYF05aOSA6fochi4oDnkgnke6ys6/iKb0OM
	ZNoApTK9EI7ykiovPkIvHOCQ3j+ewObdK73TLkk5ar2d/tje3ArPJyABuwm1+PVXgTSRglWkOOI
	Ui/JkUx3PjQ==
X-Received: by 2002:a05:6000:2503:b0:4b7:8178:f7ea with SMTP id ffacd0b85a97d-4b78178f825mr20085072f8f.51.1795739889037;
        Thu, 26 Nov 2026 16:38:09 -0800 (PST)
Received: from mohamedali-HP-EliteBook-840-G8-Notebook-PC.. ([197.21.14.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2c8csm44693592f8f.2.2026.11.26.16.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:38:08 -0800 (PST)
From: mohamedalibouhaouala@gmail.com
To: willy@infradead.org,
	jack@suse.cz,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>
Subject: [PATCH v3 0/1] docs: filesystems: update filesystem type, superblock and inode documentation
Date: Fri, 27 Nov 2026 01:32:35 +0100
Message-ID: <20261127003236.20196-1-mohamedalibouhaouala@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-234265@kernel.org>
References: <sashiko-outbox-234265@kernel.org>
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

From: Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>

Address review feedback and correct the initialization
description for ``file_system_type.list``.

Changes in v3:
- Document ``file_system_type.list`` as an unhashed hlist node.
  A zero-initialized node is unhashed; explicit initialization
  can use ``INIT_HLIST_NODE()``.


For context, ``list`` is an embedded ``struct hlist_node``:

```c
struct hlist_node {
    struct hlist_node *next;
    struct hlist_node **pprev;
};
```

The initialization helper is:

```c
static inline void INIT_HLIST_NODE(struct hlist_node *h)
{
    h->next = NULL;
    h->pprev = NULL;
}
```

Mohamed Ali Bouhaouala (1):
  docs: filesystems: update filesystem type, superblock and inode
    documentation

 Documentation/filesystems/vfs.rst | 181 +++++++++++++++++++++---------
 1 file changed, 130 insertions(+), 51 deletions(-)

-- 
2.43.0

