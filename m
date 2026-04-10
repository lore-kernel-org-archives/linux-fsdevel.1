Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5541369970
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850293; cv=pass; b=P3POm9RhtQy+irw479aVbZNiFdCd4Pn4eHMrfYBvIaFefanPXu6OGEp1CpwyXcZTrq6BrLXiTnAYr2WpT26F5Bet9vs/cnbHOJISi1joW1FqiOPMsgrEAedYgvSrYhp8oXXK4H0dlsT8jPylikcLQxofjMknwX5o49U6QgbtPjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850293; c=relaxed/simple;
	bh=FNAI03nk/4gAmnUEUdqnX++d1yEbPhddX0iMENhQHCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bh2deeMCSCNPKFhk6hftSRaqSZ+XQYhXrZfuMiUVxhiJhrEZZidZFmECr4hTRWoa2z3lA9uQjP330+iFhndE6/WnsLM1besxZAiYc3NaQWj53mmzBm05KUcgLc5bGo/vBLW+z75CGTWnTCJ+RUbRc9N0iFP2K64lC56B5LNTS2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGM7thAY; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGM7thAY"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d03db7f87so1560633f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 12:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775850288; cv=none;
        d=google.com; s=arc-20240605;
        b=bAXrnf7KzxFd1uH+KkMaREROsrZ/klLpdnZqY3mFmrh/Z+8PHlQNOVRtldOTPp5y7P
         8qHBN3+0qzIoVkPkMvWOUPx7SzAEqYQdLuk5ccqCwHJV9ORTAd66nZUkCRK4bejRE775
         ZXD8M1X+zv+Xjl/x+eznrNywjletQEI9hjVcaiToCJHZTIAK2nPs0+RG+0mLVYEAX7Bf
         RuxNoiGg+MSb31rU3LJXIpVYMGYCWYZAEo3jmp0gFnQ7SSR08plGL8yUt0ocYo3Ke1Uq
         +554rjsTcjNn4v25wCCWZ22Y514m1PAZIj+rWMgcuhgV4Ad1slZ4PNv3jy9R2Gmc1RE/
         Y4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YA+Vo+BLpjEum5uJOjv2yu6kV+TyvNZtWpStQlX6OBg=;
        fh=Aco0Kvw3+5C/BIpNfonPHylbcHS74h3Btbl2zrz0wuo=;
        b=JV6BNiWi8VA98m27TytRfbGGKW/24T0UUfcf8LJeDPvz0N20PVhxxceT53vNjOnOXc
         zcHt4Lo/ij0pkW3sZr3O3rFbNWM7a7wm8q0++dm9ugN/ilpA07WIw4xMgoasb6o1cVrE
         K0PQKGJ3E2U24ZnS6BoKW/MU/774LWgPTuliTRVafxQ5JgBysiWSinEYHQ76wAvZzjDK
         3jTCcpPpM2C9bhGxmSdkQCcgeYKxU9n1DuEmSLYuy3m2x8yAWe6LCN1BXUf8I5U2QFWm
         +msb25/Z2gdP3qgBbZ2qd7YZYNfTVQB189bPBpCq0tUv0oueuZ3se3nfTAJ/YVzdX7Ne
         o7nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775850288; x=1776455088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YA+Vo+BLpjEum5uJOjv2yu6kV+TyvNZtWpStQlX6OBg=;
        b=IGM7thAYfdRhj4Pq6JU+8m+V+TrV33GG5sFc0V+EAeogsYPFNVqMx00I0Rhqu3hVr9
         lYa0Ga6OXtGvZAlm8+bTb7M41DqTB/2j91xEYJpfnME4YW4Srv4RCmOy/5OBGLqxk8f0
         xed/juwTax4J/5a7Q8ptMy3Gf5lVohTuX4WqEzMqG3rJekfaVzB6QKvn2BX0j7Wu/QEX
         Kru7xHsfZKDvTqH1nk8h1J/y/2wHBSOHSuWT57l/sBagL/XAs0J6S8VQVd/vVnVr3Vke
         wo38dG+FCrkoKNlvRr7tIkcO3uqKewcGVQA0QsvgQYASZzwj13K8buOsXYnQNKG5G57o
         pUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850288; x=1776455088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YA+Vo+BLpjEum5uJOjv2yu6kV+TyvNZtWpStQlX6OBg=;
        b=aZEr+eCLZcF3lHfGDcxvl21POuwzjpv5s2PKMO469ci1QSC3nIpnjKJ4wA5+Y0KD3r
         hpfPkw2w1EgdR+xI4ccHFjOLozSWiMEjHgg4rV2hRD4vVWgnDEgJueevB+xN41zGNn5q
         szunNYP37HrndwZVuh6G75iWICF+GY8ud8ySIQ0T6uYuEIGx05q8/6OPTAAumfko4+XW
         6lYxo5LlC2V9xb4zrmT3bV9JKd4/BIViPcKPTx2HKosssdV9hPIr/p5qDy4tTra/8etK
         m+oRogHzTkLpi9LwfW4Hj5ItqI2RXS6/+WxCAP+1GufzrtiN4ZXYHT9L+vsUrv6t9YX6
         Rh3w==
