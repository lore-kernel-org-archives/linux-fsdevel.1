Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59A72DA76C
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856686; cv=pass; b=TlsPDXiKMdJityJJpkEwp44DF5T3K2Fj8trUF3oB/DbL9rHUTgJe9qBqo9ykJlSjW+qv3aK9+cyu2JZJ/thDc+omUlDIMnD3zmU4Ibazt7rQPEYHQcmYpBzODJ/qL8ynxLVVrq9eP9I/9w8CFRe2e/S7nb0qWKx+xJnFbRGsAH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856686; c=relaxed/simple;
	bh=Z3oC7UAO7EPiJ2ix4pRWC+rdB2Wcr7Ufg9ISDuIGkiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjFxjceLgAE1+i2X1vbet/FcC54wimes+MOOqybzybuY8khPlbeHB18I6Z9BGSjyvjmu4U7WCPlsCF4Pd13b9DOffyZdVQBC14BiDI/x+UPXB34D7BJOowZPdt9rpzqUyM1NDrfOY5+kqsvAWAjGOfosOBsquYi5vKqh2isq3tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovMr12F0; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovMr12F0"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ba6838e76f2so451080166b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 04:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776856683; cv=none;
        d=google.com; s=arc-20240605;
        b=Wko10H1NVjFZG7XA9el6siyD/db/yArZii6tu1JIylWZPR2vjzqbf8ug3ZuJOWhzb+
         fdYiC6IJnBqLtRS5jsVZ0bD89of30O15omCc3OoJhLIAiBbiPs+2wJ6Ps0mXLEtau0m/
         xw0Mp2cOVVOwWe1LmRMTR5Xh2boU4v3ou3KZSH/6Ziwhg7xCupbjBPKdki6nOMv/kNLu
         VB8Kde2RzbhlQgAb9jBjeh8oU3XMVdsWQD3oltW0ZDjqBYdDMN/rEBX8PR0Ume03AYW9
         0onRlFa/aDinTEIp+T/EP2Uk8OPShxfkKtS9o7r31fMtkZjJZoJSsg4nq70tosMas5xo
         +XIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c78h5Tn0ffRkCvNRgwvvShtuCuUkSpljeVz34Gw7+CI=;
        fh=5isSn0Mcgq7aEaEbzr55VFvHBuqu64GDETLYWbMv6fU=;
        b=UP7FPy91B99+hI4IRzHdOG/DQabVGzJ8i4FQEm/3mZH0Dp4G9ca4ITpUwP2FI+DXMY
         1EOiGSl2wYURSc/AjpPrhvubFnS7fX7/f5GRoKqxhVglfV/mvZJRmJv0lnPWzNYmdYKx
         6SbliFSTGt+nc3u1qiqJRcT+YvJKlJxGUREZ5+sZ2P+r9PXjf9nZ/jixwADO/a3V0DW0
         3ookShZBAi82/DRQspNymNdBj4nWpKqCVvHMuHjYBE5UhcowIQl9aZq5uwFEo3gJYoOH
         Ac3U4sPCk+p5mUqd0lig2N2qGclxoAjYs4SrNwNqDl2EqNftqyAmgVdM5bZdGlYfu1ve
         fhCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776856683; x=1777461483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c78h5Tn0ffRkCvNRgwvvShtuCuUkSpljeVz34Gw7+CI=;
        b=ovMr12F0j9uNBVkMe6iXI8/bleXPZiffu0VGQALwTXPO7BYnvF2xCHDxO2DvpGk11Y
         29nO8pWxg5ZT12Salo35mkgMCcKmeCcTIunG9uOhfVZAApZ4MoFZhYBMIQ6rvbwDhN/q
         WxEgWLPIGb4UlhUXt2AWuYVQyIpO7NRLcaXuTc7tKmq1p/weeE6epY9HHPMtK9/B98I7
         osYWTgvnrpcnAiyzUST91+YQeS0n3B847g6OmErg7KqVu4xh4hNP8Qc6Zxx62+k0QENk
         BFODQN0fNZw95qDHz56DdsI+9WFOH3s8HvkwHaLG0bSxH6MBkZ4PM2p/4RrhIxi1FhjX
         Yt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776856683; x=1777461483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c78h5Tn0ffRkCvNRgwvvShtuCuUkSpljeVz34Gw7+CI=;
        b=coSLatCgPL0TQxzghQogPG7+ZpIfDvG++CTahOfl+piqvDq9TcNp4GjApjyHdPfScV
         hpdISj+8Z1LpxfPZTxEPZUkTxHzynZ0CNdJyK4FxzII9K3/s5oN2cURgxPY/6iIfY7nR
         suO6CNRAAS/zvQqJxoXrY6R+sAZPAyRMlTw8Wdp7JWkR+FGD8Rbn0BvQHX1sZizpbtq3
         /Mn/7ysE3Fe9HwzIdMB8E9MVs5Vda58ZAnWePahaqs2HjTNTEOmjPhA5d3/21E8nm2Ly
         FM7x7FaXmY1gXBac4SyYyVSUEdV8U413VFMzWlsXJJ5Ok8Iq44VjTL5T/c7f2zaGeIZB
         m5Gg==
X-Forwarded-Encrypted: i=1; AFNElJ/DqKBLWUDYJMwIdHoF40i6FNx397q18EhGgQL0VJLMETNwo6/3SibT6vSN2EntVSNDn+Jc3noHgoRdkTFH@vger.kernel.org
X-Gm-Message-State: AOJu0YxxEokpMGqKLIe3/svAlfudyL6E0li34k6YzkH/jld4KaqbDbzp
	HpGWN+UmKOfn5yWfhTpywKXH1zOtEey6EN/dknOvzrKJQ5oIPbYIQCcxCeDvwsfZ12KC1Y5sZWK
	tJTm27POeUzM5dg8XZByRGNf5uPDzijI=
