Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444270;
	b=SHGwYoo4GbKh1pClety3cCjLYnTCoJpurDGru2SVhJB+3s2NkBYgvdaxD1R9M020NVR3
	 alMWVnm+ovi3b0QUYfPF2frPjHLD+Sj9AUKW+Eks0M0lAo2hHXifqJSTNFDR6uhbN1p/i
	 kDZsnrrryWWeANU2jTPrm1LahF5Is001JUwEFbGmR3l7XvZjjLD6D8V4oymvBA8CFd/eS
	 Se85quI3X2KxINSSX5tLTQoV/cpNIgTpEMqSkl0oB0dUiYW3oW+Yg6xcPLOeQiZmnEorE
	 tjSZcbNuute0AwnYYzIZXAr+fSFAtP/9pmmrpTCOkBv92+MYq4dLjn5DR3PDTXV++ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=Q4jTJ4I7+4H3U2t4gGtedRgvTT6Hqn+CljxWSv/Jr1w=;
	b=fO25/AWvNvsS593mGv7bAYlzekcd9e7Th6efLURjbH1E6FBmVN/2VeYxtiHLWANHhKwF
	 PmmFOv2sd0ZqlWw4cFS4BW3KjdpWcRTf840zRK8reKzle7Ypc/OAf3eUcyHX5HW8nPf9a
	 MH2knULiHyHXHeqH5z+L9FvSRM5YoI8+dlljX6Ntn8dxmZFfPD8akfKoK/3X0QgPWTjh/
	 5Huve/Bnfv7mJtyNgTgnnoVJ75WGrQ4+Qo0wa7dvlJmKfiZAQ7692eaBMUDlmsiRGtLDE
	 JIxLjox60alx3PAyR1lR0laFNO+4klISxH5azRyh2iOHHdpwdtJ94WqwJPrIGZhGEvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VETaX+Oc;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43B3606A321
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 14:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B43B3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VETaX+Oc
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4ac08f4a0b2so2417046f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 06:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795444268; x=1796049068; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q4jTJ4I7+4H3U2t4gGtedRgvTT6Hqn+CljxWSv/Jr1w=;
        b=VETaX+OczrckAdA40CS7vxCZvBrG7y727OkscWpuPH8NoqiwvNXiRk+iJHMiEnyahS
         RBfZSEAqPImQAgWzcD9CuB7TFbHgO7sTwpuUTArl1ERE2IPVFTM73x6AvLE8XuR2BQtI
         NfM/EDLchi7RpmRnIOG/fzpQ1VgdnuEYs56uKDFZJTocpt3Rphhzad1vr6ivfPvQfs7q
         zDPLeOj/0veY/zCOvit2isQTXe6V7TaBZ+m/Npv6BE32nGK/+xrI7JVkEb55IXUlhXV2
         5UmV9Fzv40OpemFZElWoQEjVt/wI5iQduzGzqM2a2l/IFqmMlSFsl3sDpjo6ExZub6aC
         DrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795444268; x=1796049068;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q4jTJ4I7+4H3U2t4gGtedRgvTT6Hqn+CljxWSv/Jr1w=;
        b=bWz3nbiL5te5hgm9WrxBSuhzzcorq1p2vcDW5vnyGzXvHY/zF02mNf/vX9fUhxJSjc
         DjgRd4DIhSd9oIOvrgGLiKAUvF/8ut+jDC87dPmJ3ca5a2nXzzKOUlYHz0sPOiuitAqa
         5of2pG7lJjd0HbM7BERp9sxsA4ZIn/gDp15zUyDWSlYRyobi9AkVW5PhabxYKjgf+Xnn
         ijThlzzkL0wAa5NMGCTce/xgsOMCb959ft6o2jgDRps+9gu+fCo8f1Z/ysvRHhxrCDUc
         N4JaDWQTQuHoJ7qtPGuLHX2DZ9SWMxwwlEAtulMD9rW+Dkcd8TMLxwU+jYpcfh3njT2v
         ni1g==
