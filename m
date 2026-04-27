Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8983CD8AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307461; cv=pass; b=FJCBBH+eX3nhOAK2BpMZGvcMy3hcDcABhudCfwtP2w5lpNw1h1J5kRZsVdzuVXWMLgEid+ZvrdcmPpmcnddgGk+Kx2O5ZaX1EuBoHECIU7GaHVo/i6hnoF7pBgyNlo6czdNlYnZzW5u8CRs5fOpO5K9HEMOU8xVXlVfpPEcjysM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307461; c=relaxed/simple;
	bh=idvner3mgft23dklNp8J4rH+ZI4P2VAwnJOBXPrMcrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krdJwDXM4FFlfUZWb9urLmMR2fWeDrnJ9A/HHcoCuDpW8Sc7KO8/c6oikAFXLz/hDCGeDMgWpttdXYd7B6Qd+P8kCmYWCrCiPcSlB51Sw0Sp4vj0K+mtv8Dwr6KfcCFUhE2JPFxLaWuASAEKLStkXonI9Qac/ufwQyfsJQqkvgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLUXXzdF; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLUXXzdF"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ba67b332bbaso1221150866b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 09:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777307455; cv=none;
        d=google.com; s=arc-20240605;
        b=JQhonI0CibnCc5BdFIEBB0YVR9fA0536oyZZHp/T/MdNZcAmE5CZCtUzHqxsPWus96
         D4I+ZlU5LSoDtfmIejqH+NichRMUaaBRUin3KqpJpIvQfXyOAp3NsHAY9XVlFLu7qz2K
         DyeDjpWUCeR7kMX0AZFTSlWq7qZDP3EWxs2T7oAXc3d02AmEWj5dPyphVRknhUevQohr
         khO5N7yYHqm1/N+4S23tXmRGE96IzdcIl95zI7b4h7qbLPZ/gDKhDDFViUinHi6fU0K6
         wXXQHblsGI5r9Zlbpw5Z1xZkE6lGfmd+2BNMisHnBDDwtQqhPw7t6HxZEnsWQtPVkOqN
         MUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B7Z/bR7l35cxDwn9+LDbQum27vsLynWJhwJbt8jzAnU=;
        fh=YnWKQYPeU4UCKPQCPj6MTwMDnYARn2MKYZLd4FSjnNw=;
        b=F7uSAalfxkaMRwydi3BN/KduIJjV6zWGVMWaTuCLhKkbed6GGBxWpSSBnmxANSpdCk
         BZJXofK5m9IC/A1nvpKxbNRtWzmBhho0zStt/2gt/141EcBtzwMAb0paMoV+QsdB8x69
         as98N958tBwYHC67HAvzktieT2jssne4H92S5fpmViqYRtqx2xYziiN/1Irc9MWOZEZu
         0Vf9ZR9koz1c8mPGg47C0QsjRtBYV2dN0AudQz6Oro9tUe3FmOS0gaFz3USY52yWeSkg
         BbqhKYU5wPNTXOgvIHrFIJNypaikTgfXJ8VjMt8IiGJEMgPoz7hv/rvC5Q6gBRC+H78S
         9SfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777307455; x=1777912255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7Z/bR7l35cxDwn9+LDbQum27vsLynWJhwJbt8jzAnU=;
        b=eLUXXzdF+kXYoyBc8nSDmCGGAz/1e0/zuWoSv5U3a1szoR5/g7LPlWio54onwM2f8y
         /8/tfR/sYCe8SLelIiai1EG5uW5dqol5GkS67zuvpg4pUSLy1GZpDgVKF2PlrzVmHTtK
         Y51i0ML2jdtNzC2eA/n8PcF/oH1X5FdbdqJEwlChduJbJXbDSDV0M3Ope5EchKkgPN41
         K785yoOePwIMaU9Y4v1u/mdZaL55zPAfLu0oQTHNO1nrB1OKKGUD+NamK0YWeAN22B42
         jgbE46KOamulWpQfg62tdVOuYSUVuJb/SiK0N3Oyo+s0MYwSchOdV6UihKPkMb5VUJ3q
         p8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777307455; x=1777912255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B7Z/bR7l35cxDwn9+LDbQum27vsLynWJhwJbt8jzAnU=;
        b=VrDQZiRgU8O9efycgEwIDwXveTclSbVk7Q7Oh3EGr1TWRoq1HwUjnU8NZJVnyitR6N
         GU9onaUNRJk3ZwrjoUlXbmbhvi79H5x8E8dlmux0N15kCARi+Hx2RdI3iBOUMLg5uaXH
         bcfE4WFJg1XO5wyu03f0C82GJ6rF2b32s7Wtd5bKaN8lginD+cPFp6bcfr7njGKJFEa2
         7C4kojuro7R4I8tAy7ExKSzno7aZ2uPQPJaq3B+aUkbFYMtNpYjnk5YNsREHrcGZMMGO
         8QUm+jJP+0GhDf08/N+1c1F3x53iDZ6bCCO3oVS6JdDIrWN8vTynfxw2gGD6W3EMiF3Q
         J6lQ==
