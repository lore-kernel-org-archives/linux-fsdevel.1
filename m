Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C019A2A3
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785610941; cv=pass; b=bOQ/AkW3NA7CN36l1zxSIg3SlCAcEPAoPe15Srl5miMwgPm3KmDZooIR8fAIdymCBAbA3j1IZyXaSJ+7Wse8Shu0Ifuj1ne4zLPyeCueteFRr8FyYrkQp2r10djO2XGV3ku3zdl4j7wqzN0yWQ8rVRFn4bcReEE8VUOY+6uskCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785610941; c=relaxed/simple;
	bh=nivli2INTpQAZY/8TzmpQ6V0d9mAXZr2We8tZu0CLGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPwAg5UBaRDDpYf+INHRuSnlG/bLIs+DuT1KSUuj65cb7xdkw4XKaWnqEECndXnmbam3oIOME7zYJvA8dto5x9S66LCzd+HjPyP7ALjh2KcGQe4YW4aC+0zhBbgxxvQ/MuyLOoPsLNvcxLTBm4EchH+hrPtAXgTXVESvmWPm5jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdUXF+3y; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdUXF+3y"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a063d211ebso2871758a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 12:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785610938; cv=none;
        d=google.com; s=arc-20260327;
        b=McGfsSpr+qhz693A5KQ5eJf92zvEvhRaukm7RS1VREo5l78oXE5me4kQ7L3IQq1vXY
         RBhLt3EsJxGMzY0Poyn1T0l+tzYmFAC9pUV/Wm6QUW9Vs8/ijh59teZ9J2LX9z+AIwrA
         pXpc89IBrLTUNwlVMvY31meYu9IsPfHOKgNgmgNBiCvr0RKHY7GtJSHZQTyKn8yTSa5N
         s4qIy0bSw4D+bX8THxLK2jeOJcjVadtNUTTx7eaZ7ECeSFH9/PCcm1KiRtTg5wjPXBWg
         KtBsibGEKhqn04CDZwUrOUkb5EV3x34qYUO5dc1nSCgLIbtvTe8Vt1dtfvdwTeT/BQX1
         nR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nivli2INTpQAZY/8TzmpQ6V0d9mAXZr2We8tZu0CLGU=;
        fh=tSBE87wLFcd51hq1H1G55+/q77l5VX2RFRKaiUIslR0=;
        b=ebgbsO3qlk8qWHasC3cn9rOvMq/Wd1liErMbeyRJ1PXpA9l1wQaQIF+2UA/Mw+FVdE
         elDGTDzics5+OqwwO4+ULImstseVKXeV3xb9DfkDwIq+iqsAD4C/HU1WjA6i0nDRjZjG
         FQb3N1ky49nfp5UvT6WudcFZ1OJvZCmS2rvyOlkT9GBoKsnfowu4yw3IZoM51OiNaE1c
         5z68ADSjvIXV0wHPhwb0Q7Nz7fQoAfCZE39bNbHl6WScCaJKnv4U7fVpwvK9rayP4pw/
         sz+Qk0xVsN6hUO10uveo8Pl48yzlYbBvI9VSN6oPewQ/7wRMFZoDqS1p/dNsR6zW7fbP
         79Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785610938; x=1786215738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nivli2INTpQAZY/8TzmpQ6V0d9mAXZr2We8tZu0CLGU=;
        b=KdUXF+3ykfIPwHSaJSeFEHofwhjSnI1tczDKFGkXUMnlNyR3F923FZqksKe39mHwW7
         dCFQwl+6lag2J8mXhqPdjSvJyOfv+oEGR1XZmRmdc/n+8d1Q4YUoJr2cQE8ttNrKZZtq
         q9RKXQGOJ9/j92E1PEnI+5lk20BK153agHD8gQsHInkqmhfCSGUddeIGwN1cziXS1f7t
         85D9Av9CzZ8sRacrA5DqqekOWA/HgBAaE6v7NVE1oM7qHZM6vcKSxa1M+a3CgrGhz9qE
         dXI0Fa+oxV2basBHwq944W/k3QT59qjYK6I8reBNZ2kIQ34OFLV7U2v2qBMOj0//Nh2K
         7YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785610938; x=1786215738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nivli2INTpQAZY/8TzmpQ6V0d9mAXZr2We8tZu0CLGU=;
        b=Zd7tLm4TVJypY2yRZK9ctXjxDBYAftkA5qq9qabvrgSWUOqQdbIBwJrHy+fzFpkzNP
         OvXpiQ4vzHU5tVhE1BmmneYoSbOHsRLniqWWPP3uH1ZSkH5tc2tlufDQltCa0esP0tsQ
         4kemGuP5XpULngchtgfSLIJK211p33poeNGh2ygjLCbJLzuiQGMDbfVQDn9EGJXFgrnM
         EJALnId+bAC46APvdqxd9rzS+OuarohvHmeXilV5z0b+V2LhcPVgPc9zjKcY65CQtDQx
         M0bVUTLouQY/XYqaHcPrsszRQmT9a8CpGnchhMeTKT7LGHpvpiBk1BllTMmEq1w/Rz70
         IHdA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+ryoWKBMb1qMlktuCBcDCHfnPCV6YIPK9/5w9caDkJHyf6RO0AUgA5nU7wL0IK11dy6iQ/NxRde/GX7uB@vger.kernel.org