X-Forwarded-Encrypted: i=1; AL+hErHUyobsdvmtFfd0l3Pb3UvNoPcB85bxpX1KKrLmlEq2H8q1KrqgT4NsCAP0h7eDGlnsObRJvQbkjSWpgVpU@vger.kernel.org
X-Gm-Message-State: APuU4Z9mHpdsPlQyXsk1UNrcX54DR6zNwcStU+jKiypACxUHFiS0Wel4
	UXniZBe0UzQaO6YYfkaha7c2v9NPQ6YOlHjDPb15P4ws0ZUd0/JD4lVg
X-Gm-Gg: AZFdTZck4/M4iyxPDsHwaux4J1q2ue052/iJyvm38w/AhCabv61QXrCpev7B/AviXc5
	+Nyb89CyONfUKMOyiom5/qqOLOXFUoe33ZStumknHkriY1sFq6LkAQ2wwU64UPHaJoxHZwJJiSZ
	zhKt7rytovJtOxQM5tHZ5QVRvzHAF5igMjT3kLNCbV1yndbCfxfMmgRfBOhDUCexeZkdhZvYIc/
	tJVWdchNLWI53njZwPz9jS3T950G7j/9T4KS1o/WJgrmsNOdi2mceKZNywpnV8twVCsT6ieoMT/
	pu2qIMK4UzG4vhMu+tgnf0I7G+FAoDrGP7rieoS1TdQLnpDKhkcXodDdxI4O1BhElF8e0li9AUu
	h4oqOAOjjRn0+M7Z5F2AwB3Delx4KH3ZFHu1t+kDbo1QWuBTqLw9vmiIXGtN4ndZoSh1Gliweth
	NvM/ERNf3i/eD7J8WUK2QXYHgOAB809a0KzNkr8v625nkh+jNWJJjMo4mIdGwbx6OcvADwVv1zx
	yGIZqxmul+De0PqHA4o5X8Su4sh2DAEAuCLjSOA5nWiDTkgNAIJxw8vigN2yBhBwuk4Q2hUTwme
	a4VtU7evFEsqPPn8V8dY5VtwuQ==
X-Received: by 2002:a05:6000:4616:b0:491:8286:5f0e with SMTP id ffacd0b85a97d-4abb514609amr20025380f8f.55.1795444267943;
        Mon, 23 Nov 2026 06:31:07 -0800 (PST)
Received: from localhost ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b205443sm23631206f8f.39.2026.11.23.06.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 06:31:07 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=dc84db75a66914bb784f1de9596eb2f7bc5819cd207268d8e5d18dd76353;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 23 Nov 2026 15:31:05 +0100
Message-Id: <DN2NVGUNO0GA.89JAB2PVI0LA@gmail.com>
Cc: "Namjae Jeon" <linkinjeon@kernel.org>, "Hyunchul Lee"
 <hyc.lee@gmail.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, "Chuck Lever" <cel@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, "Jan Kara" <jack@suse.cz>, "Darrick J . Wong"
 <djwong@kernel.org>, "Andrey Albershteyn" <aalbersh@kernel.org>,
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Lauri Gates"
 <lauri.gates@gmail.com>, "Christoph Hellwig" <hch@infradead.org>, "Dave
 Chinner" <dgc@kernel.org>, <linux-btrfs@vger.kernel.org>,
 <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <ntfs@lists.linux.dev>,
 <linux-nfs@vger.kernel.org>, <linux-api@vger.kernel.org>
Subject: Re: [PATCH 3/3] ntfs: switch to the new xflags fileattr API
From: "koraynilay" <koray.fra@gmail.com>
To: "Amir Goldstein" <amir73il@gmail.com>, "koraynilay"
 <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261122000856.536902-1-koray.fra@gmail.com>
 <20261122000856.536902-4-koray.fra@gmail.com>
 <CAOQ4uxgc6pP+_xvJMbqj6wOdGzS75Vn6x6i_vUfCJDD46DAA_Q@mail.gmail.com>
 <DN2N0BY83OY2.1OV3ZAZFSWCDG@gmail.com>
 <CAOQ4uxg9O-R_SUPAZ75ESGB99-4Z4EEUKGMkCF2f-sXkGPq1GA@mail.gmail.com>
In-Reply-To: <CAOQ4uxg9O-R_SUPAZ75ESGB99-4Z4EEUKGMkCF2f-sXkGPq1GA@mail.gmail.com>

