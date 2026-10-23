Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792719991;
	b=uF+gYqffWcah38g49AaST/qGOSClMTNXa3AJK+sUgv+JZgBuCe7rYKAYI49ekhpFWDOS
	 EZ1QtQn4hJw62gulpzFhPpXEQXuDg2+wnR9h+wE7n0k0elBwflGaEZLCr6lwKmRA+BUKd
	 /pOSzlBewao63dKGvfN4jg3ICsn24HWOLhwaI8LMSi8ZfxugT9hQ7AXRGuBFHqoVnaE/4
	 gjj5eTiAGBjjBF4sgTCp//Xkpt4vCVohHUXz4OKF+V22dYfgQI33G2VbX2gFFz4UTIYem
	 bLW76OUbfWrZeVcHI4f8+VnNrDNiJEbJJXM1HTAhXI7zuNuqwn4dzKT180XUF4EEg8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792719991;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:Reply-To:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Rfioo9BEa/OLZZU+Z+BKasi+I2H2lPKnHXMLZR3PMG0=;
	b=ZIccvmZ7OTh+2jQh007frV5VytYX8BePTRV7/pASF9w6hbCU/FuTskzhR/BNGnCKkBZQ
	 RI3f4+r0Dde+ZOMw9SrgoPlKltLqWCX15W+PVvkMBKJEoGlwhO/xQW2hs0maFniz1tMZr
	 FhhVrrVqK+sr/V1j0r9Oz8Rj54uSbf1sQJE0sGJOE5WJAiIBx+lWoKa3w/Rasbcc0sL+O
	 sveR5DbNengpGMemov34CF2PL6CLbPyYrUK/Kz3D9ZplLqajgntHda0MVIsMhc7KMlLfE
	 w9qjayUrBLm+HJtGn9ek4j43CjzFaj526c8+jAanAxxNXNuU1P0o6QkF3EH7z5zXBMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=Fs4t6asv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BU+4MvDI;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDB606A31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 01:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7EDB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=Fs4t6asv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BU+4MvDI
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3E6367A0172
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 21:46:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 22 Oct 2026 21:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1792719989; x=1792806389; bh=Rfioo9BEa/
	OLZZU+Z+BKasi+I2H2lPKnHXMLZR3PMG0=; b=Fs4t6asvvOaTxI+nOz0rbZGKcf
	VpJJieXXXhlCYbmSr7SIYDKBO6xmCU4XMGLbU6kot++L5h5bl2PQ1Pb321GpjBhk
	lsSolDoxacvv5SGkZ1+3v9bAbPfDl04CZtPjx6vM977bO/3jycqOy1uWZFOSGxy+
	q+kCePfPspW9VlbTl7TIBxGIqYf5vlNz5X3BOY4fwWzrudtgym8kPa2h/u9NDszj
	co+BB1m5JyNYAsDwbOXA28IFopkM+APUgzhPjatEsAyaPX4GEngnSbeh6adDSMON
	H6epjPReeomTSlSZsxiC1tvb4HHYV07HHdwl8wNslGyGit1ofLXvUXiElPPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792719989; x=1792806389; bh=Rfioo9BEa/OLZZU+Z+BKasi+I2H2
	lPKnHXMLZR3PMG0=; b=BU+4MvDIElCIL1p8wyLQWzxpAkBW4BDW25njOIt9ELmr
	adrYVq0Z/+kdgn4zuFU6sKOSGsL74iggAvxA93rkOM3QkE3l7XSlK+3/zquLv/50
	ResdIaRw1ZJwJQTPNF502yRaDlkz9A86TB2Zrf3DE/KNOd1f8C19IdcHnlXgzPQO
	PQ4Ynh5fPPI8QNAM4zM72rom0vT3P1t5/PJ7p8Ytms+bAldZYA7Pw/sHNto9IWXj
	oU4wNr80Xy5QRMnUpbfY3m4gpN6XOHjhJ2YA6bYIW8qcHmnfFgwTE51+v7MbvJIj
	bnAlbgB5DBiXRfCfRgk1cLWMm7aio1nDKuqgMweUqA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792719989; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:Pe4ytjtswhlnKx+MS0koLReh1dEpjpc89dNCUBRCj+OK2DL
	T/NxZgwprkTiOnPHtg5sa/9WyLP9ZnkuR+gG58g4YaYTSg6n1YQUWU+7sMBZqs1F
	aEbUoM/myUWDdStwhKYxpiWxtLSRbIrILIrVTr3ZqNK4e5+A8IpEw24onEsFYhwH
	ruWb4NChAy3CFCovigtta0GtGXXhudbX556D47J8Ml//3zyBfN8i8EQiFVWPinnN
	5QD4RRtuljK4xspLOC7jpkemopu7IBT6mNOAo6MrTMWEgWwkSGL6lirNvcg3R+hV
	KEZhYSxIsT7gKVmMqYTvkfGJZ1KmJvT3NGoiqwg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,reply-to,subject,to;
