Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A63947BD
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209618; cv=pass; b=aLcy9PjYdMAVmV7S+UmVew0k82sDdhPbq6zJG9mk90A9gXIhz/ZUz0rN0VD+ZJaLNmB7BPsa4s8lQxC/7joRawPbXbf0TDRwA2rFcdRQQ0ic5gup6VR5cETWMLHbJNNBCP3bcZtGXjSZ7XljJR8n7oYnTggxoSXUAbfoaLFQFuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209618; c=relaxed/simple;
	bh=FUOw5QmAJq0ii8wMmJRsu6EuuCK/CA7uZXPEgxwrJ5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcQnbgXfVBVw275cs6vEv6IRxi4q6R7wUJct31Wq9whOreIW/uJ1islrNHd3vt6SsSWNURf9KPtfbmTLuj3tjGoe0iXGHxK/uVTa64ji07KiQhJOD45WOFnurCJSh0gUrwEM4MEsA8I2bwxTxQKXk5GNAX+WVG5b6i35z3OZ7QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jotschi.de; spf=none smtp.mailfrom=jotschi.de; dkim=pass (2048-bit key) header.d=jotschi-de.20251104.gappssmtp.com header.i=@jotschi-de.20251104.gappssmtp.com header.b=YW/7MeCo; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jotschi.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jotschi.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jotschi-de.20251104.gappssmtp.com header.i=@jotschi-de.20251104.gappssmtp.com header.b="YW/7MeCo"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-356337f058aso951730a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 02:46:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775209615; cv=none;
        d=google.com; s=arc-20240605;
        b=CvKze4PwLqDCJZ4h7vhiHOW23+stkWBYD2f/oaDUW9yGM0FptvlJOXgphm14vuyMtl
         05AZRUydAcOeNfNbKdkCgcurwq9VKYuoEFQxau5AErnb00F8KOgtM3Ap03VkqxRpWq+T
         sIIl7tjIdnJmIdjyaWTIVDiOE4x4Qnqo+QnPt/3uFYXAYgv22frn1MbsI6ntFw4UX2O0
         br4G0FXizaBH+mmsCG+e1CtwbxoAlYWOYDyaFLifBZPd3zJ/b/5h+aQc4LygMQSov8XD
         aYb0+DAbC0xDis3qwcOCu3OszrLNsCDUAIcYmQC8TOwiN7S3J1DFs73m0fxKKaCshnBh
         S7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FUOw5QmAJq0ii8wMmJRsu6EuuCK/CA7uZXPEgxwrJ5Y=;
        fh=7PG5wfX+6yXe9e6/WadRwmDmQq1n6wstNi4z3pu4Ga8=;
        b=AA56J+wvARiZ9QJAMPDmH2T9gI3hhBXJxqDXFDwFmyXIYHGuwg8INNoMZ4PvYdEDln
         M7BV1ncU5ew4fskGqKBFcjQoVMoUpFZYapUU5BuIs3nU3EyptYsWgW5Injsx6VLPZ9kF
         29eRl10CfV3veFwQ245ikiR+mAndXa9V+ACuZ1qxCvebQzTTnD2gqZ8HOmU1f9sBPLf3
         4xDfJeB//+Mmu+1qKrAJb0UptGFONsvl798FgpPcSt55AT7IbPIrOdhz94J89Iq80iJ7
         Y//aepfD3RdLuii2CfCOurIKh/GbFBNeLF5RjUfg2W9wxvXq+4Foii/Q9VZA9PWvboef
         B7Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jotschi-de.20251104.gappssmtp.com; s=20251104; t=1775209615; x=1775814415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FUOw5QmAJq0ii8wMmJRsu6EuuCK/CA7uZXPEgxwrJ5Y=;
        b=YW/7MeCoC5LU53sqlylyBPX5BxLYMKcwmeXZ8EqE3LUvT9OrgqSBRz0eJED0f4E9uK
         A0+L8D3APOXJirSFO2EGSAnhV14nkER4iUItwcHjpGQWoIYZIq005qmfhPoD350t6ANB
         1bm97LNIzmjXEPPtlV+rK+MQ2IAOxDM35rSJwjaLJmrIWXCJWsQzFs4kVDzfsZ4WGadB
         U8CKQoV8pz5MOrXj0FhKsBeRZz/wb6WXeAEnpFFnJe4Uveu1tVkHrJPWAH+FU7h6XcFM
         Gj4kj+krbuqP5mJvupF2QAvebBw9cZvY5+3fY2uFw7v95SX3Iac3H+zmbkNDzUScBbKh
         BRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209615; x=1775814415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUOw5QmAJq0ii8wMmJRsu6EuuCK/CA7uZXPEgxwrJ5Y=;
        b=tPg4Wown0Sw+2SD6f1LS5xZPO3uqRT2YxvMUqwQ+Qt3Fl9tPjfrD3LmLxNUbTe4vru
         oZW2+EdOTiaTgM3jlKwwh2ny8C6EfgEFHrbjjSYY718mTFaHZMMHhdyYRxWEgK9awkZ+
         Yp7L9WwMKKC4B3X0k0qUYZRTrVzrXgU6eYhS3kmj/uzeNP7hdAqLw8ibuL40YacnpI5C
         yrdO3l06ofpEj7260aa/1Cjy1UQfhFKFs2Wf/eN0Y3ZEkv4Qw1I1ttq+he3oYJoq0ph2
         79YYaYtv3lSqScCpncUCIRKcUFUaKzsa+PTRJhzdUWrvKAqVai+W4GyVylhQhzC/Wywb
         OlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUAcjVcJKlBt49dp0AfW0NEYGsX0fwtoBe0RQkjeOpOxvxin/iF2pMznDzRkgzXekOJjascdNAcS/gg5NV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2dtQhPcRWI9++2JVO1c/pyvF5RKZMRQbzpRbhi+jR6otfrZsF
	shl0g/9kFMHbLB6WnF9SylXXp5jBSXZP235JfMbPy9EVvP8fecySpUYPJSJ/+7Ui3QWLZbHpijc
	wuXbfolA4uySzc9U+wCJeR3l0bhnxHFv7UtuxF8AL