--dc84db75a66914bb784f1de9596eb2f7bc5819cd207268d8e5d18dd76353
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Nov 23, 2026 at 3:14 PM CET, Amir Goldstein wrote:
> On Mon, Nov 23, 2026 at 2:50=E2=80=AFPM koraynilay <koray.fra@gmail.com> =
wrote:
>>
>> On Mon Nov 23, 2026 at 2:00 PM CET, Amir Goldstein wrote:
>> > On Sun, Nov 22, 2026 at 1:09=E2=80=AFAM koraynilay <koray.fra@gmail.co=
m> wrote:
>> >>
[...]
>> > Rule:
>> >
>> > You cannot add a flag to common without carefully auditing all
>> > filesystems that support the legacy flag.
>>
>> Yeah, sashiko pointed out a problem in f2fs, and I could reproduce it in
>> testing, where adding COMPR to COMMON makes f2fs crash, it also needs
>> NOCOMP in COMMON.
>>
>
> I don't think this is correct, or at least not enough.
> My agent said that this breaks or changes things on  f2fs/ext4/ubifs
> I didn't bother to check if all of them are true - I doubt it
> bottom line - need careful audit and good testing.

Yes, definitely.

>
>> > FS_XFLAG_ENCRYPT can go into common but must also
>> > go to FS_XFLAG_RDONLY_MASK because it's read-only for
>> > all existing fs.
>> >
>> > COMPR is rw for some fs and ro for others.
>> > As with CASEFOLD, you cannot make it COMMON before
>> > converting all casefold fs to new API so that each can say
>> > whether it wants RO or RW.
>>
>> How's CASEFOLD currently handled? in the v2 I'm drafting, I added
>> fileattr_mask_to_legacy() and fileattr_legacy_to_mask(), which convert
>> between the old format (filtering by FS_XFLAGS_MASK) and the new mask
>> format.
>>
>
> Good question.
> Need to check this.

Can you do that? If not, I'll check tonight, no problem.

>> > I think there may be a way to deal with this easily since
>> > ntfs doesn't need to set either but not sure.
>>
>> We could export the 2 other helpers I added for v2 (xflags_to_flags and
>> flags_to_xflags) and make NTFS use them?
>> Though adding the fileattr_ prefix will make the current (v2) vfs code
>> maybe too verbose.
>>
>
> Honestly, I can't say for sure - you can try
>
> I think you may need a different set of helpers fileattr_prep_ used by th=
e
> filesystsems that are converted to xflags_mask, which may be different fr=
om
> the set of helpers used by the user facing ioctls but I'm not sure.
>

I guess I'll think about it when I move NTFS's impl to the updated vfs
code.

> The thing is - this is all hard to wrap our heads around
Yes.
> You and I have parts of the design in our heads w.r.t backward
> compat with legacy API, both UAPI and vfs internal api.
>
> I think you should put it in writing to see that you and I have
> not left anything out because this v1 surely does get it wrong
> in several places both wrt legacy UAPI breakage and internal
> API correctness.

I agree, now the version in my head is not finalized yet, so I'll do
that in the v2 patch/cover letter.

TLDR is "use the legacy to/from mask converters whenever needed, so:
- user legacy -> fs legacy: keep as the old code did
- user legacy -> fs mask: fileattr_legacy_to_mask()
- user mask -> fs legacy: fileattr_mask_to_legacy()
- user mask -> fs mask: pass it through

(before finalizing the GET path I want to finish the SET path).

Thanks,
koraynilay

> Thanks,
> Amir.

--dc84db75a66914bb784f1de9596eb2f7bc5819cd207268d8e5d18dd76353
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSgVimKafU5DQMcjcDmj22qf5IGXAUCawROKQAKCRDmj22qf5IG
XIluAQCkRERpwhiWlAG1vnH4LLTLbZOFc6HLeE1vttoO1MkJnAEAs/LzOmQQYKAR
R7lCcHjWSuolpqeVgvCGo0f1qKCRTw0=
=50n4
-----END PGP SIGNATURE-----

--dc84db75a66914bb784f1de9596eb2f7bc5819cd207268d8e5d18dd76353--
