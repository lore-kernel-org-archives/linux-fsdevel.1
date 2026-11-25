Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626928;
	b=VeKRXiZqYuV4SZqDfQaSN0e3VBiSk0EUHlYQC0OQZe4sCMZqBvqedvmQQW1619Gu/k3A
	 TTqoCiHxtUCi2c27mbtXudP1qNuQc3VBAOLQcubSOrOjtMdN08ZYtmtFLECrOw/rWysvK
	 VapwuMk3yV1eX56oFZPsjkjrx3pBQeYFIvnlA3z/7GfIYzTfeQ1jjUooL9+XpnSWkfn6F
	 n13C0PtEo2ccIZLravkMRzAxSAwVlKTiT9NTx4mkV/gm+/D+xlhDieXJJy50Qh+wzPHAI
	 RdjLaNdrrcX1/yH3I+8d4Hx/bJVT9hZgjJS1pQBdNhxTzZXdiiSvSM+PoFI/ymU6Ayw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1JuUAgtC1w7YNld30axOMbqPcsfv9q8Ls8BXQz5mjVE=;
	b=2OEhyNPXH8VThRt4Gl9UP7Hm4m0pUSFU5KhqLrgWGnIQsHPldXMfh4g2RBeazx36mB5U
	 XA8BMf4Vc1Efdc1p6yig4dHRGpMa4E2sgsTn1NOw79AYvgI7pOjnwcPC22hZC1RyH92Ej
	 KCGEqx92Jsj3GgbOJKccYVyyX1ozWSzjxyxDt2j3H4nTunYPDMdmkh89fOdul/xDurJpA
	 0v4ZfPMSe6eeZ+BlmR9kmwXPdWTOXoW1bdSb+WoQDi150FKYH3UkVLPAfPn/UF3YoHE0J
	 oAE49pGO9fcLcL2YPDF7ROcwOpG3gLQnw1NqiT0y96SBwSLRTee7020ovRM+uhXevQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kC0yGBzj;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D46606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 17:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72D46606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kC0yGBzj
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f0213202fdso32306345ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 09:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795626928; x=1796231728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1JuUAgtC1w7YNld30axOMbqPcsfv9q8Ls8BXQz5mjVE=;
        b=kC0yGBzjd4q/7GZNKgl7OBhJPcCAFdXDZ9fP/IN5rPvjLXc2dMlqY4maeg/gSVUJbN
         y4YAWeVeEncq4Ne5s3OT4RxSozaw64uMBmVwSJ8f0+4S/ewarY9gbgg/4xIAVNh7XWKA
         Z/lfo6wALIarGCl27TGRyXzMipIkV776r/88tr2FXkqUrIKykSeJ9Z0XIOrcU7XwzJde
         QmDbSGCaqIARvOUjC/PN0WUjrspzmB+8CLadOdu+zu0nV9Yq78nJ0c+PjI3FxB6Sty06
         D64b1mMkI+FWLdgzlQ0vyzaaQKEAXfzX3ISH09CAg7i2D6FBYnxf6Y5J3EJYwK6CwUwd
         86Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626928; x=1796231728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1JuUAgtC1w7YNld30axOMbqPcsfv9q8Ls8BXQz5mjVE=;
        b=XeMNsWkzR4714xq8rAtduTp4clQtUy7wjFjs2kN2GgyTTh8O0b+0D8Bu894cKoAPcQ
         UNfI6DdAsKr9Xtzkj/36liFGyAPJvv6NI2BfHmM+IsNwpidbW5oMHCYusg/WJ5yQHS0t
         8ybtqMPdaJe6Nm9T/tNchGE4TChnADjI/jD/ePFFVa7WaoobM2al+bzEAoPw+WeO6xSn
         hZrgpfMuH6utzRAt9Uw5FWDDCssy6yB6ibBmgcPDM35RGh663GX3VgNO2ZpVuvVy/693
         SJ5sLYF/qkkl0eM5P8bHwTFAqLx4KLfOSQRmAAFdTo8gqKtmNXJWIRC8a4c/Valdjudp
         UOVg==
