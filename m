Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5113C4548
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083014; cv=pass; b=IBEkX2CDoS3XEf+guS/4JekOye5xnYchJ1uz0Y7Vi/RXd4zJ9jIfeXGa18aYygaYaXE93SwNf+UfqOPwJLYgt3B16ttLUUAklKqW022V/46pjT+Hl+YjQHVEmdny0PfnAJLSAbixG50QOD+5qZlo9X2A0z7KGGme2cB81O9u4os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083014; c=relaxed/simple;
	bh=NJnbcxur+Di9Sw8iiKloTt0UVQQYsI9XXlYh0xw/qC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llJR7IIcx0dB6W1bTo31YdmuHmVZtzbgf9vuUWNtNMCSzPvcs4sFxyBCzo+IfQLz9kIdqGEo/pyDb4rwu2+0p98gBlYcxGKcFtmt8TxtZ/AsDyqqOu6cNhHpUDSD9ZE1jAQpFRQ94oFOaqjePyqjw3gMwTo0W228seCrtw6MwPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgCe4Yua; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgCe4Yua"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so673007566b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 05:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776083011; cv=none;
        d=google.com; s=arc-20240605;
        b=QA0C1FnbKIUXx1Q2T1PeEzrEKrdJqMoO0xM9R9jssvMqTVjr5GZkBSfiEjQ4lLVq/z
         2Wrf0nvALDosn4o/YS72mjJOcH3OCDmUomiDkqKDe1w56XZWWI4C32BYOlfe0tjZYJeR
         VZLciK4uarnEmX6ko46nJMIFSDOJRriBgKEqaM5VhGEDx/YAHcGEhscSrEgmmi6lyFd4
         CfGJQZjIxB9VkyvkeFAQgD1lhXpEuWA/4VI0fCoYTgxVYCkWjDkBw2Kkd3cpPpaYv4nw
         0E5TXOIwlREaVwVWkaO5Lm7WcTJqENaGvZiOoQuYFQzJToIfpHht9WSy5vrd2816i4rg
         DGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WdXBDy3UTCAqlwG2cuSmoWMTuv5Bur9pQvnnMUgtqi4=;
        fh=uXIvmqDcDxSV8W5q+9tQpuRmxGgZxtPgUAt/imfRzYw=;
        b=kUf8fcgcN1YNbmpNnaSsBbghzCItKL8lcDbOa07bpc0OyBwQCZNC8cCMUtY0JcYmUu
         zPHwOrexu182ISTKYvQZpIs7E8n/XWlN2F7wOC0r16SYHoHzsVS9dMVF5Od1KLq2/pjv
         izmLy7ZBQWoecTOlTxckkcigoOpqooRAZ0slL3JczKlfhURblwSyq4Ea141zoI7CQfBG
         +/jYoNNVDFgqzEHW3ABlIMgFD5z1jdV2zqCz89vcZ4s2Zypbodd3/cm1rd7GAMBvWpXn
         oNddtRyw/9Crg0G2Liy/ajFrN95wfbCa2+J2NrjGY7pIf/onEwM+xPc+clBNsc/hkOHl
         FBrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776083011; x=1776687811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdXBDy3UTCAqlwG2cuSmoWMTuv5Bur9pQvnnMUgtqi4=;
        b=LgCe4YuaRHp1aJWw5NVJLqX55FLZ4Y6UJzaPqpJkUqpepiSu8h2eza0TQtCmRtVwRD
         Wv34F1elz7orDGiNHulY9hj6qGGcn0n4AKEnXwWH+adrWUk99alITSrPFh7BJXQnwAlD
         CDd9Jpw3EdiHz2WEyGNUxiEVVxhTd6NgN3y0303wuDCs8Ox+95SunibC6htvnk6Mf8ir
         b13+QDBrLJlEygKWyCVaaiNKGB+AsnykPpLfY+kV4SajX/jVZ1kGMOhOUIjji2LHwlT5
         HS5Yl1AjxussTTMMtHxg6id5pe9aE4wfbR25UJsbO4mhdcsgBndhcoaBCjad/e3YLm29
         MrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083011; x=1776687811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WdXBDy3UTCAqlwG2cuSmoWMTuv5Bur9pQvnnMUgtqi4=;
        b=NQH12B8BV0PWQTLmvXwuMOQ4m7rAMa17mFyRc7IXAraf2FLaKq91NTOAl2aX3/CZSE
         6QmrKZv66RoMc7Sd3dx2Zz9ly3NQohUGoddK6z0kcSKdFrZcmux3iszdAfqAukoIWRlE
         sg3UHGm9ynxzDfgUv33qsTh+KZq+eq/LFQDFu5xSZzRFmqHKU2IKA1F8ej3ZL3m7KMJ+
         aiskeSQobvsEMJUkJVe+KqGxpz+UrN7oMlZU41nYzsJgKuUIctrDAu95G17555V0bhqW
         Ub3Pmkws/E9+xyy5HKFeoMAGePBpZOspLcrCp+GhoKauF2H4IyygDW3peGt6qtoc4j2Z
         kv6A==
