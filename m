Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF25387587
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774347452; cv=none; b=He/nKRJe6TQu6l14ac2d5WfFT1lL8RsDYjwYOKmvJKyUmH8QKal6y4g0dvrn4HTC8kfeHRtS61Q2REZezEltzVPjMmWDdR782NbCj14DeExDe5SOTenhibi75JjOQuhqMB8GDAxjik9Wgw4mw5BAgIIojpaU7yRtFFkYqOzQdv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774347452; c=relaxed/simple;
	bh=mlwPGC93d7LuLeBZscWBRJy89AKw2YAY7azDoQsa0tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxzqWw2bbr2zR/nfThM+MPJgirI2W/FbhdDIjAxT3d5nocMwz2duxP6Hc3IzLiNJ2DHGKg4KCZTaWac9y1DiIHHVYocKnXB+0HSiv6i6N/aXubSgA8Ifct/H6g8FhgrRY/7fKQeMER7SGct8zlCr52NL8lzDVcTp0cEbn7i1u+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gROhwUEs; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gROhwUEs"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79ab0e9c724so12561867b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774347450; x=1774952250; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MfsSSbVVH6/2hHdK0oDs/Smi5npUvKbhg2cFtLmpuGk=;
        b=gROhwUEs5oANt+r9HwCElXObXrzogifPFsVt4orEn4bI4a8uNxvAUglEadr9nFQ4yL
         +WenYIDXvnk3bAxlXqup4sVUxvXjeritOO1vVXmsIysRxq2do7IbMBGKLbC/gincZVgT
         VBGF9kW+VEZd1Da6Bg9f33f+nk197nQqzKnbuIyG9gtRBRNVnkKFgi4wpdgMwPjvSLDg
         ANGHbHZ6FvknMnrho0I6JJMobPWzi6nzbrHBLZu/BgiK+bvqEplxVFyiIFxPih8a3xKb
         LgZTtJbumavyLnDeKTKuy6XsAWIY9QHjROoW5ndTC4D8oXsEUl9VchkT8QuqVF6tJQfc
         nlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774347450; x=1774952250;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfsSSbVVH6/2hHdK0oDs/Smi5npUvKbhg2cFtLmpuGk=;
        b=oWLejJGhqnJPsdLkfHCOiU/Rx2SAj/Fr5FW1roPgVXIe8LE4yJyD0z+uvfbTBA/C3h
         B7kIwI1LD+STm9AeRE3QPWX6mdxkR9oBQyWDGRcL9ondOUTFYnvlRpXvYGawUE768WhI
         rqe9rGhqyt76FF4957ExpKophE7NkfxQXqyID4xO5/p9nZs/MJa+tX/6eFL3j3CM++N0
         EmddQ7T4GS2B9VlCQioW8+Ok9h0kyNzGM/NTLwcfKKfurkyLYmSPUg6kSZy2szEIw+It
         ws0Cxs76PrKaSzSym3begMTzU0XjTl7qdUXpL59Nv26M1qqKxxbQBMiyroUNCGQ13pMB
         hzEg==
X-Forwarded-Encrypted: i=1; AJvYcCUFWP+ofaPKwwE1cyrwMi/+oD1l3h5obv67A2RmdpM/0nUKpagJxnkGpJdhmdOgNr1D+Zgzf/8IlvtELL5f@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22X+RJtbuCTbRJnZDeC0CdZBpzsWNChZZlMUR8aqnbVoTAn8Q
	ueVPz5U6oao8U0xxCBl5A6BSCGVRxzEZGIY/Wupn1AhfiHpIKsM2gZeL
