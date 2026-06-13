Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDAAC8EB
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309418; cv=none; b=dg5wqLpiekL94LYWWz/NUkLKCGiGDWGSiDPm8QaGID8PGhuzjpljdz9CNGA4xQcYMAg6nVMnkV8tNAZG0kkKamaVq1oBnmEbzZ7enSAl+0mb6SsLMwPGlY59SkVEfbJhMCPerS6kG1qOJDZ9v1fE+Q9D8KCwf+O2aWYmKfeVgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309418; c=relaxed/simple;
	bh=c0Q49lpbntXNXsuLl1k74yDPvD9eCdJopUkpac70rjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OGFJB2jDXM7tEBXQMRqLf0s5Y7r6shut+KGCDDaht2lKH2eRhOuQ4SufAGjNRRIjxZf0Zcs2dMCCg8tPt3LFjEmzUk0bB5WIwBi4ugHb+phTRFDpek4e6fTcfF75fId+PWmsttnma5BJTvGWt3tt5luhiqq9zlIJ7N2ouI9NubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DA2CCMNE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DA2CCMNE"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422f987f2eso2397802b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309416; x=1781914216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kz/YGgUT7Uc36MorqsAsmMwEDPJGbRICV4QU2IwdKQo=;
        b=DA2CCMNE18tSTB8R2nZCGKO6vpDH4JpNW8vPFx+u3kEtnmopDWTIV4lHu8lgS7DyZ9
         o6M6xKIdHWo56ECXSMATCvNaT78iP9g5DfxoEH+SP7Nc9lMToT4ierR9HEsn98Twapdc
         i6BLj1o2RfuGoy7HNvmJX9LiQvUcHw6yqo2bz0HaYSqqRE53CvYt2LDeAtYOHdsEOqt9
         xncte5BnWZLX0y64rT7A+3Jaq4Chkb2L8AMbrPn28IyLPtfEfljTouWfd7ZFWmOZTuyh
         Y3d/IjOOfNoceMZFji/bcQe5mrdZQ1csh1jIY16SLCRRt4edTFjIr5n3vKBC6/rD/D2o
         WLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309416; x=1781914216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kz/YGgUT7Uc36MorqsAsmMwEDPJGbRICV4QU2IwdKQo=;
        b=QHAHfsO2I9F8lRdK4gyEhwcqrhInpVnnN1zq4AVqCLqXRGQFk7+ezscjLGONd5rSJD
         PNEmBmJ+5tZxHg0a+vb5DNKJ7LEuorZdGJ7Qrib1W6yV+gtpOcz+rltOSRhfNsIIi0pl
         xk1jbsnF/eytgftLSPMGFe0kWXHyaO5DUvA6ydPrYwMAPMzAQMfpUVHQYkvXVM3hCZ9c
         /P6z3dfzFgB2lx2yH8LqdLWZxcbG54pAYmTTv9PqGLr7JxgMAiuymr2wZi919AZ120C2
         ciS43BDOtBVdkmmyTeweaZWoeZSDaMJTfSXIzAd9+Mu23RRqQHvMbP9dX7OmEE/X2qF5
         ta3w==
X-Forwarded-Encrypted: i=1; AFNElJ+MM1x2UxYSdl/Ofym1+8KPXkd1w0BK/3cBkWht/zbbpPL4nYL2/tlF3F32b1VVlIt5I0MedV4rsnt+Xtcc@vger.kernel.org
X-Gm-Message-State: AOJu0YxBnNcYp/Rc/T4IgPsbFRuTYs6xKi8tgAIS8YQnqAb9yt7Aprr+
	1+bGN9MsKkt2HFVl/M90DIF17Mwsm2cGADw97yFmrXaHPMxrUmcsqc6IX5YEiQ4i9I9A2FMgWWO
	ncg==
X-Received: from pfra26.prod.google.com ([2002:aa7:8e9a:0:b0:835:3df8:d72])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1404:b0:836:3f6a:3e77
 with SMTP id d2e1a72fcca58-8434cd4b0abmr5407830b3a.17.1781309415402; Fri, 12
 Jun 2026 17:10:15 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:09:52 +0000
In-Reply-To: <20260613000953.467473-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000953.467473-1-tavip@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000953.467473-2-tavip@google.com>
Subject: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
From: Octavian Purdila <tavip@google.com>
To: netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

Export iov_iter_restore so that it can be used by modules.

This is needed by the virtio vsock transport (which can be built as a
module) to restore the msg_iter state when transmission fails.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 lib/iov_iter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 243662af1af73..067e745f9ef53 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 		i->__iov -= state->nr_segs - i->nr_segs;
 	i->nr_segs = state->nr_segs;
 }
+EXPORT_SYMBOL(iov_iter_restore);
 
 /*
  * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
-- 
2.54.0.1136.gdb2ca164c4-goog

