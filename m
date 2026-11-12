Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475593;
	b=V0jvZhHw2MkBLmCj0cAsTMTLFkJHNCebPJY0T1mMuK7YHMdpwLfIxcHuOel1u+PScRMy
	 Cmj818C6gRvrzOw7ygLhrOoRxe3IEZ6QOl1uqs+3O5CliDeWPmBu2JHUjAz0qhBkgP08m
	 pEJ+dCycE3OIzgkRxX8Iu/EyIoujh0upDEhnKVzjBHMwZFBwPzgpoHEhUj0bexXp0xCR0
	 /JGKFOFYtZGg3E2D5Ok/Z6pKXgu2YHcy9qG6kmqg7643g/BfIWItfvQUx1eHtH4+oz7wM
	 x4DzFjssjT0AZUwa0SRUUDVgb5LD7WqRapp1iW7Q99v7X6nddQuOMoWCJmFgu1JS2kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475593;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=Lu9VyNMW3mU5a5OEl9u5/3DZxAvGGfoqPTt/S5UCjdA=;
	b=Cvn07Qs/sDepuR7s5gdMFLSuH4Sw42t3zQfRvJldzKVMIUSycUN32AxMusxHJmOsnsPw
	 nFMsvF2isd5vZ/OVmvbACRWNE3gsu8kECUpOf0cny8OteGHdzMlSGpWPP9+EL5jm+jMK/
	 KygGfNxfOJZmzeqGlBc27HuTvLm2YJq5Cl78kxSSVUUf0XOEQi1OfQ5KyfFO6ggJ6AqZJ
	 1tuVAHjcO60h9Wse/RBSyu9HugcC0DOku6bT8BWXdT9vj4P58Gk0sJt3HRl72bC5OKMba
	 ZtrKmUFj8XPXqUU9CzPRrOVTBOTcO83iNCNm54p+aVPMNPCReTkUdNH7vwW+fau0M0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=OOUgwSFQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NVWaEgIO;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3428606A323
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3428606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=OOUgwSFQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NVWaEgIO
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 0792C1D00258
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 04:26:31 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 04:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794475573;
	 x=1794561973; bh=Lu9VyNMW3mU5a5OEl9u5/3DZxAvGGfoqPTt/S5UCjdA=; b=
	OOUgwSFQfbLVJHu/UOI1xbxzxT29rpy6sRLNcFMwVTBXzHNs1EcuKtWWiF0p0vMV
	pwgQH1sGEyg8X9BWJj9Z/NzKcXfcrv69W+X1rEzPCKgCj0h2bl3L3ihPDe2oLjYY
	zobAf3odv5III8Y4tHRH4h7KI6Zu2YAP1UhQkG7TLYGIF7ij7jyaOKtlnwbncIBt
	YYijyIAjywbzRp3ltvL9VcQ+OgsMOskRjbN5gFQ7kHc6RKUvcDzTn9Bv2ou+3eMQ
	+moij8YDdCQz1xPUNUyDy748IUxc03Vs5IiimdOyBTWHHVLADFFEPPRw9kr247dq
	eA1g8xF4ovQHK5pm56sqRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794475573; x=
	1794561973; bh=Lu9VyNMW3mU5a5OEl9u5/3DZxAvGGfoqPTt/S5UCjdA=; b=N
	VWaEgIOJNaSA6tI7c9inqYnE1uxJ1vlT9Fjg51KVxZqxAtQIwJxYCc+Yxxb7rrfn
	lqi1becGt5OevebJBN8V0kD4rsO7nanl9iJhWpW39+wqAcVowfsRChKO9vZj3XwM
	7NhuZpLuKr+pKPwEUlXfEC8HTZXygCfCxcVDP5ySwWAwgTE1ocLPnQU9k3YbVcrg
	8qPDj48hZiFbBg3pVGUGyWsocTCPYj+vZnwsb7ciMOC3xtR6G8+2aCSAIkSBkIfF
	MDY35u/n4XM4lh+7S50G0rTFS8IvB0y7JNUhkRyoe1XrzafTLgNWCU6E0BQ2ICEU
	o1x08xFRSCGrwAhYDzLTQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794475573; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:ZmfaFVeAuPZcKm22T88vy/neQPM8kVIoNABEaQeJZwmIBWC
	UFVm9yEV0ZGeCn3MvFjRppICZQuKLoLaWzvl3jokRLvafNRn1MoS/vcpk9SEkHoT
	NzeJqkt9fLzPJOMDcb4Vzity1xAT++vFChmrVYjUzfyuqy3lAMfLUgMR9S3Bat/y
	VuprNuxZIWAaMdZPXOedjcNKwLtjKqA6oAoGhfP9+412lz+z8msaMMrJDUnAJcu7
	73+MY8YsSrdoJCO+/ZMwQk6DfwT+ILpZywG+9X6CZtaqzRzIKq9zIfWK/61AEUVw
	hXssomOBHR7AaIt8SgKGF23BfOTcFHfWz8fk1oQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:lHtQvLsWKEfUdBxf+XVyTOgUlpH79KXAE43pmsNxrkU=:Zt3fqEzGcC9UmMEpGQAYwZ0fmVAGINXNyxE6QV2Knis=;
X-ME-Sender: <xms:J4b1aszZnXXmJXycTKT68GToSThX6hRpgSLl_4I6u4n_9y0ijscfDA>
    <xme:J4b1arHXgXG0E3ZLvA7HJOwMoR1J3526nRnSxn39ymzynPVz3tcJjXoKQqdwOqpDJ
    AeT-pkeNEL1EAxxeIv_exqlwG8lFva3ZbqaIZ3tJwi6d46YBYeiMr6m>
