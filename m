Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC243815DD
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621176; cv=none; b=Ndh7H+WXpmtyaCuao8t1Rp5ePEQ/XNW77c+g6vggT0ctiSE1OvMXyaNBuJnyR0bHL6odlDNJFuebWZDwc0RnJ2gLorRyPq+JcxGyvhqOpgaKIDH4Mr7WCkrx8E+Xw+gjFNL3uOmrwwioNBaZ0tFM3PEaed1CDO2OGjEbOE3jolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621176; c=relaxed/simple;
	bh=Qau6jT3rPPqH/Zogi1sV6mj/ZZBSF0sv5dikKreUZas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsS4RIgLMZGKHfOzd8YHrOE3AvQK8pqzgpjGVjI/bkZDoln5GonhoeUX4TUAu5hRAjkdh72dkg2jTCD/f/TXkA1l2qsNBtSKNL9eeX8t2DgPEq2I1Fhnv5x6Dlc/0/EKNvkzRc03GV7/LblMDYuTPZ5j/gKlNrpnHlE7pSSyZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=lAljjmgM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pOBCA0lW; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="lAljjmgM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pOBCA0lW"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CCC01D000B6;
	Tue, 12 May 2026 17:26:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 12 May 2026 17:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778621173;
	 x=1778707573; bh=/awHd2lyw70IkmBOnkMg/OqZ+Q4Hfgoqc2QXdEHtCuc=; b=
	lAljjmgMsm9vsHHwTHwx48WKsHmqARYzrQUHBKBqbTi9ZMTKD9nHWx5SakygW+Ob
	vIDzd2NnJscApzd72gXJ+T+oNBLWKoHrMNjhsLu8lGg6lh6F+ur+paC57DwD9TZ1
	Z6ADNMf0LPf49SDmbfrsbfRPt4YC7QT7ou4m8VK2vJNAKUjE3yIh/KHSqpZDOmn6
	KlTZ6pedAkYlAQc4Snmgdv5yQMWetpyaOwrin6RezVdIN2X3cMC6zWYfJsW7Q81s
	iMdWgWOIe6qalY6JaxVhjj7DL6piY393GtQTy/VhIkkwgAnZI5cFWyqs/NhS3s2o
	Zfme5LqI/IiC8kdt+JwXKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778621173; x=
	1778707573; bh=/awHd2lyw70IkmBOnkMg/OqZ+Q4Hfgoqc2QXdEHtCuc=; b=p
	OBCA0lWKVo2eJaKDDCE7i9hsK+akkr2PyL5QVw41wvQP0e9OccBpXV84IHl6Q1pR
	GRbBYwr+w0ddT7K4h/v4ptJAhXbxz1mSnruEUl4dTkU8dvXXC5Suz9jnGujGu0iO
	BPu0h8DFeY73uGsdhk6G9z1tWyM1W+v7zAzwnf0hW8IJtzbXWZxh0N3PNQw7sJhx
	Cj9zUN8/GAJLhK1D+b/Wxf2E3SCxpnrV/u15V/vwmyOegB1QCPlAvsxxs4fK1fM4
	GgSYwzH3Jh4EIKiNqC6NKgdIhJmBGZo6gKsr1SVRua/YnCIr5R+vB6qMxVWFVGS7
	Zl05kHb/FAPrnIoWALNbg==
X-ME-Sender: <xms:9JoDar3eutyhynGF-M6buXTrUu7SidhDY4gTRhqOoaIasprO4APxLQ>
    <xme:9JoDaqwSmqr3o4eIIEt2juALEhqi6wRG8tSDdOR08FbU84mFRkOgk1OjabDqWiI9r
    UghAqTElhAuhnzm8ZQCBuyaRAsa9P0V8n0ZEXo5uI4mpTkchk8>
X-ME-Received: <xmr:9JoDaqFPpbauH5Oyn-JOYyYCtgj_tPQQyFXn_haFZRAeHRhKX5dGwnL2GQ_aEe66g6i5cL2_Y2ZfKhi-fdwQ0lfcbo7X2QA6yPfZKbDiSZR6zxgpTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprh
    gtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepmhhsiigv
    rhgvughisehrvgguhhgrthdrtghomhdprhgtphhtthhopehfuhhsvgdquggvvhgvlheslh
    hishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhsthessghirhhthh
    gvlhhmvghrrdguvgdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9JoDalbtpqIEZSfMqycwrmbSlTy195lVcHbxxqZqFfjKVW18pdyplw>
    <xmx:9JoDakCtcA2jPzaN1jd93xuBx0HDGTd8A19BZpN0Uv_Ak2INetVAsA>
    <xmx:9JoDalk_CrqrckJQLuy8LxSSrAd3gdeIyV5X3-rPHmaopH1EYYPtqA>
    <xmx:9JoDatys35K_5ClJTtZ4yZsQ-Xo0oydXmXzTl1sMNEwu05xBg6Gw8A>
    <xmx:9ZoDasBiH-BMrRXKIUaC9r__ylhyDf0yctYHcE2p6sRnn3AZLO585N0n>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 17:26:11 -0400 (EDT)
