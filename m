Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3348A2836BE
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245421; cv=pass; b=lgjHBg2inqF4eup0Obwz3WmkGuZwSoeTNxXC+SEneVeGTQdde8pz/TvQi/mE70DI/ExFOfJ0lKY/9pS16ufeq9ZwldlCM4sLs7yWoYa8KgOgbg2tzUfP6hkA6/wRi+UL7Y75kbB5mVaSfDOgsHsD3diRBjFEAfyjBy3tr/yjC4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245421; c=relaxed/simple;
	bh=RINC3OxukObTWwNgLj8cUCMQfmLKMyUKoc5ifoxu7lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVYMLbO3gWWGwppInvz/Nllv14dpX5jdr77YGk1VtT7cy5wphKwvs93hafdYo9Q/NtbEpJNjgVHu5Cqapg23nZiEIPv37nVDakR4LTJEzEUYelYhTLEq2nfJlwGzEgfB/TS+ZBi3qOTeaPvfGPUxzaQjA2qRFwGp2BBcYI48aTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=DQI1cRxa; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="DQI1cRxa"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a1330ac6c3so131077e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 09:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773245418; cv=none;
        d=google.com; s=arc-20240605;
        b=eEfjeEq1cIhg4VR5OBSoUpf7oTz8t4j6ev+26SQoPDms70WTDCjtBSwuTEvRUGfy0x
         HBJ3k8YkDdkJndJ5RYxozXtuVwf44vNfixF7tRJ9k6j+VSk9Kv/CFXq5mBYyMYSlqasQ
         uR4dMK8qHV4WyG5FJlJpPyN0uoVXvW7YfKelsEFeprzNHo37mz/Ut/CnGwqdBqz5ZacZ
         O904a5rgeJM3LL/WY/K8a8odAemIc6W/gBg2jUuAnIoYakntZFdGeiGVhX9s6NhvEnYj
         ubJomY23m1P9HUW6Tflof48D3DOUvnCuDH51sJh3B7sL/gET7g2Yeg0mZC0wmuL8YiM9
         nwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQf3bqKM0prJaYagyzgzwBy7UALOn5Wa6w4qvhYX8FU=;
        fh=Ru6d8ZHzbJ+4iL5irZLgrwhGvuJZlMPM85SMprRLJfc=;
        b=MFDX+eJQb53gv5ucNQrEVzliyMhJRqvBcxQbJj5DvMtQVgkrZO2T3P7Db8RqlGVzVQ
         Lh2WPNhDNi50Eda4hBeMDuv+2CJ8xeywPlx1n0afHfamwgWF0lwuL7xqVp6deUhP140X
         N2ejnyNk6pYv3Hz9duDk4hykAXfVAChfPzp+YC9h5zbskuJh0IHwifv60+BpTcCS81K2
         D+1HWg1vWo7g8RqLOWGfKgqBY0iHhiHDsbf812I/0FDhNJP9lVJsFrng9s8n0G9b08D7
         FszPNnKyWujxl149WFcwPUAiHasz8U1Ia1jyp+hZ0utnluP92FQytkLg3QoM02rQOJSP
         ufew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1773245418; x=1773850218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQf3bqKM0prJaYagyzgzwBy7UALOn5Wa6w4qvhYX8FU=;
        b=DQI1cRxaYaxsZCMcyoPsKK9oceAAMF2Z/4ka0wFpZB8+XmCfMpWDiiF7wWVvKTnenh
         fLiq0/4041WV6SUN9UIAUOBG/CMSj6vFuAOInXJ4NveJurk01cGbF8fRy51alCQzW54O
         UmWAXgDLBXidwZi/zen/FyMiT4+9QZH++ETKQNT+c0cTD2imeB9je4SnL8TKcC48glED
         ooRh8mXUApVARqvWJDY7zkjpZo16/2+cEhSB1AU7m2IZ8+56OmAYPqCj9CJqISqpRtn0
         +Gzbol7v857u1b5Km8cgfWLXwWaOdvanog3a0ycMGHtle6ytBjRh/50KWHHrh5a7Q75q
         +ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245418; x=1773850218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zQf3bqKM0prJaYagyzgzwBy7UALOn5Wa6w4qvhYX8FU=;
        b=oDMZTbU5Is7HBIYjGACaO1W6T4Xw++M2fh7EquYO6Kdad7mTKe6faUwJCzPxjfL5w+
         X8GXMfOlFAV6GgswRMW+8LJmYe6oGx1/lXdFrHWEAaE4OUvQbIsxdmqoG1e/UmPB0hPY
         oIAogqZOphFIwgPoWzjGvwmp5HjOS2OPggWbmtoB/L1Fu3h3HjDu4U8+wOUFPB/hAt8J
         DJE2pnXgS4vhYFColq2HAl9rWXF+H8jSm9GYjDiVtjo2pjBZpW75cNLJVRKwqX0M+Gd7
         yIbQ6ehllrvy2WjKxOeBcVmXDMYGNq03mUFVCFib1QOn1jfzcTqcyX38RwD4PWGKmVzA
         clVg==
