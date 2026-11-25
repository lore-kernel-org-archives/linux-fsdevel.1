Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649101;
	b=tVdvzraOuMTMdN1AnWb2stYF7YnFxpU2UOiOjTwRGOP72ve/LHI+4boskQfJLD4/OQWu
	 t9oM20HfM/srmnFhOC8j6QwNRGHzg+uh8Bc3ECDGlkCNWwadja2SSec+540XGGk0//dJH
	 Ao2EDgPUeSElqDZaPPVhfZfVhCV2FFyMwCxOy+cs7Myl+/gDwcMGfsb8DUQh7kbgvPFCQ
	 nFM9AJgCzC1We94wfSwYh+jLWq9opKvLwmN5mdijBNQpetCmpeRJg5JPBk4a/SGlL6NsB
	 Q/3IvMxYYrzVqgJ7CKE4kIN3oqF8Vtsr2uohiSQwrvMKsdknNK1llfjhdasB8za5+vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=L6X4hxg9g2a4Kk54pYVDsh+6JPYXZP17k3uQAGcEC60=;
	b=i+mxAJu8MsB49A/ahw1Vvn3xW/z7/Ge4uSIgWGJERic5Ll6nGycDjeqhUc3czknonaqZ
	 NQRxCXC5G7xyX5lG3bvd3gPeCBVTFwxbh4loodqknntr7dwq4kxwSXiLltPffJ9oiHXFX
	 HLz90CvZJMH3ulPabLkK3RYzyCkMmfznGGwTMyMbm+kYn5G0ExKVifImKxHXXjBWabqmQ
	 lEWpIt9o6q0rVnVDVmKnG/XPDW3SHLsywv1Uzm/d5ke6YHoLz4SGJhCVEI5Y4OEIpZ47m
	 Im8nb1M3rpGxK1GOTAhxLOTnsi0PNUc0+Qk7Q2rAd7uC8tgVb3P75IQvHrEu0b6xAtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nU0bcAb9;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8F2606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 23:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B8F2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nU0bcAb9
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so64330895e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 15:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795649099; x=1796253899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L6X4hxg9g2a4Kk54pYVDsh+6JPYXZP17k3uQAGcEC60=;
        b=nU0bcAb9fsTujKO4firFKvcUAuPT8aUbcufiUqVA9gF9kqLjgdWOABKvoMX+ru2K1V
         3e8RwqIIWi61/pcvQhafPPco4CBat41WCNtkAuMYkxjEUdAjHBLNtzYUUVwpV/FUCnbh
         BHOIJuQBZsGZ/cIv+Vbxqaj+QQ9CFScpBX1ZT0nQgCB6WGVzTQpTsXRUGX/EdG+HGgwY
         4ODQb/aMG8QwSCAZMg8ZPqIVZvWzrJqs3CXk4O+BehrNOMqATQF2zXztMoJI93Ko1hK5
         V8P1t1xYvRVwKWo/aFeV+XyXkJTQ0BJglH9FO4F3l6U+pq+VyGfDiqZqZ/TUbQyQ6PrV
         ypMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649099; x=1796253899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L6X4hxg9g2a4Kk54pYVDsh+6JPYXZP17k3uQAGcEC60=;
        b=JX7sZKTbvmjEj/EAmFs8WKRN0ahfYmcS786NpzbiR+OCGtFHNxl69qNImwO6X+mdKu
         YiYJeTdt+Ycu4hgwqHEVeP3KWxwmFMl77PAsvkGHhwTTKK7cKPUyg9ZyJ063QHke0OG7
         NW2pg5+E1hDEcS2Q8u8RsOAq9hQaSjQFo5jx4TsnoQ1zqIjKJAA8Mk5EdnM7F1EpBzHk
         TQyYf3T8+VS6qoFXn4amxotlBeSKf9KfXWG/O40lYWjNYTI8i0T7nZqEzT2LL+h7p1JY
         li1v3ppKnP3K2X/VPFmU2C0hC0pvBRKKtwurLCWb6rlt8t04iqKg2jcGkDx6HukW3KBR
         xN5g==
