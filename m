Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4881732
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724475; cv=pass; b=NhXGx4FFjfcDGAj+LOHuKrMYH6vx6leotnYTg37esiPS2pmw7zMO8rJAWlgGsvi+2UMLsL/yuVAiOYZDoY70tG89n0mPDvRoCHMVPi4qfXFV2dag2H2cIOBmFYfuWlcvPoCaDD3zQl4sVhPnQfZGKcUyL0n7SHt1DlpQIs6I8ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724475; c=relaxed/simple;
	bh=TWe1Cg0XZd9aKCfBim6632tR82TsQqkTtOSHRxZ8GhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAgWwA668muvBF26g+J3fgvEVDn3W1oeTDYsnc+qAqMKrzK8fwPleg3XtCuRT3u/ub75wByyKVJWAm52fnuSplu5iza++jAmqU9A1GN8mOTGJmxb88U0tAdViIzTcDsYacmkNMKLooecOeFR+ku6ZJqJl8zEvldgpjcGiL0c1/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brRId3TP; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brRId3TP"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so17076954a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 05:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784724472; cv=none;
        d=google.com; s=arc-20260327;
        b=S14p78UCZpwKGMtdZcQlu/HZVtNXpaS62jEP5wmFJW/41M9du2osO/XwRjS6B3GQzZ
         RIViuFVga0zjeXuWmo9szHEo4q6XOKZxZC84lXMBNqwSSUz8oezgMbUrlzxaQPyh7ac5
         AEFRkiER9TWIk70hLqyNKn63s3gOvk/f/Iwm6iw8RrN6Y8zuelnXax7r6aMx2zToIosD
         59ZSAgxq7+h+Geyo1D/2spIGLj14+ehhdq8ZGXLMagtt2AXGPntG7barnDeX/WbCtd5/
         7l2ufwBMjUMY7CkGCv2bkPOBuHLhUgdz2GWuBrokxBv8VSOyATh7G/Iyax5Knv2iO1HO
         1MyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XYV9hkuF2d5ODBMLR+pFWv3rbaq2dbZuJ+4IyfPmr+A=;
        fh=g+G1jc5Ik8JSbkGmjE+hYNgraq3hYHn24EzvUbLKEJg=;
        b=eeHPBrbabjSAswYBNlGI/5Aj34ecQ4ATLY0FfOGI5qXV+m633vgHs+H1OEjM16y/vb
         v63dgaXOrbPH6bWK7nRDHc3m6Qy8LPmE8WV7cBLsJOvmYYNHRuzp6t0qX0+d6mGZXR8U
         Ukq6qCcb69Mg1Wj8E3h3Gp+j25Fe0bxnWBAsiw9A+3aI2xOvWanMu1ctGLTQ/bKcPDlu
         6ihErCF0HC2bgqtcZYc6FH/I2An5+8C41MJYkPjbsOhnk0llqpM7i+QNy8qRLAbxmx9Z
         whDF0ZrjFYyrlHncQpD36yjcPRYhLlNWc1LLnWeP1AT/uHUqapeV3NGSXTCDRzeirQZz
         IbCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784724472; x=1785329272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XYV9hkuF2d5ODBMLR+pFWv3rbaq2dbZuJ+4IyfPmr+A=;
        b=brRId3TPWt1m/r+PuXSWAwdfqAY4dtCCP5M63A4yYVkmjXM/Vtfgc8136k4/ty3Y1n
         QVuQ5GkIubXX/JyQKYOCLeMH5i4EM91ZUTrkyqEuOZfnL/n5XD4kbUllgiFLnuUinUaR
         zF0Y/Nqzn0XDu98ZhtEmLfq/r3+B2pcsxe/CZtBqdSWfqUR5+8OvOaCqDp2mqiniPmi6
         lxdYD3LUGRCdCEcD6tc0Qb7xZlxx7ULPjXehFIOjT9JV0JNQxMGJYbXsILsDpmrqndST
         UNjgAwCkJj4dbYw7keH9EuHoKdlcpjXuufHpdn+oUNyfkKQtFChYO/oNIGmqUUBtwhr5
         Hdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784724472; x=1785329272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XYV9hkuF2d5ODBMLR+pFWv3rbaq2dbZuJ+4IyfPmr+A=;
        b=qQWJyyZ/SrbgyM8EfD2WqLd3c6i4+x9PWV5eIfUPc5aIHOuG2w6gfHeLAJ4aMAFJE/
         +zkOuIePUJ46ep9lypoFPK0opszB9ITBqcfIYh+Mq86PgZM3+detqdJX8vE0xwxCyXQt
         rhsUjSs/koyE4h8qC82Ym84HiWrEqDHaSHhUTe09lO09a9/A2SZkp6qImpWPAarrY+AO
         sK+KK2Rm+nMOIZDK/y0vyQkFiSLAboyCOC+1TFL8N4p5iT7dcuIZTfUFhjAJoYBcTOkO
         xICfzfFxjGrsq6fGmS36RB61KAeS1IFOCRjvDbt4XzfGagtp1muQW0lG728phsBpSjEB
         zzIw==
