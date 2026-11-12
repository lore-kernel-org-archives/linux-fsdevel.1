Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481079;
	b=47scXT1AmGIQoEwzHGP9JNjQhnDFnoZf2eraxBnJORLiSLSBTuvdEH/okmSQSYMrTvWh
	 RkPDHAeiXbbDic0UkTzRREZ73jK5NSIUqxU7o3nF/rf2ktk5obXXiGfSaJHpXzQ0pTBo7
	 LPgzxbV+bh/26/yB2iX/rb3MFcP1s1tCTgmI2jzL8xxdNtNxptaFuJ5iJNcA9AAnkZMPk
	 +OArLGUlRPtpdL+KsBEn8y6N/FhOJjimsT3Vdi0t1OFLqApomxWHjWFRtECK6WDHYZNL/
	 sfxgbNH5H3QHp8BXlFyVH1XSXoDTxNMGEo67B4VQOAaqX3cFFC2NEXlnYoJQacvFPQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481079;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=7Meslkpa8R+PBS0DyHZFPRgLYTJh3HuHkb0AOxumEFg=;
	b=DipMkqCS5C9ZXdnredXqt918AkY5xpO0A90tBupld5PPvKCh/e1QhIcpz2lC2pUqUVdZ
	 n+Ptbc2eI1ILObQbrisaNhKbm25TojCS5f/roLBQMeKVLHqsbvfbsuKiYxa6hBnn6iNkc
	 iF6TeyG7+oSzfSBaT3CLYgTZ8OsaNs3z8hS66xSsuvCn4hrjDHTemELnpZtQ3hH+PYle9
	 ZJqb8tJYBttv9YR+yVGdLY9RZHz5DWI4OxaoXfV3T5C7hC0oEXdVXd6GdIHLNBS00xu4J
	 QmG0LXVEvKhhM3xUFrsEgeboOlY8r9pt321uimcCYtjOKeCJrLRgtgH0Y6YI26/fJhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Lx3oOVyr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5Tucp5Ch;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07639606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 10:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07639606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Lx3oOVyr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5Tucp5Ch
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F1787A0157
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 05:57:58 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 05:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794481059;
	 x=1794567459; bh=7Meslkpa8R+PBS0DyHZFPRgLYTJh3HuHkb0AOxumEFg=; b=
	Lx3oOVyr7xrldDhNotY/Y44ZUkWpUbS/Sw15HoBIt7zwVfFUJYzuhwJE6hHBi/f8
	72PdLUrfif3QbiaqWlxNR28c8e/kBp2q3B8JS74VmKGEIA51P5NyNwQU9UU2U8DZ
	5hOupRTbk/Bo1YRYVjiwE79692Z2HaOFkRbUqn04C0dAknhoZ/XF/BqXISN8djmK
	nzQpQlDPCzLVKROdNaK/NAazeqQ5iP1EORfBNzaq7ok9xgR2qwyEFHaDlF4Y9AlF
	XYa4+Lf5XVm+Qhxd+suZVmkwWbJXRviGrqHovHUmcPfLOq6ZV/oylQQuwfeVvML/
	U7opSxQSF50d5vGuJszB5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794481059; x=
	1794567459; bh=7Meslkpa8R+PBS0DyHZFPRgLYTJh3HuHkb0AOxumEFg=; b=5
	Tucp5ChVCBDjhl4dk5C7F5X3LVKTFsMP8gnn9x0MuH2+7jMPa4Nj+SIQT2DVG8uJ
	u5wupJm5rdstAzMZZInODnyvvfpTJfSSXwspucG8yFOI18XQA+xNSYU8OspFIhSc
	LO/T82B7R1uppnjALZIhacMzde9ZBYWKSQzN44nG7+0vSBMXLzlZpyo2vVWuFYH0
	fE8J7L53cCmOZj5msmFb4hnFvbEATEFuLAZdCbui2G1dPgjuzrWnaKOAF5Kwkf9e
	8FQ0yTD33WASXijjLCTz8CpmqYu/XHq6UATYTYTvybNI0UcKwDFTUQ2UkVbC+N6n
	CdlnYUUoCZMBRuGIDFwhA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794481059; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:j56dYKbKkdQcya2Fkb3IByoWtEvCSt0cuR1RP/YVOxANugu
	3ctFmoxWV25dHcHHBzlHYJVdYHg1ilMShXVC10hmQKxkDamsxXTV04Fk7szNJw5Y
	IN2Va/zdxAgA4PN3XYqefr/jS1mxfzM3LPg/rTGg74l+mkUpJsyzd3mYdtsYSyko
	O4FMPbeSi9uKG75AIybBpuAdhcHb8jb9z2KNc5n7oEkvmcOTBk9aaa9dWjLFivuU
	RqoKoL0toRfHN9XmIdJyrp1KBZecutzwONAoQOF/63enccJbO4TrZVNsIUGm7iZ9
	O/PtsRjhsop/54vlaVQKhouVsMCCfcaM/F0HfBA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QYGhyNrll/z2x43nzHbHMzcpokL6CuOf/GHVHHBnNG4=:9cBz8A60daXm+XxflR0ZEsASkUqul+qaMs0gX60bkz4=;
