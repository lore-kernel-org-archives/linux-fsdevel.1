Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803103;
	b=jcyjQGGXdP6PIS580DY9N43Agnxox/TF08JOg1nUI56hMX7+ozBiwIbq2Wf1I9cmp4WZ
	 3gKQhzzRTR1OLHxeg4EXz64fEHwIc46Zh0byCDyrvKSJEGp1cK/yS6i10oDkRNwTtZ9/J
	 dLaPuwz92m0541igbHDWcvJ649sNI5aKXPdlYQaKExb/qQAM8TuWrUSryHtJpb9xod6vy
	 1ivs0oWccbl0x7pl888nb4+0jR/ocB+yUwExmfTv1TFfDkseGxI5BzwhEgUY08P/qx235
	 hV7Q7Oa5PMJCqnWiedZliByEly4aLDI8Un2ZOjoJzOWyk2+KH8wIVWBG5IAQf7+LMHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803103;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TQh3NLauPY1iVVeXcuDFWHu+HqpyEZbU2yQkADbmaQs=;
	b=j/hkYlePVIIhGTmr3FWb/mB9aaHSRbQAHt0ZperJ70USetEKn9OWOKQZfiXHFlJJ9y/3
	 OilZXwW2PyZsUrh9VroRj+1SR36DqHhT7Y4zTgdtp7FsWSQjLeUl9lrbX+MLiS+NizyN3
	 zQzSCNGbf2I3e4IG4n7qW8F+VwtBsEsWT1rpA8bZuK3fWrHtdPG6VbyaxS8Dv5dc+0ofk
	 6K+IzZrxWVJpS7FKi+JpKZ/YjM/MeiCXP5bZk3e90JX6kCo0pSRaMx4j0dq3crdX4zwWP
	 iWrg/bZaVUIpMsVPe9wnBmsjGHxoRQyT+UDUl2NFvqIBZPJ25uBz2ouP2fYY+gQIKSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfKhKgVm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D3606A326
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfKhKgVm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A591F00A1A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793803102;
	bh=TQh3NLauPY1iVVeXcuDFWHu+HqpyEZbU2yQkADbmaQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VfKhKgVmXvQe2VRewqtDFVT3Z/6Dtd7+1cJreS9lRzXIAAkUnc5H2oJX9ssBZK3JX
	 AWPrnhiuzCSj2FTM/6tRlbNTnvjd7y7nZk77uv5TZ86dFsccq+SB+0JJ4F2eY+C16m
	 865v3OcqqLlGqjthBx7950hiNAYoevx/W/cNhXABD4mdfKS7S0OZhjove/5ihzff+J
	 lhtnksdv0u6LFEafggI/Hmjhpnhph3fBWr4sZL3vCclpGarIsZjOzUZ/PCXSo1TFGy
	 eva9+D6vDYz2OLgmNcF8TdV3pfHlUPo4GtfA6bjoSj5igS0XuaKDsGjLeuf98FzbyZ
	 0NYLenDuMIn6w==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcb1f1358aso579324e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 06:38:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx3vj55q37GyNcaW3HKv4ljJ0r6H698ycnQcctHe9krNqRUpFedZiO/8Fovk/Xb1B5aOd2hAl5BFEUWOoXq@vger.kernel.org
X-Gm-Message-State: APuU4Z9AriZGSrdlpCjbytoXagpOOsFN9LTmCDRm/HnFhOqZb6kbS8bs
	hSwyJ468tcicStF2G5NHpa+m2yTD4DC2zYcHsa92WSoECsrWhM/lsJ8FHwZofBfTagg25JikVX1
	8SvatuPaDDAQpd4/O/iFVdKwb2xn8vo4=
X-Received: by 2002:a05:6512:6193:b0:5bf:bf86:d01a with SMTP id
 2adb3069b0e04-5bfd9562e8amr5915003e87.17.1793803100471; Wed, 04 Nov 2026
 06:38:20 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793715774.git.krystianmkaniewski@gmail.com> <417c773d1719006cc85a3468dc393f5e754bf855.1793715774.git.krystianmkaniewski@gmail.com>
In-Reply-To: <417c773d1719006cc85a3468dc393f5e754bf855.1793715774.git.krystianmkaniewski@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 4 Nov 2026 15:38:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j-WY=nwVvq6Ck7kDLZ_E6jXGsQHohB5uZtT3uSQ0-6Ng@mail.gmail.com>
X-Gm-Features: AclHuK9myr72rVuqTOxZAZX_zcmWDtmvlF6GR5rcMcUu0FZVOtDo1SpAWRGZnAQ
Message-ID: <CAJZ5v0j-WY=nwVvq6Ck7kDLZ_E6jXGsQHohB5uZtT3uSQ0-6Ng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PM: hibernate: refuse splice on /sys/power/resume
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ian Kent <raven@themaw.net>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, autofs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 3:57=E2=80=AFPM Krystian Kaniewski
<krystianmkaniewski@gmail.com> wrote:
>
> resume_store() passes the written string to lookup_bdev() before it
> tries to parse it as a device number, so the string is resolved as a
> path relative to the current directory of the writer. The syzbot
> reproducer writes a relative name from the root of an indirect autofs
> mount. Autofs writes a mount request to its daemon pipe while kernfs
> holds of->mutex. Together with a splice into a writable kernfs file,
> which takes of->mutex inside a pipe mutex, lockdep reports
>
>   Chain exists of:
>     &pipe->mutex --> &of->mutex --> &sbi->pipe_mutex
>
> A splice from the daemon pipe into /sys/power/resume deadlocks when
> the written path triggers a mount request. Mark the attribute with
> SYSFS_LOOKUP so that its writable opens refuse splice and use lockdep
> classes of their own. Plain read() and write() keep their behavior, and
> read-only opens retain splice support.
>
> Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resum=
e_store")
> Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D002fb7b2d0bc53bf7e75
> Suggested-by: Tejun Heo <tj@kernel.org>
> Link: https://lore.kernel.org/r/ec0c2add83f18d7a3c726d5d219dfe42@kernel.o=
rg
> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

and I'm expecting this to be routed along with the first patch in the serie=
s.

Thanks!

> ---
> v2:
> - New patch. Together with patch 1, this replaces the v1 autofs change.
>
>  kernel/power/hibernate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index e365e440cd5299..9dc5a27f674fa0 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1316,7 +1316,8 @@ static ssize_t resume_store(struct kobject *kobj, s=
truct kobj_attribute *attr,
>         return n;
>  }
>
> -power_attr(resume);
> +static struct kobj_attribute resume_attr =3D
> +       __ATTR_LOOKUP(resume, 0644, resume_show, resume_store);
>
>  static ssize_t resume_offset_show(struct kobject *kobj,
>                                   struct kobj_attribute *attr, char *buf)
> --
> 2.53.0
>