X-Gm-Gg: AeBDieuBokg96aK3/eL6iL17pi6SIs0XYz5d1GuioyreHjLpm6mWzGWukg79EH1Vg5Y
	U2at3dKBEkfWeNbL5lTuBqkDfLf+utuSrBUFNkAvU0dvyiyqUAxX5w8dTHkdl05UzBBqAvTOHby
	WNMwHW63FRZaBzCRRAdiwPMr1cJvYjON1rbSyF5XNc3+FGcpOWNDxUNg5cpGt57WCE0AfY2Dc0w
	KoLqeCGrqoxhNEDUVsm5DazhSZoeOSIPDH1X8W3fAGFASsQdIElEUF3MbCe4Mllaw6ldQzFZQ2I
	Fr8avzRm3+mc1ZKahnUReI4VQRwgmixt6cpcH/JDu4scjD2Ibrqf
X-Received: by 2002:a17:907:3d90:b0:ba7:cc67:4874 with SMTP id
 a640c23a62f3a-ba7cc674c7bmr589573966b.46.1776856682843; Wed, 22 Apr 2026
 04:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
 <20260416194844.3874004-3-ibrahimjirdeh@meta.com> <bcodsu6plppnwotjuisi7kvwkftpennowemslxur33qhtmd4qp@wc536gzxu53m>
 <CAAwtZY6Bas3jLQZ_GDhbjj4pekjhT6kxAQ+5_35mzwk5_HUKhg@mail.gmail.com> <g2fx5drvoen4tkmnxe2mc44gihhtcwqhhvc7nbe4dbv6ay6idh@xc2zlk3s7q2g>
In-Reply-To: <g2fx5drvoen4tkmnxe2mc44gihhtcwqhhvc7nbe4dbv6ay6idh@xc2zlk3s7q2g>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Apr 2026 13:17:51 +0200
X-Gm-Features: AQROBzBuPm_AcDedpejevyT35sQpAUFYB47T7HPbzckMbuGibxY93LVnHLQYr7E
Message-ID: <CAOQ4uxg7Mfk5Y1qV9YD1eifO-bJ3+miCm4-GLO=sBs9q-1mGNQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fanotify: introduce restartable permission events
To: Jan Kara <jack@suse.cz>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 12:36=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 22-04-26 03:22:32, Ibrahim Jirdeh wrote:
> > On Mon, Apr 20, 2026 at 7:37=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > > +const struct file_operations fanotify_control_fops =3D {
> > > > +     .show_fdinfo    =3D fanotify_show_fdinfo,
> > > > +     .release        =3D fanotify_release,
> > > > +     .unlocked_ioctl =3D fanotify_control_ioctl,
> > > > +     .llseek         =3D noop_llseek,
> > > > +};
> > > > +
> > > > +const struct file_operations fanotify_queue_fops =3D {
> > > > +     .poll           =3D fanotify_poll,
> > > > +     .read           =3D fanotify_read,
> > > > +     .write          =3D fanotify_write,
> > > > +     .release        =3D fanotify_queue_release,
> > > > +     .unlocked_ioctl =3D fanotify_ioctl,
> > > > +     .compat_ioctl   =3D compat_ptr_ioctl,
> > > > +     .llseek         =3D noop_llseek,
> > > > +};
> > >
> > > The new scheme with queue fd & control fd opens up an interesting new=
 set
> > > of races which needs a deeper thought I think. As it is currently
> > > implemented for example if there's a task waiting for event on queue =
fd, it
> > > will never wake up if control fd is closed. Similar problem is there =
for
> > > fanotify_poll(). So we need to carefully define how operations on que=
ue fd
> > > synchronize with operations on control fd and closing of it in partic=
ular.
> > > Besides dealing with the hung waits (which can be dealt with by just =
waking
> > > the notification_waitq from fanotify_release()) we also need to deal =
with
> > > fanotify_read() moving events from notification list to access list. =
I'm a
> > > bit unhappy with how ad hoc and fragile this looks but so far don't h=
ave an
> > > idea for a cleaner solution.
> > >
> >
> > I wanted to ask a few more questions here about the race conditions you=
 are
> > outlining. Is it accurate that the main risk of races is primarily
> > related to early control fd shutdown with this new two fd case, or are
> > there other races to worry about?
>
> No, this is my main concern.
>
> > I added a few protections in this patch so far and wanted to check if
> > there are outsanding risks:
> > 1) Have queue fd also maintain a group reference as well
>
> Yes, this is good and takes care that the group is not freed. But it stil=
l
> can be fully cleaned up even if you hold a reference.
>
> > 2) Check for control fd close (group->shutdown) in fanotify_read. I wil=
l also
> > incorporate the wake up in fanotify_release you have suggested here.
>
> Yes, I've noticed that but that check is racy...
>
> > Regarding fanotify_read moving events from notification list to access =
list, do
> > we need to allow pending events in fanotify_restart_pending_events
> > after all to prevent potential hung waits stemming from race with shutd=
own?
>
> Thinking about this some more... Won't it be easier if the queue fd held =
a
> struct file reference of the control fd? That way the notification group
> couldn't be shut down until queue fd is also closed. That will deal with
> all the possible races, we don't even have to hold a notification group
> reference. I don't think this behavior would be surprising to userspace a=
nd
> I don't see any other possible downsides either. Amir, any opinion?
>

hmm, that sounds pretty neat.

queue_file->private_data =3D control_file;
control_file->private_data =3D group;

Makes sense to me.

Please remove the group->shutdown check in read and any other
safe race guards that were added.

Thanks,
Amir.
