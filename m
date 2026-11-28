Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795874791;
	b=0tPavF83OjuMaSPG0ppZBLs1Hd/HOcg9VXzwpJ3XrpJTJSbHaSQXEV1TvoUalYTcnWCv
	 UrdoF8hd4bQFHeUe/gRqwX4h74k1SMLmlLCDluzmM15cEGT0DO79NDIpPb7946JeKqMnd
	 +XkF++da1nBG0qUZmHlG1MJ2KYlOcbsVMdn2EE7CB8YQ3UW/W7/0XiVgA+Vx/En/toNDP
	 AzKM5Dkes1SIO4wy30cNTpKpzr5MHuUqqB1iUcllv/m2JMydWaLIf7Mi75XzZONu2qlVs
	 IC0qMC3qEfJvZPZByT64GL/AFZzfZn2ob/ivmyyYPTM4nJeC5pJAaWqHWiWk0fwhF5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795874791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hu4rTYZRq8CRBWytQe/3nd1VmbMLjbiC2A6r+ZmdVf8=;
	b=pgP1W263P4a0gm0lTKWiDvQrQq0QoLPW1ThOeeIKOnNkRsVWRWE9R42nT2TPYjZeEb6m
	 Xit/rLbdoAamopcZ9qFfQgqhNmBKXw+bhXcn1bE4jiVBaHT3Tm9IfOP+PJ2b3g1cxL2Bm
	 GWaaqO8O4IaqYN+FrKKx3r/LKxpPUREa52dYf6fwN72U10HlNaRjb8CoSShZsveNPe/oF
	 I1ybHdv2nDtMwJcN1GlvuJ8fi3vkvb5/A53ljoBfpD4ZjRwF2HjNUzGmCEXjVIR5K7lwE
	 oMZqKEGKJVAwrbBFHMT6eJZvdJ11CA8WxNoVO5ZE44b3ADaGDQZ9A1c9kznOrN/PiWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmp30UDl;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1834606A324
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 14:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1834606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmp30UDl
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-537548b811aso71939451cf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 06:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795874790; x=1796479590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hu4rTYZRq8CRBWytQe/3nd1VmbMLjbiC2A6r+ZmdVf8=;
        b=qmp30UDlRJrw8D65dtGD3Y4sLmXyuySPR2zFk4D4VglYBX1w3L9bsDC4lvVVgTKTDn
         0y2BW2EZ5jAwVsCIMh25KHvQWY15I6Ogp2PZepWQXDyyj8CPKDnovWRP1q1Xt3LOAkZR
         hAQ91GmjHVOkYlwar1+pq80tMUlQGAkIjY/maUd3pvOVNNCBjgB3fosVtA6IdxYTkIRK
         MlChkve4wIRqupfcCXDepISVUYgMXU3qrCInPK+WjqNamVprJN0yOfYJ6la2bMx/dWo1
         fjlwvIxVfeuwLZIHlfqEdEpDwfi8j6Wukyc75ui5zEhEZy47UnXbgz/g7mYPDfYRp58r
         V9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795874790; x=1796479590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hu4rTYZRq8CRBWytQe/3nd1VmbMLjbiC2A6r+ZmdVf8=;
        b=EBRu2DC7MiyiuHjy2QIrG/mUSKsAqkocxKtJNY/OWMZMD55re1BmgFQFOJpR7Y94fm
         Ryfc3Gpe2YldEOhwhnhS3zVw0wILBUErSHc/LAvMwRwOhW8TG8mo9qZXrZ9dko1smz0Y
         QLvuAz9ECzO3CmsWSze2AGoTXLKdkz7f5p2c8xDcgkH3bG/3h1k2OFxWapK05WixmnSR
         YwYhTs4aXSnGZ5RtGhT4Jk2YCQPB/lytMbLugFdJjmnH3Wf/YrTaMW5mPWaA2GdGd/rd
         Zyz1yRNCo5M5ca/xTC85iTowXtRSiUfdcUfk5bBQeAZhWh6uUAoNlcg1J0PQMJSPZ+LZ
         7zvA==