X-Forwarded-Encrypted: i=1; AJvYcCWvzP4Ea7RCyGOGHAcrW2+axIQfKSJxBtjgihQ1KiP9yJ1LWR+M+vFjD29/xkGdAARrVXcZYJHnydq2BnIS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzai1NfRnlZ1vuGtjy5Smh5lstyzjhOQdK64IsPhSrCjUe9WZv6
	UDEKPOFCj7Y+Wl/dtvv4Q1wqih6QYtcggMSHdEXBX+H9r83+cHPGY99ZS+qrgF1qXLvj9mp8Olz
	4sIGGFfv/el8+Nlmo6JwnvYUCdUv/fwc=
X-Gm-Gg: AeBDieth0ioK26GZ5aU7R5zPcyItkwvxStCLtrydM7CYtUfL9EDC+Ua7mDKDSMSlGZz
	P+IKN4OR1gch8PnmZs2BeFCe+sQGmcdx0JqkXPjl6bFB9kjh431CaFvUY2LGK7hNsEt7D0WVCwB
	ZMuTCQyt8YmaRCZeuUAEBevPDAMzZBf+G2tNlIHqwxSuLCtD3l9tf8SXbG6w6YI2juFdeKczLu9
	cPmVniXx9QP4q2mZyaOUmpSaTaHiSad6gbUmjrvGz0KnRjeUUD/zNiop5zBeE2ub9ln2GFoF5k3
	hR0wSQ==
X-Received: by 2002:a05:6000:26cf:b0:439:b440:b8a2 with SMTP id
 ffacd0b85a97d-43d642b6b7fmr6878443f8f.28.1775850288128; Fri, 10 Apr 2026
 12:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331123702.35052-1-john@jagalactic.com> <0100019d43e5f632-f5862a3e-361c-4b54-a9a6-96c242a8f17a-000000@email.amazonses.com>
 <CAJnrk1ZRTGWjNzkMxS3UkeZMmrpadJDtWKontMx2=d-smXYq=w@mail.gmail.com>
 <adkDq0m5Wt9YhJ8A@groves.net> <38744253-efa3-41c5-a491-b177a4a4c835@bsbernd.com>
 <adlBcwJjLOQDAR65@groves.net>