X-Forwarded-Encrypted: i=1; AJvYcCVCb2f7ddGjmRPzpr0SUiWpLAIri1dDuksOneMKZSxxEnOxOEkfSEPX8SwU9e3+Y+QzjWrjM2hR6oJwctRt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5uSEQMwq4DxzDamowqa1KebRZ4qVJ9yqzd3hSiP5V61mpulE
	5VvZwM5pUjT0/DT7YEIV7XGEiM5CAB1B2qVlqudvMRBSYrnkm4jCGnf5TZ/yog7rvgib8CWHDaM
	OVoBodk3rUlf/eN6uYR9MwvATWnHTWh6hz4RL2CLY
X-Gm-Gg: ATEYQzy1LN0JlIRJhZvgwmgYhOsSgtwMHTNbElGKg9flSTY/w9dRl/fZ4/p3zEFwDQu
	Q3OdfRLxKb8YG14LtSqUeMIFn04fQAiXyr/asy/48TV3Pdb+MKVeYzIw1NzzJ2I9Y9IcmjAjmgE
	o4PiFEW7uWV53OR4S0/1VbD4dz6Wy7naDX+SlLdchrkmazDfcHn6joN7eaKdAMBtWj0qAjlYI6c
	zB+nMZgrdoedbU0huNieGUkzysSwgEMcq3EhaK1yrizwC+IfincHD/LU37INEutcvfazFshuWpJ
	v3/2
X-Received: by 2002:a05:6512:712:b0:5a1:4835:306f with SMTP id
 2adb3069b0e04-5a156baf0a8mr762062e87.19.1773245418128; Wed, 11 Mar 2026
 09:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
 <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
 <20260309-umsturz-herfallen-067eb2df7ec2@brauner> <2026-03-11-regular-sore-census-shops-DqYcUT@cyphar.com>
In-Reply-To: <2026-03-11-regular-sore-census-shops-DqYcUT@cyphar.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 11 Mar 2026 09:10:05 -0700
X-Gm-Features: AaiRm51EXHFpn1BAVpxsTY5E2VQC7PD0Lwp6wdRjddj9MKMq4N9OfHTiuPJrR94
Message-ID: <CALCETrVMF3VBr0cuEYOg-M_u+hX77Jfdujv3ZMtLGCzHgOcsGA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:49=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2026-03-09, Christian Brauner <brauner@kernel.org> wrote:
> > > > On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > > > > I think this needs more clarification as to what "regular" means,
> > > > > since S_IFREG may not be sufficient.  The UAPI group page says:
> > > > >
> > > > > Use-Case: this would be very useful to write secure programs that=
 want
> > > > > to avoid being tricked into opening device nodes with special
> > > > > semantics while thinking they operate on regular files. This is
> > > > > particularly relevant as many device nodes (or even FIFOs) come w=
ith
> > > > > blocking I/O (or even blocking open()!) by default, which is not
> > > > > expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk=
 I/O. Consider
> > > > > implementation of a naive web browser which is pointed to
> > > > > file://dev/zero, not expecting an endless amount of data to read.
> > > > >
> > > > > What about procfs?  What about sysfs?  What about /proc/self/fd/1=
7
> > > > > where that fd is a memfd?  What about files backed by non-"fast" =
disk
> > > > > I/O like something on a flaky USB stick or a network mount or FUS=
E?
> > > > >
> > > > > Are we concerned about blocking open?  (open blocks as a matter o=
f
> > > > > course.)  Are we concerned about open having strange side effects=
?
> > > > > Are we concerned about write having strange side effects?  Are we
> > > > > concerned about cases where opening the file as root results in
> > > > > elevated privilege beyond merely gaining the ability to write to =
that
> > > > > specific path on an ordinary filesystem?
> >
> > I think this is opening up a barrage of question that I'm not sure are
> > all that useful. The ability to only open regular file isn't intended t=
o
> > defend against hung FUSE or NFS servers or other random Linux
> > special-sauce murder-suicide file descriptor traps. For a lot of those
> > we have O_PATH which can easily function with the new extension. A lot
> > of the other special-sauce files (most anonymous inode fds) cannot even
> > be reopened via e.g., /proc.
>
> Indeed, I see OPENAT2_REGULAR as a way of optimising the tedious checks
> that userspace does using O_PATH+/proc/self/fd/$n re-opening when
> dealing with regular files.

Can you give a brief decription or a link to what these checks are and
what problem they solve?

--Andy