X-Forwarded-Encrypted: i=1; AFNElJ9D4Li5SfaspeHGqI6uVbLcPkxsksOcb5iUoXdGhy8VHWVxEL+oIxK9MdHi4K3KxqMUyu84mv6epV4mO+Xf@vger.kernel.org
X-Gm-Message-State: AOJu0YxKZN0EtvhZ7oXUnygKP9lv7goiFUju5UMu1g4ydgtp4wan7VK+
	sgpGegumgii7Qd8DnB5pR8UjDz/N+L5lqaVi72+H//qZ91ZJ7//TqujZBdmlkuWQomD3hnwardY
	6OlvFfAt0yoHA2eBIjpW0HUfnr1MCwc8=
X-Gm-Gg: AeBDiet8uQd66Ny5JrgkQkeqh+u493ruLMtKNpJAw5WcHJ6oxLWAUcAYI3egO7CqoWB
	cW+FEPAHFxlneUFTeaVQBBv3Q2mdmllTGIXjxAvfZdfzhU6p4wjjC0SwKnvAxDooKCSCRx2n5nA
	DgduwFeCPNddNnAgW4vCYvKklDJu1RPhCWg9Uzh32NSz4yVboVwbqZhrRpIcaje6ouZtVd+chkt
	lRxfwhzVkIShUBZuAGJ+7K/8H3exg2r9OX5nmDFXK/cJhIvPZnk0FhH1te2c3VEKWSpcPGyyOaj
	I5eGaLriGN7etL6gd7tEoNmcrr8dSIqD36srRaVtnRR6Jk4X6z+TyByyS2iF
X-Received: by 2002:a17:906:8e15:b0:b9c:4fa:9141 with SMTP id
 a640c23a62f3a-ba419077377mr2070161466b.9.1777307454882; Mon, 27 Apr 2026
 09:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl> <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <5xexygc3rvvlir4smdfn7gndwjgbuijqfummwwumivsnosijux@ygqs3iqxmovh> <20260427-rudel-gipsabdruck-a7884db4ecea@brauner>
In-Reply-To: <20260427-rudel-gipsabdruck-a7884db4ecea@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 27 Apr 2026 18:30:42 +0200
X-Gm-Features: AVHnY4ISYjfmOuhoMK9ONLGmIrCNFHHU0Ih5PKAcLvuNRoFbTb0DP2K6JgsHNoI
Message-ID: <CAGudoHFLSHhDZoC6maLsn234dMQVnG4ZbpKXoVrueGujArNF-A@mail.gmail.com>
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

On Mon, Apr 27, 2026 at 5:14=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > Things proceed to handle_truncate:
> >       int error =3D get_write_access(inode);
> >       if (error)
> >               return error;
> >
> >       error =3D security_file_truncate(filp);
> >       if (!error) {
> >               error =3D do_truncate(idmap, path->dentry, 0,
> >                                   ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
> >                                   filp);
> >       }
> >
> > I'm going to ignore the LSM situation and do_truncate failure modes in =
this one.
> >
> > AFAICS nothing prevents the same user from racing against file creation=
 to
> > execve it, which starts with exe_file_deny_write_access. Should the
> > other thread win the race, get_write_access will fail and the WARN_ON
> > splat will be generated. That is definitely a problem.
>
> That can't happen:
>
> static inline int get_write_access(struct inode *inode)
> {
>         return atomic_inc_unless_negative(&inode->i_writecount) ? 0 : -ET=
XTBSY;
> }
>
> and the check is:
>
> error =3D handle_truncate(idmap, file);
> if (unlikely(error > 0)) {
>
> This was a catch all for broken LSM hook or ->open() instance.
>

So with this prog:
#include <fcntl.h>

int main(void)
{
    open("test", O_TRUNC);
}

I verified writecount is 0 on entry to handle_truncate like so:

bpftrace -e 'kprobe:security_file_truncate { @[comm, (int64)((struct
file *)arg0)->f_path.dentry->d_inode->i_writecount.counter] =3D count();
}'

@[a.out, 1]: 1

i.e., get_write_access in handle_truncate transitioned the count 0 -> 1

but then what prevents the following race:

CPU0                    CPU1
open("test")            execve("test")
  handle_truncate         do_open_execat
                            exe_file_deny_write_access # should
succeed as count is 0?
  get_write_access # should fail as the count is now -1?
