Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B1F37BE72
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167299; cv=none; b=c8UGvQQOAVE3/1B27GhQWrdl7aKxwlv7gy/AGCK5sF3T8fMHvCpNNrkgh1VyJmLSF97dzNjArfsPGOjeMlFhtCwC/vI+IIv/EmvUa+eH7ofy5QURntmTahZBSYIgz4fWQ0m4LrlJKL9eMGXOc4oDCM5BgR7/y1HcZgnkhrW+iiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167299; c=relaxed/simple;
	bh=gry1uQqAa0tANDVkHjkuPNbr5jKjvV245FrhWBFwAuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ASiZ4YVLUs5nXRmxX4RcD7tenpN5rfzdwZ/pvngnkzGYC7KTGU+0RyIYP+89s87GkY7NxBw3roQhoh0m67MvMuYwnoKCVxFdngFF6isVffKltG8xpprONX0diqktLBVi8IiQvtFf1CMELvY6357LtoH81MHwyyeesXAcmnrgz9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jlei4Ipy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jlei4Ipy"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845438fbd9cso3622914b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782167298; x=1782772098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEqk/nI9MwbHFJChA3EKe7XfZWAt05hBZjjNOpuqeXY=;
        b=Jlei4IpyQ3goNhDa9zVqdgLsY1t+VD5eYju0ZpbPO8QuSAPeurqxXDRSY7iV+6IIhQ
         sdmAeeMfAc1tsz1nq43TlRUXhcYiRH7HOKiiQG3oI5upK9DsmVGsalIxWhymw/qwZFKy
         Q1rBTeOmuhHuuA5dkg2nSH2vA1NzAfCT4x7hESSPUQhpFhQlHJIOlDBqne0RTfCKyVff
         h/DRTFgs3YSeU/59ub8RylBNeotHT7vdVBnIcqwsvvFVALjcESoiCFarcp3igRgwzPcR
         vZv3Kt6rimbn3ZOM4xJ1sPdETWRCJ3ifqEeN4bts96xQ621GHB2k1OexF/gbpHJHtxGZ
         GoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782167298; x=1782772098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEqk/nI9MwbHFJChA3EKe7XfZWAt05hBZjjNOpuqeXY=;
        b=stXYRY7VhnTiLteOjPsrYcfsL1gpjFW1znmlCgn14Nmxz6B5jiQpKvZOuZGyjvkNVW
         qEhANY2lP0xVYPz3oiC21LHFHS5tstM/9Z4JgD7/auB09qIwyy0va9sgOcHA8u1qs/Mp
         PPmblCLPKXvF/+PLFGQt1amNfm0ryFQiQ5xlTbJUc9F01fwO1WtBVgMCdGStv7C0onqD
         G4rzC3DaZgffKyqRsITgPwlLyiboaTG9ZjBS+ercH4cyESpRAhoKaczURdTx5lIMJAaO
         MOOZ5Z0JtSziVKfWV5vNl0HIIHktq6WraFHEAFSwmnmAWG/KNb3sH0VRX4qIEY/kTDV6
         +K+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+PVZFGVHJcC9HyAw0hbWVFQmi5i1dVVTv9LFA373OMIoPErXRWppKnNVhjVQF1OHCHx4EohzmWlV15I3O/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1h6ifcWHyDUotMZ2yz5pFBvznZF1Jlu2RcNLKMUoIw00cpqJa
	oQmIKdEqVJP+y2F7BkPn3jLtlx573ShQhKCYUCMuzoPsz486AGl94Rr2KT+EL7lo93DEdCFyKw1
	NxQ==
X-Received: from pfn22.prod.google.com ([2002:a05:6a00:a216:b0:842:3963:226a])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:806:b0:845:41e4:3faa
 with SMTP id d2e1a72fcca58-845508bb8a9mr17027325b3a.31.1782167297664; Mon, 22
 Jun 2026 15:28:17 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:27:56 +0000
In-Reply-To: <20260622222757.2130402-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622222757.2130402-1-tavip@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622222757.2130402-2-tavip@google.com>
Subject: [PATCH net v3 1/2] iov_iter: export iov_iter_restore
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
	Jens Axboe <axboe@kernel.dk>, Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

Export iov_iter_restore so that it can be used by modules.

This is needed by the virtio vsock transport (which can be built as a
module) to restore the msg_iter state when transmission fails.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 lib/iov_iter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 273919b161617..f5df63961fb24 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 		i->__iov -= state->nr_segs - i->nr_segs;
 	i->nr_segs = state->nr_segs;
 }
+EXPORT_SYMBOL_GPL(iov_iter_restore);
 
 /*
  * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
-- 
2.55.0.rc0.799.gd6f94ed593-goog

