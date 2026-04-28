Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A0372661
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387164; cv=pass; b=i1+S2eER8lrc3TY+mgGr8Sg1pOq0VeC2CvQRAXgOnImmdnQQ3lLUB0nOHXLywARlMyJHuUz6wYDF+geF5PgFIF2cf8Zb6YcE0+Te5GWEZSXJTFHcOpv7aqxQYE/sRsMgepadDmBtIBf1HPO1v2JernLactcH3kyc1sy9VOFCRbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387164; c=relaxed/simple;
	bh=o5yp/O/UpJT2rk9hPW1wx6A8M3OZah1AeYGoao4WXUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpniL5tE7HDrNBqhjATJ4vzwr06TGlHtLjWigwYkAQ3xhGCIBXuxCJYANOFgL4Oa2Djb23gWR2iHheWD+w4r3kVJbIH7kHr6qmZLUlzlzyr6oWHYp+9sPoc4DTlwoInq0zs1kXoVFtQpWDTQLno3mAQJvma1P98zOpodG2Abwts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D08mcnP5; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D08mcnP5"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66e8cf72a93so14238859a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 07:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777387160; cv=none;
        d=google.com; s=arc-20240605;
        b=gRUh5mE1z/2eXB0jCUoKX0jDbbwk3exWBmR4/RHbsZmgyaOkWXPEVMoFWAUojJ1YuD
         ONz06FqfmiWY9bu7k4ZCCMdfR9DPYXVVXtzfmdYNWBNEktvDPig7V1vwGy+hirONzN07
         5clgaH1YqVYqQfY51BC8GzNKmIb6iBtL/kVvIrkazbbPun/qqmbXp+luiOmQVE8X66pw
         ysJ6lCMAmuaHlFffWWbCzLsZpkMyMpQKheuYwzdrZo7EyWEbPbIumG6UE6DvG/tlfx/a
         GpJ1E9vKlROniJtvwTs4cKVVdg263AnbWCnO1A3poAAuM76ifd3CAjgdPa0v7T+RZw70
         uGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PN1B9vhJycrgbEH0DOyhYXb0qxN2cniV/ZcL9J2GD5k=;
        fh=UEIXpA1d6iwKWkd1z50aB1fIUmrNDMowBcle4wb4sKk=;
        b=K8eMLpMWKfw3vKV0dIJWy842qPxPwfoyGr+eRTATbmO+8M8cPMJVEI9TDrOZ6QZtkG
         +8rerXZzInu/l9fgJjkOq31V3XZOPsFIBtNznYnYFMUwZAinasDXwRlC5qt6ZUqQ5odZ
         BtC5E7Wre/8FjBbd6Kf4ZlFbTZFEM1RYNxcBhmz7DWQPiibCQEQyrQWzc6uBzCh+mFox
         0+tv6NtGOub8eZnZlZf8IMaOs8KVS55kvNneNX8bKQyakxj0Yo9aMjmFq0RFy1rpV1yK
         mqaoRUEGCsL5pkCcFbFUH7jJiY0MRfZIBBAmdJR9o92VYVDM6sAfoLv67hWstCSeG36w
         6BeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777387160; x=1777991960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN1B9vhJycrgbEH0DOyhYXb0qxN2cniV/ZcL9J2GD5k=;
        b=D08mcnP5szl+13rSRXOE9LH8Qc4jOlJdFOrsL3d5rSmnIWRl2EQMMdhsnQ0VzTI/p3
         z4PFNZ5PWDzow9X4xtOVmJ7h8xY0taALshxRAZgUAXxUnrPyzwznZnbvd4s6vw1ZMM6b
         RPW49w0al36ig6M48MBi5BStjBbzdVz7aZgP68JqJLlhU9A5sfGD94dDZQ16MYRL3CKV
         95i3ALKLBMRxxh6+2mNY5OVwSQJM21tiKp8PbiGWcwtHYZFekNFUYDVwlMVtnBTsYye3
         8C5raITCLyi1C17H3EmKSreZP8jOcMvv55fRU1wY4BkTUxCjWwFtpyEZr7Xky/75i36C
         ZUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777387160; x=1777991960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PN1B9vhJycrgbEH0DOyhYXb0qxN2cniV/ZcL9J2GD5k=;
        b=AOPXu29oMuqM3dm1m9jGVbxhepDn2XA2YDu+GQNvLyMMKzb27Qr9YpH5lUtaoSN70b
         IIL+qy8eswZ/ni0lIvZg/vYZQ1WEgQeE9ZFVxVgvLQ0fEGVdFOdYkysPvr9xn9HdekjO
         hkc1aCDVqZ5Gc+evXcvYqgtLO3kvmrXzL5AtSfPizBqZem1Ih/r89yuACLFOIq/bhwLQ
         rsmuJEsEOR6/CZanrvFFmeYCF+ize58tM+UnghhiyTD7ircny2cpfjEGs67Rydjq6EsE
         USU1/jXuVymyeAw/VUj09fdbDKUyQ7ybkHm4NnhVXBKcefpwVZ3CkhQVm7CQbhVxigWU
         16NA==