X-Gm-Gg: ATEYQzwWQa8P20G07G22JIXLaI2Nj2PAWH9ZdOLWxlZ9JPUlFOZwBVccK+f0LkSK2la
	JF6V3KOB1e0rjhGOSZkJgNa2YRkV3El5dTBvH4BNdrrpp3Mh1LCtr81MdEqf5gIqGyduun8mMXz
	5JNWDVzRLPm8fPImCleNokFf0ikpDD9PA125Dt1DU11t1DnncipqPCqv7B81r1S/IHsHfONhgCx
	oM/uL+lLgkpwWxD7RJxUQfb/FwW15GGBwSsRv5czpzpB34qRhu+Nz99Z24mhkONTEzUs9WR4poX
	GdTa+//PMXHxxKQwzHB4iAbE8P8obto+Jb4UrTlkM0e68UlHF/kftgwMoim1+z7tlkKQtS/2XJU
	WCqFEchNBH6lupydy9IKra1vhvzgs3bDOnDnllhLmdtAQUXZe+RF2gpEHWcSdlNVF2KRsP7Evxn
	J2TZZjNZN4KYWbo9kWwRFKgXIP25Npm+xsd7J4rpii3RIqiPcRy+LUG4I6wQnbjHC7Bu0Qy+EZV
	aVNjlTvzppNwAfreF6WZ7QWVDy+T3Zsll0+ZoIlDREaAdCAFg==
X-Received: by 2002:a05:690c:dc3:b0:79a:b118:4386 with SMTP id 00721157ae682-79ab1184799mr74577367b3.48.1774347449835;
        Tue, 24 Mar 2026 03:17:29 -0700 (PDT)