X-Gm-Message-State: AOJu0YzGHtnovIlhXk9kWkBdaLBtDqJTQm7MmHxXbf5g8d/6uQ4zSWV+
	4muo2uhcjzR136DjUQbJ86Ps+2LLtdh0PAgnJoZnHy+/Pv1k1TLaRd8zUX8ye+Xf1rAqP4wO5C5
	13CHxYdMJ2i6jpJtErJ/arqFN+TNA4Pg=
X-Gm-Gg: AR+sD123hLbUoWzDEzQtabvIlZnBZpyy2Ph7a60cBsy7VVIs8K1+aL3mF0cBv2mBu70
	/fMgwb7yU52QYA3YwolcvaP9HYr3MtMrR970OB05/QFAZVO3SqVSusq/FXKST5zpwP7qoVpqsZz
	TTA/PX1Okygpxfw5xY1WiPaySkrvzd2oT0DlFgb4q1TL3l0O1FIHay9AyypzECvTDvXEEfQ/ORp
	OQt1rkLdksPezVH9JRSnNpKO6zVABUevOURXUB9ME9V7PcWLOYGE8xYP9Oup6ZDfbeAN7AC/9ZW
	yomhxuxQ9CgLSLUFmtnGkZ10gTyNkcH9D+GTTliKOSeYONI=
X-Received: by 2002:a05:6402:449a:b0:697:de29:c802 with SMTP id
 4fb4d7f45d1cf-6a0a7ccb364mr2898579a12.18.1785610937994; Sat, 01 Aug 2026
 12:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034358.68714-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <CAOQ4uxiEzP2e=cRw-AiGxtSv6WMSA5yR3cmgrF97s7ggU6wzqg@mail.gmail.com>
 <CAJfpegt9PwHksYhsQZeCsW0eooXVVihyieTpeHMmC-+Pq8BWaw@mail.gmail.com>
 <CAOQ4uxhuivjMMt_Dm3VwKmOhHg7ZHdAww6j6jp+RMjPoRde+bA@mail.gmail.com>
 <CAJnrk1Yat+SEr=SmZXwUt9y2WcC0VEC4KUpPrkrRSjMEmx42WQ@mail.gmail.com>
 <CAJfpegtnja6tkOnNPD2WZxu14Dd+UM9AvynsVB_E268iSXLbkQ@mail.gmail.com>
 <CAJnrk1a9mR-6hFie3hfFRgWTkrhJMVx4j9e7WGnjTRFuX2iJOg@mail.gmail.com> <CAJnrk1aj4B-T14SMTZhst2XsjOkKWStUj_0cjwHswgYWWuaB4w@mail.gmail.com>
In-Reply-To: <CAJnrk1aj4B-T14SMTZhst2XsjOkKWStUj_0cjwHswgYWWuaB4w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 1 Aug 2026 21:02:06 +0200
X-Gm-Features: AUfX_mx0nmQgWA50AjJPZwCEcEACcDvMhxSi5YeCpVu2bWW7aLZWp00XQH36_Y0
Message-ID: <CAOQ4uxhop5bzpDxiqSdfHS8JyUASfAmpsmuhrpq7Ey28jATVsw@mail.gmail.com>
Subject: Re: [PATCH V11 0/9] famfs: port into fuse
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, John Groves <john@jagalactic.com>, 
	John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
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

On Thu, Jul 30, 2026 at 10:59=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Fri, Jul 24, 2026 at 1:23=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > As I understand it, the merge window for 7.3 closes at the end of
> > August. Just to summarize, the only things needed to get this into 7.3
> > (besides addressing the Sashiko comments) are:
> > a) replace FUSE_GET_FMAP with FUSE_NOTIFY_EXTENT_MAP (will also be
> > good for famfs in general, saves an extra context switch)
> > b) remove FUSE_DEV_IOC_DAXDEV_OPEN and reuse existing
> > FUSE_DEV_IOC_BACKING_OPEN (logic for this already supplied in Miklos's
> > patch in [1])
> > c) remove "config FUSE_FAMFS_DAX"
> > d) remove FUSE_DAX_FMAP capability (not 100% sure about this, but
> > since the only thing added to the uapi is a new notif type, seems fine
> > to exclude this cap flag)
> >

FWIW I'd rather keep the explicit negotiation flag and make it mutually
exclusive with FUSE_PASSTHROUGH (anything else)?

This will allow us reuse of fuse_passthrough infrastructure with less
concern about mixing the two use cases, which at this point seem
like two different use cases.

Thanks,
Amir.
