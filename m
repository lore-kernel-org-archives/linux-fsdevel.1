Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527155;
	b=fdOUBC0o24XTcWXL428SiYwan7rhekX8npSVKUQDfnnbEXH+Eubg+/fR8tXZtsRt3+Px
	 phayLNn66pdMBMGjQp2NsdUfWNcRn5+KiS5qhHHsahtxQPiyNx4ioMWnUZ9m/of/k8het
	 SEEQxOiwH4d7hb93Br73nhh/HYaGPE/Q9zZ0aRkrJekxXjIR6KJAi94i7UaNq3tg89Blw
	 siytVHYglDTrSR2VWPxsm5I4gSng36c4wQyR5CCuxm5GFrS5I/5CTw8JH4mwBGy2LENU2
	 Yqyhnq/vcn3tOAH6BhUdywcv/XWghhYxDlxfPaiUnAclYn/PHBSpKaoGCIArE441c/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=yoACHzjvOAJdvpPuferIsXvKypwVQHWVjU7r+31tcrg=;
	b=EtbhN8S4oNDvmYPTlFCCv0X6RNmjN6bUSx+RYvMNv+dDYswJ0pBYBiAP2ujyoDoI4HZ5
	 sYxdR7C8L/NtUUolPUNABVSrdUjmsJhfUqtkTvHmb5GDrmS8UEik863YFNEmDZtO4eIl6
	 9tiayV8GoiUU+7pdZAkuDlSaca0Cp7AXPBoOnKXTR42Ut2rGPg4IwM8waINDDCg3jXbBQ
	 KTtIwJLvPPNqZQPcGYW3b/bVj4HDZcWGBnagutkJxbwPKPDZ6LozTmEAFmyWDgn4TzBys
	 EiM0M8k0mBQ7QlshqklzIqrY8FMxY6nbH9EZDtU+PO1HVljk940tmrAZ6rtYXW5YO9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ueMG2Buz;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF71606A321
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 13:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CF71606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ueMG2Buz
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f0414c1062so25713215ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 05:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795527154; x=1796131954; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yoACHzjvOAJdvpPuferIsXvKypwVQHWVjU7r+31tcrg=;
        b=ueMG2BuzcgorKMzxH8JBpCaCkce4MHYb65SghwgmoIdop3I24opihHNjsT4k2iRBAY
         2Jr1dFgGBH0EMuSfTEDizUl4WjpEkvL9dKhu5Bw1KGfx2S2c2ozToi041YPCqbwyJL1g
         BwRbQMrvHhZ1ItlbnnQLK5Zb5vCsPSqY+G4nWKogFt9DGxgOEhXMyqf2prnC8M1LOOI+
         8d1AB1yQEh8qjda3MgTV5k1S67CLlAzktnh94Y1zFk9GEaWj4ZJzziQl5sxfOWSJvffD
         kVoloIRmRyElZlA6Q/N9wQzax7HM2jxeXn8q1KC/p/kvS/hKJABSl+6jMaDettt006Wr
         I6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527154; x=1796131954;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yoACHzjvOAJdvpPuferIsXvKypwVQHWVjU7r+31tcrg=;
        b=lMA3yXkxAfwr23jkB7CV7oOzXnJKLfR6WEvDPE4hcTU9HHRmwHrGY1f0O7Ulz2RyDg
         0mgopNk8F2kyVAPTSXlgcGJF+09aCWTMMK1KKav0vZf5N3pQSDc9HE/CMnCSE/HO8vxv
         Qk6KPx0sqUGYIXaPjZiOKdoP0vfUwD6OkEbczmxTr97Zqv1pjULgJ2mGBc9fv/qx7ry0
         x9CS5hdRunIIkm3rHMwTKeSXXhA89fQ2XOqu8JuIPZmggdBl1i0UCrIiTDAwwPUN5QWk
         z4OTzaVNWrxU3nx0+9LpwN1OrCPYDsmt8J8Gh1Z/H0ZrNWCG0DoJW+kr4oruxu9WSXm5
         VrWQ==