Received: from [10.138.34.110] (h69-131-148-49.cncrtn.broadband.dynamic.tds.net. [69.131.148.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a9057f820sm70640787b3.40.2026.03.24.03.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 03:17:29 -0700 (PDT)
Message-ID: <d09dcad2-506a-4739-bf5d-3e7d21207836@gmail.com>
Date: Tue, 24 Mar 2026 06:17:24 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi
 <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>,
 Bernd Schubert <bernd@bsbernd.com>, Amir Goldstein <amir73il@gmail.com>,
 Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>,
 Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
References: <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
 <390cd031-742b-4f1b-99c4-8ee41a259744@linux.alibaba.com>
 <j3gafvpt6r47trvrkttfvilejplluagdz3alcjxmc7xhnzmemv@tahjpv2ak6qj>
 <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
 <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
 <72eaaed1-24a0-4c98-a7c0-ea249d541f2d@linux.alibaba.com>
 <9af9ad0e-8070-4aaa-9f64-7d72074bd948@linux.alibaba.com>
 <wo2nf7bux5rhexbpyeutbb5bkpqlumq3ht7iqxdft7lhc2p6va@3q6wsi2xndpu>
 <68116ee5-b1f7-484b-a520-7dc5aefd7738@linux.alibaba.com>
 <2gyfmxfnnxrglpzb7kz63xbve5vnosl6gi54c3umgrpwbjr4og@lz4e2ptqanfe>
 <20260324-hilfen-reibung-9783005d5d0f@brauner>
 <ee146a41-2628-4cde-9f82-e718480edd4d@linux.alibaba.com>
 <052d27ff-9239-44fa-8604-336de0dc4711@gmail.com>
 <99ffdfa1-b18a-4f05-91e2-81c320e8edb5@linux.alibaba.com>
 <bf4764a9-ba89-4268-bcfc-125c9dabf0d7@gmail.com>
 <558f4e2b-7f9d-4e70-9516-5c1b300166bc@linux.alibaba.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <558f4e2b-7f9d-4e70-9516-5c1b300166bc@linux.alibaba.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------e1c07ZtMUk3v10PR8g0fftSr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------e1c07ZtMUk3v10PR8g0fftSr
Content-Type: multipart/mixed; boundary="------------kDnJHWjYC5BEz2K0YVezs9Rp";
 protected-headers="v1"
Message-ID: <d09dcad2-506a-4739-bf5d-3e7d21207836@gmail.com>
Date: Tue, 24 Mar 2026 06:17:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi
 <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>,
 Bernd Schubert <bernd@bsbernd.com>, Amir Goldstein <amir73il@gmail.com>,
 Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>,
 Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
References: <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
 <390cd031-742b-4f1b-99c4-8ee41a259744@linux.alibaba.com>
 <j3gafvpt6r47trvrkttfvilejplluagdz3alcjxmc7xhnzmemv@tahjpv2ak6qj>
 <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
 <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
 <72eaaed1-24a0-4c98-a7c0-ea249d541f2d@linux.alibaba.com>
 <9af9ad0e-8070-4aaa-9f64-7d72074bd948@linux.alibaba.com>
 <wo2nf7bux5rhexbpyeutbb5bkpqlumq3ht7iqxdft7lhc2p6va@3q6wsi2xndpu>
 <68116ee5-b1f7-484b-a520-7dc5aefd7738@linux.alibaba.com>
 <2gyfmxfnnxrglpzb7kz63xbve5vnosl6gi54c3umgrpwbjr4og@lz4e2ptqanfe>
 <20260324-hilfen-reibung-9783005d5d0f@brauner>
 <ee146a41-2628-4cde-9f82-e718480edd4d@linux.alibaba.com>
 <052d27ff-9239-44fa-8604-336de0dc4711@gmail.com>
 <99ffdfa1-b18a-4f05-91e2-81c320e8edb5@linux.alibaba.com>
 <bf4764a9-ba89-4268-bcfc-125c9dabf0d7@gmail.com>
 <558f4e2b-7f9d-4e70-9516-5c1b300166bc@linux.alibaba.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <558f4e2b-7f9d-4e70-9516-5c1b300166bc@linux.alibaba.com>

--------------kDnJHWjYC5BEz2K0YVezs9Rp
Content-Type: multipart/mixed; boundary="------------DTLwTM0yMzpYw8AtFuiCJYIs"

--------------DTLwTM0yMzpYw8AtFuiCJYIs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 3/24/26 06:14, Gao Xiang wrote:
>=20
>=20
> On 2026/3/24 18:02, Demi Marie Obenour wrote:
>> On 3/24/26 05:53, Gao Xiang wrote:
>>>
>>>
>>> On 2026/3/24 17:49, Demi Marie Obenour wrote:
>>>> On 3/24/26 05:30, Gao Xiang wrote:
>>>>> Hi Christian,
>>>>>
>>>>> On 2026/3/24 16:48, Christian Brauner wrote:
>>>>>> On Mon, Mar 23, 2026 at 03:47:24PM +0100, Jan Kara wrote:
>>>>>>> On Mon 23-03-26 22:36:46, Gao Xiang wrote:
>>>>>>>> On 2026/3/23 22:13, Jan Kara wrote:
>>>>>>>>>>> think that is the corner cases if you don't claim the
>>>>>>>>>>> limitation of FUSE approaches.
>>>>>>>>>>>
>>>>>>>>>>> If none expects that, that is absolute be fine, as I said,
>>>>>>>>>>> it provides strong isolation and stability, but I really
>>>>>>>>>>> suspect this approach could be abused to mount totally
>>>>>>>>>>> untrusted remote filesystems (Actually as I said, some
>>>>>>>>>>> business of ours already did: fetching EXT4 filesystems
>>>>>>>>>>> with unknown status and mount without fscking, that is
>>>>>>>>>>> really disappointing.)
>>>>>>>>>
>>>>>>>>> Yes, someone downloading untrusted ext4 image, mounting in read=
-write and
>>>>>>>>> using it for sensitive application, that falls to "insane" cate=
gory for me
>>>>>>>>> :) We agree on that. And I agree that depending on the applicat=
ion using
>>>>>>>>> FUSE to access such filesystem needn't be safe enough and immut=
able fs +
>>>>>>>>> overlayfs writeable layer may provide better guarantees about f=
s behavior.
>>>>>>>>
>>>>>>>> That is my overall goal, I just want to make it clear
>>>>>>>> the difference out of write isolation, but of course,
>>>>>>>> "secure" or not is relative, and according to the
>>>>>>>> system design.
>>>>>>>>
>>>>>>>> If isolation and system stability are enough for
>>>>>>>> a system and can be called "secure", yes, they are
>>>>>>>> both the same in such aspects.
>>>>>>>>
>>>>>>>>> I would still consider such design highly suspicious but withou=
t more
>>>>>>>>> detailed knowledge about the application I cannot say it's outr=
ight broken
>>>>>>>>> :).
>>>>>>>>
>>>>>>>> What do you mean "such design"?  "Writable untrusted
>>>>>>>> remote EXT4 images mounting on the host"? Really, we have
>>>>>>>> such applications for containers for many years but I don't
>>>>>>>> want to name it here, but I'm totally exhaused by such
>>>>>>>> usage (since I explained many many times, and they even
>>>>>>>> never bother with LWN.net) and the internal team.
>>>>>>>
>>>>>>> By "such design" I meant generally the concept that you fetch fil=
esystem
>>>>>>> images (regardless whether ext4 or some other type) from untruste=
d source.
>>>>>>> Unless you do cryptographical verification of the data, you never=
 know what