X-Forwarded-Encrypted: i=1; AL+hErFGcOPbu/SduLbpQZWpHd/zcH7JUg0aAe6nfX1+zxNIwOrB0CLyTGjmMJ7rPIrwxxwUBRKbf4QUQakcF7yH@vger.kernel.org
X-Gm-Message-State: APuU4Z/6or5Qnr+V96EM9hcqy8rf1A5A+qvrYW86Nmg5sTYnwvyhcy7b
	2ehUKVLTz+7kHriC7FJXF2T5ND+hgYUMiVefvNjdM8WFzhGhgqUiENEH
X-Gm-Gg: AZFdTZe1IdD9SRxZq2a1moXCCaxV+F/wL91niLqPwqvVm8JcA2pP8WMoCxHumQk9YNl
	W6ZgFGlklU3NuIcSsX1VyTeWGUP88zea4i70Yfi911hMx9Bat6QbRm/FIS3g0wQovmv9Vnfpu7E
	AtUTsdUrKkaTKt1O88yCnWanpfQPLKwqq9yttVatpJtFQzLgB4+KqldOTcSDonubbL7iZuVGeFy
	dtZNTBIH4Dm0cMenQs3uKPwCBam4Wuvyw4MXVRwIfK2BBK9YqcszGYYn8eFQG2eBW6DzafbsXJq
	iiI4mzZhLce5uo9RSqxQySszwSdK0oCpuQNW3bIkNLwhpxIY5FfRgD7dc7HKFZB7t9Xt2RTlf9g
	d8Pec3jpczdzNpkSsaZ3+XEv7CHxIJVienkMWRj563vz9t3B9uvHXYcHvfYqGqKoJV9uTcYsFaJ
	tvwG29EFnIc1c3APVprsbd6Pdb083c+a0TkBpTKL3sTC5n4ZtdDF2VebGlIEkeRa+PGEMLNU0st
	av0UyH6zJo96BkjU98kRCZaQKEtA1E2SbvFtbUj1/UULa+vUNvkSLGCVobDGOt3I73RI0wTNPCU
	rH4ALDdrBtSlRZzVhd4BhR3qPBi0bf9r2MJkaWJUoO+j2hw=
X-Received: by 2002:a05:600c:154c:b0:4a2:729:f7ce with SMTP id 5b1f17b1804b1-4bb8881c378mr396837705e9.8.1795649099232;
        Wed, 25 Nov 2026 15:24:59 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4b34e9c3ffesm20957965f8f.19.2026.11.25.15.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 15:24:58 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: jkoolstra@xs4all.nl
Cc: amir73il@gmail.com,
	brauner@kernel.org,
	cyphar@cyphar.com,
	gregkh@linuxfoundation.org,
	jack@suse.cz,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	neil@brown.name,
	neilb@ownmail.net,
	safinaskar@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v8 07/12] vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
Date: Thu, 26 Nov 2026 02:24:43 +0300
Message-ID: <20261125232443.1897836-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1119017860.2578021.1795602566314@kpc.webmail.kpnmail.nl>
References: <1119017860.2578021.1795602566314@kpc.webmail.kpnmail.nl>
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

Jori Koolstra <jkoolstra@xs4all.nl>:
> > The problem is that "flags" contains an invalid value.  The correct
> > error for that (according to open.2 man page) is EINVAL.
> > 
> 
> This is best probably. The counter is that I wanted to change errnos as little
> as possible. Now you get at least something that could already happen when
> you did a normal open(O_DIRECTORY). Were this designed from the start -EINVAL
> is obviously what is needed here.
> 
> I dunno, not sure what other people think.

Now I think it should be changed to EINVAL, too.

-- 
Askar Safin