X-Forwarded-Encrypted: i=1; AL+hErHrkXbgiJDc+gzTNgEJuzkpkXXhTK6OMkL7xYhZGCy2egDo57r3GKRIhpCwR2FLVxdkPcHEQcJ5q8FoZABd@vger.kernel.org
X-Gm-Message-State: APuU4Z+oiuvWlQfS5xRaEVQRNmmDX3O6+4q1TbBvckzBnc8TBzJkmNCO
	EfoGnr2ltZqmHpA60YbVfwr28F5XIwz2ez9gECE2e1/JZnuqsHJDusCC
X-Gm-Gg: AZFdTZci/27+cvkf79sGEkfGL1sdIVkTD0GoAnhbsDNfEoYObqxpQuLL5bbjufHUDCO
	5+LquADO5XfJbNwcMXV5uIOANp2qBCiXkpK9HKYFNGINxt2ao49jnpcNk4M17n53Zau3CCnXHpH
	TbME0x1w9aJPCa3vA3t+cMSdWAR+bnEwP8FBBrcnUt2Ji/OPidFuD+LNN83djzjk7Dh2500zkvX
	Z8eXLAZDJuD20IUTN+g4Hg7hESReYxro5+EVAe0rIiOqOZMSkrwGAtzltN0VvlYCju7ZviyhNxL
	qjg7vwlHhaA2K81cPsIeqWD59g5ib/zxROC1v8rL/bRzGGTXpx3ZLLYnNzEUalfpcxvtFIGULJh
	N2wfEHgIWaH4Mty4EginOL8R1VYhuJDvPRSrTrBS1DOm4r4AB4PmFnIBO0n0d37pR2qhQsvhRnN
	wUU+pAi13QoxeFlEc9UEQIjKyRaYoEA5nVLT3h/230MPtYjrYvJkYY40ASbASWjZvO/UTF3jo+v
	I0eNzHlQKNaqe6qmoakjN0/JKOTcbaUg9qmhnXneSfTey/sc5jzpZ98vNpD15TOVACHQPI=
X-Received: by 2002:a17:902:e80b:b0:2e9:9a19:c43 with SMTP id d9443c01a7336-2f03f118277mr143962275ad.15.1795527153946;
        Tue, 24 Nov 2026 05:32:33 -0800 (PST)
Received: from [172.21.0.2] (vldb.skku.ac.kr. [115.145.173.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c7dsm69525075ad.55.2026.11.24.05.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:32:33 -0800 (PST)
Date: Tue, 24 Nov 2026 05:32:33 -0800 (PST)
From: Kyuwon Cho <kyuwoncho18@gmail.com>
To: Ding Feng <dingf3ng@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Ian Kent <raven@themaw.net>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] statmount: retry an overflowed string before reporting -EOVERFLOW
In-Reply-To: <20261120033644.99834-1-dingf3ng@gmail.com>
References: <20261120033644.99834-1-dingf3ng@gmail.com>
Message-ID: <179552693473.1490262.10477620788152048784@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Ding,

Moving the check one step further up, above the "seq->count == start"
return, also fixes a case where a string is dropped without any error:

	/* signal a retry */
	if (unlikely(seq_has_overflowed(seq)))
		return -EAGAIN;

	if (seq->count == start)
		return ret;

The NUL written after a string that ends one byte before the end of the
seq buffer leaves seq->count == seq->size. The next string then emits
nothing, and the early return drops it with no error and no retry. For
example, with a tmpfs mounted on a 12278-byte path, statmount() for
STATMOUNT_FS_TYPE | STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT |
STATMOUNT_SB_SOURCE returns 0 without STATMOUNT_SB_SOURCE, with or
without your patch, and returns it with the check moved up.

Could you fold this into a v2?

We found this with an LLM-guided test generator, a research prototype
we are developing.

Thanks,
Kyuwon