Message-Instance: m=1; h=sha256:MLTCWzKeJscQs/62hI2JW8WOvvmPWL1aa50AkyQwjxk=:Rfioo9BEa/OLZZU+Z+BKasi+I2H2lPKnHXMLZR3PMG0=;
X-ME-Sender: <xms:dbzaagGKZrhsbZYoVxaABlK_C4CaHJ65FvNSJOZqWXUbcci7rSrrng>
    <xme:dbzaasapBuva-Rta9EoZ3Yi9ot8SQBVCKxwdSoNutMOKvz2WPC7aWhUwdj3dTilRf
    IR83Vj8ibOXPwWN_Hl3ldgIbsTghYKK5-CpIBCd5Rr2lg5xmZI>
X-ME-Received: <xmr:dbzaakwFBKFzI31HymouMvA0O-RPkMwGqfdHvBXl_jk7FmFf7n3KBR3GzFEpQzEfbw>
X-ME-Proxy-Cause: dmFkZTEp2Lx5qsq+hBbGaKApI86lLKUHrxGE1mckZo/hv/vdMROzZRsKgccZBffZbdnOtw
    +bMMbAYCEAoEnAO0hjMvgVlqrwz+mXGaw5XIWe75ekrot+H7lcC55+yBePVzDoZlC2M+7G
    gr5juSa+qo8uiRtmhTuHyXsUHvyQBPEzrVAOklPdmobFlAotkZm12f2J7cHMx1GpfsSaZ2
    KLJpuFWeSbYCI6aGwPGk6nnJIUjwC+xwgJWJSe3AWXD66W/brUj4YA4S5sRlBkliPkZrCj
    /iiuOFfygwNuFqbKOQusxO+Zg+pKMB9qiUwNndiXq1ImepU7LnGPcglNDzfyDqOPyCobkp
    M7qI5U5CKIEY80CE+6v8qLiezNK7GCeJT21yWZwTvbbYET9/gkh1ARO9vjNMJ2u9OiTLE0
    xLlZlWNhf92wGaAVy7TKJ836xTEZLPX+9TThRYhMYhd87BPGI03nIEPCehWBo28qGiKBNA
    IWzwnnHkXqEmdMN/st3khBrY69hG349zBFb0PfrHv/+kMw2vjV051vPev2AZauqMY/DCrH
    JpUbCtmI9G8T2vFYCEOKbsMMgV3AN3Qgt8JxKzIUJsBTVUIsy2/6sMoFtsaOzKA8sTAu4i
    lxlZvDktLQKRLMbO9G0/ief8ir/EqhjzgujlWz18f0ZRtmlb0+ff8ycLSYdg
X-ME-Proxy: <xmx:dbzaauQAi86y0jzkwX1ZcKxwuYEQEIPYGuwYggYdJ6iW2f5IrIFlSg>
    <xmx:dbzaahKi7PEvdRVovozLxpnmGVxzqJR0j0RBG2BaDBPP01K4umnqpA>
    <xmx:dbzaalU-Z2KYqkh6MJNug-PSto57YrjsviIQkz1VDOaWDNVf67ehrg>
    <xmx:dbzaalSqzF0CGSQZEJjJXUmIjXvNvDRGdxut0EeHtRe3W9o9hviBBA>
    <xmx:dbzaajFRn2mSuIh9eKGDTOzu9sgMXRs39WqD4wnckBPkRB-hXF8nPQsm>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 21:46:26 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: 
Date: Fri, 23 Oct 2026 12:40:22 +1100
Message-ID: <20261023014211.2120871-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
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

This v3 removes the DCACHE_BLOCKED #define and uses IS_ERR_OR_NULL() as requested.
Also adds the ack-ed by from Namjae Jeon - thanks!

NeilBrown


 [PATCH v3 1/3] smb/client: don't unhash and rehash to prevent new
 [PATCH v3 2/3] smb/client: use d_alloc_trylock in
 [PATCH v3 3/3] smb/client: Use d_alloc_trylock() in