X-ME-Sender: <xms:lZv1aulnwhqAVrU2ywlIhlQkx3jcr_mjJ1oOcF-oQALIJdbh9W2MSg>
    <xme:lZv1agpofMLGq5k0IqsluYkWK-3JUTpfBoFK3L6DLiuUPYqcFGn2Enty4uF_-XQnJ
    z94b6dWlBxsjyCv4Ip2kz_9V8gd6SZusy2huFR7jeXtsherYI7qUTdq>
X-ME-Proxy-Cause: dmFkZTFPAb5ZVZzWlLcejKGx6E4VA3h8PqNfBXtLQtoFPOgpmgytfsUfOyDLCYXd2SSa4q
    2EH8IJ2PPzcvWQUIF8rzpRv4eG4RNXvx0NBusK63EGFOtvbarh8wH0CGqL2blZX5LnwxGj
    Bq7bb6BFYZpib28HfQC1ujCrw0Q8TBW7/48cz6euAfTCWQtTfGAuyvgN7GbpRZsmgRF2E4
    TCaNzGWqT+dNqpflZRaBZXkZZtt4lBXqOUPXc/rjd4+dtSMM8lEb+r/hClV3R/o7Q+s5sd
    1lcFl3GcCnNdnbplqVUVqfvmlm5/4bt3TMMk6ZNCk1/IOqRAfS2+h81eYDNbQMld/1X+lI
    8+vvCIKZ1a4bZphSYeDPjCLmrTmXj+ipxN85OGTScj/sl7+Ut3TC/P8rMkVApR+7BygKid
    SkK0hxv5G+rH+sog2zIEng3jqw0sOhQu7dCKfMZsvhYS/RJDLdeoB3JlbIKQ1Ys7dHJw2w
    E1GTp+3yFqf73WGe3gAJZsZogHWBjRGFo1jLw+xcZHLP9MN34ZbJcYdMqQYR6DX3zmMqyt
    U2s5m3k8BcCtol6aY9t+57PktWJnKsaEvlPS7qbnA2Qi397OHuVQYt2HBnl4g4gG0zdN1t
    W74OFEbJGA5QHDn0M9LErHNZjmr7Zm0RyUqswJebH+zD/PZn3cfiGvgMm5gg
X-ME-Proxy: <xmx:m5v1apYfRm6Zt7Y0f2U2u3xCBkE7OANuu7_SI_WuQKzpEBsoK_gakw>
    <xmx:m5v1aqwe9cSnJzJz-zCoa-M5X9VKgGBOT0Z-GKILMaQBtdU6hxleOg>
    <xmx:m5v1angYViALKmj2ClSkaSfBGAsOhh0oZTdF0LOqTWdiA7YmSiqtnA>
    <xmx:m5v1ahr24wqldhEb8CE5VCD_MYmhCuogL16D5SqQjqcPObg2XEt3og>
    <xmx:o5v1ag_90SnSwFh8o9nRP0b3a1tEHU8n2Te6e-_AnmGGK-27gNICHabi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 82A8332A009E; Thu, 12 Nov 2026 05:57:25 -0500 (EST)
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
Date: Thu, 12 Nov 2026 11:56:55 +0100
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
Message-Id: <bf186643-780c-40e0-bde6-f2af90404a18@app.fastmail.com>
In-Reply-To: <4d6a3d68-3fc7-446e-9f59-f61d7475e22e@kernel.org>
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
 <3eb60948-8fc9-4682-87c2-c113e54e7d4e@app.fastmail.com>
 <4d6a3d68-3fc7-446e-9f59-f61d7475e22e@kernel.org>
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 12, 2026, at 10:28, David Hildenbrand (Arm) wrote:
> On 11/12/26 10:25, Arnd Bergmann wrote:
>> On Thu, Nov 12, 2026, at 10:09, David Hildenbrand (Arm) wrote:
>>> On 11/12/26 09:55, Arnd Bergmann wrote:
>>>>
>>>> I tried to push for what I thought was an aggressive timeline
>>>> last year, but that would still keep the Arm bits for a couple more
>>>> LTS releases and only gradually reduce the scope of highmem in the
>>>> meantime, removing support from architectures, file systems, and
>>>> drivers where possible. See https://lwn.net/Articles/1051010/
>>>> for a summary of my talk in Tokyo, including the slides and
>>>> a link to the video for anyone wanting more details.
>>>>
>>>> I also prepared a number of patches towards this, but have so
>>>> far not been great at following up to get them merged, sorry
>>>> about that.
>>>
>>> I think we can already start at removing CONFIG_HIGHPTE now, right?
>> 
>> Yes, I think my patch from two years ago still applies, see
>> 
>> https://lore.kernel.org/all/20241210160556.2341497-4-arnd@kernel.org/
>> https://lore.kernel.org/all/20241210160556.2341497-5-arnd@kernel.org/
>> 
>> If not, I can send you an updated version.
>
> yes, please, that also brings it up to reviewer's attention :)

Ok, I have rebased my old patches to 7.4-rc2 now and pushed them to

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=highmem-7.4

I'll do some more build testing on this version before I post
them to the list.

    Arnd