Message-ID: <a1092e7a-e24a-4262-8e54-449bd0e26c8e@bsbernd.com>
Date: Tue, 12 May 2026 23:26:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>,
 fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Horst Birthelmer <horst@birthelmer.de>, "Darrick J. Wong" <djwong@kernel.org>
References: <20260429102058.1362965-1-mszeredi@redhat.com>
 <afxK2HSiwY32KaWw@fedora>
 <CAOQ4uxg-tgCmJkjFAQ86_xB7dDQKGy=geKAcxT2vB8cUSEKdPQ@mail.gmail.com>
 <CAJfpegt7hj=WDKKASjWLVG-R2tGYUKMJ1qR0iv_Y+GaYS0mW4w@mail.gmail.com>
 <CAOQ4uxgoavKU6zNMN9YF5cchvux6CGGxd56BBOJFWX0gkVAChg@mail.gmail.com>
 <89cb66a2-0f38-4b44-8897-50e932ef6153@bsbernd.com>
 <CAOQ4uxj7tZ1gcfRDPTiwgGgDR8DBXpL++=go+AeMOFvUBEjLZA@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <CAOQ4uxj7tZ1gcfRDPTiwgGgDR8DBXpL++=go+AeMOFvUBEjLZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/12/26 23:07, Amir Goldstein wrote:
> On Tue, May 12, 2026 at 3:46 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>>
>>
>> On 5/12/26 15:08, Amir Goldstein wrote:
>>> On Tue, May 12, 2026 at 10:18 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>>
>>>>> I see no reason for fusex to not support lookup by ".", which is
>>>>> anyway needed for "reconnect", so a fresh FUSEX_NFS_EXPORT opt-in
>>>>> for "re-export to NFS" may make more sense.
>>>>
>>>> Why add reconnect?  If server supports persistent file handles, and
>>>> all req's get the file handle, then no state (nodeid) needs to be
>>>> stored by the server.
>>>>
>>>
>>> Yes, we are saying the same thing.
>>> What I am saying is that legacy fuse has FUSE_EXPORT_SUPPORT
>>> which means server supports lookup of "." which libfuse always enabled
>>> and then we added FUSE_NO_EXPORT_SUPPORT to opt-out of nfs export.
>>>
>>> I am saying that in FUSEX, lookup "." support is implied.
>>> And that nfs export should always be opt-in (FUSEX_NFS_EXPORT).
>>
>> I'm confused here, why do we need lookup of "." without NFS export? And
>> which file system actually supports lookup of "."?
>> Shouldn't all that be scratched in favor of LOOKUP_HANDLE?
> 
> Yes. This is exactly what I meant by lookup "." support is implied.
> 
> AFAICT, libfuse sets CAP_EXPORT_SUPPORT unconditionally:
> 
>         fuse_set_feature_flag(conn, FUSE_CAP_EXPORT_SUPPORT);
> 
> ALL of the high level fuse fs are allowed to be exported by NFS,
> which is often a very bad idea.

I think that predates me and is in the came category as
FUSE_CAP_AUTO_INVAL_DATA. Initially I thought it gets really complicated
and I need to add another ABI/API compat layer to encode into struct
fuse_session which FUSE_USE_VERSION the application uses, but then in
the discussion with Darrick we got the idea to put it into the existing
padding

fuse_session_new_fn(struct fuse_args *args, const struct
fuse_lowlevel_ops *op,
                    size_t op_size, void *userdata)
{
        struct libfuse_version version = {
                .major = FUSE_MAJOR_VERSION,
                .minor = FUSE_MINOR_VERSION,
                .hotfix = FUSE_HOTFIX_VERSION,
                .padding = 0
        };

        return fuse_session_new_versioned(args, op, op_size, &version,
                                          userdata);
}


So idea and suggestion Miklos for FUSE_CAP_AUTO_INVAL_DATA was to chage
the default based on FUSE_USE_VERSION. We can do the same for
FUSE_CAP_EXPORT_SUPPORT.


The initial patch to add in that version into libfuse as another
function argument got really complex in the high level layer and then QA
team at DDN figure out that disabling FUSE_CAP_AUTO_INVAL_DATA actually
triggers another data corruption related xftest error (reproducible with
passthrough_hp) and I didn't have time to follow up that chain of issues
- got stalled for now, but I need to resume it (unless someone else
wants to work on it).


Thanks,
Bernd