X-Forwarded-Encrypted: i=1; AFNElJ836RcWfSQyoxvk4BKmhv5wkyvL8amSEgBoASeF6Gz9Pz4zMKiSUrXWHMZXOvwyMgyS3z+a/SwMz6szuWPa@vger.kernel.org
X-Gm-Message-State: AOJu0YzDYeaRFAsZjIyjH5jG9HIu4jqgtNxkQf6CKpJ9HG5235rZp6G9
	KnLSiPZiMhI2bSTi5JMvNrbTHfCh4n0FrI4F9EDEpwJutQ5XZtZXCcWEEX2iGbzzWfMj9r20mbZ
	ua7mcYEWOFIb3i3Q618Hw8EcZlUhXnk0=
X-Gm-Gg: AeBDiesFMXZxHW39KTnhUE6bRJprIyVLp7DnIHyYjCzTlEvdSwoK2ndTzBg3udq5n7e
	MNinNpE1u1EbklInp8sgQ0sSDUi6Vu1KxLyKRny8/FkCoX1kNqzAUhnvybAQ4JcAJY+dOFpUSv6
	H4B4XXWQviKg/SO8uygCJKNvStGW1aUzoHyiTfM3RcWj/qXPkn21GZ8vOxFH8O1++xsaPm3k7oP
	HILX9mlyusDYJEM9Ec6Gv6zqrnBTJQ7Pi37tXi5P+EsdPyVGKmaK9I9lBSbFa1zrbF6kOvmgUBv
	iCnzWoQfDtXd6KoyEJL4+JfslD5xavDRi6q6j4R82w==
X-Received: by 2002:a17:907:c48e:b0:b9c:5672:852 with SMTP id
 a640c23a62f3a-b9d727fe83bmr746453066b.40.1776083009787; Mon, 13 Apr 2026
 05:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <adTyw4UJ04qOggCQ@amir-ThinkPad-T480> <c4ffec34-fad0-40d9-bff1-06c3cd202351@bsbernd.com>
 <CAOQ4uxhBC7eTkaB6Ws1DqewzxkGdEfcCyJ8EZszn+YeHwG0-wQ@mail.gmail.com>
 <5d7295b0-bd7e-41e7-b176-3d19b240413c@bsbernd.com> <20260407191046.GL6254@frogsfrogsfrogs>
 <CAOQ4uxiU3RcoNMD21Yx_ZPqCpmtL8-Eda=a5+uJC+AsO7F=_2Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxiU3RcoNMD21Yx_ZPqCpmtL8-Eda=a5+uJC+AsO7F=_2Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 13 Apr 2026 14:23:16 +0200