X-ME-Proxy-Cause: dmFkZTFWfgeeGR8mo+0U7OOkwDrigGQ4sGgOFZOIt6DyKqatgGiIKMzD3PV2KmRP46YBiF
    NN7VF9RNbZITkPsgZWpSOFDs2Hsgp/9VR+G7lO3+PQKbSnfTnKJELeW/wMgoAW5UIhwmdD
    NSL49KegZyyd7iwPktON7yNbn9dxeoKfVhWM9t2Io9/1BIHEHKTR0WotbG6kr8eFh2z+1b
    csxbAPpRQXO2C4GVfNYOGDOiPXISwylHCy4FaZ7cR6oRi/vJtPkZHGg3mRklsb0kNGxOVd
    DNAGk5hP/cEFOfJdJHRax64lA7dWq1eHZmhIG5RrznsMXvnmtyPlQ334MKerO1ZX5NuqBV
    GKnK5TATlSIwk4cWKGycpyTUodNZKF7vM4JxgjSDyU5c3JZMA/00XtklF92iMVX2n35r1M
    D/1BnTxNkAJQYU6IHiZtnAi+F9Kc5txc7hseFdo5PA6gwuLLPcpiIgVACKdGaO06xjKt6+
    eDS6tHC5JLF0NyKlfrEblcX91WlQ2m0ahg+JEq12dOeKhFtHqe72OYrIJRxH9aVIg4H37T
    QC9Hsu2aYqgpvUxhfN9yptOYqfhbjSb7ExkyhKIO3SlLEus47FmO1j/M7VmkJjnZFvCjAd
    +wpeLaOzhd2kTOw74kwWkYpnUq7IGz2Ntd9IYIHxAihCXh+HKjeLVoMLwTQg
X-ME-Proxy: <xmx:LIb1anFpYFUFUsNVtoim2Rg7LU1Tm3N1l3d1uUOvZWcowJ5OmXznLw>
    <xmx:LIb1autSZclqgSgCMjcYXfz7f3-TG4EIJFu13rcYRYlFv3xXvuqTzA>
    <xmx:LIb1akvxIJ80Do08wt6yzER2CcaT4RkBEgb7xl8huakw9lE5eJlL1w>
    <xmx:LIb1avHZkyKCDYHXN5bL4LY8EPvrUmq0Rhqocr6RmLq2C_LNQVrCwA>
    <xmx:NYb1ag6y-0KJmsy4GI_oyZKqDIFupBSr4UE9rN5CDa5GuRRBsmAx6rWK>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1E26232A0099; Thu, 12 Nov 2026 04:25:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AD8wiEBgakfZ
Date: Thu, 12 Nov 2026 10:25:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Matthew Wilcox" <willy@infradead.org>,
 "Kirill A. Shutemov" <kas@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Amit Shah" <amit@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "Zi Yan" <ziy@nvidia.com>,
 "Bernd Schubert" <bschubert@ddn.com>, "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 virtualization@lists.linux.dev, Netdev <netdev@vger.kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 "Malin Jonsson" <malin.jonsson@est.tech>,
 "Richard Weinberger" <richard@nod.at>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>, "Nishanth Menon" <nm@ti.com>,
 "Frank Li" <frank.li@nxp.com>
Message-Id: <3eb60948-8fc9-4682-87c2-c113e54e7d4e@app.fastmail.com>
In-Reply-To: <32ad880e-5946-4703-9c6f-43ff59da39af@kernel.org>
References: <20261110145241.536019-1-kas@kernel.org>
 <20261110145241.536019-2-kas@kernel.org>
 <avNuQqLf9CG9dSsE@casper.infradead.org>
 <20261111-heimreisen-ungeziefer-empfunden-a892571f2c07@brauner>
 <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner>
 <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
 <20261111-stumpf-montag-miterleben-c4e2feac8090@brauner>
 <CAHk-=wjGXBnme-N+HvbzHH40ftb7Suc=kZVT5cuintQWyMHJ7Q@mail.gmail.com>
 <e94bdf7c-eae6-4f64-bf93-0aeedca1a22e@app.fastmail.com>
 <32ad880e-5946-4703-9c6f-43ff59da39af@kernel.org>
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 12, 2026, at 10:09, David Hildenbrand (Arm) wrote:
> On 11/12/26 09:55, Arnd Bergmann wrote:
>> On Wed, Nov 11, 2026, at 20:26, Linus Torvalds wrote:
>>
>> I tried to push for what I thought was an aggressive timeline
>> last year, but that would still keep the Arm bits for a couple more
>> LTS releases and only gradually reduce the scope of highmem in the
>> meantime, removing support from architectures, file systems, and
>> drivers where possible. See https://lwn.net/Articles/1051010/
>> for a summary of my talk in Tokyo, including the slides and
>> a link to the video for anyone wanting more details.
>> 
>> I also prepared a number of patches towards this, but have so
>> far not been great at following up to get them merged, sorry
>> about that.
>
> I think we can already start at removing CONFIG_HIGHPTE now, right?

Yes, I think my patch from two years ago still applies, see

https://lore.kernel.org/all/20241210160556.2341497-4-arnd@kernel.org/
https://lore.kernel.org/all/20241210160556.2341497-5-arnd@kernel.org/

If not, I can send you an updated version.

     Arnd