X-Forwarded-Encrypted: i=1; AL+hErEOlKdU2DJLHdgnH+ZNkdFK5a9BV19oGydULjeKsG5YHcIqTFyI9qki69/WTvEzeBiIEOa0ia9/6sxB48rE@vger.kernel.org
X-Gm-Message-State: APuU4Z+iuVW6FufjB2FOnkJZ6N/qH9sehaljjCj9vmOpRUsUsq6tdwpW
	j/S1+pEch7Jppf1Iq6367eyzbUcNKAxe2RLj3PbD5h09UUqa0jGdm6Gm
X-Gm-Gg: AZFdTZfsBt8sB4xibSDf/H5vCtSwlAYaL5xIdg9dY//5UVnMZ1j9qn9RPqMcqrPE1XI
	MuxlzHisPb6OSdI3DKifdtlkCk4YBDMCy9CJ/uFuyqpjkUEtF4ycFAneThqbCgSWQv2+9p0nsei
	UpVeafkVikqiMKw8lzsEKgKJW4lWi3qfPPrIwAvB7bdwA2lSw89IMdt0tQAUqIPQ9rHi5PJXG0T
	iSgTDQ8dlhrs3rWq5pF0QwUNKsd7gEzhYLontApLqqUHVPJ3fFEU3+ei41wMgrejp/KWd9gK+Bu
	shloHyO8ecMS5zYyZY9reGFCeSufpk0KqvaP+YrHyB7zZUbUYKIztGZ7RayQMh2LAo0p1W51eUl
	/+0e1DfS3naNKZXHBO5atv17xllC0uXftfcAu7YwveYLcYDDZbnwJcuNXbczwGRN7SsTxVr9/Ri
	2+rD+iOp9Dk1SjsTA6qGtANzh/+KsNWKH00HtKtUWKx/mLsTAUObZDUcgULUG232GEWrxSI+ZFV
	eV0MuW8G1TQ0ufSzwAHuMxfqtXb5VuxV5jY6X6J9KSZrhUWC/6lqbeVfKt9avRI2QT1lfv+R3v4
	uJiJ3tMXTTYoGvGVci/HmizJ9Wgx86OgMDmnE0u7IBes+SrKFhpZZERv4U8ADA==
X-Received: by 2002:a17:903:19cb:b0:2f0:3b78:29fa with SMTP id d9443c01a7336-2f03f1df637mr195381985ad.50.1795626927701;
        Wed, 25 Nov 2026 09:15:27 -0800 (PST)
Received: from localhost.localdomain ([64.118.140.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84285sm88133495ad.3.2026.11.25.09.15.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 09:15:27 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: Kyuwon Cho <kyuwoncho18@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Ian Kent <raven@themaw.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] statmount: retry an overflowed string before reporting -EOVERFLOW
Date: Thu, 26 Nov 2026 01:14:09 +0800
Message-ID: <20261125171515.16640-1-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179552693473.1490262.10477620788152048784@gmail.com>
References: <20261120033644.99834-1-dingf3ng@gmail.com> <179552693473.1490262.10477620788152048784@gmail.com>
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

Hi Kyuwon,

Thanks, confirmed. On v7.4-rc3 (arm64, QEMU), a tmpfs mounted on a
12278-byte path loses STATMOUNT_SB_SOURCE with and without v1, and gets
it back with the check moved up. 12276, 12277, 12279 and 12280 bytes
work on all three kernels.

The early return came in with 75ead69a7173 ("fs: don't let statmount
return empty strings"), so v2 has a second Fixes tag, along with your
Reported-by and Suggested-by:

https://lore.kernel.org/all/20261125-statmount-retry-v2-1-dingf3ng@gmail.com/

Thanks,
Ding Feng