X-Forwarded-Encrypted: i=1; AHgh+RpgLf7i1GJ7eMGb9Xor+tkTlMoY6r1aTkqRVpymbH3lHcLbpaiTw7nYc4iIkM5cfCbrhCsPvWAfnBqJVTVz@vger.kernel.org
X-Gm-Message-State: AOJu0YxfjpClnhg1Nd4HzWGuBqr+bgWEo/7ZHM7OhTUuKl55z7yKS6up
	8BW/uebxrQ7auyV8yq9iLqqb9WqkslUNrenJ/9KIRso3xexhlXZkBe27jt0NuN4oQ+rznrpxdYJ
	T703ObYYbmiS/Ter3+rlgKb9/ezQj+y4=
X-Gm-Gg: AR+sD12BrRaDcxamqpJDvoG7EtXuooblKhYK5FV1euXQdNDXU6QkdSAEw5xmFQguX0b
	SnAv3KRj9VfYQN70XWGvZ9gkUjYnmGyl+VnoBX9vvG95npBGC5JZ+CRWCkvI1BudAfBFeDNxnH8
	2i5u2wk9msLzsQ0wGrBpVXPAFv99POJCcALiSLo2VW8l3f1xq+hquKk6KDGkfWpSGHt1qcWtJDk
	X3iXSPCFaohi/ushCnRX8bVDTYlHKuDLhykhoguXUTRsDX7DPrbIlQ3YE+xLaA=
X-Received: by 2002:a17:907:972a:b0:c16:46b1:e0c2 with SMTP id
 a640c23a62f3a-c16b48a8b9dmr984425966b.62.1784724471369; Wed, 22 Jul 2026
 05:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034358.68714-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <CAOQ4uxiEzP2e=cRw-AiGxtSv6WMSA5yR3cmgrF97s7ggU6wzqg@mail.gmail.com> <CAJfpegt9PwHksYhsQZeCsW0eooXVVihyieTpeHMmC-+Pq8BWaw@mail.gmail.com>
In-Reply-To: <CAJfpegt9PwHksYhsQZeCsW0eooXVVihyieTpeHMmC-+Pq8BWaw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Jul 2026 14:47:37 +0200
X-Gm-Features: AUfX_my2cSFlhFYxiKgO1hiNmZM0_RgRfBeCPM6_N17W9wq10tY2PdKKMNctT2o
Message-ID: <CAOQ4uxhuivjMMt_Dm3VwKmOhHg7ZHdAww6j6jp+RMjPoRde+bA@mail.gmail.com>
Subject: Re: [PATCH V11 0/9] famfs: port into fuse
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 12:47=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Mon, 20 Jul 2026 at 12:07, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > It's not about this ioctl, it's about infrastructure reuse.
> > It's about the fact that there is NOTHING special about dax_devlist;
> > and no reason not to manage it via backing_files_map.
> >
> > The reason you stated was that you want userspace to determine the
> > daxdev_index/backing_id - fine, no problem - this is why I asked that
> > you pass it the desired backing_id in the ioctl.
> > In fact I think that all fuse backing_ids would be better assigned by u=
ser space
> > so the extension of padding =3D> backing_id is not unique to famfs.
>
> Right, so I suggest to just reuse FUSE_DEV_IOC_BACKING_OPEN and add
> two flags: one to enable user supplied backing ID and the other to
> indicate that fd refers to DAX device.  The changes to do compared to
> the current patchset are quite minimal.
>
> > And the best part is that this request requires no changes to your user=
space.
> > You already bite the bullet and maintain the new/old uapi but changing =
the
> > kernel implementation does not require this burden from you, so to be h=
onest
> > I really don't understand why you did not follow Miklos' suggestion.
>
> Code reuse is also important, but I understand John's position to want
> to separate famfs from existing codebase as much as possible.  And
> because this is an implementation detail I don't want to make this a
> show stopper.  We can easily fix it later.
>
> > > - Lose the famfs interleaved extent format. I have complied with this=
 request.
> > >   It makes some things worse, but we'll discuss that later.
> > >
> >
> > I am really not aware of a request to lose the interleaved extent forma=
t.
> > How can this patch [2] from Miklos which reimplements this format as a =
generic
> > uapi be mistaken for a request to lose this format?
>
> Let's not care.  We can easily add this later if famfs (or any other
> use case) decides to want this after all.
>
> Making the initial patchset smaller is win in any case.
>
> > Let me recap the former review requests as I understand them:
> >
> > 1. Use ioctl instead of GET_DAXDEV
>
> This is done, just need to reuse the existing ioctl instead of add a
> new one with the same semantics (okay not true because of the fixed
> backing ID extension...)
>
> > 2. Use backing files infra for daxdev table
>
> Leave this later.
>
> > 3. Use ioctl instead of GET_FMAP
>
> Not sure we agreed to use an ioctl for extent mapping.   What we did
> agree on was to use a generic interface that doesn't have anything
> famfs specific in it.

My bad. I thought that FUSE_DEV_IOC_STRIPE_OPEN was an
example of how GET_FMAP should be made into a generic interface.

Sorry for the misunderstanding John.

Thanks,
Amir.