X-Gm-Gg: AeBDiesFVy09gGJ98KsA62cFSD9NB7SXtS/JFchgAdkL9e7ZO1KUGLMFXcX42/lqGn/
	Bsal042KS7xrtBNAyoNlglriMPDEEBZxB+6g6NcZ0xAvw6llcdhalKBO4yw9YkCXHN7wFlG0MYn
	S1Pr3smf0yEaEMAvHY75kxLZzsy2Woez9CJdBhaKbC9cqROZjIZgmGlBReMefwfAtVoYiFbAcZw
	4F/DiVdUyN6Ap8zjlcGqqSUZWCrCP4SXDxP1+Zdx8r+NTyvJ+7XgUMhflQapcdvyYufS/PG/l7y
	Qp+oZTPMXzOQZkoC
X-Received: by 2002:a17:90b:3f08:b0:35d:997c:8eb8 with SMTP id
 98e67ed59e1d1-35de697d01bmr1991531a91.24.1775209614954; Fri, 03 Apr 2026
 02:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <32Xtx4IaYj8nhPIXtt0gPimTRQy4RNjzmsqI1vQB1YBpRes0TEgu6zVzWbBEcn2U6ZxB14BD9vakmezNyhdXDt3CVGO8WYGxHSZZ1qtQVy8=@spawn.link>
 <8f5bb04853073dc620b5a6ebc116942a9b0a2b5c.camel@kernel.org> <e5-exnk0NS5Bsw0Ir_wplkePzOzCUPSsez9oqF7OVAAq3DASvNJ62B9EuQbvIqHitDgxtVnu74QYDYVEQ8rCCU74p4YupWxaKZNN34EPKUY=@spawn.link>
In-Reply-To: <e5-exnk0NS5Bsw0Ir_wplkePzOzCUPSsez9oqF7OVAAq3DASvNJ62B9EuQbvIqHitDgxtVnu74QYDYVEQ8rCCU74p4YupWxaKZNN34EPKUY=@spawn.link>
From: =?UTF-8?Q?Johannes_Sch=C3=BCth?= <j.schueth@jotschi.de>
Date: Fri, 3 Apr 2026 11:46:43 +0200
X-Gm-Features: AQROBzCj3jnypGq0B4RJQclKy6naKB4OfdMyHseNUoPC566jlmaEdgZmMgYanjY
Message-ID: <CA+zj3DLdxpqcoiyi7j+WKZ4nJOA6RfX4LRRoizGaJnNAruPY6w@mail.gmail.com>
Subject: Re: NFSv4 + FUSE xattr user namespace regression/change?
To: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Trond Myklebust <trondmy@kernel.org>, linux-fsdevel@vger.kernel.org, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: multipart/mixed; boundary="000000000000807cdb064e8b3273"

--000000000000807cdb064e8b3273
Content-Type: text/plain; charset="UTF-8"

