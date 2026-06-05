Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC53358AF
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647352; cv=pass; b=KhQsahBgO25sxIr3TYeGi2fpOHvsDm+QeIUOq+SNNwGEUAlNVntwgymYFzZm9LNJQ9mUIRDdaJBLC4glqqx7SgcDW2gv9YYXgl7pKeEnWrKo2jxrlefJIQ/GlSJffCDEjZbeEuJpHIQJOJK4HiOolSHKrl5xW/Z2MFH7e6ZEYaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647352; c=relaxed/simple;
	bh=Zir5YAuuO+uYmw4O6hfX9fjLtaG28Vwt81N/CJtHIck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hatXK2R0RZ1/D2oBfw4JcPyUcZtjTh81RmkYGPO6oFPfIHd2TigqNS1VE7ZLH71fsiimT10VuwDeyKwOJmn4ibZ+HWIfyyvq2obVYUbgY9aqUUgYpG/4xYD0vzZ6GDcE8kSgdk9prZdiS9emVhzCN04P9FE15PNkt7++G85U9O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsgJiKi6; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsgJiKi6"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45fd464d51fso904370f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 01:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780647349; cv=none;
        d=google.com; s=arc-20240605;
        b=i75UmJjFr+rthsFRlGbwhEEd6ocAjWZxfi4aewgTPPrj7UZMfd/hnPSIh+A5uRvwIL
         twbJnSG8TocI+X79VlLuU9NylabqTuADaD5VCU9/NzgyKQ5fA6QZDFyAv9cHcO1Rev0N
         pyvmLdE+B1XKo08s/MngHHJ6bM3XnD8zwjgpabT1uUFxw+/zUcPcQqrhKyEQjmZ14A+s
         AqyLQWpTdvCZq3DW9udK8pFjdjZSbaEdG5/UfAbyMdFNTg2L/K8BelLgtN88lf45+xu9
         SH9dZAeEpymM11ftStIawnJLFa8NRnZFEPFVy3mf/zoKWLhUXVELq41wlBOKG316NVHg
         noMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zir5YAuuO+uYmw4O6hfX9fjLtaG28Vwt81N/CJtHIck=;
        fh=apDqyZcJHECWscjtHf/yYFDtY0l90B9uPxQUOFTbUf0=;
        b=A8MSzQhoM8LxlUAKOjMnJ6eaFN6wLLUINSTwvlccbgW+KZsdBHXeLi9gq+qalutweY
         s1tVhwf/AO6rfkrCkSUh7YX9LPaaYVDww+25zWgV3j9J+r0SsuXBWn+UrvN524srM+i6
         uDnoRI4qohoUQeYkpbI7a+dsSSUAiY2sV3/ollvmuN1m/EsXhDupp2vvx5BSQ89eHgYD
         qeB5/dTl9rdhYMjHUX+giY7cTZLGZ+tM+RWFep2yg/eLpjcK3zkzKxTgl8t0Q9LYsYja
         7wu/p1aaU2hvWjDIPi2S3znMbU9+3KnqQ8dAs1XM6vdeIxbJoLlQ8G3Qd2vJCBdc3Z4Y
         p6OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780647349; x=1781252149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zir5YAuuO+uYmw4O6hfX9fjLtaG28Vwt81N/CJtHIck=;
        b=LsgJiKi61PVGbFGDrfnFKZHJOii5djIPEH/DZF0bprq/cOdSJ2viFzTmEDIe71z3cT
         drNnr5pxlYgCWJhYirahO4AQ0Rk0XTD/gx7rEJpivvabY65xRQx7ayKhPGmEfwOCFgvJ
         WJ7TZ8AelDAUfrd5wI7da0160xPoU6ghkJQTJLAMpGHYLgvldIoU4QfyLaLy6vQusgOm
         Yvgisyjnw1tGT7lMHX6CjltBp3NXmxVOKzTKAO0aTo3vmTxsqBW4cBK0W1N2/LRMx9Mg
         USsFWLyiwBfeIDH6S8aoDOQAipdqLrkEkGyvH/sS01HKAuAYfPT2znCMur4T8LGrWj+v
         KqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647349; x=1781252149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zir5YAuuO+uYmw4O6hfX9fjLtaG28Vwt81N/CJtHIck=;
        b=m00CJ2zkbHHbufQgh/CyBBicyRqL+x/YiVma5KtQGzJjWknjkUpID7ohQefQx5weSh
         t6zOhPgkyErso+WnJAE/oKqnZaDeI2btq1fcQS5G/vziOPJhFSRH8MnokOMyTTyEYQaY
         0ycKWpWtd2XgWwkNu1JqCc3n+62iSTbkoHEc7zitORMlS0l/nQkeeEgaD/0Llymf6tLp
         g360SqI/l/yVAZwGx6yoVxLYjdLOQMIfo85tSMFUW1FImxOsmVCh/xt1HahQjFovib8e
         se/jtLHrqT4RA5nmV6PAmyMQ3JffPXmgcUVRzCq9AW2oRgxpTXxlmnM0vDNVQjsQq8qd
         Js2g==