X-Gm-Features: AQROBzBJEPDbN5cE7NaFSed_jf6F4jyPs0uC1n1qzEhkM_oy3DQDatuGivkhF2E
Message-ID: <CAOQ4uxg+DhWoKtHFOt4eEgYYqAAmcJG_q3nJcQ2ZVOFCWRN0bw@mail.gmail.com>
Subject: Re: fuse-devel list on kernel.org
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>, 
	Bernd Schubert <bschubert@ddn.com>, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:21=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Apr 7, 2026 at 9:10=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
> >
> > On Tue, Apr 07, 2026 at 08:05:36PM +0200, Bernd Schubert wrote:
> > >
> > >
> > > On 4/7/26 14:29, Amir Goldstein wrote:
> > > > On Tue, Apr 7, 2026 at 2:25=E2=80=AFPM Bernd Schubert <bernd@bsbern=
d.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 4/7/26 14:04, Amir Goldstein wrote:
> > > >>> On Thu, Mar 26, 2026 at 10:34:33PM +0100, Bernd Schubert wrote:
> > > >>>> I'm taking Darricks example here and posting API changing libfus=
e
> > > >>>> changes to linux-fsdevel. We should consider to create a fuse
> > > >>>> specific list if that is too much. The existing
> > > >>>> fuse-devel@lists.sourceforge.net is rather hopeless due to lack
> > > >>>> of spam filtering.
> > > >>>>
> > > >>>
> > > >>> Let's do this already!
> > > >>>
> > > >>> https://korg.docs.kernel.org/lore-archives.html
> > > >>>
> > > >>> Do you want me to send the email to kernel.org?
> > > >>>
> > > >>> I suggest that we ask for fuse-deve@lists.linux.dev
> > > >
> > > > Just don't copy paste my fuse-deve typo in the request ;)
> > > >
> > > >>> and then we can migrated the old sourceforge archives
> > > >>
> > > >> I'm all for a new fuse mailing list.
> > > >>
> > > >>>
> > > >>> As far as I can understand getting the archives from sourceforge
> > > >>> required the admin password:
> > > >>>
> > > >>> https://sourceforge.net/p/forge/documentation/Mailing%20List%20Ar=
chives/
> > > >>>
> > > >>> Mikos,
> > > >>>
> > > >>> Will you be able to handle the archive migration?
> > > >>
> > > >> Have that password from Nikolaus.
> > > >>
> > > >
> > > > Excellent, so will you be sending that email to helpdesk@kernel.org=
?
> > >
> > > I can login here as admin:
> > > https://lists.sourceforge.net/lists/admin/fuse-devel with the admin
> > > password.
> > >
> > > Here https://lists.sourceforge.net/mbox/fuse-devel which is supposed =
to
> > > create the mbox file it asks for "user" and password. Assuming the
> > > password is the same, what is the "user"? Also tried my user sourcefo=
rge
> > > credentials, does not work either.
> > >
> > > Can we defer this a bit? Too many things to do and I think for now
> > > reviewing Joannes Patches and finishing sync-init and Darricks mail h=
as
> > > a higher priority than fighting with sourceforge mbox.
> >
> > I don't have a problem with deferring, but FYI you don't have to have
> > old ML history ready to go when you apply for a new list.  It, erm, too=
k
> > us months to scrounge the entire xfs history together after linux-xfs
> > was created.
>
> I requested the list:
> https://lore.kernel.org/linux-fsdevel/CAOQ4uxjRgQGxWYWbRbjVZy19oA5qKZSd9e=
ANKyD8yCoBNGPNNw@mail.gmail.com/
>
> I cannot imagine anyone missing the fuse patches on fsdevel
> if people just started posting their kernel and libfuse patches to fuse-d=
evel.
>
> Should have done this two years ago when it was also proposed.
>

Well the list is up (now in CC) <fuse-devel@lists.linux.dev> and
archived on lore.kernel.org.

Now you'all only need to subscribe and send the patches there.

Cheers,
Amir.