X-Gm-Message-State: APuU4Z97XO8En24p71wP3hIecfDkp/dYJMzzgftGzzSZLYVER5HM5oeW
	zZVQWoI8+eSKjkHqcchcF9Z8TiQ9rLXrpHXx77QO0ubRqlo2w9emQGPt
X-Gm-Gg: AZFdTZepREUzEDG88JniPo7fBwc/DqdjTDqL+VzRDplMQFD/srq1dXE4qQHoBHak/h8
	qBMNtR9PNvYhIdu5W8QRlIndyK/FzDU7HuAgWBqlwze2NtfzxdiEU/KP4Vg0iURc0az5ZWogvib
	t1JIshLW0udxBqPa/SEzxgU2a3TWI0Qm+RPCzXnztWiMfVK3HJSKNPP2RJG6cmTeM41bpkP6zJy
	HWhKfCy8m/Bj9+Qej4umT8E2GBVa2gLtzp1sJbrP5Qnbp72YT1epArG5wnrggdKOtJSM+QnLH+4
	gMstEQxkPQ5jgXfTa+bckk1PM5DaoK/X/1mjinxgQ22ZU+I4nt6jP9JZ7iJMsZCG0z8k5ra+qYI
	OXqAzGEaRgUebMqb2X26N7j++5i/VTfir9jBiEOM1Zd5/F/zpITX36wv0Ssr5mW/7tiHT5zFYjH
	SEjO07jLXjcION7cs1XGrGsqPRmhBZhbSnfSVnUU7Q3lp0tuLauXfyY+k081AS6ZMgaRBPdYUZz
	Fh2dcTjtsosu3WlLy3DOzR33EmPSNR64+XLnq9wzwvLVjQkDuKW9DHmcpL2wpWqCdrJgCrQeO4l
	BWTZMp8dh+mwqSxNj/PhlKR0sE5AdNtFThsP0xSpKww8lkqokK4cxjmYh/zE/M/l2ypCpKZvO5I
	p5ErY
X-Received: by 2002:a05:620a:4056:b0:949:7893:397d with SMTP id af79cd13be357-949ba9b8ccdmr5414402485a.23.1795874788655;
        Sat, 28 Nov 2026 06:06:28 -0800 (PST)
Received: from localhost ([138.197.109.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94a017cfb46sm1038426385a.28.2026.11.28.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:06:28 -0800 (PST)
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nikolai Dokutovich <ndokutovich@gmail.com>
Subject: [PATCH 1/2] nstree: reject a non-zero spare2 in the listns() request
Date: Sat, 28 Nov 2026 17:06:22 +0300
Message-ID: <20261128140623.19-2-ndokutovich@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128140623.19-1-ndokutovich@gmail.com>
References: <20261128140623.19-1-ndokutovich@gmail.com>
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

struct ns_id_req documents @spare2 as reserved, and copy_ns_id_req()
already rejects a non-zero @spare.  Reject a non-zero @spare2 the same
way so that both reserved fields are validated consistently and the
field can be given a meaning later without having to keep accepting
callers that filled it with arbitrary bits.

This makes kernels that already have listns() reject a value they used
to accept; no valid caller has a reason to set the field.

Fixes: 76b6f5dfb3fd ("nstree: add listns()")
Cc: stable@vger.kernel.org
Signed-off-by: Nikolai Dokutovich <ndokutovich@gmail.com>
---
 kernel/nstree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/nstree.c b/kernel/nstree.c
index 44e07d0fa8e5..ba5743dd4f17 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -437,7 +437,7 @@ static int copy_ns_id_req(const struct ns_id_req __user *req,
 	ret = copy_struct_from_user(kreq, sizeof(*kreq), req, usize);
 	if (ret)
 		return ret;
-	if (kreq->spare != 0)
+	if (kreq->spare != 0 || kreq->spare2 != 0)
 		return -EINVAL;
 	if (kreq->ns_type & ~NS_ALL)
 		return -EOPNOTSUPP;
-- 
2.43.0

