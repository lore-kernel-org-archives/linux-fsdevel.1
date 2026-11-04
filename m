Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751561;
	b=urvcarJzxq0yVFvVoCnRbRl8GkOoAE/9xnr5BnoCc0x9qG/pW4XwBBdqDTYhj3swm8dy
	 GT3DQs9uQSOIoTlLDe2FKnw89EktvcOrcF0QnkJQW4uT6gGBTDQzIz3ZzCHJd83DBRBjg
	 ru3znwH1Gfbvo1k08zwUuiiryG9Cx5alE9zT+7rhGfd8q2lt6BFbAydokTWC39OH05zlm
	 a/jsQJuKq1cv66yN2+ZQ/H5LgTPTfC7lylmGtISqjj1keycYPs2YuMjE8xtOErIHM6PBS
	 nTmb7Yg+Hj7BfCOz2yoZNRTnZdovUpiAqf2k+u780bkbu+vtW3nMwX9BnBeAQFz1o6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q9rahWNqn5TrjQs9MBNRTiFNXPe8F3h3uvk3o1ZjbFE=;
	b=zvyIUyMpwaUPtOt1hp2S5BOCgQ7ZE1RllNJj02hhrhB4QIndDUuzYQUFOWeojJe45Iso
	 Hoi0XnERyDcTvp8MtVQnr6y1HbMoHPXF70utUG7zz+bL5slsEpYWvjbYWDd4iSdbszrk2
	 TLZUVcAdRhOh3ZjSmbPUfzFUXWovOWlnReM7fmL6DfYescwAFjrfIKAJzYpziWSstjaSZ
	 pEFksJSd2oknow3CNrmOIX9kriEgfiGre4l70+JIatGViZIggbZNsqZF8RszvAjVqFE3L
	 WGBez5pOOmmOfzkjcFY4ehfW1es2tmqY8L1lki+FMpmyFA6znYmU0l/iM3Zcnda3N/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4bw5pwH;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A892A606A32E
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 00:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A892A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4bw5pwH
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso106062f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 16:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793751559; x=1794356359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q9rahWNqn5TrjQs9MBNRTiFNXPe8F3h3uvk3o1ZjbFE=;
        b=C4bw5pwHYHKdBx7XMHDV2xpsCjhmtYFZlM0xZCGGFxbTeRU/HKmGYdlrUC0OpsaE76
         sxmnko+3wk5uDyFU/+r1JLpCP/eP9ukWXMWBNJMCD40nKwguWgcqYGGYt+IE7ll7C2pf
         o7W0xco1UcZ+wNXkxSW7dwlVniMCkCs5ZEsbiySzJNn0p//HrTw9Z7VwZ18jlUf8rH/i
         FmaFm9kX1Qp6PWhIQCdFZ15FF9zROPyZ71eO7A568PBC1uAFunqbyVVs6evwu0/IB0ns
         GY+oEPG4GDDP77pRv2pubjSoD/BxAS9jl91VHj8CzE8x35vhARJmsUOExuPjse5frMXu
         2HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751559; x=1794356359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q9rahWNqn5TrjQs9MBNRTiFNXPe8F3h3uvk3o1ZjbFE=;
        b=y2HnQch/c1weKmBadMPsdS2B34usiHj2jgF4osra6oTzXpt/aqD4eHkbEgphd1LQ6X
         GoLMETu+e/7b38+JYCU1L7vNP699jIu9KNTDpRrTvyNyAu4A1ZaedsLfta038E5QzWzz
         tDnzTeGZvCZi1UDa99Kp/r0vENXILAI7WPF3cCxAiSN2r7cep23CAYeuoxO2gBe99KIY
         3rFkTuA0qVg9S/s1HWbMI9JtOEnDRxNgN/i4Ibuqr9LWfZoWpyQXgin6z3esq72Ysu+2
         qAk6I99mP6czVtwMbqmfPpiDrYK+s0h49zVe/ddTKiHmv+YeHf+3kZRmkuOAaU2/L03e
         htLw==
X-Forwarded-Encrypted: i=1; AKwUvByZT6DzLccmbytkYo87co/s++wJUpTUrWMDh+zOYBbqjGn1V/piLzkNilaOemsWdRIvEvdrPsWDA7rNILgW@vger.kernel.org
X-Gm-Message-State: APuU4Z8f2OswmPE5qNpyqMTf2YuA9SRUK92DFy85Dwp6nOLxfUHHwmNm
	saCPcXdbPIewG4G2BoGPKIdxbLGRfzu0kyckl/atZ9lX9aBXl1bI3LbB
X-Gm-Gg: AYBFou2PQgZyemYbJL38iQJ649jGwx2b9VbPMwR8Kt/dXzapVD/8CQ8FRhQ4wx6HaUJ
	YMpTyAr2Ri68t55PCppvyJqPIJLalKbbdXW4fIXi1D0RW91fJs9YuT6O7zsS/aAzv/nHNCTXnZ/
	Ar95HZF6NYYnQVX/iMFd5RgbR89b+/6iXFxIFkY9XIofpb0THQTAjR9QKjlUU1x+fuACbQuTD4f
	5TB81sKl9F+mxv3p4MuTpgfTaWAErJfDVx7biEVTSi9DOHVMCyMbIKOx+y2FdLk1e0hxrTLJXkr
	JAnek49CJS4sBe6zP48ZqplwEMdumwTTUciHFEDwr9TCvF6quK2iWNzNqyT5hBKoC9ZgPDPImBK
	nzJXoX2OGfQBpiyAVOzBo7dsPdcD781swrSseaTtVPr6gi4/PJ426Txpi/VUOXsd2bp+sMcaq9X
	oDCrTSnRGriEEHbpH3Drie/iiyL0M+ZJnXQEKC+ZDvQwziYpZa42hU3dpyqaKXSBb5ymtaoIeK0
	Fquxac2RoZCE62gRA0jGDfcNMOepBjuD5RFeinm78fF5+GLSOLDa7R+pqgwQYFtfkM7K/ePLGsD
	/FNBj3J3MalTEomoVsonKq95TRRemS6+iJ1ya5lZDhYfgq7Agf/3e/Se/Nwj9L0/mxtTtGfCZMl
	elIblb2OeO90gy6Aor+fLRO2ryRs1PBU=
X-Received: by 2002:a05:6000:2dc4:b0:48e:3b53:e100 with SMTP id ffacd0b85a97d-48e6e535ca9mr33172348f8f.56.1793751558968;
        Tue, 03 Nov 2026 16:19:18 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:19:17 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 2/5] block: set dma-buf-io tag to block files
Date: Wed,  4 Nov 2026 00:18:58 +0000
Message-ID: <91697f770aa09d1be8f358378f1e11e0143ebe5d.1793751001.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1793751001.git.asml.silence@gmail.com>
References: <cover.1793751001.git.asml.silence@gmail.com>
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

We need to set dma-buf-io tag to be able to share contexts between
multiple files. Use gendisk pointer as a tag, this allows sharing
b/w different partitions of the same block device.

Fixes: 839231d19393 ("block: add dma-buf support for raw bdev")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/fops.c b/block/fops.c
index 60b9c9b1cefe..6f013780b76b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -687,6 +687,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	ret = bdev_open(bdev, mode, filp->private_data, NULL, filp);
 	if (ret)
 		blkdev_put_no_open(bdev);
+	filp->f_dma_io_tag = (unsigned long)bdev->bd_disk;
 	return ret;
 }
 
-- 
2.54.0