In-Reply-To: <adlBcwJjLOQDAR65@groves.net>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 10 Apr 2026 12:44:35 -0700
X-Gm-Features: AQROBzARHDFbLCramX7y6XHbmzYw4l9YPeopkOWAW_WNkYoeqE-JB9tvnAmSS9c
Message-ID: <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: John Groves <John@groves.net>
Cc: Bernd Schubert <bernd@bsbernd.com>, John Groves <john@jagalactic.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, djbw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 11:38=E2=80=AFAM John Groves <John@groves.net> wrot=
e:
>
> On 26/04/10 05:24PM, Bernd Schubert wrote:
> >
> >
> > On 4/10/26 16:46, John Groves wrote:
> > > On 26/04/06 10:43AM, Joanne Koong wrote:
> > >> On Tue, Mar 31, 2026 at 5:37=E2=80=AFAM John Groves <john@jagalactic=
.com> wrote:
> > >>>
> > >>> From: John Groves <john@groves.net>
> > >>>
> > >>> NOTE: this series depends on the famfs dax series in Ira's for-7.1/=
dax-famfs
> > >>> branch [0]
> > >>>
> > >>> Description:
> > >>>
> > >>> This patch series introduces famfs into the fuse file system framew=
ork.
> > >>> Famfs depends on the bundled dax patch set.
> > >>>
> > >>> The famfs user space code can be found at [1].
> > >>>
> > >>> John Groves (10):
> > >>>   famfs_fuse: Update macro s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
> > >>>   famfs_fuse: Basic fuse kernel ABI enablement for famfs
> > >>>   famfs_fuse: Plumb the GET_FMAP message/response
> > >>>   famfs_fuse: Create files with famfs fmaps
> > >>>   famfs_fuse: GET_DAXDEV message and daxdev_table
> > >>>   famfs_fuse: Plumb dax iomap and fuse read/write/mmap
> > >>>   famfs_fuse: Add holder_operations for dax notify_failure()
> > >>>   famfs_fuse: Add DAX address_space_operations with noop_dirty_foli=
o
> > >>>   famfs_fuse: Add famfs fmap metadata documentation
> > >>>   famfs_fuse: Add documentation
> > >>>
> > >>>  Documentation/filesystems/famfs.rst |  142 ++++
> > >>>  Documentation/filesystems/index.rst |    1 +
> > >>>  MAINTAINERS                         |   10 +
> > >>>  fs/fuse/Kconfig                     |   13 +
> > >>>  fs/fuse/Makefile                    |    1 +
> > >>>  fs/fuse/dir.c                       |    2 +-
> > >>>  fs/fuse/famfs.c                     | 1180 +++++++++++++++++++++++=
++++
> > >>>  fs/fuse/famfs_kfmap.h               |  167 ++++
> > >>>  fs/fuse/file.c                      |   45 +-
> > >>>  fs/fuse/fuse_i.h                    |  116 ++-
> > >>>  fs/fuse/inode.c                     |   35 +-
> > >>>  fs/fuse/iomode.c                    |    2 +-
> > >>>  fs/namei.c                          |    1 +
> > >>>  include/uapi/linux/fuse.h           |   88 ++
> > >>>  14 files changed, 1790 insertions(+), 13 deletions(-)
> > >>>  create mode 100644 Documentation/filesystems/famfs.rst
> > >>>  create mode 100644 fs/fuse/famfs.c
> > >>>  create mode 100644 fs/fuse/famfs_kfmap.h
> > >>>
> > >>>
> > >>> base-commit: 2ae624d5a555d47a735fb3f4d850402859a4db77
> > >>> --
> > >>> 2.53.0
> > >>>
> > >>
> > >> Hi John,
> > >>
> > >> I=E2=80=99m curious to hear your thoughts on whether you think it ma=
kes sense
> > >> for the famfs-specific logic in this series to be moved to a bpf
> > >> program that goes through a generic fuse iomap dax layer.
> > >>
> > >> Based on [1], this gives feature-parity with the famfs logic in this
> > >> series. In my opinion, having famfs go through a generic fuse iomap
> > >> dax layer makes the fuse kernel code more extensible for future
> > >> servers that will also want to use dax iomap, and keeps the fuse cod=
e
> > >> cleaner by not having famfs-specific logic hardcoded in and having t=
o
> > >> introduce new fuse uapis for something famfs-specific. In my
> > >> understanding of it, fuse is meant to be generic and it feels like
> > >> adding server-specific logic goes against that design philosophy and
> > >> sets a precedent for other servers wanting similar special-casing in
> > >> the future. I'd like to explore whether the bpf and generic fuse iom=
ap
> > >> dax layer approach can preserve that philosophy while still giving
> > >> famfs the flexibility it needs.
> > >>
> > >> I think moving the famfs logic to bpf benefits famfs as well:
> > >> - Instead of needing to issue a FUSE_GET_FMAP request after a file i=
s
> > >> opened, the server can directly populate the metadata map from
> > >> userspace with the mapping info when it processes the FUSE_OPEN
> > >> request, which gets rid of the roundtrip cost
> > >> - The server can dynamically update the metadata / bpf maps during
> > >> runtime from userspace if any mapping info needs to change
> > >> - Future code changes / updates for famfs are all server-side and ca=
n
> > >> be deployed immediately instead of needing to go through the upstrea=
m
> > >> kernel mailing list process
> > >> - Famfs updates / new releases can ship independently of kernel rele=
ases
> > >>
> > >> I'd appreciate the chance to discuss tradeoffs or if you'd rather
> > >> discuss this at the fuse BoF at lsf, that sounds great too.
> > >>
> > >> Thanks,
> > >> Joanne
> > >>
> > >
> > > Hi Joanne,
> > >
> > > I'm definitely up for discussing it, and talking before LSFMM would b=
e
> > > good because then I'd have some time to think about before we discuss
> > > at LSFMM.
> > >
> > > I have not had a chance to really study this, in part since I've neve=
r even
> > > written a "hello world" BPF program.
> > >
> > > I'll ping off-list about times to talk.
> > >
> > > However...
> > >
> > > I would object vehemently to this sort of re-write prior to going ups=
tream,
> > > as would users and vendors who need famfs now that the memory product=
s it
> > > enables have started to ship.
> > >
> > > This work started over 3 years ago, initial patches over 2 years ago,
> > > community decision that it should go into fuse 2 years ago, first fus=
e
> > > patches a year ago.
> > >
> > > This implementation is pretty much exactly in line with expectation-s=
etting
> > > starting two years ago. Famfs is a complicated orchestration between =
dax,
> > > fuse, ndctl (for daxctl), libfuse and the extensive famfs user space.=
 Famfs
