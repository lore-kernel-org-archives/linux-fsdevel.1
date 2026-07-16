Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E130DEA5;
	Thu, 16 Jul 2026 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206161; cv=none; b=m/plBwKpqth8FWhs1A7dn1ia9SD3V1X/sLoogP+cP/753SFFZ0Avqt/SkMwZWvuRkkZmhvONMD+ZnOyNAwOvlFf0puOh7qmDDm7G6v3o+h1jS2BL4b3ETWg+ZQ+F6FuYEOxdQ0nIv/x1dlsGVw2LHTR7N46Q85gBexQUkoLkywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206161; c=relaxed/simple;
	bh=5SggAL8W7FjBNNBAAmEdYkV9MPvIzcTxA136Xy/kQ/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rWLKpVcrBKCWqRB3xU23U5WqdeSMgOpl+7yGOTTXok3uzQDvhIxpG3rNcLTg2qddXDZvXEicjPM9qeOqpgIM35QvMZ1B8O3REmUmo4NvaHCVPuAIkxz+2de8HYr+rBzh/oekbMp/1dXc1wBT11bGF/4o/MzR68fiV1UCGEmL6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fOZpAeRl; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fOZpAeRl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=ow4y7RBs8TK9F664Wr5L5yTjag7BNJlXO1x6vpYxro8=; b=fOZpAeRl/+2JpvHokAX3zAx5s/
	Bd27ARapSLKP1zsIcBXHE5IXEmg5h6CEUi08PP1Haed2bley5opxkMhfXtU3amnRsuEp/biEovh0v
	s2XiAtzLIRSL9oQghQLhwmyRsH861a4Ubo6CJnw+InNRedveLMTt/FyTv0u61HEeBlYWkVvLCXoSm
	Btd8ChE7AvWgRrJpFe5QPITfBRuhzmu/10o3u4kr/Gp9N6jVFGSvXUazarkeq8uzBt8AWrfq91gDh
	ZiCIV5LI5u3GVOY3XJ5KYzautGXhhRUCiU8fqiWj6tP3qzM/C4QyDLJ3kP3f71U+zfmt5uc1kcQXu
	V+H4hLZA==;
Received: from bl21-120-122.dsl.telepac.pt ([2.82.120.122] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wkLWZ-00FuUc-DO; Thu, 16 Jul 2026 14:49:11 +0200
From: Luis Henriques <luis@igalia.com>
To: Chen Linxuan <me@black-desk.cn>
Cc: Amir Goldstein <amir73il@gmail.com>,  Christian Brauner
 <brauner@kernel.org>,  Miklos Szeredi <miklos@szeredi.hu>,
  linux-fsdevel@vger.kernel.org,  fuse-devel@lists.linux.dev,  Chen Linxuan
 <chenlinxuan@uniontech.com>
Subject: Re: [PATCH 2/2] selftests/fuse: add ACL_DONT_CACHE regression test
In-Reply-To: <CAC1kPDMPfYAUsmT-yx4NK=hT5OdeZuJpyVTbfHZxfdbH8b_=uQ@mail.gmail.com>
	(Chen Linxuan's message of "Thu, 16 Jul 2026 04:24:27 -0700")
References: <20260713220932.413004-1-amir73il@gmail.com>
	<20260713220932.413004-3-amir73il@gmail.com>
	<87wluw2qeh.fsf@wotan.olymp>
	<CAOQ4uxjzAXgBaggRNJxcEn39LY4+D6ZVHLqODJ3C6cHnDdkG_g@mail.gmail.com>
	<87se5k2des.fsf@wotan.olymp>
	<CAOQ4uxjakizfBuTYUG-=K+L1MUfaCkwtKUyNh2g_9K2c4u3-Ng@mail.gmail.com>
	<CAC1kPDMPfYAUsmT-yx4NK=hT5OdeZuJpyVTbfHZxfdbH8b_=uQ@mail.gmail.com>
Date: Thu, 16 Jul 2026 13:49:37 +0100
Message-ID: <87o6g785ge.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16 2026, Chen Linxuan wrote:

> On Thu Jul 16, 2026 at 6:10 PM CST, Amir Goldstein wrote:
>> On Wed, Jul 15, 2026 at 10:41=E2=80=AFPM Luis Henriques <luis@igalia.com=
> wrote:
>>>
>>> Hi!
>>>
>>> On Wed, Jul 15 2026, Amir Goldstein wrote:
>>>
>>> [...]
>>> >> A question: in my own tests I have been following a different approa=
ch,
>>> >> where the filesystem is mounted from a shell script that does the ac=
tual
>>> >> testing.  I wonder if you think your approach (i.e. writing the actu=
al
>>> >> test in C, using the kselftest macros) is the preferred one.
>>> >
>>> > I always prefer a standalone C program for a selftest.
>>> > For fstests naturally the tests are done by the shell scripts,
>>> > so it really depends.
>>>
>>> Cool, thanks.  I'll consider adapting my own tests to have a similar
>>> format as this one.
>>>
>>> >> Anyway, the test looks good to me, and I just have a few minor comme=
nts
>>> >> below.
>>> >>
>>> >> > fuse_acl_cache_test is only built when libfuse3 is detected via
>>> >> > pkg-config.
>>> >>
>>> >> Yeah, I've sent a patch recently converting the only existing test t=
o also
>>> >> user fuse3 instead.  Not sure that's acceptable though, since there'=
s a
>>> >> chance of breaking some CI.
>>> >
>>> > I mean if the test is not built it wont run, so I don't know why CI w=
ould fail.
>>> > Obviously some systems do not have libfuse. That's fine by me
>>> > not everyone needs to run all the tests.
>>>
>>> Oh! as usual my comment wasn't clear :-)
>>>
>>> In fact, my comment wasn't really very relevant in the context of this
>>> patch as, in my opinion, I think it's OK for new tests to depend on fus=
e3.
>>>
>>> I was talking about my own patch[1] which was converting the existing
>>> test, which depends on fuse2, to use fuse3.  That's what I was referring
>>> to when talking about breaking CI: we could have a scenario where a test
>>> was being built and executed and, because it's now using fuse3, it can't
>>> be built any more.
>>>
>>> [1] https://lore.kernel.org/all/20260708131122.2917-3-luis@igalia.com/
>>>
>>
>> CC test author
>> I think your concern is exaggerated
>> This test is 1 year old. Who runs this test and doesn't have fuse3?
>
> A quick note on why it used fuse2 to begin with: back then there was no
> fuse3-based test anywhere in the selftests tree. Amir actually pointed me
> to tools/testing/selftests/memfd [1] as the reference to follow, and
> that one (both its Makefile and fuse_mnt.c) is built on libfuse2, so I
> simply copied that pattern for consistency.

Ah! I wasn't aware there was yet another selftest relying on fuse2.
Thanks a lot for pointing that out.  It now makes sense -- that's a very
old test.

Cheers,
--=20
Lu=C3=ADs