X-Forwarded-Encrypted: i=1; AFNElJ8unvmHdjnozJbbeaA7sEJCVmsiUazV8tbmm06X9wYKbSpCDeVQiyaEv4xLre/gmSKbbxfYIdpZ+vGSOQPF@vger.kernel.org
X-Gm-Message-State: AOJu0YzV+9AK9stEGPik5ANjn2bervtTQpsfmMud/06rDBsSxeHaZ7hA
	CaC/YlQ2Mg01PPTjC7RHASqORNs2IanPSJYyno2iNC1fIW5f2UHpSdmAjdbubW/2U3X/2rVWFUA
	XbSKA6Fx8HIrHC8Wch91aGzBUS04pYhg=
X-Gm-Gg: AeBDieuHMIM4aKESqg+LhivAY0MIErtSUvQYUSECYXcwlpSJfZmsQnOu6z/7gtsfLzW
	K7kbTGZio6+MNuBhO2FHTie/HSlmF77DgfimlENgIyQnG2VDhKv4rShPDl4MYMOcBFkqw1A0bWI
	0oFjSB3bh8K0xap3rNfawGjjqklXXBZFaX9uU7pbq27SL0zAL7TleE/R373B7vRO/DGU07AL32F
	IA6FOqpY0NrDDDKko+oowVswfdeLgfPtpuSNC5nlXFfFNVxizhx+mphByzD4F/zQCb+d4lWejGG
	fLfQP2+bbCi4t5Yitaq6CmQVl84IlAe4AfWEfrbhOlRboeGwPal/XXc46cGC
X-Received: by 2002:a05:6402:501c:b0:672:bc73:a124 with SMTP id
 4fb4d7f45d1cf-679bb092fdbmr1761172a12.24.1777387159785; Tue, 28 Apr 2026
 07:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl> <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <5xexygc3rvvlir4smdfn7gndwjgbuijqfummwwumivsnosijux@ygqs3iqxmovh>
 <20260427-rudel-gipsabdruck-a7884db4ecea@brauner> <CAGudoHFLSHhDZoC6maLsn234dMQVnG4ZbpKXoVrueGujArNF-A@mail.gmail.com>
 <20260428-zoodirektor-latten-e412db97141d@brauner>
In-Reply-To: <20260428-zoodirektor-latten-e412db97141d@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 28 Apr 2026 16:39:06 +0200
X-Gm-Features: AVHnY4Ja3pLpw7UMkXw0oBF-9fgYduWvYEChf9BQ65RTEdqUwZXM4GrqcMzSxBY
Message-ID: <CAGudoHHMG2Arne=B1XnJmSesfUH4se5eEQ2Lsc0FRmCxr3AECw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns an
 O_DIRECTORY fd
To: Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, cmirabil@redhat.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 10:55=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, Apr 27, 2026 at 06:30:42PM +0200, Mateusz Guzik wrote:
> > On Mon, Apr 27, 2026 at 5:14=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > > Things proceed to handle_truncate:
> > > >       int error =3D get_write_access(inode);
> > > >       if (error)
> > > >               return error;
> > > >
> > > >       error =3D security_file_truncate(filp);
> > > >       if (!error) {
> > > >               error =3D do_truncate(idmap, path->dentry, 0,
> > > >                                   ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
> > > >                                   filp);
> > > >       }
> > > >
> > > > I'm going to ignore the LSM situation and do_truncate failure modes=
 in this one.
> > > >
> > > > AFAICS nothing prevents the same user from racing against file crea=
tion to
> > > > execve it, which starts with exe_file_deny_write_access. Should the
> > > > other thread win the race, get_write_access will fail and the WARN_=
ON
> > > > splat will be generated. That is definitely a problem.
> > >
> > > That can't happen:
> > >
> > > static inline int get_write_access(struct inode *inode)
> > > {
> > >         return atomic_inc_unless_negative(&inode->i_writecount) ? 0 :=
 -ETXTBSY;
> > > }
> > >
> > > and the check is:
> > >
> > > error =3D handle_truncate(idmap, file);
> > > if (unlikely(error > 0)) {
> > >
> > > This was a catch all for broken LSM hook or ->open() instance.
> > >
> >
> > So with this prog:
> > #include <fcntl.h>
> >
> > int main(void)
> > {
> >     open("test", O_TRUNC);
> > }
> >
> > I verified writecount is 0 on entry to handle_truncate like so:
> >
> > bpftrace -e 'kprobe:security_file_truncate { @[comm, (int64)((struct
> > file *)arg0)->f_path.dentry->d_inode->i_writecount.counter] =3D count()=
;
> > }'
> >
> > @[a.out, 1]: 1
> >
> > i.e., get_write_access in handle_truncate transitioned the count 0 -> 1
> >
> > but then what prevents the following race:
> >
> > CPU0                    CPU1
> > open("test")            execve("test")
> >   handle_truncate         do_open_execat
> >                             exe_file_deny_write_access # should
> > succeed as count is 0?
> >   get_write_access # should fail as the count is now -1?
>
> I'm not arguing that get_write_access() cannot fail. I'm arguing that it
> cannot hit that WARN_ON() as you said above because get_write_access()
> returns either 0 or -ETXTBUSY.

ops, right:
  4681         =E2=94=82       error =3D handle_truncate(idmap, file);
  4682         if (unlikely(error > 0)) {
  4683                 WARN_ON(1);
  4684                 error =3D -EINVAL;
  4685         }

I mentally had it warn on any error.