> > > has a fairly small kernel footprint, but its user space is much large=
r.
> > > This could set it back a year if we re-write now.


Hi John,

Thanks for your email. I totally understand where you're coming from -
having already spent a year reworking your initial patches to go
through fuse, the last thing needed is another change. Bernd brought
up the question of whether after merging this series in, it could then
be converted to bpf. If this is an option on the table, I'd say we
should just merge your series now and do any conversions later, but I
don't think this is possible. As I understand it, the policy is that
all kernel releases must be backwards-compatible, which means once
this series lands, the famfs code will live within fuse permanently.

I definitely do not want to see famfs set back by yet another year.
With the bpf approach, I don't think it requires another rewrite. I'm
not sure if you had the chance to look at my email from February [1],
but it contains the prototype code for the generic fuse iomap dax
layer with your famfs logic in this series moved to bpf. I think it's
pretty technically straightforward as it uses the famfs code logic
you've already written in this series and just moves it to bpf.

Overall, my intention with bringing this up is just to make sure we're
at least aware of this alternative before anything is merged and
permanent. If Miklos and you think we should land this series, then
I'm on board with that.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1YMqDKA5gDZasrxGjJtfdbhmjxX=
5uhUv=3DOSPyA=3DG5EE+Q@mail.gmail.com/

> > >
> > > Two things are true at once: I think this is a serious idea worth
> > > considering, and I think it's too late to make this sort of change be=
fore
> > > going upstream. Products need this enablement, and quite a long proce=
ss has
> > > run in order to make it available in a timely fashion (which means so=
on
> > > now). I hope we can avoid making the perfect the enemy of the good.
> > >
> > > I believe the risk of merging famfs soon is quite low, because famfs =
will
> > > not affect anybody who doesn't use it. I hope we can run this discuss=
ion and
> > > analysis in parallel with merging the current implementation of famfs=
 soon.
> >
> >
> > Hi John,
> >
> > one question, assuming most of these things can be done with eBPF, woul=
d
> > you convert to eBPF after the merge?
>
> Hi Bernd,
>
> Stipulating that I've never even written 'hello world' with BPF, if it's
> a nicer solution with no downsides we would migrate there. I don't know
> enough yet to put a time frame on it, but I'll certainly understand more
> by LSFMM. Will you be there?
>
> I'm hoping for a call with Joanne and Darrick in the next few days to get
> better educated on it.
>
> >
> > (I also need to find the time to review at least all of your libfuse
> > changes, I feel guilty that still haven't done it.).
> >
> >
> > Thanks,
> > Bernd
>
> The libfuse changes are pretty small now. Two new messages - GET_FMAP and
> GET_DAXDEV - plus a few more bits and bobs. If a future BPF migration too=
k
> place, there is a chance that those message numbers could be retired and
> reused in the future.
>
> Watch this space...
>
> Thanks,
> John
>