X-Forwarded-Encrypted: i=1; AFNElJ9eU5/Sz/RoaIQAgGRB5LDCwgEL8yeEheJLakXobZ08RbM+/6M2gVdDoqmH76ZGB7pYSiXfVSTA9AOCgplQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcXZ0YO2j1xClV0B3UpNixi3qH4foa3SOkI9cBDIyOZSOCnJp
	hBFiV5247nLrfeY4j1hUrS2Q9mXtfjNj6WiPFEVBFrTjoU3poXD1eeinQLOrFev+Rnog9IZwOwp
	txjYlkhbw2aD5itH/X8XLVxiO+9FGcqI=
X-Gm-Gg: Acq92OGymtDoI8nFXfJpI3YlgxLwL/jZ2Y5xjsbDtbAPfDkkCNl1Cf52/WSCkfq35f2
	OL3+i0/XPYE5A9fdBEyMRc3NXYDvY6VDi8dia8TZBVW43+eC138edWWeQT9if4ZyR+3COBdLfuV
	TEQbYgmJ06HQaQ3whtFlD2xA1xFUXDuA8LIgwlhqvwHBR7tDRqrI83bg0ZOQ9aD+qHv3jOJ6CKu
	n8P1MCtth3o98wGGN2HLyzPz/4Ta/tNO+DcH1HLVelrrSqstX2MRD6TAOtcTp8GLti4mMB3IG2o
	2w1YWPX5FeqzhKM8hTZnCtJSVgBJynNp5rO/GzjBB3rU61iX7a72
X-Received: by 2002:a5d:6610:0:b0:45e:fa38:c899 with SMTP id
 ffacd0b85a97d-460302dc4dbmr2898885f8f.4.1780647348563; Fri, 05 Jun 2026
 01:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603001516.26234-3-anonymemeow@gmail.com> <20260603031117.20950-1-anonymemeow@gmail.com>
 <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>
 <20260603-schindel-drehzahl-planlos-e334e6899cd5@brauner> <CAOQ4uxgEnD6aN4HTh14=SPzU25_2xOXxfnY+60udOqNp3nnm4w@mail.gmail.com>
 <20260603-mehrsprachig-altlasten-unverantwortlich-4fcd029306b0@brauner>
 <178060498710.12657.15047020114378440191.b4-reply@b4> <20260605-inwiefern-flugbereit-reintreten-9ff8d18b642d@brauner>