>>>>>>> kind of garbage your application is processing which is always in=
vitation
>>>>>>> for nasty exploits and bugs...
>>>>>>
>>>>>> If this is another 500 mail discussion about FS_USERNS_MOUNT on
>>>>>> block-backed filesystems then my verdict still stands that the onl=
y
>>>>>> condition under which I will let the VFS allow this if the underly=
ing
>>>>>> device is signed and dm-verity protected. The kernel will continue=
 to
>>>>>> refuse unprivileged policy in general and specifically based on qu=
ality
>>>>>> or implementation of the underlying filesystem driver.
>>>>>
>>>>>
>>>>> First, if block devices are your concern, fine, how about
>>>>> allowing it if EROFS file-backed mounts and S_IMMUTABLE
>>>>> for underlay files is set, and refuse any block device
>>>>> mounts.
>>>>>
>>>>> If the issue is "you don't know how to define the quality
>>>>> or implementation of the underlying filesystem drivers",
>>>>> you could list your detailed concerns (I think at least
>>>>> people have trust to the individual filesystem
>>>>> maintainers' judgements), otherwise there will be endless
>>>>> new sets of new immutable filesystems for this requirement
>>>>> (previously, composefs , puzzlefs, and tarfs are all for
>>>>> this; I admit I didn't get the point of FS_USERNS_MOUNT
>>>>> at that time of 2023; but know I also think FS_USERNS_MOUNT
>>>>> is a strong requirement for DinD for example), because that
>>>>> idea should be sensible according to Darrick and Jan's
>>>>> reply, and I think more people will agree with that.
>>>>>
>>>>> And another idea is that you still could return arbitary
>>>>> metadata with immutable FUSE fses and let users get
>>>>> garbage (meta)data, and FUSE already allows FS_USERNS_MOUNT,
>>>>> and if user and mount namespaces are isolated, why bothering
>>>>> it?
>>>>>
>>>>> I just hope know why? And as you may notice,
>>>>> "Demi Marie Obenour wrote:"
>>>>>
>>>>>> The only exceptions are if the filesystem is incredibly simple
>>>>>> or formal methods are used, and neither is the case for existing
>>>>>> filesystems in the Linux kernel.
>>>>>
>>>>> I still strong disagree with that judgement, a minimal EROFS
>>>>> can build an image with superblock, dirs, and files with
>>>>> xattrs in a 4k-size image; and 4k image should be enough for
>>>>> fuzzing; also the in-core EROFS format even never allocates
>>>>> any extra buffers, which is much simplar than FUSE.
>>>>>
>>>>> In brief, so how to meet your requirement?
>>>>>
>>>>> Thanks,
>>>>> Gao Xiang
>>>>
>>>> Rewriting the code in Rust would dramatically reduce the attack
>>>> surface when it comes to memory corruption.  That's a lot to ask,
>>>> though, and a lot of work.
>>>
>>> I don't think so, FUSE can do FS_USERNS_MOUNT and written in C
>>> , and the attack surface is already huge.
>>>
>>> EROFS will switch to Rust some time, but your judgement will
>>> make people to make another complete new toys of Rust kernel
>>> filesystems --- just because EROFS is currently not written
>>> in Rust.
>>>
>>> I'm completely exhaused with such game: If I will address
>>> every single fuzzing bug and CVE, why not?
>>>
>>> Thanks,
>>> Gao Xiang
>>
>> I should have written that rewriting in Rust could help convince
>> people that it is in fact safe.  One *can* make safe C code, as shown
>> by OpenSSH.  It's just *harder* to write safe C code, and harder to
>> demonstrate to others that C code is in fact safe.
>=20
> How do you define a formal `safe C`? "C without pointers"?

Safe =3D "history of not having many vulnerabilities"

> Actually, we tried to switch to Rust but Rust developpers
> resist with incremental change, they just want a pure Rust
> and switch to it all the time, that is impossible for all
> mature kernel filesystems.

Incremental change is definitely good.

>> Whether the burden of proof being placed on you is excessive is a
>> separate question that I do not have the experience to comment on.
>=20
> That is funny TBH, just because the whole policy here
> is broken, if you call out the LOC of codebase, I
> believe FUSE, OverlayFS and even TCP/IP are all complex
> than EROFS.
>=20
> If you still think LOC is the issue, I'm pretty fine to
> isolate a `fs/simple_erofs` and drop all advanced runtime
> features and even compression.

I don't think LOC is the main problem.

>> That said:
>>
>>> I will address every single fuzzing bug and CVE
>>
>> is very different than the view of most filesystem developers.
>> If the fuzzers have good code coverage in EROFS, this is a very strong=

>> argument for making an exception.
>=20
> I don't know if it's just your judgement or Christian's
> judgement.
>=20
> Currently EROFS is well-fuzzed by syzkaller and I keep
> maintaining it as 0 active issue (as I said, 4k images
> are enough for fuzzing all EROFS metadata format, almost
> all previous syzkaller issues are out of compressed
> inodes but we can just disable compression formats for
> FS_USERNS_MOUNT, just because compression algorithms
> are already complex for fuzzing) and we will definitely
> improve this part even further if that is the real
> concern of this.
>=20
> And we will accept any fuzzing bug as CVE, and fix them
> as 0day bugs like other subsystems written in C which
> accept untrusted (meta)data.  Is that end of story of
> this game?

It should be!
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------DTLwTM0yMzpYw8AtFuiCJYIs
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49y
B+l2nipdaq+4Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYf
bWpr/si88QKgyGSVZ7GeNW1UnzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/
UorR+FaSuVwT7rqzGrTlscnTDlPWgRzrQ3jssesI7sZLm82E3pJSgaUoCdCOlL7M
MPCJwI8JpPlBedRpe9tfVyfu3euTPLPxwcV3L/cfWPGSL4PofBtB8NUU6QwYiQ9H
zx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR6h3nBc3eyuZ+q62HS1pJ5EvU
T1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl5FMWo8TCniHynNXs
BtDQbabt7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2Bkg1b//r
6bTBswMBXVJ5H44Qf0+eKeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C
9a1P1MYVysLvkLvS4H+crmxA/i08Tc1h+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nS
m9BBff0Nm0bSNRS8InXdO1Aq3362QKX2NOwcL5YaStwODNyZUqF7izjK4QARAQAB
zTxEZW1pIE9iZW5vdXIgKElUTCBFbWFpbCBLZXkpIDxhdGhlbmFAaW52aXNpYmxl
dGhpbmdzbGFiLmNvbT7CwY4EEwEIADgWIQR2h02fEza6IlkHHHGyiLVf/5wiwQUC
X6YJvQIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCyiLVf/5wiwWRhD/0Y
R+YYC5Kduv/2LBgQJIygMsFiRHbR4+tWXuTFqgrxxFSlMktZ6gQrQCWe38WnOXkB
oY6n/5lSJdfnuGd2UagZ/9dkaGMUkqt+5WshLFly4BnP7pSsWReKgMP7etRTwn3S
zk1OwFx2lzY1EnnconPLfPBc6rWG2moA6l0WX+3WNR1B1ndqpl2hPSjT2jUCBWDV
rGOUSX7r5f1WgtBeNYnEXPBCUUM51pFGESmfHIXQrqFDA7nBNiIVFDJTmQzuEqIy
Jl67pKNgooij5mKzRhFKHfjLRAH4mmWZlB9UjDStAfFBAoDFHwd1HL5VQCNQdqEc
/9lZDApqWuCPadZN+pGouqLysesIYsNxUhJ7dtWOWHl0vs7/3qkWmWun/2uOJMQh
ra2u8nA9g91FbOobWqjrDd6x3ZJoGQf4zLqjmn/P514gb697788e573WN/MpQ5XI
Fl7aM2d6/GJiq6LC9T2gSUW4rbPBiqOCeiUx7Kd/sVm41p9TOA7fEG4bYddCfDsN
xaQJH6VRK3NOuBUGeL+iQEVF5Xs6Yp+U+jwvv2M5Lel3EqAYo5xXTx4ls0xaxDCu
fudcAh8CMMqx3fguSb7Mi31WlnZpk0fDuWQVNKyDP7lYpwc4nCCGNKCj622ZSocH
AcQmX28L8pJdLYacv9pU3jPy4fHcQYvmTavTqowGnM08RGVtaSBNYXJpZSBPYmVu
b3VyIChsb3ZlciBvZiBjb2RpbmcpIDxkZW1pb2Jlbm91ckBnbWFpbC5jb20+wsF4
BBMBAgAiBQJafgNKAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyiLVf
/5wiwYa/EACv8a2+MMou9cSCNoZBQaU+fTmyzft9hUE+0d5W2UY1RY3OsjFIzm9R
/4SVccfsqOYLEo+S0vQMIIIqFEq3FCpXXwPzyimotps05VA8U3Bd7yseojFygOgK
sAMOAee2RCaDDOnoJue01dfZMzzHPO/TVdp3OvnpWipfv5G1Xg96rwbhMLE3tg6N
xwAHa31Bv4/Xq8CJOoIWvx6fcmZQpz01/lSvsYn0KrfEbTKkuUf0vM9JrCTCP2oz
VNN5BYzqaq2M4r+jmSyeXLim922VOWqGkUEQ85BSEemqrRS06IU6NtEMsF8EWt/b
hWjk/9GDKTcnpdJHTrMxTspExBiNrvpI2t+YPU5B/dJJAUxvmhFrbSIbdB8umBZs
I3AMYrEmpAbh5x7jEjoskUC7uN3o9vpg1oCLS2ePDLtAtyBtbHnkA4xGD7ar8mem
xpH9lY/i+sC6CyyIUWcUDnnagKyJP0m9ks0GLsTeOCA0bft2XA6rD6aaCnMUsndT
ctrab42CV5XypjmC4U1rPJ8JQJUh1/3P48/8sMH+3krxpJ06KNWNFaUbaMTGiltZ
7x9DngklSYrX0T+2G4kVXNmjaljwkoLahwLla2gUWwBSyofXdqyhQdwZsp01KXNQ
UCyT/Pg+aDcm/E7OMV3d4lf7g/CSxiX2GSEe6BlhSz+Lmd7ZJ3g32M1ARGVtaSBN
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
EtJuZYM5blWncBOJCoWMnBEcTEo/viU3GgcVRw=3D=3D
=3Dx94R
-----END PGP PUBLIC KEY BLOCK-----

--------------DTLwTM0yMzpYw8AtFuiCJYIs--

--------------kDnJHWjYC5BEz2K0YVezs9Rp--

--------------e1c07ZtMUk3v10PR8g0fftSr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmnCZLQACgkQszaHOrMp
8lOKzg//Y8IBWd3iP3AgjNTnGcebWEJ6ZllDhWu6jx+SiWFyi98g1/0HrjolE1SK
ulS5LbKf6/HXr2HGaDaJphTZOsmBM3Q/XjcdqztqlyajPYp94dTzYYjWa2+aoulR
TcV0Pqfl0e+5NHP6lZ/KcuZ70a9t+YikMAn/9CcIxNQarkzn1kQhHbQuP8I2vfN/
JFDnaao+IuyXltq4EjyUTwwDwXKqK4/n9qkDG6jpjHPTpIqi28JjoLWy/kSrFMor
XYCwAFUwkGsiGOsCuDfopg1M98+0JCE/Yuols/FfbTGHOf+DLIgA19XiX8GhKaBL
5zu11OU7lgWIYqlcUjCrXUe6Y0LIDwxgUUyrMDW4AlvouKgMzw0UkPLITPBvDk+r
O+VojLUpN0w7FQNHzCIr7SsybWGtspsGzZFpJKFl4ZhCQiX5cJjXYX0yOjAG5qJ+
XON546DGBeyVqynbBjl8XQ71EEJW9iE6URPBOJpI+XsyuLHnSM8dT24LBQHqJKHj
oSI8xgXJ+wZoX9/7+CZtuULZPwPiKWNMheg4CUEmZKcALU3ayHoyW/1p8TqF5dxv
NH+8HwKWE/M/Hcq3+HRhDlQ+t+pLf6tyxCB8RaExM4gATp8fdebYGbfIUTGikZwk
tzIFgISXtX0J+am/871iuwyBG98+biGL9rKmn5GZBi4lSDUhe6k=
=phJ0
-----END PGP SIGNATURE-----

--------------e1c07ZtMUk3v10PR8g0fftSr--
