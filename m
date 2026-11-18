Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007163;
	b=TwHba8gnB+b/8wrAQOXl1I93LS2/8+cBqInHwgoq7AEP+oyBE1vV7RLZ4ZlzCHA9CBkh
	 ayaghpyiDRjy4DSD6nRG/F6sfGrCOVni1VJ686dEiNecTrNxF87OFlp/hA0yfCgcaZzXw
	 mqaAPJhcpedctjW1f504zjYHytWm3AXdLUJs2gXE0J+s6zkUio5guCYM1+gDGz47ddZiv
	 79f4Uf4LZb3DuU0bUo9LmbrcyDZ5LLYEda2y3pLVkB2ST6lMJ420U3VRr8fpeuZg4wap0
	 /qbQykiSkb/1RZCC85Fh/laJEn4pW01tC6trsJD9fqs93QThXdrauUHPS0YuuJ3Gw+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tP8QKRJpZigGHJKGRqvFEzv+St6vv1COCqEtNwoaz7I=;
	b=x0zmGyofWkGEoBJNp8Wis1GFN0+WJdHEs8opvmIEbCDW8Le8vQgeJ7+P6jFnbOeDb7P1
	 BlUUvx83+8z4v0vGOB4s3Xg+GPZadm1IkAkS6PH+gdn5vBJiAMk/1m98bdO1KAZ3zRfbn
	 60WovuXAu8PZpgb4q0LfB4oWB2oIUO9C+f+ORPvMkygN3RYUltoMe6C8raO825EhZs67O
	 4Srkp/Q5+1W+lu9XpD00/NeFCAhL3MOuTbKcXJ41iS+j2aTSDAZL6zaPHGktiIuuYsKLy
	 w1bo2cf3tuNwoznU15bkPp7Xg1zPaJ0Y+lpfbubtFdZEp9gluB6NKA+lHbrIPKTs4vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BWR73Gp8;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572B8606A331
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 13:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 572B8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BWR73Gp8
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so4616295e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 05:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795007162; x=1795611962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tP8QKRJpZigGHJKGRqvFEzv+St6vv1COCqEtNwoaz7I=;
        b=BWR73Gp8ur1TqAXGpsO4UaQ9kojgP0l25Y9EsOwJN9jJ29SmPg+0OkAG4NDidExD/4
         Hr1v5u5i25ZD9WY0qFfn7FzJe/uDztuJnPpwRtc/Q+nsXf9pcfOEdDXZSne+QoQJJMfN
         q+E0URIEcdy/rBlRwVSWZ7R6IOx7WYyULuZYfHBxrolLmPPPrlNF8fZ3GP5q3amWfH+s
         DIOD/Cb8vK70lK3NnN+qEVPVJ+NsCd8cFWRYolIdGwP/CyqXmLO99a7S+zjjJqLVtl1N
         v0HxxanTuFQx0iElx2nuj1YSc/O7m7zBy1cKYmElYBwKWIh0OgiSiuPjowps6/nW6c9Q
         32PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795007162; x=1795611962;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tP8QKRJpZigGHJKGRqvFEzv+St6vv1COCqEtNwoaz7I=;
        b=HaNVsSzqB6eVK6MaPH9OsPK7/IBeOUgIo0KpyzSQDak/jA0nVoceu7gXtrG7PNrJbj
         8hDquKMNiurCmnq4Jh58U/15tNDCLRI4PFrCta6RzDKvLeJuJb5WTou2w5UM3wa8HDCV
         2SMGF5m5oSkRxWMyH878LCKgx7jqQ/PHyjD7kHwaNiuEkMcJWE+n2OiqRFAU/6JI6Ki9
         j0kKc1feHJ9wLQXth0er9KKDeaM5agLI710NGpW44UwobnvUbwHSQzFSf4o/eUwIHN2R
         K2Th2x9yv+uDelN3Hngo9qa5gmOQkAF19IgPz0LXX+GRJj01zUst8bO71onZBVC3GI6R
         pxzw==
X-Forwarded-Encrypted: i=1; AL+hErGF1s2rt1h/y/C3bWOHAgSPYSMziXNuBzkPAEn63SbcK4IX4j2txyggtkG7RYwo6GUaeay1H91s5zi8BEHK@vger.kernel.org
X-Gm-Message-State: APuU4Z/DOTiJJl7DQ03Y6Eo4TJQlTxEvQRRoXr3C5/xW4xNs8lqmoKmJ
	TtpsWHjhbIu+LX4BiAix9ReerzrzijMfPcSENgyRtb/8Z/B3bfHYCdgC
X-Gm-Gg: AYBFou1EVVsKbKA9lxzuIswia5jnXb7769eXhJ+utM2ZADcmTqVlBkyBXppmXTCdDnS
	/WRmm+tXrjgaXkT0cKWSY8caWcsA1y0g79xEQr6oNP5rkphgidt+N9xuSnK1iAlKCUaimX+YySl
	Fdfjp55X8YKmkjMYxgReoGz7bfzplDmjRa9sPbW9ffohgK/mQF+nw9arli7kIYeLg+XQvXlmShW
	d+Oz/cumdBZAyvZTc4vW9OvEJlS5uJw1/YfnMdztDYOJsRvK7w4IKd7P5MqCc7AgHt/D7dBjZTF
	tPaykrt8Dmki+tkapnyLzJd0qOx0f9Y0Jv+7A7v9ZQ+XTeHAIs5ER71qH+ICqbl85jteQIpnguJ
	F97tm5/HO/F1QAZNkxrlzDNBXqVm89vaqvJ/iyz0+wcjtht8ZJkkhjJXbwDJ3n4DE7S9Oh7q2cS
	3gG9pTVu7TItWbHqBwmhSDbb0MiuSaLjqbsthKhKzPVyRU+eW833UOsjESBNC0+URxZXP97L/Kv
	vau8z9ZT2Q8ZaSiy276bA2HaQ6A1nHZ0xkKKAAILShQAG2izWH/fWi4/CmGYIAhKGV9C63ym8iW
	Oz7ABg4Q7pDeMIErW4YgNiUEtuFWmKqTpGfludmKxIrJHCxk82Lq2MKiKsGIKN79ErDvbVrrAxk
	Ow1g1OfkLwtrPGa01ixA2Zngy2TioTXrj928Melv1wccuO0MwpcKr
X-Received: by 2002:a05:600c:3556:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4bb7da26d70mr47037875e9.27.1795007161548;
        Wed, 18 Nov 2026 05:06:01 -0800 (PST)
Received: from DESKTOP-IR7J1S9.localdomain ([41.111.247.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d2c3c93sm95218535e9.13.2026.11.18.05.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:06:01 -0800 (PST)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Tyler Hicks <code@tyhicks.com>
Cc: Jan Kara <jack@suse.cz>,
	ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: ecryptfs: the lower filesystem gets modified while it is frozen
Date: Wed, 18 Nov 2026 14:05:56 +0100
Message-ID: <20261118130557.374-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114-kranich-banknoten-anheuern-5d0a2354a51d@brauner>
References: <20261114-kranich-banknoten-anheuern-5d0a2354a51d@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone, I’d like to take this one unless one of you is already working
on it.
Cordially,