In-Reply-To: <20260605-inwiefern-flugbereit-reintreten-9ff8d18b642d@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Jun 2026 10:15:32 +0200
X-Gm-Features: AVVi8CcYAL9twdUvsr3GjUwGzb094bZkHk7hHlnJj3sKn8b_jY4tXxcqP32kJzo
Message-ID: <CAOQ4uxgQt8y-KfCrnbgnqsFYxE-7zzmaBYFTh03ZjfHqs2FRZA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fanotify: allow reporting pidfds for reaped tasks
To: Christian Brauner <brauner@kernel.org>
Cc: AnonymeMeow <anonymemeow@gmail.com>, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 9:54=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Jun 05, 2026 at 04:29:47AM +0800, AnonymeMeow wrote:
> > On 2026-06-03 13:25 +0200, Christian Brauner wrote:
> > > On Wed, Jun 03, 2026 at 12:58:09PM +0200, Amir Goldstein wrote:
> > > > On Wed, Jun 3, 2026 at 12:28=E2=80=AFPM Christian Brauner <brauner@=
kernel.org> wrote:
> > > > >
> > > > > On Wed, Jun 03, 2026 at 12:00:42PM +0200, Amir Goldstein wrote:
> > > > > > On Wed, Jun 3, 2026 at 5:11=E2=80=AFAM AnonymeMeow <anonymemeow=
@gmail.com> wrote:
> > > > > > >
> > > > > > > Sashiko said that pidfs_register_pid() can fail under memory =
pressure,
> > > > > > > since it allocates memory using GFP_KERNEL without a way to p=
ass in
> > > > > > > __GFP_NOFAIL. This can cause fanotify_alloc_event() to silent=
ly drop
> > > > > > > the event even when the group has an unlimited queue length.
> > > > > > >
> > > > > > > Should we make pidfs registration best-effort instead and sti=
ll return
> > > > > > > the allocated event if pidfs_register_pid() fails? But IMO th=
is will
> > > > > > > make the API semantically ambiguous. If the kernel guarantees=
 that the
> > > > > > > event pid is registered with pidfs when pidfd reporting is re=
quested,
> > > > > > > then a later FAN_NOPIDFD or -ESRCH can only be caused by the =
task being
> > > > > > > invisible within the reader's pid namespace. But if we allow =
best-effort
> > > > > > > registration, the event may still carry a pinned struct pid, =
but pidfs
> > > > > > > registration may have failed due to memory pressure. If users=
pace reads
> > > > > > > the event after the task has been reaped, it still gets a FAN=
_NOPIDFD
> > > > > > > or -ESRCH due to failed pidfs registration caused by memory p=
ressure,
> > > > > > > IMO this should be reported as a -ENOMEM instead of -ESRCH. B=
ut
> > > > > > > currently it seems we don't have a good way to register the p=
id with
> > > > > > > __GFP_NOFAIL or __GFP_RETRY_MAYFAIL, so what would be the pre=
ferred
> > > > > > > approach to handle this situation?
> > > > > >
> > > > > > Thanks for noticing the oddity and explaining the options.
> > > > > >
> > > > > > We could fail the event in case on ENOMEM because the system
> > > > > > is likely is a bad shape anyway and other events are likely to =
fail
> > > > > > allocation themselves, so I am not objecting to your patch as i=
s,
> > > > > >
> > > > > > but I am slightly leaning towards the semantically ambiguous AP=
I.
> > > > >
> > > > > As usual, I think a semantically ambiguous api should be avoided.
> > > > >
> > > > > > I don't think that we are going to change the man page to say t=
hat
> > > > > > FAN_REPORT_PIDFD is guaranteed to return a pidfd, maybe we just
> > > > > > add a NOTE about increased likelihood of getting a pidfd since =
kernel XXX
> > > > > > and mention the known cases of pid namespace and ENOMEM.
> > > > >
> > > > > The pid namespace shouldn't matter.
> > > >
> > > > DO you mean that the event reader inside a pidns always gets a pidf=
d but
> > > > it will not be able to query the pid of the process outside the pid=
ns
> > > > or do you mean something else?
> > >
> > > So they will always get a pidfd since fanotify is correctly using
> > > pidfd_prepare() directly. But when the reader tries to resolve the pi=
dfd
> > > to say a pid or retrieve info via the pidfd info ioctl they would fai=
l
> > > to do so (well, the pid will resolve to 0 which is the global indicat=
or
> > > for "can't be resolved in your pidns").
> > >
> >
> > Before pidfd_prepare(), fanotify checks whether metadata.pid is
> > non-zero, i.e. whether the event pid is visible in the reader's pidns.
> > If it's not visible, fanotify will not create a valid pidfd and return =
a
> > FAN_NOPIDFD. This is the existing behavior, and my patches do not chang=
e
> > it.
>
> We can hand that out. That's another change we should consider. The
> pidfd works even if the pid namespace is outside the caller's hierarchy.

I don't get the idea of allowing any insight for things outside of a proces=
s
namespace to be exposed by fanotify, apart from the information that someth=
ing
happened on the watched filesystem object.

Thanks,
Amir.