>
> The user (cc'ed) said they have tested numerous recent releases including 6.18.5 (on both client and server.)
>
>
>
> On Wednesday, January 14th, 2026 at 1:27 PM, Trond Myklebust <trondmy@kernel.org> wrote:
>
> >
> >
> > On Wed, 2026-01-14 at 19:18 +0000, Antonio SJ Musumeci wrote:
> >
> > > You don't often get email from trapexit@spawn.link.
> > > Learn why this is important
> > >
> > > Forgive me but I've not had the chance to investigate this in detail
> > > but according to a user of mine[0] after a commit[1] between 6.15.10
> > > and 6.15.11 user namespaced xattr requests now return EOPNOSUPP when
> > > the FUSE filesystem is exported via NFS. It was replicated with other
> > > FUSE filesystems.
> > >
> > > Was this intentional? If "yes", what would be the proper way to
> > > support this?
> > >
> > > -Antonio
> > >
> > > [0] https://github.com/trapexit/mergerfs/issues/1607
> > > [1]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/comm
> > > it/?id=a8ffee4abd8ec9d7a64d394e0306ae64ba139fd2
> >
> >
> > You should upgrade to a newer stable kernel.
> >
> > This issue has already been reported and fixed by commit 31f1a960ad1a
> > ("NFSv4: Don't clear capabilities that won't be reset").
> >
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trondmy@kernel.org, trond.myklebust@hammerspace.com

I have an update to share on this issue. I used Claude Opus 4.6 to
analyze the issue. It proposed a patch which I tested on kernel
v6.19.11 - Using this patch I was able to resolve the NFS / xattr /
fuse issue for me. I'm not at all familiar with the kernel code base
and advise to take the information in this mail with caution.
According to AI did the initial patch from Miklos not work because
xattr_resolve_name() modifies the prefix and thus the check in
xattr_supports_user_prefix fails. The patch modifies the check so it
passes. I'm not in the position to verify the change or judge it in
any way. But maybe it gives details on why xattr via fuse via NFS is
currently not working.
I uploaded a summary AI explanation [0] which contains more details.

Johannes

[0] https://gist.github.com/Jotschi/3aed062a47d14e0fc96f6c730f70f6f6

--000000000000807cdb064e8b3273
Content-Type: text/x-patch; charset="US-ASCII"; name="nfs_xattr_fuse.patch"
Content-Disposition: attachment; filename="nfs_xattr_fuse.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mniplabl0>
X-Attachment-Id: f_mniplabl0

ZGlmZiAtLWdpdCBhL2ZzL3hhdHRyLmMgYi9mcy94YXR0ci5jCmluZGV4IDMyZDQ0NWZiNjBhYS4u
ZjA5OTFlNDY1OTc0IDEwMDY0NAotLS0gYS9mcy94YXR0ci5jCisrKyBiL2ZzL3hhdHRyLmMKQEAg
LTE3MSw5ICsxNzEsMTYgQEAgeGF0dHJfc3VwcG9ydHNfdXNlcl9wcmVmaXgoc3RydWN0IGlub2Rl
ICppbm9kZSkKICAgICAgICB9CiAKICAgICAgICBmb3JfZWFjaF94YXR0cl9oYW5kbGVyKGhhbmRs
ZXJzLCBoYW5kbGVyKSB7Ci0gICAgICAgICAgICAgICBpZiAoIXN0cm5jbXAoeGF0dHJfcHJlZml4
KGhhbmRsZXIpLCBYQVRUUl9VU0VSX1BSRUZJWCwKKyAgICAgICAgICAgICAgIGNvbnN0IGNoYXIg
KnByZWZpeCA9IHhhdHRyX3ByZWZpeChoYW5kbGVyKTsKKworICAgICAgICAgICAgICAgaWYgKCFz
dHJuY21wKHByZWZpeCwgWEFUVFJfVVNFUl9QUkVGSVgsCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgWEFUVFJfVVNFUl9QUkVGSVhfTEVOKSkKICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIDA7CisgICAgICAgICAgICAgICAvKiBBIGNhdGNoLWFsbCBoYW5kbGVyIHdpdGggYW4gZW1w
dHkgcHJlZml4IGhhbmRsZXMgYWxsCisgICAgICAgICAgICAgICAgKiBuYW1lc3BhY2VzIGluY2x1
ZGluZyAidXNlci4qIi4KKyAgICAgICAgICAgICAgICAqLworICAgICAgICAgICAgICAgaWYgKCEq
cHJlZml4KQorICAgICAgICAgICAgICAgICByZXR1cm4gMDsKICAgICAgICB9
--000000000000807cdb064e8b3273--
